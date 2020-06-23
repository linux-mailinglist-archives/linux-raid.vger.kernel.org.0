Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7CD205345
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jun 2020 15:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbgFWNRl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Jun 2020 09:17:41 -0400
Received: from forward102p.mail.yandex.net ([77.88.28.102]:52059 "EHLO
        forward102p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732580AbgFWNRk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 23 Jun 2020 09:17:40 -0400
Received: from mxback14g.mail.yandex.net (mxback14g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:93])
        by forward102p.mail.yandex.net (Yandex) with ESMTP id 9EAC41D41C89;
        Tue, 23 Jun 2020 16:17:37 +0300 (MSK)
Received: from sas1-26681efc71ef.qloud-c.yandex.net (sas1-26681efc71ef.qloud-c.yandex.net [2a02:6b8:c08:37a4:0:640:2668:1efc])
        by mxback14g.mail.yandex.net (mxback/Yandex) with ESMTP id EEkquSDJ6m-Hb8GIoPI;
        Tue, 23 Jun 2020 16:17:37 +0300
Received: by sas1-26681efc71ef.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 4FBjRRMB2C-Ha88g7uu;
        Tue, 23 Jun 2020 16:17:37 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: Assemblin journaled array fails
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
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
 <4b426e56-f971-67cf-81c0-63e035bf492a@yandex.pl>
 <CAPhsuW6fvgRCz7X7nnCEof4+yy2fTsxShNCuqTkMC0JQpj6gKw@mail.gmail.com>
From:   Michal Soltys <msoltyspl@yandex.pl>
Message-ID: <57247f5e-ec38-fb8c-9684-abbe699945fb@yandex.pl>
Date:   Tue, 23 Jun 2020 15:17:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6fvgRCz7X7nnCEof4+yy2fTsxShNCuqTkMC0JQpj6gKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/22/20 6:37 PM, Song Liu wrote:
>>>
>>> Thanks for the trace. Looks like we may have some issues with
>>> MD_SB_CHANGE_PENDING.
>>> Could you please try the attached patch?
>>
>> Should I run this along with pr_debugs from the previous patch enabled ?
> 
> We don't need those pr_debug() here.
> 
> Thanks,
> Song
> 

So with this patch attached, there is no extra output whatsoever - once it finished getting past this point:

[  +0.371752] r5c_recovery_rewrite_data_only_stripes rewritten 20001 stripes to the journal, current ctx->pos 408461384 ctx->seq 866603361                           
[  +0.395000] r5c_recovery_rewrite_data_only_stripes rewritten 21001 stripes to the journal, current ctx->pos 408479568 ctx->seq 866604361                           
[  +0.371255] r5c_recovery_rewrite_data_only_stripes rewritten 22001 stripes to the journal, current ctx->pos 408496600 ctx->seq 866605361                           
[  +0.401013] r5c_recovery_rewrite_data_only_stripes rewritten 23001 stripes to the journal, current ctx->pos 408515472 ctx->seq 866606361                           
[  +0.370543] r5c_recovery_rewrite_data_only_stripes rewritten 24001 stripes to the journal, current ctx->pos 408532112 ctx->seq 866607361                           
[  +0.319253] r5c_recovery_rewrite_data_only_stripes done
[  +0.061560] r5c_recovery_flush_data_only_stripes enter
[  +0.075697] r5c_recovery_flush_data_only_stripes before wait_event

That is, besides 'task <....> blocked for' traces or unless pr_debug()s were enabled.

There were a few 'md_write_start set MD_SB_CHANGE_PENDING' *before* that (all of them likely related to another raid that is active at the moment, as these were happening during that lengthy r5c_recovery_flush_log() process).
