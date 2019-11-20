Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 853911040CD
	for <lists+linux-raid@lfdr.de>; Wed, 20 Nov 2019 17:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfKTQ3m (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 20 Nov 2019 11:29:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39670 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727192AbfKTQ3l (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 20 Nov 2019 11:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574267380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dn1DGdvj9ZgVAu/GBTd959WpG3gJsRVVVCWzCDVqvc4=;
        b=DjRJdz3jAihAKZ+D4QbriDLT+wbUtT/YvZjuhQJsxehXr3Q+nqSU21ICQMsOqqVxAkVDz7
        H467i5k8+5Jm5CGDkohaPAa4wXWxbTHgXaNBOJhH3xy3B0UMyfh7lDi2u/nGj0mFKp5KNu
        Wfffldpdb9OYXK/WuGg2LeKokkjcEvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-A1KtTv-qNUayabZK_Ve9nQ-1; Wed, 20 Nov 2019 11:29:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 187E1802689;
        Wed, 20 Nov 2019 16:29:36 +0000 (UTC)
Received: from localhost (dhcp-17-171.bos.redhat.com [10.18.17.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC7C42AA9E;
        Wed, 20 Nov 2019 16:29:35 +0000 (UTC)
From:   Nigel Croxon <ncroxon@redhat.com>
To:     liu.song.a23@gmail.com, linux-raid@vger.kernel.org
Subject: [PATCH V2] raid5: avoid second retry of read-error
Date:   Wed, 20 Nov 2019 11:29:35 -0500
Message-Id: <20191120162935.9617-1-ncroxon@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: A1KtTv-qNUayabZK_Ve9nQ-1
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

Version 2:
* Renamed *raid456* to *raid5*.
* Changed set_raid5_retry_re routine to use 'if-then' to make cleaner.
* Added set_bit R5_ReadError in retry_aligned_read routine.

Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
---
 drivers/md/md.c    | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/md/md.h    |  3 +++
 drivers/md/raid5.c |  4 +++-
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1be7abeb24fd..6f47489e0b23 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -125,6 +125,15 @@ static inline int speed_max(struct mddev *mddev)
 =09=09mddev->sync_speed_max : sysctl_speed_limit_max;
 }
=20
+static int sysctl_raid5_retry_read_error =3D 0;
+static inline void set_raid5_retry_re(struct mddev *mddev, int re)
+{
+=09if (re)
+=09=09set_bit(MD_RAID5_RETRY_RE, &mddev->flags);
+=09else
+=09=09clear_bit(MD_RAID5_RETRY_RE, &mddev->flags);
+}
+
 static int rdev_init_wb(struct md_rdev *rdev)
 {
 =09if (rdev->bdev->bd_queue->nr_hw_queues =3D=3D 1)
@@ -213,6 +222,13 @@ static struct ctl_table raid_table[] =3D {
 =09=09.mode=09=09=3D S_IRUGO|S_IWUSR,
 =09=09.proc_handler=09=3D proc_dointvec,
 =09},
+=09{
+=09=09.procname=09=3D "raid5_retry_read_error",
+=09=09.data=09=09=3D &sysctl_raid5_retry_read_error,
+=09=09.maxlen=09=09=3D sizeof(int),
+=09=09.mode=09=09=3D S_IRUGO|S_IWUSR,
+=09=09.proc_handler=09=3D proc_dointvec,
+=09},
 =09{ }
 };
=20
@@ -4721,6 +4737,32 @@ mismatch_cnt_show(struct mddev *mddev, char *page)
=20
 static struct md_sysfs_entry md_mismatches =3D __ATTR_RO(mismatch_cnt);
=20
+static ssize_t
+raid5_retry_re_show(struct mddev *mddev, char *page)
+{
+=09return sprintf(page, "RAID456 retry Read Error =3D %u\n",
+=09=09       test_bit(MD_RAID5_RETRY_RE, &mddev->flags));
+}
+
+static ssize_t raid5_retry_re_store(struct mddev *mddev, const char *buf, =
size_t len)
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
+=09set_raid5_retry_re(mddev, retry);
+=09return len;
+}
+
+static struct md_sysfs_entry md_raid5_retry_read_error =3D
+__ATTR(raid5_retry_read_error, S_IRUGO|S_IWUSR, raid5_retry_re_show, raid5=
_retry_re_store);
+
 static ssize_t
 sync_min_show(struct mddev *mddev, char *page)
 {
@@ -5272,6 +5314,7 @@ static struct attribute *md_redundancy_attrs[] =3D {
 =09&md_suspend_hi.attr,
 =09&md_bitmap.attr,
 =09&md_degraded.attr,
+=09&md_raid5_retry_read_error.attr,
 =09NULL,
 };
 static struct attribute_group md_redundancy_group =3D {
@@ -5833,6 +5876,8 @@ static int do_md_run(struct mddev *mddev)
 =09if (mddev_is_clustered(mddev))
 =09=09md_allow_write(mddev);
=20
+=09set_raid5_retry_re(mddev, sysctl_raid5_retry_read_error);
+
 =09/* run start up tasks that require md_thread */
 =09md_start(mddev);
=20
@@ -8411,6 +8456,7 @@ void md_do_sync(struct md_thread *thread)
 =09else
 =09=09desc =3D "recovery";
=20
+=09set_raid5_retry_re(mddev, sysctl_raid5_retry_read_error);
 =09mddev->last_sync_action =3D action ?: desc;
=20
 =09/* we overload curr_resync somewhat here.
diff --git a/drivers/md/md.h b/drivers/md/md.h
index c5e3ff398b59..6703a7d0b633 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -254,6 +254,9 @@ enum mddev_flags {
 =09MD_BROKEN,              /* This is used in RAID-0/LINEAR only, to stop
 =09=09=09=09 * I/O in case an array member is gone/failed.
 =09=09=09=09 */
+=09MD_RAID5_RETRY_RE,=09/* allow user-space to request RAID456
+=09=09=09=09 * retry read errors
+=09=09=09=09 */
 };
=20
 enum mddev_sb_flags {
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 223e97ab27e6..0b627fface78 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2567,7 +2567,8 @@ static void raid5_end_read_request(struct bio * bi)
 =09=09if (retry)
 =09=09=09if (sh->qd_idx >=3D 0 && sh->pd_idx =3D=3D i)
 =09=09=09=09set_bit(R5_ReadError, &sh->dev[i].flags);
-=09=09=09else if (test_bit(R5_ReadNoMerge, &sh->dev[i].flags)) {
+=09=09=09else if ((test_bit(R5_ReadNoMerge, &sh->dev[i].flags)) ||
+=09=09=09      (test_bit(MD_RAID5_RETRY_RE, &conf->mddev->flags))) {
 =09=09=09=09set_bit(R5_ReadError, &sh->dev[i].flags);
 =09=09=09=09clear_bit(R5_ReadNoMerge, &sh->dev[i].flags);
 =09=09=09} else
@@ -6163,6 +6164,7 @@ static int  retry_aligned_read(struct r5conf *conf, s=
truct bio *raid_bio,
 =09=09}
=20
 =09=09set_bit(R5_ReadNoMerge, &sh->dev[dd_idx].flags);
+=09=09set_bit(R5_ReadError, &sh->dev[dd_idx].flags);
 =09=09handle_stripe(sh);
 =09=09raid5_release_stripe(sh);
 =09=09handled++;
--=20
2.18.1

