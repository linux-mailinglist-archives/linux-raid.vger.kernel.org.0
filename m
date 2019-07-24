Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E8572A24
	for <lists+linux-raid@lfdr.de>; Wed, 24 Jul 2019 10:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfGXIc7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 24 Jul 2019 04:32:59 -0400
Received: from drutsystem.com ([84.10.39.251]:58239 "EHLO drutsystem.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfGXIc7 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 24 Jul 2019 04:32:59 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jul 2019 04:32:59 EDT
Received: from [10.227.137.2] (89-76-20-72.dynamic.chello.pl [89.76.20.72])
        by drutsystem.com (Postfix) with ESMTPA id BC4707B042A;
        Wed, 24 Jul 2019 10:22:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ziu.info; s=ziu;
        t=1563956573; bh=Iggd/pcaVpchBbUdRXt5ZsN0uddra+U+boa5oM/zp8M=;
        h=Subject:To:References:From:Cc:Date:In-Reply-To;
        b=7Yh4hkAoLye4cSnjM5g217IeL1UD5JtikWTq2T3x2juEswvRaX19EM22uIhRFqiO/
         aZ5ohxUXonQYMFOqIYO8YXj7UBXrcr8bM3TEar/GFBZeHNP02GtLYPqWSSnBDFrBd/
         J+uVJr5r103us8Jof6m/YAY4bQhFrlNDgiqS2o+I=
Subject: Re: slow BLKDISCARD on RAID10 md block devices
To:     Lennert Buytenhek <buytenh@wantstofly.org>
References: <20190717090200.GD2080@wantstofly.org>
From:   Michal Soltys <soltys@ziu.info>
Cc:     linux-raid@vger.kernel.org, Song Liu <liu.song.a23@gmail.com>,
        colyli@suse.de
Message-ID: <6bf5708a-28ee-9018-82c0-4637ce6e59b2@ziu.info>
Date:   Wed, 24 Jul 2019 10:23:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190717090200.GD2080@wantstofly.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MailScanner-ID: BC4707B042A.A2FCB
X-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailScanner-From: soltys@ziu.info
X-Spam-Status: No
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 19/07/17 11:02, Lennert Buytenhek wrote:
> Hello!
> 
> I've been running into an issue with background fstrim on large xfs
> filesystems on RAID10d SSDs taking a lot of time to complete and
> starving out other I/O to the filesystem.  There seem to be a few
> different issues involved here, but the main one appears to be that
> BLKDISCARD on a RAID10 md block device sends many small discard
> requests down to the underlying component devices (while this doesn't
> seem to be an issue for RAID0 or for RAID1).
> 

It seems to have super weird friction with blkdiscard sized that are not 
multiple of the chunk - and as a result did very werid things.

If you force a size that is nominally a multiple of one (from my 
testings) it will work with sensible speed (in context of raid10).

You can find more in the thread I did some time ago:

https://www.spinics.net/lists/raid/msg62094.html

While this was originally about raid456 (different issue there), check out:

https://www.spinics.net/lists/raid/msg62115.html
https://www.spinics.net/lists/raid/msg62134.html

 From blktraces you can see it sent e.g. single sized blkdiscards 
backwards across the whole array.
