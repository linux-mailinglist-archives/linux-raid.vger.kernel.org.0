Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF7C2B2C5
	for <lists+linux-raid@lfdr.de>; Mon, 27 May 2019 13:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfE0LIa (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 May 2019 07:08:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfE0LI3 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 27 May 2019 07:08:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05C33330260;
        Mon, 27 May 2019 11:08:29 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A8C660606;
        Mon, 27 May 2019 11:08:25 +0000 (UTC)
Subject: Re: Few questions about (attempting to use) write journal + call
 traces
To:     Song Liu <liu.song.a23@gmail.com>, Michal Soltys <soltys@ziu.info>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <0fd0ab3a-7e7e-b4d5-fffe-c34f3868a8dd@ziu.info>
 <CAPhsuW4ZetsxTjuACOBekboNTtbqc0pYbXn01KtE1oZ8MoKU3w@mail.gmail.com>
 <ae69671c-7763-916e-5b45-0ff4741293eb@ziu.info>
 <CAPhsuW4yMSjzb0FCQsRWJCYmXNQM5Y2o_LCOE-6C7gTOcCNrEQ@mail.gmail.com>
 <32f8bf8c-6a81-0490-f702-fa9cc41c38e9@ziu.info>
 <CAPhsuW6FOoOxfCMov0bTUeLrWYN6f8-ZisW9HLCRXKPJhHE1Hw@mail.gmail.com>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <24dcc1a6-66f6-0a8c-ff6f-bfdf13ff73e1@redhat.com>
Date:   Mon, 27 May 2019 19:08:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6FOoOxfCMov0bTUeLrWYN6f8-ZisW9HLCRXKPJhHE1Hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 27 May 2019 11:08:29 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 05/25/2019 01:51 AM, Song Liu wrote:
> On Fri, May 24, 2019 at 3:51 AM Michal Soltys <soltys@ziu.info> wrote:
>> On 5/23/19 8:09 PM, Song Liu wrote:
>>>> Actually, this seems to be unreleated to underlying devices - the culprit seems to be attempting to write to an array after adding journal, without stopping and reassembling it first. Details below.
>>> Thanks for these experiments. Your analysis makes perfect sense.
>>>
>>> Do you think you can continue the  experiments with the write journal before
>>> this issue got fixed?
>>>
>>> I am asking because this is not on the top of my list at this time. If
>>> this is not
>>> blocking other important tests, I would prefer to fix it at a later time.
>>>
>>> Thanks,
>>> Song
>>>
>> Yea it's fine. I can help with testing (whenever you sit down to this
>> issues) as well.
>>
>> Question though - other than trying to add journal to existing live raid
>> - is this feature overall safe to use (or are there any other know
>> issues one should be aware of beforehand) ?
>>
> We (Facebook) have done some tests with it. However, we didn't put
> it into production. The reason behind this decision was not reliability, but
> performance concerns and high level directions. I think Redhat is
> evaluating it.
>
> + Xiao, who might be working on this.
>
Hi all

It's easy to reproduce this. I enable debug logs and there are some hints

[  163.227472] handling stripe 0, state=0x2041 cnt=1, pd_idx=2, qd_idx=-1
                , check:0, reconstruct:5
[  163.227472] check 2: state 0x10013 read           (null) 
write           (null) written           (null)
[  163.227473] check 1: state 0x11 read           (null) write           
(null) written           (null)
[  163.227473] check 0: state 0x1001b read           (null) 
write           (null) written 00000000a1271076
[  163.227474] locked=2 uptodate=3 to_read=0 to_write=0 failed=0 
failed_num=-1,-1
[  163.227474] Writing block 2
[  163.227474] Writing block 0

After writing block there is no response. So the I/O hasn't finished yet.
I'll update more information later.

Regards
Xiao
