Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB8D203562
	for <lists+linux-raid@lfdr.de>; Mon, 22 Jun 2020 13:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgFVLMN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 22 Jun 2020 07:12:13 -0400
Received: from forward104o.mail.yandex.net ([37.140.190.179]:45545 "EHLO
        forward104o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727822AbgFVLMM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 22 Jun 2020 07:12:12 -0400
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id 0F58E94163D;
        Mon, 22 Jun 2020 14:12:05 +0300 (MSK)
Received: from mxback3q.mail.yandex.net (mxback3q.mail.yandex.net [IPv6:2a02:6b8:c0e:39:0:640:4545:437c])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id 0D6C7CF40002;
        Mon, 22 Jun 2020 14:12:05 +0300 (MSK)
Received: from vla1-ad90edf60279.qloud-c.yandex.net (vla1-ad90edf60279.qloud-c.yandex.net [2a02:6b8:c0d:d87:0:640:ad90:edf6])
        by mxback3q.mail.yandex.net (mxback/Yandex) with ESMTP id dvpYKVajci-C46aMIso;
        Mon, 22 Jun 2020 14:12:05 +0300
Received: by vla1-ad90edf60279.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id lnqtBN2Wid-C4lSgJk0;
        Mon, 22 Jun 2020 14:12:04 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: Assemblin journaled array fails
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
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
 <a772ede5-1d6f-e7cd-e949-a5d81d0fdbd1@yandex.pl>
 <CAPhsuW5hwAMTy8ozpsT+n5F3M7NzKqBdheFZvnouZEv8hEqAxQ@mail.gmail.com>
From:   Michal Soltys <msoltyspl@yandex.pl>
Message-ID: <4b426e56-f971-67cf-81c0-63e035bf492a@yandex.pl>
Date:   Mon, 22 Jun 2020 13:12:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5hwAMTy8ozpsT+n5F3M7NzKqBdheFZvnouZEv8hEqAxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/20/20 2:14 AM, Song Liu wrote:
> On Fri, Jun 19, 2020 at 4:35 AM Michal Soltys <msoltyspl@yandex.pl> wrote:
>>
>> On 6/17/20 7:11 PM, Song Liu wrote:
>>>>
>>>>> 1. There are two pr_debug() calls in handle_stripe():
>>>>>           pr_debug("handling stripe %llu, state=%#lx cnt=%d, "
>>>>>           pr_debug("locked=%d uptodate=%d to_read=%d"
>>>>>
>>>>>        Did you enable all of them? Or only the first one?
>>>>
>>>> I enabled all of them (I think), to be precise:
>>>>
>>>> echo -n 'func handle_stripe +p' >/sys/kernel/debug/dynamic_debug/control
>>>>
>>>> Haven't seen any `locked` lines though.
>>>
>>> That's a little weird, and probably explains why we stuck. Could you
>>> please try the attached patch?
>>>
>>> Thanks,
>>> Song
>>>
>>
>> I've started assembly with the above patch, the output can be inspected
>> from this file:
>>
>> https://ufile.io/yx4bbcb4
>>
>> This is ~5mb packed dmesg from start of the boot to the relevant parts,
>> unpacks to ~150mb file.
> 
> Thanks for the trace. Looks like we may have some issues with
> MD_SB_CHANGE_PENDING.
> Could you please try the attached patch?

Should I run this along with pr_debugs from the previous patch enabled ?
