Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACA0EE91D
	for <lists+linux-raid@lfdr.de>; Mon,  4 Nov 2019 21:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfKDUCD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 Nov 2019 15:02:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44267 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728409AbfKDUCD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 4 Nov 2019 15:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572897721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hKEmJBGazQIjd4V/0Zw3pR/wn+EkjB7VcVbH7ndPPts=;
        b=gi7JnCgoYYsIucQyAXxhFcINgs62BDM0/7Y+C39bJ8Ea7SJQpVbPNDV8wHNNiIvC+9YnD/
        HeM0e2wRrVLcPK36jvrnf6GgUYkNm0G7KvMnzXVEFMyFgkTZ49vUzmIbI8V1wKVTGMbTmv
        6gUiYnvpYBexE4QBxVl3z1I4Fm60vok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-SfARq3SuNdGqfX53WmYSaA-1; Mon, 04 Nov 2019 15:01:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 012691005500;
        Mon,  4 Nov 2019 20:01:59 +0000 (UTC)
Received: from localhost (dhcp-17-171.bos.redhat.com [10.18.17.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4DD53D8C;
        Mon,  4 Nov 2019 20:01:58 +0000 (UTC)
From:   Nigel Croxon <ncroxon@redhat.com>
To:     linux-raid@vger.kernel.org, liu.song.a23@gmail.com
Subject: [PATCH] raid456: avoid second retry of read-error
Date:   Mon,  4 Nov 2019 15:01:57 -0500
Message-Id: <20191104200157.31656-1-ncroxon@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: SfARq3SuNdGqfX53WmYSaA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The MD driver for level-456 should prevent re-reading read errors.

For redundant raid it makes no sense to retry the operation:
When one of the disks in the array hits a read error, that will
cause a stall for the reading process:
- either the read succeeds (e.g. after 4 seconds the HDD error
strategy could read the sector)
- or it fails after HDD imposed timeout (w/TLER, e.g. after 7
seconds (might be even longer)

The user can enable/disable this functionality by the following
commands:
To Enable:
echo 1 > /proc/sys/dev/raid/raid456_retry_read_error

To Disable, type the following at anytime:
echo 0 > /proc/sys/dev/raid/raid456_retry_read_error

Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
---
 drivers/md/md.c    | 43 +++++++++++++++++++++++++++++++++++++++++++
 drivers/md/md.h    |  3 +++
 drivers/md/raid5.c |  3 ++-
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6f0ecfe8eab2..75b8b0615328 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -125,6 +125,12 @@ static inline int speed_max(struct mddev *mddev)
 =09=09mddev->sync_speed_max : sysctl_speed_limit_max;
 }
=20
+static int sysctl_raid456_retry_read_error =3D 0;
+static inline void set_raid456_retry_re(struct mddev *mddev, int re)
+{
+=09(re ? set_bit : clear_bit)(MD_RAID456_RETRY_RE, &mddev->flags);
+}
+
 static int rdev_init_wb(struct md_rdev *rdev)
 {
 =09if (rdev->bdev->bd_queue->nr_hw_queues =3D=3D 1)
@@ -213,6 +219,13 @@ static struct ctl_table raid_table[] =3D {
 =09=09.mode=09=09=3D S_IRUGO|S_IWUSR,
 =09=09.proc_handler=09=3D proc_dointvec,
 =09},
+=09{
+=09=09.procname=09=3D "raid456_retry_read_error",
+=09=09.data=09=09=3D &sysctl_raid456_retry_read_error,
+=09=09.maxlen=09=09=3D sizeof(int),
+=09=09.mode=09=09=3D S_IRUGO|S_IWUSR,
+=09=09.proc_handler=09=3D proc_dointvec,
+=09},
 =09{ }
 };
=20
@@ -4771,6 +4784,32 @@ mismatch_cnt_show(struct mddev *mddev, char *page)
=20
 static struct md_sysfs_entry md_mismatches =3D __ATTR_RO(mismatch_cnt);
=20
+static ssize_t
+raid456_retry_re_show(struct mddev *mddev, char *page)
+{
+=09return sprintf(page, "RAID456 retry Read Error =3D %u\n",
+=09=09       test_bit(MD_RAID456_RETRY_RE, &mddev->flags));
+}
+
+static ssize_t raid456_retry_re_store(struct mddev *mddev, const char *buf=
, size_t len)
+{
+=09int retry;
+
+=09if (!mddev->private)
+=09=09return -ENODEV;
+
+=09if (len > 1 ||
+=09    kstrtoint(buf, 10, &retry) ||
+=09    retry < 0 || retry > 1)
+=09=09return -EINVAL;
+
+=09set_raid456_retry_re(mddev, retry);
+=09return len;
+}
+
+static struct md_sysfs_entry md_raid456_retry_read_error =3D
+__ATTR(raid456_retry_read_error, S_IRUGO|S_IWUSR, raid456_retry_re_show, r=
aid456_retry_re_store);
+
 static ssize_t
 sync_min_show(struct mddev *mddev, char *page)
 {
@@ -5322,6 +5361,7 @@ static struct attribute *md_redundancy_attrs[] =3D {
 =09&md_suspend_hi.attr,
 =09&md_bitmap.attr,
 =09&md_degraded.attr,
+=09&md_raid456_retry_read_error.attr,
 =09NULL,
 };
 static struct attribute_group md_redundancy_group =3D {
@@ -5885,6 +5925,8 @@ static int do_md_run(struct mddev *mddev)
 =09if (mddev_is_clustered(mddev))
 =09=09md_allow_write(mddev);
=20
+=09set_raid456_retry_re(mddev, sysctl_raid456_retry_read_error);
+
 =09/* run start up tasks that require md_thread */
 =09md_start(mddev);
=20
@@ -8463,6 +8505,7 @@ void md_do_sync(struct md_thread *thread)
 =09else
 =09=09desc =3D "recovery";
=20
+=09set_raid456_retry_re(mddev, sysctl_raid456_retry_read_error);
 =09mddev->last_sync_action =3D action ?: desc;
=20
 =09/* we overload curr_resync somewhat here.
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 5f86f8adb0a4..1e3e3d5eb859 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -254,6 +254,9 @@ enum mddev_flags {
 =09MD_BROKEN,              /* This is used in RAID-0/LINEAR only, to stop
 =09=09=09=09 * I/O in case an array member is gone/failed.
 =09=09=09=09 */
+=09MD_RAID456_RETRY_RE,=09/* allow user-space to request RAID456
+=09=09=09=09 * retry read errors
+=09=09=09=09 */
 };
=20
 enum mddev_sb_flags {
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 12a8ce83786e..63c616b996b6 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2567,7 +2567,8 @@ static void raid5_end_read_request(struct bio * bi)
 =09=09if (retry)
 =09=09=09if (sh->qd_idx >=3D 0 && sh->pd_idx =3D=3D i)
 =09=09=09=09set_bit(R5_ReadError, &sh->dev[i].flags);
-=09=09=09else if (test_bit(R5_ReadNoMerge, &sh->dev[i].flags)) {
+=09=09=09else if ((test_bit(R5_ReadNoMerge, &sh->dev[i].flags)) ||
+=09=09=09      (test_bit(MD_RAID456_RETRY_RE, &conf->mddev->flags))) {
 =09=09=09=09set_bit(R5_ReadError, &sh->dev[i].flags);
 =09=09=09=09clear_bit(R5_ReadNoMerge, &sh->dev[i].flags);
 =09=09=09} else
--=20
2.20.1

