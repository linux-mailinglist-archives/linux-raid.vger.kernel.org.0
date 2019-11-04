Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8601EE48A
	for <lists+linux-raid@lfdr.de>; Mon,  4 Nov 2019 17:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfKDQUE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 Nov 2019 11:20:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51270 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727838AbfKDQUE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 4 Nov 2019 11:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572884402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9IMPeJVHAgURJZQsd+PAT8o23wYoOZufGT/lv1PbwRs=;
        b=bjQo+rysCjZAy/m90ozRtQRCtglfj+yeVmjIzkO3gyWLgwuMPKUcY2X/4rLkgDHY9J5mZ7
        9IC2BK9Xp5fwmBo9xun7b0rMHS1SSMrpxxkE1KfDQ605QgQ32+6Pn6IB5Zr073jaswe9Nz
        mQtZibKnfuq5TmMWSqQmB+IUvQXtxyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-89lybNarPHeepiB_1QkHlA-1; Mon, 04 Nov 2019 11:19:59 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EDAD8017DD;
        Mon,  4 Nov 2019 16:19:58 +0000 (UTC)
Received: from localhost (dhcp-17-171.bos.redhat.com [10.18.17.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F80F60878;
        Mon,  4 Nov 2019 16:19:58 +0000 (UTC)
From:   Nigel Croxon <ncroxon@redhat.com>
To:     linux-raid@vger.kernel.org, liu.song.a23@gmail.com
Subject: [PATCH 1/1] raid456: avoid second retry of read-error
Date:   Mon,  4 Nov 2019 11:19:57 -0500
Message-Id: <20191104161957.30123-1-ncroxon@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 89lybNarPHeepiB_1QkHlA-1
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
 drivers/md/md.h    |  2 ++
 drivers/md/raid5.c |  3 ++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 18153647e6a1..4e92996f773e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -132,6 +132,12 @@ static inline int speed_max(struct mddev *mddev)
 =09=09mddev->sync_speed_max : sysctl_speed_limit_max;
 }
=20
+static int sysctl_raid456_retry_read_error =3D 0;
+static inline void set_raid456_retry_read_error(struct mddev *mddev, int r=
e)
+{
+=09(re ? set_bit : clear_bit)(MD_RAID456_RETRY_RE, &mddev->flags);
+}
+
 static int rdev_init_wb(struct md_rdev *rdev)
 {
 =09if (rdev->bdev->bd_queue->nr_hw_queues =3D=3D 1)
@@ -220,6 +226,13 @@ static struct ctl_table raid_table[] =3D {
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
@@ -4701,6 +4714,32 @@ mismatch_cnt_show(struct mddev *mddev, char *page)
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
+=09set_raid456_retry_read_error(mddev, retry);
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
@@ -5223,6 +5262,7 @@ static struct attribute *md_redundancy_attrs[] =3D {
 =09&md_suspend_hi.attr,
 =09&md_bitmap.attr,
 =09&md_degraded.attr,
+=09&md_raid456_retry_read_error.attr,
 =09NULL,
 };
 static struct attribute_group md_redundancy_group =3D {
@@ -5785,6 +5825,8 @@ static int do_md_run(struct mddev *mddev)
 =09if (mddev_is_clustered(mddev))
 =09=09md_allow_write(mddev);
=20
+=09set_raid456_retry_read_error(mddev, sysctl_raid456_retry_read_error);
+
 =09/* run start up tasks that require md_thread */
 =09md_start(mddev);
=20
@@ -8355,6 +8397,7 @@ void md_do_sync(struct md_thread *thread)
 =09else
 =09=09desc =3D "recovery";
=20
+=09set_raid456_retry_read_error(mddev, sysctl_raid456_retry_read_error);
 =09mddev->last_sync_action =3D action ?: desc;
=20
 =09/* we overload curr_resync somewhat here.
diff --git a/drivers/md/md.h b/drivers/md/md.h
index fcb6cce5a459..013d4f758cb5 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -255,6 +255,8 @@ enum mddev_flags {
 =09MD_UPDATING_SB,=09=09/* md_check_recovery is updating the metadata
 =09=09=09=09 * without explicitly holding reconfig_mutex.
 =09=09=09=09 */
+=09MD_RAID456_RETRY_RE,=09/* allow user-space to request RAID456
+=09=09=09=09 * retry read errors */
 };
=20
 enum mddev_sb_flags {
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 0e52f1dbbc14..9fb6d29fa046 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2566,7 +2566,8 @@ static void raid5_end_read_request(struct bio * bi)
 =09=09    && !test_bit(R5_ReadNoMerge, &sh->dev[i].flags))
 =09=09=09retry =3D 1;
 =09=09if (retry)
-=09=09=09if (test_bit(R5_ReadNoMerge, &sh->dev[i].flags)) {
+=09=09=09if ((test_bit(R5_ReadNoMerge, &sh->dev[i].flags)) ||
+=09=09=09    (test_bit(MD_RAID456_RETRY_RE, &conf->mddev->recovery))) {
 =09=09=09=09set_bit(R5_ReadError, &sh->dev[i].flags);
 =09=09=09=09clear_bit(R5_ReadNoMerge, &sh->dev[i].flags);
 =09=09=09} else
--=20
2.20.1

