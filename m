Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98BB41A0CCF
	for <lists+linux-raid@lfdr.de>; Tue,  7 Apr 2020 13:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDGL2R (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 Apr 2020 07:28:17 -0400
Received: from atl.turmel.org ([74.117.157.138]:60113 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgDGL2R (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 7 Apr 2020 07:28:17 -0400
Received: from [108.243.25.188] (helo=[192.168.20.61])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1jLmOu-0005UV-Ai; Tue, 07 Apr 2020 07:28:16 -0400
Subject: Re: Raid-6 cannot reshape
To:     Alexander Shenkin <al@shenkin.org>,
        Wols Lists <antlists@youngman.org.uk>,
        Roger Heflin <rogerheflin@gmail.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
References: <24a0ef04-46a9-13ee-b8cb-d1a0a5b939fb@shenkin.org>
 <6b9b6d37-6325-6515-f693-0ff3b641a67a@shenkin.org>
 <3135fb29-cfaa-d8ac-264d-fd3110217370@shenkin.org>
 <CAAMCDecyr4R_z3-E8HYwYM4CyQtAY_nBmXdvvMkTgZCcCp7MjQ@mail.gmail.com>
 <5E8B5865.9060107@youngman.org.uk>
 <08d66411-5045-56e1-cbad-7edefa94a363@turmel.org>
 <945332b3-6a47-c2b3-7d1e-70a44f6fd370@shenkin.org>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <b9bb796e-08cd-e10a-d345-992e5f3abea7@turmel.org>
Date:   Tue, 7 Apr 2020 07:28:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <945332b3-6a47-c2b3-7d1e-70a44f6fd370@shenkin.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Allie,

On 4/7/20 6:25 AM, Alexander Shenkin wrote:
> 
> 
> On 4/6/2020 9:34 PM, Phil Turmel wrote:
>> On 4/6/20 12:27 PM, Wols Lists wrote:
>>> On 06/04/20 17:12, Roger Heflin wrote:
>>>> When I looked at your detailed files you sent a few days ago, all of
>>>> the reshapes (on all disks) indicated that they were at position 0, so
>>>> it kind of appears that the reshape never actually started at all and
>>>> hung immediately which is probably why it cannot find the critical
>>>> section, it hung prior to that getting done.   Not entirely sure how
>>>> to undo a reshape that failed like this.
>>>
>>> This seems quite common. Search the archives - it's probably something
>>> like --assemble --revert-reshape.
>>
>> Ah, yes.  I recall cases where mdmon wouldn't start or wouldn't open the
>> array to start moving the stripes, so the kernel wouldn't advance.
>> SystemD was one of the culprits, I believe, back then.
> 
> Thanks all.
> 
> So, is the following safe to run, and a good idea to try?
> 
> mdadm --assemble --update=revert-reshape /dev/md127 /dev/sd[a-g]3

Yes.

> And if that doesn't work, add a force? >
> mdadm --assemble --force --update=revert-reshape /dev/md127 /dev/sd[a-g]3

Yes.

> And adding --invalid-backup if it complains about backup files?

Yes.

> Thanks,
> Allie

Phil

