Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC0E4CCEA
	for <lists+linux-raid@lfdr.de>; Thu, 20 Jun 2019 13:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbfFTLbK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 20 Jun 2019 07:31:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfFTLbK (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 20 Jun 2019 07:31:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44E9130C5831
        for <linux-raid@vger.kernel.org>; Thu, 20 Jun 2019 11:31:10 +0000 (UTC)
Received: from [10.10.124.219] (ovpn-124-219.rdu2.redhat.com [10.10.124.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E3DC5D9D2
        for <linux-raid@vger.kernel.org>; Thu, 20 Jun 2019 11:31:09 +0000 (UTC)
To:     linux-raid@vger.kernel.org
From:   Nigel Croxon <ncroxon@redhat.com>
Subject: raid6 with dm-integrity should not cause device to fail
Message-ID: <9dd94796-4398-55c5-b4b6-4adfa2b88901@redhat.com>
Date:   Thu, 20 Jun 2019 07:31:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 20 Jun 2019 11:31:10 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello All,

When RAID6 is set up on dm-integrity target that detects massive 
corruption, the leg will be ejected from the array.  Even if the issue 
is correctable with a sector re-write and the array has necessary 
redundancy to correct it.

The leg is ejected because it runs up the rdev->read_errors beyond 
conf->max_nr_stripes (600).

The return status in dm-crypt when there is a data integrity error is 
BLK_STS_PROTECTION.

I propose we don't increment the read_errors when the bi->bi_status is 
BLK_STS_PROTECTION.


  drivers/md/raid5.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index b83bce2beb66..ca73e60e33ed 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2526,7 +2526,8 @@ static void raid5_end_read_request(struct bio * bi)
          int set_bad = 0;

          clear_bit(R5_UPTODATE, &sh->dev[i].flags);
-        atomic_inc(&rdev->read_errors);
+        if (!(bi->bi_status == BLK_STS_PROTECTION))
+            atomic_inc(&rdev->read_errors);
          if (test_bit(R5_ReadRepl, &sh->dev[i].flags))
              pr_warn_ratelimited(
                  "md/raid:%s: read error on replacement device (sector 
%llu on %s).\n",
-- 
2.20.1


The script below creates the failing environment.  It needs to run a 
couple times in a row to take the leg out.

#!/bin/sh -x
#### cleanup script:
mdadm --stop /dev/md/robust
for i in $(seq $COUNT); do
    integritysetup close integr-$i
    rm -Rf raw-$i
done

### configurable RAID level:
SIZE=$((1024*1024*1024))
COUNT=4
LEVEL=6
for i in $(seq $COUNT); do
   truncate -s $SIZE "raw-$i"
   integritysetup format --integrity sha1 --tag-size 16 \
   --sector-size 4096  --batch-mode "./raw-$i"
   integritysetup open --integrity-no-journal --integrity \
   sha1 --batch-mode "./raw-$i" "integr-$i"
   dd if=/dev/zero "of=/dev/mapper/integr-$i" bs=$((4096*512)) || :
done
mdadm --create /dev/md/robust -n$COUNT --level=$LEVEL \
$(seq --format "/dev/mapper/integr-%.0f" $COUNT)
mdadm --wait /dev/md/robust && echo ready
mdadm --stop /dev/md/robust
integritysetup close integr-1
sync
tr '\000' '\377' < /dev/zero | dd of=raw-1 bs=4096 \
seek=$((SIZE/4096/2)) count=$((SIZE/4096/2-256)) \
conv=notrunc status=progress
sync
echo 3 > /proc/sys/vm/drop_caches
integritysetup open --integrity-no-journal --integrity \
sha1 "./raw-1" "integr-1"
# udev is a bit too eager to start assembling the array, so stop the 
partially assembled one
mdadm --stop /dev/$(grep -oE '(md[^ ]*).*inactive' /proc/mdstat | awk 
'{print $1}')
mdadm --assemble /dev/md/robust $(seq --format \
"/dev/mapper/integr-%.0f" $COUNT)
mdadm --action=repair /dev/md/robust
mdadm --wait /dev/md/robust && echo ready





