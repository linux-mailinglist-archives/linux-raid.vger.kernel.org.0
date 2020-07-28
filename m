Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19033230591
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jul 2020 10:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgG1IiT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 04:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbgG1IiT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 Jul 2020 04:38:19 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2786DC061794
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 01:38:19 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id g11so8035215ejr.0
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 01:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=o5Uk5TEXaRnaxx/RMIjR6Cch7U21y2ghIP2wk5JokyA=;
        b=GD2w2y9aryb/ZGphpZluwWRCI6JCzkeDn8wDF2KW8m4SsL2HEPW2PHaqCAL0x9wa2o
         qJmbzujgGTrwKoWGP0qYuF4/ptas7XQ8H4vUPvJP4UeffIDpvnB1jHCY9te4FlgJhpp0
         7qSlTHlUpov6bymBnX2dZEk7Bs2TZvlAMvZGjy564nQMzv0HfyG8V7Fh/xuy9RTbtV86
         ra+u61+31ZGqSAYiXrKV6K4eO/nZMkmukvN8JVZFSYYDgL3ozoEd9tQAkFuTJlg6+rIb
         lcailRMkXXNpS0RYpKQCiHZ4C1ZrZjCQ3CSxrfqiVN8IUNsXhWclkNxgZByuHGrxTq0t
         aErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=o5Uk5TEXaRnaxx/RMIjR6Cch7U21y2ghIP2wk5JokyA=;
        b=hsXqVgFbdmNO0vUeWXkD+E3nBcFsMSav8LzZ5Q7zOfHF3fg8EPfgGzFpSRnlpzunlM
         rXomrpnFQPVlm2kqfaBv3QT4VDOZz3hg5WxusoisQkPjUuHCEndYvxn7G37cKETA9YbO
         z+IEE4PEvFXE33sc+Anz3IwylU3Bb6dYuFqxFnEwwE0vC1bE0avt1USfGokX1tyGLtx0
         hKbxvnLkp0fi4DOSBdC+RR7GWkjnGsCPVOI5j4IXRpQSp6ZhoyC3lv6zAtX6J2p88PZw
         zDkqssDiYVM94pmZVxlKfQ27Dkhj67ORKOK70wOPaEM5O0SR7Cy7kRQ6e15DismKY8x0
         z8tQ==
X-Gm-Message-State: AOAM5303eQjqyUw2vE1h9Th7cU/kfu8O88AiCgL5Ve6+QDkJVPSHYsdp
        CbSYx18YcZ57S4U39eThE90iTQ==
X-Google-Smtp-Source: ABdhPJx2EiuEhTFas+1nsX/mgwK9TDMIrBD+aWnc6/0uxvetTSAV9wxpXwZDLNPDun83KBGj5btQ5w==
X-Received: by 2002:a17:906:bcf3:: with SMTP id op19mr6643982ejb.1.1595925497799;
        Tue, 28 Jul 2020 01:38:17 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:34cb:1cd0:d3a5:9c35? ([2001:1438:4010:2540:34cb:1cd0:d3a5:9c35])
        by smtp.gmail.com with ESMTPSA id r6sm8499702ejd.55.2020.07.28.01.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 01:38:17 -0700 (PDT)
Subject: Re: [PATCH V2 3/3] improve raid10 discard request
To:     Xiao Ni <xni@redhat.com>, song@kernel.org,
        linux-raid@vger.kernel.org
Cc:     colyli@suse.de, ncroxon@redhat.com, heinzm@redhat.com
References: <1595920703-6125-1-git-send-email-xni@redhat.com>
 <1595920703-6125-4-git-send-email-xni@redhat.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <81fdb14b-e292-8dfc-5228-c6bfaa800dfe@cloud.ionos.com>
Date:   Tue, 28 Jul 2020 10:38:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595920703-6125-4-git-send-email-xni@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 7/28/20 9:18 AM, Xiao Ni wrote:
> Now the discard request is split by chunk size. So it takes a long time
> to finish mkfs on disks which support discard function. This patch improve
> handling raid10 discard request. It uses the similar way with patch
> 29efc390b (md/md0: optimize raid0 discard handling).
>
> But it's a little complex than raid0. Because raid10 has different layout.
> If raid10 is offset layout and the discard request is smaller than stripe
> size. There are some holes when we submit discard bio to underlayer disks.
>
> For example: five disks (disk1 - disk5)
> D01 D02 D03 D04 D05
> D05 D01 D02 D03 D04
> D06 D07 D08 D09 D10
> D10 D06 D07 D08 D09
> The discard bio just wants to discard from D03 to D10. For disk3, there is
> a hole between D03 and D08. For disk4, there is a hole between D04 and D09.
> D03 is a chunk, raid10_write_request can handle one chunk perfectly. So
> the part that is not aligned with stripe size is still handled by
> raid10_write_request.

One question, is far layout handled by raid10_write_request or the
discard request?

>
> If reshape is running when discard bio comes and the discard bio spans the
> reshape position, raid10_write_request is responsible to handle this
> discard bio.
>
> I did a test with this patch set.
> Without patch:
> time mkfs.xfs /dev/md0
> real4m39.775s
> user0m0.000s
> sys0m0.298s
>
> With patch:
> time mkfs.xfs /dev/md0
> real0m0.105s
> user0m0.000s
> sys0m0.007s
>
> nvme3n1           259:1    0   477G  0 disk
> └─nvme3n1p1       259:10   0    50G  0 part
> nvme4n1           259:2    0   477G  0 disk
> └─nvme4n1p1       259:11   0    50G  0 part
> nvme5n1           259:6    0   477G  0 disk
> └─nvme5n1p1       259:12   0    50G  0 part
> nvme2n1           259:9    0   477G  0 disk
> └─nvme2n1p1       259:15   0    50G  0 part
> nvme0n1           259:13   0   477G  0 disk
> └─nvme0n1p1       259:14   0    50G  0 part
>
> v1:
> Coly helps to review these patches and give some suggestions:
> One bug is found. If discard bio is across one stripe but bio size is bigger
> than one stripe size. After spliting, the bio will be NULL. In this version,
> it checks whether discard bio size is bigger than 2*stripe_size.
> In raid10_end_discard_request, it's better to check R10BIO_Uptodate is set
> or not. It can avoid write memory to improve performance.
> Add more comments for calculating addresses.
>
> v2:
> Fix error by checkpatch.pl
> Fix one bug for offset layout. v1 calculates wrongly split size
> Add more comments to explain how the discard range of each component disk
> is decided.

The above change log are usually put under "---".

> Reviewed-by: Coly Li <colyli@suse.de>
> Signed-off-by: Xiao Ni <xni@redhat.com>
> ---

[...]

> +
> +/* There are some limitations to handle discard bio
> + * 1st, the discard size is bigger than stripe_size*2.
> + * 2st, if the discard bio spans reshape progress, we use the old way to
> + * handle discard bio
> + */
> +static bool raid10_handle_discard(struct mddev *mddev, struct bio *bio)
> +{

[...]

> +	/* For far offset layout, if bio is not aligned with stripe size, it splits
> +	 * the part that is not aligned with strip size.
> +	 */
> +	if (geo.far_offset && (bio_start & stripe_mask)) {
> +		sector_t split_size;
> +		split_size = round_up(bio_start, stripe_size) - bio_start;
> +		bio = raid10_split_bio(conf, bio, split_size, false);
> +	}
> +	if (geo.far_offset && (bio_end & stripe_mask)) {
> +		sector_t split_size;
> +		split_size = bio_sectors(bio) - (bio_end & stripe_mask);
> +		bio = raid10_split_bio(conf, bio, split_size, true);
> +	}

So far layout is handled here. I think the hole issue is existed for far 
layout,
Just FYI.

> +
> +	r10_bio = mempool_alloc(&conf->r10bio_pool, GFP_NOIO);
> +	r10_bio->mddev = mddev;
> +	r10_bio->state = 0;
> +	memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) * conf->geo.raid_disks);
> +
> +	wait_blocked_dev(mddev, geo.raid_disks);
> +
> +	r10_bio->master_bio = bio;
> +
> +	bio_start = bio->bi_iter.bi_sector;
> +	bio_end = bio_end_sector(bio);
> +
> +	/* raid10 uses chunk as the unit to store data. It's similar like raid0.
> +	 * One stripe contains the chunks from all member disk (one chunk from
> +	 * one disk at the same HAB address). For layout detail, see 'man md 4'
> +	 */

s/HAB/HBA/

Thanks,
Guoqing
