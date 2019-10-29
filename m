Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A0DE9268
	for <lists+linux-raid@lfdr.de>; Tue, 29 Oct 2019 22:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfJ2VyO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 29 Oct 2019 17:54:14 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:37671 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727706AbfJ2VyN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 29 Oct 2019 17:54:13 -0400
Received: from [IPv6:2001:980:b8b2:1:953c:3bd3:747b:48b4]
 ([IPv6:2001:980:b8b2:1:953c:3bd3:747b:48b4])
        by smtp-cloud9.xs4all.net with ESMTPSA
        id PZRKiVUp2sBskPZRLiJ9Im; Tue, 29 Oct 2019 22:54:11 +0100
Subject: Re: raid0 layout issue documentation / confusions
To:     Wol's lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
References: <1389f13b-eaf0-7ae2-d99b-697ae008f2c9@hegyi.info>
 <ea1d4d12-0b92-ab2f-3911-0de21f1a40ee@youngman.org.uk>
From:   Andreas Hegyi <a@hegyi.info>
Message-ID: <5c8c9e4a-51f2-a1a1-bc5b-2cf812683447@hegyi.info>
Date:   Tue, 29 Oct 2019 22:54:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ea1d4d12-0b92-ab2f-3911-0de21f1a40ee@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: nl
X-CMAE-Envelope: MS4wfM+CzkYAboCrOeLQdzkX+hlSWKAItaeAwW/GEfZUHivNaWyq8aFr6+wAH+oHDzG3EdZ7kIweXep2vRd9upONz8Nwu0eQo3Esky40egJl7YTNEvqvaANX
 h9Gbf74VC1JtWNt2sHDfqj3Sb0xCZtPSVGePRS/XDDSKYtwM0K3+zMxFr8ZKHPmUgcbP/863HgcFAzfoNJHsJ/bydCxkR74LqHR6Zy0Va3M1GNVC27g09Xhf
 eGcoaJisMdhCpvr7rGE26rNEW18ZXkjdTrM8AR1tUfmX/xGPBHIW+lbuEdxczPiQYjAV+oakFHjDggrSUVEmqQ==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 10/29/19 11:33 PM, Wol's lists wrote:
> On 29/10/2019 21:21, Andreas wrote:
>> (I wanted to react to the thread "admin-guide page for raid0 layout issue", but I just registered and I don't know how to respond to
>> existing messages.)
>
> Just read a message in your email client and hit "reply" - unless you're not reading the mailing list as email?
There was no message to reply to, because I just registered.
>>
>> I would like to make some suggestions regarding the recent raid0 layout patch, as it made my system unbootable, and it took me quite some 
>> time to figure out what was wrong and how to fix it. I also encountered confusion on the web. I am just a regular user, not a programmer 
>> or linux guru, so take my suggestions as such.
>
> Bear mind that the layout only changed as a result of a bug slipping through - the layout should not have changed. The problem is that 
> once it got in to the wild, we have to live with it. There's nowhere in the metadata for it to go, because it shouldn't have been needed. 
> It couldn't be reverted because that would break any arrays created with the "faulty" kernel. So what to do?
>
> At the end of the day, the devs have done their best to fix an issue that should never have happened. But shit does happen, unfortunately.
>
I understand that the devs are doing the best, and mistakes happen. However the confusing documentation (even in the patch description!) may 
also cause data corruption.

BTW, I do see a layout field in the raid metadata definitions, which is undefined (yet) for raid0 (offset 0x4C-0x4F). 
https://raid.wiki.kernel.org/index.php/RAID_superblock_formats.
