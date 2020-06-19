Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F432007F2
	for <lists+linux-raid@lfdr.de>; Fri, 19 Jun 2020 13:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbgFSLgc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 19 Jun 2020 07:36:32 -0400
Received: from forward104j.mail.yandex.net ([5.45.198.247]:51018 "EHLO
        forward104j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728624AbgFSLfv (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 19 Jun 2020 07:35:51 -0400
Received: from mxback7j.mail.yandex.net (mxback7j.mail.yandex.net [IPv6:2a02:6b8:0:1619::110])
        by forward104j.mail.yandex.net (Yandex) with ESMTP id 0FB9A4A1D21;
        Fri, 19 Jun 2020 14:35:20 +0300 (MSK)
Received: from sas8-b61c542d7279.qloud-c.yandex.net (sas8-b61c542d7279.qloud-c.yandex.net [2a02:6b8:c1b:2912:0:640:b61c:542d])
        by mxback7j.mail.yandex.net (mxback/Yandex) with ESMTP id 4YCYSyIb8M-ZJFqcS95;
        Fri, 19 Jun 2020 14:35:20 +0300
Received: by sas8-b61c542d7279.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id MVzNfsOBDs-ZJPiUBvH;
        Fri, 19 Jun 2020 14:35:19 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: Assemblin journaled array fails
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <7b2b2bca-c1b7-06c5-10c5-2b1cdda21607@yandex.pl>
 <48e4fa28-4d20-ba80-cd69-b17da719531a@yandex.pl>
 <CAPhsuW69VYgLBZboxvQ6-Fmm-Oa0fGOVBg3SOVkzP_UopH+_wg@mail.gmail.com>
 <1767d7aa-6c60-7efb-bf37-6506f9aaa8a2@yandex.pl>
 <CAPhsuW4oMKuCrHUU1ucsMKQbSfBQdsNEQWHA1SSbGR5nbvy21w@mail.gmail.com>
 <CAPhsuW4WBDGGLYc=f4xoThxtxuF5K74m3odJ-uA98DuPLJR4nw@mail.gmail.com>
 <0cf6454d-a8b5-4bee-5389-94b23c077050@yandex.pl>
 <CAPhsuW51u6KWLvUntMXPU7stu7oSA+d-yT6zf7G0zCETzLWwiA@mail.gmail.com>
 <49efa0d2-b44c-ec85-5e44-fb93a15001e7@yandex.pl>
 <4df42e3d-ad2b-dfc2-3961-49ada4ea7eaf@yandex.pl>
 <CAPhsuW5kk0G9PSfEADc8+rn=QT2z4ogjuV98qWsH_s_WBic-5w@mail.gmail.com>
 <71f58507-314e-4a1d-dd50-41a60d76521b@yandex.pl>
 <CAPhsuW59Q7mU9WH36RHs9kb-TMk7FmrQL+JCApupf_TZtpWynA@mail.gmail.com>
 <4a03e900-61a8-f150-9be8-739e88ba8ce6@yandex.pl>
 <CAPhsuW4BZE-DeESsq-coNx5_KZrfHjP=d9YOjOPqPji5kQBXjg@mail.gmail.com>
From:   Michal Soltys <msoltyspl@yandex.pl>
Message-ID: <a772ede5-1d6f-e7cd-e949-a5d81d0fdbd1@yandex.pl>
Date:   Fri, 19 Jun 2020 13:35:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4BZE-DeESsq-coNx5_KZrfHjP=d9YOjOPqPji5kQBXjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/17/20 7:11 PM, Song Liu wrote:
>>
>>> 1. There are two pr_debug() calls in handle_stripe():
>>>          pr_debug("handling stripe %llu, state=%#lx cnt=%d, "
>>>          pr_debug("locked=%d uptodate=%d to_read=%d"
>>>
>>>       Did you enable all of them? Or only the first one?
>>
>> I enabled all of them (I think), to be precise:
>>
>> echo -n 'func handle_stripe +p' >/sys/kernel/debug/dynamic_debug/control
>>
>> Haven't seen any `locked` lines though.
> 
> That's a little weird, and probably explains why we stuck. Could you
> please try the attached patch?
> 
> Thanks,
> Song
> 

I've started assembly with the above patch, the output can be inspected 
from this file:

https://ufile.io/yx4bbcb4

This is ~5mb packed dmesg from start of the boot to the relevant parts, 
unpacks to ~150mb file.
