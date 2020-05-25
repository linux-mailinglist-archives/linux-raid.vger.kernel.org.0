Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABF61E128F
	for <lists+linux-raid@lfdr.de>; Mon, 25 May 2020 18:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgEYQXW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 12:23:22 -0400
Received: from forward101o.mail.yandex.net ([37.140.190.181]:53119 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730015AbgEYQXW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 25 May 2020 12:23:22 -0400
Received: from mxback5g.mail.yandex.net (mxback5g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:166])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id 1F25C3C0012C;
        Mon, 25 May 2020 19:23:19 +0300 (MSK)
Received: from sas2-ee0cb368bd51.qloud-c.yandex.net (sas2-ee0cb368bd51.qloud-c.yandex.net [2a02:6b8:c08:b7a3:0:640:ee0c:b368])
        by mxback5g.mail.yandex.net (mxback/Yandex) with ESMTP id jp3r0g4Do0-NJiOx1fk;
        Mon, 25 May 2020 19:23:19 +0300
Received: by sas2-ee0cb368bd51.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id JC4wAoF9o6-NIW0weVP;
        Mon, 25 May 2020 19:23:18 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: Assemblin journaled array fails
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <70dad446-7d38-fd10-130f-c23797165a21@yandex.pl>
 <56b68265-ca54-05d3-95bc-ea8ee0b227f6@yandex.pl>
 <CAPhsuW4WcqkDXOhcuG33bZtSEZ-V-KYPLm87piBH24eYEB0qVw@mail.gmail.com>
 <b9b6b007-2177-a844-4d80-480393f30476@yandex.pl>
 <CAPhsuW70NNozBmt1-zsM_Pk-39cLzi8bC3ZZaNwQ0-VgYsmkiA@mail.gmail.com>
 <f9b54d87-5b81-1fa3-04d5-ea86a6c062cb@yandex.pl>
 <CAPhsuW5ZfmCowTHNum5CSeadHqqPa5049weK6bq=m+JmnDE9Vg@mail.gmail.com>
 <d0340d7b-6b3a-4fd3-e446-5f0967132ef6@yandex.pl>
 <CAPhsuW4byXUvseqoj3Pw4r5nRGu=fHekdDec8FG6vj3of1wCyg@mail.gmail.com>
From:   Michal Soltys <msoltyspl@yandex.pl>
Message-ID: <1cb6c63f-a74c-a6f4-6875-455780f53fa1@yandex.pl>
Date:   Mon, 25 May 2020 18:23:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4byXUvseqoj3Pw4r5nRGu=fHekdDec8FG6vj3of1wCyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/19/20 1:55 AM, Song Liu wrote:
> 
> 2. try use bcc/bpftrace to trace r5l_recovery_read_page(),
> specifically, the 4th argument.
> With bcc, it is something like:
> 
>      trace.py -M 100 'r5l_recovery_read_page() "%llx", arg4'
> 
> -M above limits the number of outputs to 100 lines. We may need to
> increase the limit or
> remove the constraint. If the system doesn't have bcc/bpftrace. You
> can also try with
> kprobe.
> 


Trace keeps outputting the following data (with steadily growing 4th 
argument):

PID     TID     COMM            FUNC             -
3456    3456    mdadm           r5l_recovery_read_page 98f65b8
3456    3456    mdadm           r5l_recovery_read_page 98f65c0
3456    3456    mdadm           r5l_recovery_read_page 98f65c8
3456    3456    mdadm           r5l_recovery_read_page 98f65d0
3456    3456    mdadm           r5l_recovery_read_page 98f65d8
3456    3456    mdadm           r5l_recovery_read_page 98f65e0
3456    3456    mdadm           r5l_recovery_read_page 98f65e8
3456    3456    mdadm           r5l_recovery_read_page 98f65f0
3456    3456    mdadm           r5l_recovery_read_page 98f65f8
3456    3456    mdadm           r5l_recovery_read_page 98f6600
3456    3456    mdadm           r5l_recovery_read_page 98f65c0
3456    3456    mdadm           r5l_recovery_read_page 98f65c8
3456    3456    mdadm           r5l_recovery_read_page 98f65d0
3456    3456    mdadm           r5l_recovery_read_page 98f65d8
3456    3456    mdadm           r5l_recovery_read_page 98f65e0
3456    3456    mdadm           r5l_recovery_read_page 98f65e8
3456    3456    mdadm           r5l_recovery_read_page 98f65f0
3456    3456    mdadm           r5l_recovery_read_page 98f65f8
3456    3456    mdadm           r5l_recovery_read_page 98f6600
3456    3456    mdadm           r5l_recovery_read_page 98f6608
3456    3456    mdadm           r5l_recovery_read_page 98f6610

... a few minutes later ...

PID     TID     COMM            FUNC             -
3456    3456    mdadm           r5l_recovery_read_page 9b69b60
3456    3456    mdadm           r5l_recovery_read_page 9b69b68 

3456    3456    mdadm           r5l_recovery_read_page 9b69b70
3456    3456    mdadm           r5l_recovery_read_page 9b69b78 

3456    3456    mdadm           r5l_recovery_read_page 9b69b80
3456    3456    mdadm           r5l_recovery_read_page 9b69b88
3456    3456    mdadm           r5l_recovery_read_page 9b69b90 
 

3456    3456    mdadm           r5l_recovery_read_page 9b69b98
3456    3456    mdadm           r5l_recovery_read_page 9b69ba0
3456    3456    mdadm           r5l_recovery_read_page 9b69ba8 
 

3456    3456    mdadm           r5l_recovery_read_page 9b69bb0 
 

3456    3456    mdadm           r5l_recovery_read_page 9b69bb8
3456    3456    mdadm           r5l_recovery_read_page 9b69bc0 

3456    3456    mdadm           r5l_recovery_read_page 9b69bc8
3456    3456    mdadm           r5l_recovery_read_page 9b69b90 
 

3456    3456    mdadm           r5l_recovery_read_page 9b69b98
3456    3456    mdadm           r5l_recovery_read_page 9b69ba0
3456    3456    mdadm           r5l_recovery_read_page 9b69ba8
3456    3456    mdadm           r5l_recovery_read_page 9b69bb0
3456    3456    mdadm           r5l_recovery_read_page 9b69bb8

... and so on
