Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D411979A09
	for <lists+linux-raid@lfdr.de>; Mon, 29 Jul 2019 22:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387785AbfG2Uca (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 29 Jul 2019 16:32:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43132 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfG2Uc3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 29 Jul 2019 16:32:29 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hsCJn-0001ry-8p
        for linux-raid@vger.kernel.org; Mon, 29 Jul 2019 20:32:27 +0000
Received: by mail-pg1-f200.google.com with SMTP id g2so17693127pgj.2
        for <linux-raid@vger.kernel.org>; Mon, 29 Jul 2019 13:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZIjcz6M8NyPtGB3RM+IZ0QLHvujOqxEoGwPE89UkV5k=;
        b=A7Kkv86lUvJY3AtXm8B9eh8MPg2yYHn9t2QacHGNRRJUoFFCVRrXjjtLEUqZPaJp7r
         RpkxXHrdVfbgKR5olYBV1xcoWQu9UUknCBlYsojO/o1vZ7zP5hwgFVrKbVc3Q9bhtNp1
         Zyz4+CfCE7r7DgT0y+N1NH+N2PHM5lMi/tBlVrKHLYzEAsYq1jBCyVqym2ax/azliq8h
         vYrG39kfQ4KBiNfnEYu1aMO2n2L3p7m4p+KwoEsca97Vk8WgVnxoaHYwKzJymcOq4/s8
         zWXZtAZ385Kevc2d3sYA9ZDyIl9PPReD+T7Xpby2rU0fpxtid+Q4TD1qmlfQDTvsaOu8
         qlDA==
X-Gm-Message-State: APjAAAWwKRzZZBO8TcKYEGpaQ/1LWNepj2K8h+Ij1iROQIzff4Tt6rSl
        1VG6k+yR+DcAY4JBwmOcz0dBTcgVymA28wT6oI0qfcMqsrIITWE0qM/I68VczmXM9xQwb+9U52M
        giVO4wBKj8vzQS9SB8hWNl6z9jsZR8+Cy/JTIlW8=
X-Received: by 2002:a62:b411:: with SMTP id h17mr36752105pfn.99.1564432345512;
        Mon, 29 Jul 2019 13:32:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxeJ2LYVVU963yH9rf018/SKEDn/PK5NA2KYIlWk86JH+JXwBlhoFCYG/WM7iwIvhPnEptODA==
X-Received: by 2002:a62:b411:: with SMTP id h17mr36752082pfn.99.1564432345289;
        Mon, 29 Jul 2019 13:32:25 -0700 (PDT)
Received: from localhost ([152.254.214.186])
        by smtp.gmail.com with ESMTPSA id 67sm28789831pfd.177.2019.07.29.13.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:32:24 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-raid@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        gpiccoli@canonical.com, jay.vosburgh@canonical.com, neilb@suse.com,
        songliubraving@fb.com
Subject: [PATCH 2/2] mdadm: Introduce new array state 'broken' for raid0
Date:   Mon, 29 Jul 2019 17:31:35 -0300
Message-Id: <20190729203135.12934-3-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729203135.12934-1-gpiccoli@canonical.com>
References: <20190729203135.12934-1-gpiccoli@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Currently if a md/raid0 array gets one or more members removed while
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
command (for raid0 only) - now it takes the 'array_state' sysfs attribute
into account instead of only rely in the MD_SB_CLEAN flag.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---
 Detail.c  | 16 ++++++++++++++--
 Monitor.c |  9 +++++++--
 maps.c    |  1 +
 mdadm.h   |  1 +
 mdmon.h   |  2 +-
 monitor.c |  4 ++--
 6 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/Detail.c b/Detail.c
index 20ea03a..4bf86b1 100644
--- a/Detail.c
+++ b/Detail.c
@@ -81,6 +81,7 @@ int Detail(char *dev, struct context *c)
 	int external;
 	int inactive;
 	int is_container = 0;
+	char arrayst[12] = { 0 }; /* no state is >10 chars currently */
 
 	if (fd < 0) {
 		pr_err("cannot open %s: %s\n",
@@ -485,9 +486,20 @@ int Detail(char *dev, struct context *c)
 			else
 				st = ", degraded";
 
+			if (array.state & (1 << MD_SB_CLEAN)) {
+				if (array.level == 0)
+					strncpy(arrayst,
+						map_num(sysfs_array_states,
+							sra->array_state),
+						sizeof(arrayst)-1);
+				else
+					strncpy(arrayst, "clean",
+						sizeof(arrayst)-1);
+			} else
+				strncpy(arrayst, "active", sizeof(arrayst)-1);
+
 			printf("             State : %s%s%s%s%s%s \n",
-			       (array.state & (1 << MD_SB_CLEAN)) ?
-			       "clean" : "active", st,
+			       arrayst, st,
 			       (!e || (e->percent < 0 &&
 				       e->percent != RESYNC_PENDING &&
 				       e->percent != RESYNC_DELAYED)) ?
diff --git a/Monitor.c b/Monitor.c
index 036103f..9a6a250 100644
--- a/Monitor.c
+++ b/Monitor.c
@@ -1055,8 +1055,12 @@ int Wait(char *dev)
 	}
 }
 
+/* The state "broken" is used only for RAID0 - it's the same as "clean", but
+ * used in case the array has one or more members missing.
+ */
+#define CLEAN_STATES_LAST_POS	5
 static char *clean_states[] = {
-	"clear", "inactive", "readonly", "read-auto", "clean", NULL };
+	"clear", "inactive", "readonly", "read-auto", "clean", "broken", NULL };
 
 int WaitClean(char *dev, int verbose)
 {
@@ -1116,7 +1120,8 @@ int WaitClean(char *dev, int verbose)
 			rv = read(state_fd, buf, sizeof(buf));
 			if (rv < 0)
 				break;
-			if (sysfs_match_word(buf, clean_states) <= 4)
+			if (sysfs_match_word(buf, clean_states)
+			    <= CLEAN_STATES_LAST_POS)
 				break;
 			rv = sysfs_wait(state_fd, &delay);
 			if (rv < 0 && errno != EINTR)
diff --git a/maps.c b/maps.c
index 02a0474..98ddbbc 100644
--- a/maps.c
+++ b/maps.c
@@ -150,6 +150,7 @@ mapping_t sysfs_array_states[] = {
 	{ "read-auto", ARRAY_READ_AUTO },
 	{ "clean", ARRAY_CLEAN },
 	{ "write-pending", ARRAY_WRITE_PENDING },
+	{ "broken", ARRAY_BROKEN_RAID0 },
 	{ NULL, ARRAY_UNKNOWN_STATE }
 };
 
diff --git a/mdadm.h b/mdadm.h
index c36d7fd..72c2525 100644
--- a/mdadm.h
+++ b/mdadm.h
@@ -375,6 +375,7 @@ struct mdinfo {
 		ARRAY_ACTIVE,
 		ARRAY_WRITE_PENDING,
 		ARRAY_ACTIVE_IDLE,
+		ARRAY_BROKEN_RAID0,
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
2.22.0

