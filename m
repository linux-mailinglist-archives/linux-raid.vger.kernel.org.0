Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689C0255E90
	for <lists+linux-raid@lfdr.de>; Fri, 28 Aug 2020 18:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgH1QGr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 28 Aug 2020 12:06:47 -0400
Received: from mailout-l3b-97.contactoffice.com ([212.3.242.97]:38128 "EHLO
        mailout-l3b-97.contactoffice.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726954AbgH1QGp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 28 Aug 2020 12:06:45 -0400
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
        by mailout-l3b-97.contactoffice.com (Postfix) with ESMTP id 75CA63E9
        for <linux-raid@vger.kernel.org>; Fri, 28 Aug 2020 18:06:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailfence.com;
        s=20160819-nLV10XS2; t=1598630802;
        bh=o5LU47srRIAAAfW4ucEQXMaPvmJaIZ8T0h76CnNBzGk=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=VGCqp5NGeRZbCFhHPvBQoT6qCcFnxZTPDDd0vbRRHdF2226WnBEudBYagHL9qOND1
         Zi3XoEmgB7dx3JockNM4szMVaNnZhfU0xIIpFHjkb1BE3UirPQAW14cwWILPTa/Zjg
         +S/X+DLD3JDg6ks12ngqolAStdxF/MShKyJVT6CwQdHHVpCn4ieUCStBYJFA/192J+
         XO3B8VQow23NC7bwHQdG0ypj0X1rmEn7/Omk1lzq5pdMrcUct4UEjpRWRCPCfGGDz7
         T6RCK8azX7D94DHM65eJnsALFT/uLSwikUKO9dfbCXiVtHl4WMi54A8/Eb+4eGkcSh
         OsIXWc30Vd+Fw==
Received: by smtp.mailfence.com with ESMTPA
          for <linux-raid@vger.kernel.org> ; Fri, 28 Aug 2020 18:06:38 +0200 (CEST)
Date:   Fri, 28 Aug 2020 18:06:39 +0200 (CEST)
From:   grumpy@mailfence.com
To:     linux-raid@vger.kernel.org
Subject: Re: increase size of raid
In-Reply-To: <d6a5a32d-07e7-cd77-8e1d-55216f98bc15@youngman.org.uk>
Message-ID: <nycvar.QRO.7.76.2008281104480.2090@tehzcl5.tehzcl-arg>
References: <nycvar.QRO.7.76.2008241430040.28072@tehzcl5.tehzcl-arg> <d6a5a32d-07e7-cd77-8e1d-55216f98bc15@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Flag: NO
X-Spam-Status: No, hits=-2.6 required=4.7 symbols=ALL_TRUSTED,BAYES_00,HEADER_FROM_DIFFERENT_DOMAINS device=10.2.0.1
X-ContactOffice-Account: com:191882055
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, 28 Aug 2020, antlists wrote:

> On 24/08/2020 20:33, grumpy@mailfence.com wrote:
>> i have 2 6tb drives
>> i use a 3tb partition on each drive for raid 1
>> i want to increase the size of the partitions
>> what are the steps for this that will result in the least likelihood of me 
>> screw'n up my system
>> thanks
>
> Seeing as no-one else has commented - you don't happen to have a spare disk 
> by any chance? In that case you simply create a new 6TB partition on your new 
> disk, and do a replace. You can then rinse and repeat with the disk you've 
> just freed.
>
> Otherwise, what I think you do is ... SHUT DOWN THE ARRAY. I *think* you can 
> increase the partition size by deleting the old 3TB partition then just 
> creating a new one starting in exactly the same place. Do it on one disk, 
> test it by restarting the array. If it works, rinse and repeat on the second 
> disk.
>
> You now have a 3TB array on 2 6TB partitions. You should be able to do an 
> "mdadm --grow" on the array - no need to specify the size as it should 
> default to 6TB - to make a 6TB array. There are reports that might fail - a 
> reboot should fix that - and you can now grow your filesystem to use the 
> whole array.
>
> Cheers,
> Wol
>

that's exactly what i did
no lost data
thanks
