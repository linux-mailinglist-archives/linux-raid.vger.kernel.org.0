Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 942502B189
	for <lists+linux-raid@lfdr.de>; Mon, 27 May 2019 11:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfE0JqY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 May 2019 05:46:24 -0400
Received: from drutsystem.com ([84.10.39.251]:59550 "EHLO drutsystem.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfE0JqX (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 27 May 2019 05:46:23 -0400
Subject: Re: Few questions about (attempting to use) write journal + call
 traces
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ziu.info; s=ziu;
        t=1558950374; bh=rWKZmmRoV7iHTBc/rsgxTrPmTh4ldjTmH8MYqNl+rRk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gJogzi41hxlTpLse77cYCVk/yLPgqoXZ3DmTYKMmGU2SuklvN327gP7gqWvtdq4gx
         +Vc9FI+Nf6FGvvElS3NvMqabeIoQpxgNeM5QwWAx/7345PgYmRO3IflEybrOnKjzmc
         blmPThoVrLZ8imjVl43Z/WZRGzVq+H9GTrfwKH88=
To:     Song Liu <liu.song.a23@gmail.com>, Xiao Ni <xni@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <0fd0ab3a-7e7e-b4d5-fffe-c34f3868a8dd@ziu.info>
 <CAPhsuW4ZetsxTjuACOBekboNTtbqc0pYbXn01KtE1oZ8MoKU3w@mail.gmail.com>
 <ae69671c-7763-916e-5b45-0ff4741293eb@ziu.info>
 <CAPhsuW4yMSjzb0FCQsRWJCYmXNQM5Y2o_LCOE-6C7gTOcCNrEQ@mail.gmail.com>
 <32f8bf8c-6a81-0490-f702-fa9cc41c38e9@ziu.info>
 <CAPhsuW6FOoOxfCMov0bTUeLrWYN6f8-ZisW9HLCRXKPJhHE1Hw@mail.gmail.com>
From:   Michal Soltys <soltys@ziu.info>
Message-ID: <de217f41-52e1-886a-fa60-52cd830864ad@ziu.info>
Date:   Mon, 27 May 2019 11:46:13 +0200
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6FOoOxfCMov0bTUeLrWYN6f8-ZisW9HLCRXKPJhHE1Hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-MailScanner-ID: 7855974C70A.A073E
X-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailScanner-From: soltys@ziu.info
X-Spam-Status: No
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/24/19 7:51 PM, Song Liu wrote:
> On Fri, May 24, 2019 at 3:51 AM Michal Soltys <soltys@ziu.info> wrote:
>>
>> On 5/23/19 8:09 PM, Song Liu wrote:
>>>>>
>>>>
>>>> Actually, this seems to be unreleated to underlying devices - the culprit seems to be attempting to write to an array after adding journal, without stopping and reassembling it first. Details below.
>>>
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
>>
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

Well I will give it a shot probably. My case scenario is that a bunch of 
sync-happy VMs on top of lvm+raid seem to be crushing performance 
(unless there are other reasons), even with very small disk usage.

Out of curiosity - is the journal in writeback mode controllable in some 
way (e.g. frequency of how often it flushes to raid disks, whether it's 
space or time (or both) based ?).




> + Xiao, who might be working on this.
> 
> Thanks,
> Song
> 

