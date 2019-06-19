Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850B84B0E6
	for <lists+linux-raid@lfdr.de>; Wed, 19 Jun 2019 06:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbfFSEin (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 19 Jun 2019 00:38:43 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:46011 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfFSEin (ORCPT
        <rfc822;groupwise-linux-raid@vger.kernel.org:0:0>);
        Wed, 19 Jun 2019 00:38:43 -0400
Received: from linux-fcij.suse (prva10-snat226-2.provo.novell.com [137.65.226.36])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Tue, 18 Jun 2019 22:38:36 -0600
Subject: Re: [PATCH 1/5] md/raid1: fix potential data inconsistency issue with
 write behind device
To:     nikolay@oldum.net, Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20190614091039.32461-1-gqjiang@suse.com>
 <20190614091039.32461-2-gqjiang@suse.com>
 <CAPhsuW6eYaqxmHzHeu8UzXXx+DH-2FkEtQcWfvHp-YKTVe2U6Q@mail.gmail.com>
 <a8504a6a-6ecf-798a-0d3b-1243936b5588@suse.com>
 <CAPhsuW4YqH46jiSH9OEzUMf3rBCoJPa_=+ekVEi5s==sx=SWRQ@mail.gmail.com>
 <545a6f2a-7dab-e6b6-649a-6e6e67f10e0e@suse.com>
 <dcc1af10-6e45-464a-bb6d-e4f5e446788a@oldum.net>
From:   Guoqing Jiang <gqjiang@suse.com>
Message-ID: <25524d6e-ad56-8da3-f0ae-bbb935c7e2b0@suse.com>
Date:   Wed, 19 Jun 2019 12:38:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <dcc1af10-6e45-464a-bb6d-e4f5e446788a@oldum.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

On 6/18/19 5:30 PM, Nikolay Kichukov wrote:
> Hello,
> 
> Is there a proper patch formatted variant of this where I can download
> and test? Or is it included in a released kernel already?
>

As you can see, it is still in review stage, so the patch is not in any 
released kernel.

I suppose you can get the patch from the archive, but I am not sure
if it can apply directly.

> I am seeing an issue, where one of the write-mostly disks in a 3 disk
> raid1 array consisting of one ssd and 2 spinning disks(write-mostly) is
> causing the mismatch_cnt to go as high as 1,5 million and a repair does
> not fix it. So this looks like a good potential resolver.
> 

You are more than welcome to test the patch. And I can rebase the patch
to your kernel version if needed.

Thanks,
Guoqing
