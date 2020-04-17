Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DC61ADB0D
	for <lists+linux-raid@lfdr.de>; Fri, 17 Apr 2020 12:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgDQK2o (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 17 Apr 2020 06:28:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:12036 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbgDQK2n (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 17 Apr 2020 06:28:43 -0400
IronPort-SDR: 3nONTvrgkTmq3Ah/GbR48EP4SvlCEtFVdRwEsdKrZZVd8BRaAJjAqHIueh/Zf+VB3mkQsgDEOJ
 m4Vnwv/aMk3A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 03:28:42 -0700
IronPort-SDR: YxqiDh7lnjp9tSyJWGpVJLKtceGyPBAlEZ0lPrLUFd9M9M7kLxlooMfznWPquuuiBK5+x843Jx
 ARKpPklhSFPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,394,1580803200"; 
   d="scan'208";a="428186055"
Received: from unknown (HELO apaszkie-desk.igk.intel.com) ([10.213.1.226])
  by orsmga005.jf.intel.com with ESMTP; 17 Apr 2020 03:28:41 -0700
Subject: Re: [BUG REPORT] md raid5 with write log does not start
To:     Coly Li <colyli@suse.de>, linux-raid@vger.kernel.org
References: <4ad57f1f-a00f-3bc6-33d2-f30ca8e18c0d@suse.de>
From:   Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Message-ID: <fee374b7-0fc6-2cf9-6f36-be5c95ec3f60@intel.com>
Date:   Fri, 17 Apr 2020 12:28:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4ad57f1f-a00f-3bc6-33d2-f30ca8e18c0d@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/16/20 6:30 PM, Coly Li wrote:
> Hi folks,
> 
> When I try to create md raid5 array with 4 NVMe SSD (3 for raid array
> component disks, 1 for write log), the kernel is Linux v5.6 (not Linux
> v5.7-rc), I find the md raid5 array cannot start.
> 
> I use this command to create md raid5 with writelog,
> 
> mdadm -C /dev/md0 -l 5 -n 3 /dev/nvme{0,1,2}n1 --write-journal /dev/nvme3n1
> 
> From terminal I have the following 2 lines information,
> 
> mdadm: Defaulting to version 1.2 metadata
> mdadm: RUN_ARRAY failed: Invalid argument
> 
> From kernel message, I have the following dmesg lines,
> 
> [13624.897066] md/raid:md0: array cannot have both journal and bitmap
> [13624.897068] md: pers->run() failed ...
> [13624.897105] md: md0 stopped.
> 
> But from /proc/mdstat, it seems an inactive array is still created,
> 
> /proc/mdstat
> Personalities : [raid6] [raid5] [raid4]
> md127 : inactive nvme2n1[4](S) nvme0n1[0](S) nvme3n1[3](S)
>       11251818504 blocks super 1.2
> 
> unused devices: <none>
> 
> From all the information it seems when initialize raid5 cache the bitmap
> information is not cleared, so an error message shows up and raid5_run()
> fails.
> 
> I don't have clear idea who to handle bitmap, journal and ppl properly,
> so I firstly report the problem here.
> 
> So far I am not sure whether this is a bug or I do something wrong. Hope
> other people may reproduce the above failure too.

Hi Coly,

It looks like the mdadm that you're using added an internal bitmap
despite creating the array with a journal. I think that was fixed some
time ago. The kernel correctly does not allow starting the array with
bitmap and journal (or ppl). You can assemble this now with:

mdadm -A /dev/md0 /dev/nvme[0-3]n1 --update=no-bitmap

You can also explicitly tell mdadm not to add a bitmap when creating an
array using "--bitmap=none".

Regards,
Artur

