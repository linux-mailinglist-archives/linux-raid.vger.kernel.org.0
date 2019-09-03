Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B336DA7402
	for <lists+linux-raid@lfdr.de>; Tue,  3 Sep 2019 21:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfICTtd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 3 Sep 2019 15:49:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57565 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfICTtd (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 3 Sep 2019 15:49:33 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1i5Eny-0004ug-M8
        for linux-raid@vger.kernel.org; Tue, 03 Sep 2019 19:49:30 +0000
Received: by mail-pl1-f197.google.com with SMTP id gn3so44988plb.1
        for <linux-raid@vger.kernel.org>; Tue, 03 Sep 2019 12:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G5yfoLgOl+DBM+YTslU6y0CKPqFGOH/9TbsO7XW6rqc=;
        b=fAT2l82psdN+PmHJkk/zx0IeKVVfT3yR61x64Njbe+gjqZCPg73y7PTG3qNfLNpJUD
         UeIGVFTgx+yAAL5Yz7FBqN/nN37zG6E8eshsRsM1NfT+55nzEb2lAi1omGuwS5hsPDxn
         7LW1teiWELhve75jKwAxIDHacDqG29mWe2z53+khkb7F5Uj5Ery7ndln1h3lTZvnWRyc
         435Ksa8NlbTvboCIzgrNHw8pZtDNgZSMkZ19TVI4NB24i27Q1Pt7tEfLOTiDLn77Ob05
         JnYRlkO/o4h/1l7oihVTQMRYwVOXazhaFRwol6pdMnW/E9UIqLaHL0lFtncKK+Gg+iWt
         uAHg==
X-Gm-Message-State: APjAAAWyN8S8ib/DlXwHkNPg1tQRpBB2CTDwk4gaTAt00/B/Jy+8WuRZ
        WLAgeBNRiZkXMBuriXz9ijTcpTRD3OepZF9vz0wHOkdEY8tyI8Ur68zlxOFSCl7SVF/I+XIJjkh
        z4pq7u9JsXQmv1LLOEbyuYX7WLhSvGr15u7NsbN0=
X-Received: by 2002:a17:902:7592:: with SMTP id j18mr36507845pll.186.1567540169143;
        Tue, 03 Sep 2019 12:49:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxyoaUoLZlZenn5wcFMze5HicJKKUtAW77wnfwEqBzb28QkXp3iA25uQpSEt3LD2a5mu0QFGA==
X-Received: by 2002:a17:902:7592:: with SMTP id j18mr36507826pll.186.1567540168966;
        Tue, 03 Sep 2019 12:49:28 -0700 (PDT)
Received: from localhost (201-93-37-171.dial-up.telesp.net.br. [201.93.37.171])
        by smtp.gmail.com with ESMTPSA id y15sm24921254pfp.111.2019.09.03.12.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 12:49:28 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-raid@vger.kernel.org
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        jay.vosburgh@canonical.com, liu.song.a23@gmail.com,
        nfbrown@suse.com, jes.sorensen@gmail.com, gpiccoli@canonical.com,
        NeilBrown <neilb@suse.de>, Song Liu <songliubraving@fb.com>
Subject: [PATCH v4 2/2] mdadm: Introduce new array state 'broken' for raid0/linear
Date:   Tue,  3 Sep 2019 16:49:01 -0300
Message-Id: <20190903194901.13524-2-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190903194901.13524-1-gpiccoli@canonical.com>
References: <20190903194901.13524-1-gpiccoli@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Currently if a md raid0/linear array gets one or more members removed while
being mounted, kernel keeps showing state 'clean' in the 'array_state'
sysfs attribute. Despite udev signaling the member device is gone, 'mdadm'
cannot issue the STOP_ARRAY ioctl successfully, given the array is mounted.

Nothing else hints that something is wrong (except that the removed devices
don't show properly in the output of mdadm 'detail' command). There is no
other property to be checked, and if user is not performing reads/writes
to the array, even kernel log is quiet and doesn't give a clue about the
missing member.

This patch is the mdadm counterpart of kernel new array state 'broken'.
The 'broken' state mimics the state 'clean' in every aspect, being useful
only to distinguish if an array has some member missing. All necessary
paths in mdadm were changed to deal with 'broken' state, and in case the
tool runs in a kernel that is not updated, it'll work normally, i.e., it
doesn't require the 'broken' state in order to work.
Also, this patch changes the way the array state is showed in the 'detail'
command (for raid0/linear only) - now it takes the 'array_state' sysfs
attribute into account instead of only rely in the MD_SB_CLEAN flag.

Cc: Jes Sorensen <jes.sorensen@gmail.com>
Cc: NeilBrown <neilb@suse.de>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---

v3 -> v4:
* Changed arrayst from pre-allocated to pointer (thanks Neil
for the suggestion).
* Simplified array size validation in Monitor/Wait() by
using ARRAY_SIZE(), per Neil's suggestion.

v2 -> v3:
* Nothing changed.

v1 -> v2:
* Added handling for md/linear 'broken' state.


 Detail.c  | 14 ++++++++++++--
 Monitor.c |  8 ++++++--
 maps.c    |  1 +
 mdadm.h   |  1 +
 mdmon.h   |  2 +-
 monitor.c |  4 ++--
 6 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/Detail.c b/Detail.c
index ad60434..3e61e37 100644
--- a/Detail.c
+++ b/Detail.c
@@ -81,6 +81,7 @@ int Detail(char *dev, struct context *c)
 	int external;
 	int inactive;
 	int is_container = 0;
+	char *arrayst;
 
 	if (fd < 0) {
 		pr_err("cannot open %s: %s\n",
@@ -485,9 +486,18 @@ int Detail(char *dev, struct context *c)
 			else
 				st = ", degraded";
 
+			if (array.state & (1 << MD_SB_CLEAN)) {
+				if ((array.level == 0) ||
+				    (array.level == LEVEL_LINEAR))
+					arrayst = map_num(sysfs_array_states,
+							  sra->array_state);
+				else
+					arrayst = "clean";
+			} else
+				arrayst = "active";
+
 			printf("             State : %s%s%s%s%s%s \n",
-			       (array.state & (1 << MD_SB_CLEAN)) ?
-			       "clean" : "active", st,
+			       arrayst, st,
 			       (!e || (e->percent < 0 &&
 				       e->percent != RESYNC_PENDING &&
 				       e->percent != RESYNC_DELAYED)) ?
diff --git a/Monitor.c b/Monitor.c
index 036103f..cf0610b 100644
--- a/Monitor.c
+++ b/Monitor.c
@@ -1055,8 +1055,11 @@ int Wait(char *dev)
 	}
 }
 
+/* The state "broken" is used only for RAID0/LINEAR - it's the same as
+ * "clean", but used in case the array has one or more members missing.
+ */
 static char *clean_states[] = {
-	"clear", "inactive", "readonly", "read-auto", "clean", NULL };
+	"clear", "inactive", "readonly", "read-auto", "clean", "broken", NULL };
 
 int WaitClean(char *dev, int verbose)
 {
@@ -1116,7 +1119,8 @@ int WaitClean(char *dev, int verbose)
 			rv = read(state_fd, buf, sizeof(buf));
 			if (rv < 0)
 				break;
-			if (sysfs_match_word(buf, clean_states) <= 4)
+			if (sysfs_match_word(buf, clean_states)
+			    < (int)ARRAY_SIZE(clean_states)-1)
 				break;
 			rv = sysfs_wait(state_fd, &delay);
 			if (rv < 0 && errno != EINTR)
diff --git a/maps.c b/maps.c
index 02a0474..49b7f2c 100644
--- a/maps.c
+++ b/maps.c
@@ -150,6 +150,7 @@ mapping_t sysfs_array_states[] = {
 	{ "read-auto", ARRAY_READ_AUTO },
 	{ "clean", ARRAY_CLEAN },
 	{ "write-pending", ARRAY_WRITE_PENDING },
+	{ "broken", ARRAY_BROKEN },
 	{ NULL, ARRAY_UNKNOWN_STATE }
 };
 
diff --git a/mdadm.h b/mdadm.h
index 43b07d5..c88ceab 100644
--- a/mdadm.h
+++ b/mdadm.h
@@ -373,6 +373,7 @@ struct mdinfo {
 		ARRAY_ACTIVE,
 		ARRAY_WRITE_PENDING,
 		ARRAY_ACTIVE_IDLE,
+		ARRAY_BROKEN,
 		ARRAY_UNKNOWN_STATE,
 	} array_state;
 	struct md_bb bb;
diff --git a/mdmon.h b/mdmon.h
index 818367c..b3d72ac 100644
--- a/mdmon.h
+++ b/mdmon.h
@@ -21,7 +21,7 @@
 extern const char Name[];
 
 enum array_state { clear, inactive, suspended, readonly, read_auto,
-		   clean, active, write_pending, active_idle, bad_word};
+		   clean, active, write_pending, active_idle, broken, bad_word};
 
 enum sync_action { idle, reshape, resync, recover, check, repair, bad_action };
 
diff --git a/monitor.c b/monitor.c
index 81537ed..e0d3be6 100644
--- a/monitor.c
+++ b/monitor.c
@@ -26,7 +26,7 @@
 
 static char *array_states[] = {
 	"clear", "inactive", "suspended", "readonly", "read-auto",
-	"clean", "active", "write-pending", "active-idle", NULL };
+	"clean", "active", "write-pending", "active-idle", "broken", NULL };
 static char *sync_actions[] = {
 	"idle", "reshape", "resync", "recover", "check", "repair", NULL
 };
@@ -476,7 +476,7 @@ static int read_and_act(struct active_array *a, fd_set *fds)
 		a->next_state = clean;
 		ret |= ARRAY_DIRTY;
 	}
-	if (a->curr_state == clean) {
+	if ((a->curr_state == clean) || (a->curr_state == broken)) {
 		a->container->ss->set_array_state(a, 1);
 	}
 	if (a->curr_state == active ||
-- 
2.17.1

