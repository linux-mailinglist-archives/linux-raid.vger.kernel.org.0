Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E60196278
	for <lists+linux-raid@lfdr.de>; Tue, 20 Aug 2019 16:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfHTOau (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 20 Aug 2019 10:30:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbfHTOau (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 20 Aug 2019 10:30:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F7A510C052A;
        Tue, 20 Aug 2019 14:30:49 +0000 (UTC)
Received: from [10.10.120.189] (ovpn-120-189.rdu2.redhat.com [10.10.120.189])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73D8E3DA5;
        Tue, 20 Aug 2019 14:30:48 +0000 (UTC)
Subject: Re: [PATCH] raid5 improve too many read errors msg by adding limits
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     NeilBrown <neilb@suse.com>, Xiao Ni <xni@redhat.com>,
        Neil F Brown <nfbrown@suse.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>
References: <20190812153039.13604-1-ncroxon@redhat.com>
 <f79ead58-9feb-4b0b-5f29-fd1a4f10342f@redhat.com>
 <CAPhsuW5+vk4Ln84JSe-QEt-O2xee9d63B8aGEpxFLVfZWADEfA@mail.gmail.com>
 <875zmxj3cf.fsf@notabene.neil.brown.name>
 <9770f0c0-58a3-c283-02c0-25c0f94dc514@redhat.com>
 <CAPhsuW4T-ccC_kCycyuYENj2918aUDN9w6kt-eN_-K4761UTPQ@mail.gmail.com>
From:   Nigel Croxon <ncroxon@redhat.com>
Message-ID: <23c37f55-db8e-07f7-9229-b8ea705e4d63@redhat.com>
Date:   Tue, 20 Aug 2019 10:30:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4T-ccC_kCycyuYENj2918aUDN9w6kt-eN_-K4761UTPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Tue, 20 Aug 2019 14:30:49 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 8/16/19 7:52 PM, Song Liu wrote:
> On Fri, Aug 16, 2019 at 10:02 AM Nigel Croxon <ncroxon@redhat.com> wrote:
> [...]
>> [  +0.000008] md/raid:md127: 793 read_errors, > 781 stripes
>> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
>> [  +0.000018] md/raid:md127: 794 read_errors, > 781 stripes
>> [  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
>> [  +0.000009] md/raid:md127: 795 read_errors, > 781 stripes
>> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
>> [  +0.000008] md/raid:md127: 796 read_errors, > 781 stripes
>> [  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
>> [  +0.000018] md/raid:md127: 797 read_errors, > 781 stripes
>> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
>> [  +0.000008] md/raid:md127: 798 read_errors, > 781 stripes
>> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
>> [  +0.000017] md/raid:md127: 799 read_errors, > 781 stripes
>> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
>> [  +0.000008] md/raid:md127: 800 read_errors, > 781 stripes
>> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
>> [  +0.000008] md/raid:md127: 801 read_errors, > 781 stripes
>> [  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
>> [  +0.000021] md/raid:md127: 802 read_errors, > 781 stripes
>> [  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
>> [  +0.000009] md/raid:md127: 803 read_errors, > 781 stripes
>> [  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
>> [  +0.000009] md/raid:md127: 804 read_errors, > 781 stripes
>> [  +0.000000] md/raid:md127: Too many read errors, failing device dm-0.
>> [  +0.000008] md/raid:md127: 805 read_errors, > 781 stripes
>> [  +0.000001] md/raid:md127: Too many read errors, failing device dm-0.
>> [  +0.928614] md: md127: requested-resync interrupted.
>>
> This is a little too noisy. How about we only pr_warn() for
> test_bit(Faulty) == 0?
> (This is not directly related to this patch, but since we are at it).
>
> Thanks,
> Song
From: Nigel Croxon <ncroxon@redhat.com>
Date: Mon, 19 Aug 2019 16:01:04 -0400
Subject: [PATCH]  raid5 improve too many read errors msg by adding limits

Often limits can be changed by admin. When discussing such things
it helps if you can provide "self-sustained" facts. Also
sometimes the admin thinks he changed a limit, but it did not
take effect for some reason or he changed the wrong thing.

V3: Only pr_warn when Faulty is 0.
V2: Add read_errors value to pr_warn.

Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
---
  drivers/md/raid5.c | 13 +++++++++----
  1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7fde645d2e90..6812cefea308 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2557,10 +2557,15 @@ static void raid5_end_read_request(struct bio * bi)
                  (unsigned long long)s,
                  bdn);
          } else if (atomic_read(&rdev->read_errors)
-             > conf->max_nr_stripes)
-            pr_warn("md/raid:%s: Too many read errors, failing device 
%s.\n",
-                   mdname(conf->mddev), bdn);
-        else
+            > conf->max_nr_stripes) {
+            if (!test_bit(Faulty, &rdev->flags)) {
+                pr_warn("md/raid:%s: %d read_errors, > %d stripes\n",
+                   mdname(conf->mddev), atomic_read(&rdev->read_errors),
+                   conf->max_nr_stripes);
+                pr_warn("md/raid:%s: Too many read errors, failing 
device %s.\n",
+                   mdname(conf->mddev), bdn);
+            }
+        } else
              retry = 1;
          if (set_bad && test_bit(In_sync, &rdev->flags)
              && !test_bit(R5_ReadNoMerge, &sh->dev[i].flags))
-- 
2.20.1


