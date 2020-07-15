Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FCD221418
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 20:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgGOSRm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Jul 2020 14:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGOSRl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 15 Jul 2020 14:17:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EF8C061755
        for <linux-raid@vger.kernel.org>; Wed, 15 Jul 2020 11:17:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id by13so2304052edb.11
        for <linux-raid@vger.kernel.org>; Wed, 15 Jul 2020 11:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rm7uUDAlAbh4QM9kMt/CW62OVNOxKlfzvaYXNHtTzcU=;
        b=jHofT77IX3I9Ns0kj6DsiNG036fE8e9QIYEkC03ylUi/Qs+4K7Q2Nxh7T8QnQH/b+d
         Z+BIn25aECXLg1RZ3+tkIW4XDRLo1QDtOWnQtgFUf+w9kW+HorlBFwAti2zcO0gKlEni
         oRYTiDEUcG92Qhxyt4EUg46disO/5ndR1d+Bwas15xsaivuQJX73hCGjCGQ+4FI5NAOT
         hUS33qSM6PY4ymahHCh3xmboTTtfuO6uV3VamcGQvQA0BK7QI0xLnT9bqULIeNj5AXoY
         Nf6Lx+yu6zSB+Cf6ai7Wo9zJtW0asUgpVRxNaAUGXiOhXAaoubmhgm64tB8vOMV/+v5I
         hQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rm7uUDAlAbh4QM9kMt/CW62OVNOxKlfzvaYXNHtTzcU=;
        b=kXFZqX4WVTyX1rn2gtwSHp4s4PTke9N6yNSwroZA2HZYPrML/D6XrzF6cwqMgsNtWo
         DdQA/h8e3CBYyobdBulR4ImBloqDaUKD0BDLeB8mwb40a01jnbaFbqjBk6lsTrsf6h0r
         0Sjp+17bMn0wGTYAIEQ0txToV2d71G84jobGNJUflbBqjvrRiY0kdHxEDEkkJA9Rx4Ed
         /xvDYK/8gCIXQG7bON3eXPK35DTG6D+S9VRj8XzKVoz1FT2xy8/3Y2CVI6A0ColQnwRa
         /6AQqb2PzRRs3l6WsAJVN44ZJ56CNdSM2CfUDb0Db8D7cI2rV+nn5wkeLEioGuA6903P
         LBug==
X-Gm-Message-State: AOAM532DvDPXGjApcKZ+WTpflgdWjnwMJKQHg2hiUK5fAtkVF+eFgrMx
        2VFWTl0erqk8sQVncFrHn2KP3JZ8LuNRrO3/
X-Google-Smtp-Source: ABdhPJzVq88W7R6C7OU6hlbeaKC/YdOS/IpUlVrq7iafKQ1cYSexne0foeUJp0k1s0u2a+OE0+chRQ==
X-Received: by 2002:a50:8f83:: with SMTP id y3mr877320edy.257.1594837058689;
        Wed, 15 Jul 2020 11:17:38 -0700 (PDT)
Received: from ?IPv6:2001:16b8:482d:f200:587:bfc1:3ea4:c2f6? ([2001:16b8:482d:f200:587:bfc1:3ea4:c2f6])
        by smtp.gmail.com with ESMTPSA id u13sm2755472ejx.3.2020.07.15.11.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 11:17:37 -0700 (PDT)
Subject: Re: cluster-md mddev->in_sync & mddev->safemode_delay may have bug
To:     "heming.zhao@suse.com" <heming.zhao@suse.com>,
        linux-raid@vger.kernel.org
Cc:     neilb@suse.com
References: <a29f8374-cc64-cc87-71cb-507c43aff503@suse.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <91c60c65-11c4-35e7-41d2-77a1febc3249@cloud.ionos.com>
Date:   Wed, 15 Jul 2020 20:17:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a29f8374-cc64-cc87-71cb-507c43aff503@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/15/20 5:48 AM, heming.zhao@suse.com wrote:
> Hello List,
>
>
> @Neil  @Guoqing,
> Would you have time to take a look at this bug?

I don't focus on it now, and you need CC me if you want my attention.

> This mail replaces previous mail: commit 480523feae581 may introduce a 
> bug.
> Previous mail has some unclear description, I sort out & resend in 
> this mail.
>
> This bug was reported from a SUSE customer.
>
> In cluster-md env, after below steps, "mdadm -D /dev/md0" shows 
> "State: active" all the time.
> ```
> # mdadm -S --scan
> # mdadm --zero-superblock /dev/sd{a,b}
> # mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sda /dev/sdb
>
> # mdadm -D /dev/md0
> /dev/md0:
>            Version : 1.2
>      Creation Time : Mon Jul  6 12:02:23 2020
>         Raid Level : raid1
>         Array Size : 64512 (63.00 MiB 66.06 MB)
>      Used Dev Size : 64512 (63.00 MiB 66.06 MB)
>       Raid Devices : 2
>      Total Devices : 2
>        Persistence : Superblock is persistent
>
>      Intent Bitmap : Internal
>
>        Update Time : Mon Jul  6 12:02:24 2020
>              State : active <==== this line
>     Active Devices : 2
>    Working Devices : 2
>     Failed Devices : 0
>      Spare Devices : 0
>
> Consistency Policy : bitmap
>
>               Name : lp-clustermd1:0  (local to host lp-clustermd1)
>       Cluster Name : hacluster
>               UUID : 38ae5052:560c7d36:bb221e15:7437f460
>             Events : 18
>
>     Number   Major   Minor   RaidDevice State
>        0       8        0        0      active sync   /dev/sda
>        1       8       16        1      active sync   /dev/sdb
> ```
>
> with commit 480523feae581 (author: Neil Brown), the try_set_sync never 
> true, so mddev->in_sync always 0.
>
> the simplest fix is bypass try_set_sync when array is clustered.
> ```
>  void md_check_recovery(struct mddev *mddev)
>  {
>     ... ...
>         if (mddev_is_clustered(mddev)) {
>             struct md_rdev *rdev;
>             /* kick the device if another node issued a
>              * remove disk.
>              */
>             rdev_for_each(rdev, mddev) {
>                 if (test_and_clear_bit(ClusterRemove, &rdev->flags) &&
>                         rdev->raid_disk < 0)
>                     md_kick_rdev_from_array(rdev);
>             }
> +           try_set_sync = 1;
>         }
>     ... ...
>  }
> ```
> this fix makes commit 480523feae581 doesn't work when clustered env.
> I want to know what impact with above fix.
> Or does there have other solution for this issue?
>
>
> --------
> And for mddev->safemode_delay issue
>
> There is also another bug when array change bitmap from internal to 
> clustered.
> the /sys/block/mdX/md/safe_mode_delay keep original value after 
> changing bitmap type.
> in safe_delay_store(), the code forbids setting mddev->safemode_delay 
> when array is clustered.
> So in cluster-md env, the expected safemode_delay value should be 0.
>
> reproduction steps:
> ```
> # mdadm --zero-superblock /dev/sd{b,c,d}
> # mdadm -C /dev/md0 -b internal -e 1.2 -n 2 -l mirror /dev/sdb /dev/sdc
> # cat /sys/block/md0/md/safe_mode_delay
> 0.204
> # mdadm -G /dev/md0 -b none
> # mdadm --grow /dev/md0 --bitmap=clustered
> # cat /sys/block/md0/md/safe_mode_delay
> 0.204  <== doesn't change, should ZERO for cluster-md

I saw you have sent a patch, which is good. And I suggest you to improve 
the header
with your above analysis instead of just have the reproduce steps in header.

Thanks,
Guoqing
