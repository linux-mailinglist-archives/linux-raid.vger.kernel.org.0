Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A840239B44
	for <lists+linux-raid@lfdr.de>; Sat,  8 Jun 2019 07:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfFHFV2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 8 Jun 2019 01:21:28 -0400
Received: from mail.prgmr.com ([71.19.149.6]:52402 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfFHFV2 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 8 Jun 2019 01:21:28 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Jun 2019 01:21:27 EDT
Received: from [192.168.2.33] (c-174-62-72-237.hsd1.ca.comcast.net [174.62.72.237])
        (Authenticated sender: srn)
        by mail.prgmr.com (Postfix) with ESMTPSA id ACA8C28C00C
        for <linux-raid@vger.kernel.org>; Sat,  8 Jun 2019 06:12:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com ACA8C28C00C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1559988768;
        bh=/ThMRB6DztJuynVtvc696AQIK2rtZF0JQ/EZYxWnThc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=pIFYhtm7Sq4xwx212c24rIfoF3asdtQVBswnvONHIpXaE7hBfH2UbLtBRCKdg7U8V
         HZBsGtyNSDcgiUBtHpPNqUpKQt/pq5deS5GS4FdfjZwBqzlkE/F2mtLpAzwUB2q7HB
         hnF+38US0GVY3URAzUjT5rXSNN8Ad3NkoLClUTS8=
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
To:     linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <6b34f202-65c4-b6f9-0ae1-cbb517c2b8f2@suse.com>
 <20190601053925.GO4569@bitfolk.com> <20190607112219.GA4569@bitfolk.com>
From:   Sarah Newman <srn@prgmr.com>
Openpgp: preference=signencrypt
Message-ID: <e0aa2876-cd07-8c38-97f7-a72b279f28e3@prgmr.com>
Date:   Fri, 7 Jun 2019 22:15:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607112219.GA4569@bitfolk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/7/19 4:22 AM, Andy Smith wrote:
> On Sat, Jun 01, 2019 at 05:39:25AM +0000, Andy Smith wrote:
>> On Fri, May 31, 2019 at 09:43:35AM +0800, Guoqing Jiang wrote:
>>> There are some optimizations in raid1's read_balance for ssd, unfortunately,
>>> raid10 didn't have similar code.
> 
> […]
> 
>> Is it just that no one has tried to apply the same optimizations to
>> RAID-10, or is it technically difficult/impossible to do this in
>> RAID-10?
> 
> Guoqing sent me a patch off-list that implements these same device
> selection optimizations to RAID-10, and it seems to work. RAID-10
> random read performance in this setup is now the same as RAID-1
> (both very near to fastest device) and sequential read is even
> better than RAID-1.
> 
>     http://strugglers.net/~andy/blog/2019/06/06/linux-raid-10-fixed-on-imbalanced-devices/

We've been seriously considering switching from raid10 to lvm stripes across raid1 for a different reason.

Crucial/Micron SSDs, even the enterprise ones, do not always finish smart tests under some read loads. With RAID1 we could set them temporarily to
write-mostly so that they can finish their smart tests and vendor tests. It would be really nice if with RAID10 we could also set drives to write-mostly.

--Sarah
