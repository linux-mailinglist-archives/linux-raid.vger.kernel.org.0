Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22D7D2DD22
	for <lists+linux-raid@lfdr.de>; Wed, 29 May 2019 14:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfE2Mbd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 29 May 2019 08:31:33 -0400
Received: from drutsystem.com ([84.10.39.251]:45964 "EHLO drutsystem.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbfE2Mbc (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 29 May 2019 08:31:32 -0400
Subject: Re: Few questions about (attempting to use) write journal + call
 traces
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ziu.info; s=ziu;
        t=1559133086; bh=bcdV9/bFfMzrcbRmDowJTm1n0jyt7I5NPnCTSJAQfv8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=E0QScxWgYC4KVWz6+cRXPIMqCHq1eI6c6NYWGUOcN9Et+hQNF2jmbKHwydqMan9OX
         Xt2Q5H/j+jdgwGPULBPklOHft6D+lswtQPHq0GZTGNpuS1/2RbQ24xSbypx2D2Cg70
         fYo3gamZRBtiiNQY52YxqpS2i+oEgefAX56AF4xE=
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Xiao Ni <xni@redhat.com>, linux-raid <linux-raid@vger.kernel.org>
References: <0fd0ab3a-7e7e-b4d5-fffe-c34f3868a8dd@ziu.info>
 <CAPhsuW4ZetsxTjuACOBekboNTtbqc0pYbXn01KtE1oZ8MoKU3w@mail.gmail.com>
 <ae69671c-7763-916e-5b45-0ff4741293eb@ziu.info>
 <CAPhsuW4yMSjzb0FCQsRWJCYmXNQM5Y2o_LCOE-6C7gTOcCNrEQ@mail.gmail.com>
 <32f8bf8c-6a81-0490-f702-fa9cc41c38e9@ziu.info>
 <CAPhsuW6FOoOxfCMov0bTUeLrWYN6f8-ZisW9HLCRXKPJhHE1Hw@mail.gmail.com>
 <de217f41-52e1-886a-fa60-52cd830864ad@ziu.info>
 <CAPhsuW6cwWToqd7ag7xZWb2uosFO=qc5a2d4DFdmwc7gOrcX7g@mail.gmail.com>
From:   Michal Soltys <soltys@ziu.info>
Message-ID: <a6f2f02b-f0c9-99be-48c0-19dad8d5cb82@ziu.info>
Date:   Wed, 29 May 2019 14:31:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6cwWToqd7ag7xZWb2uosFO=qc5a2d4DFdmwc7gOrcX7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-MailScanner-ID: E4C5D74EDF6.A4311
X-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailScanner-From: soltys@ziu.info
X-Spam-Status: No
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/28/19 6:31 PM, Song Liu wrote:
> On Mon, May 27, 2019 at 2:46 AM Michal Soltys <soltys@ziu.info> wrote:
>>>>
>>>> Question though - other than trying to add journal to existing live raid
>>>> - is this feature overall safe to use (or are there any other know
>>>> issues one should be aware of beforehand) ?
>>>>
>>> We (Facebook) have done some tests with it. However, we didn't put
>>> it into production. The reason behind this decision was not reliability, but
>>> performance concerns and high level directions. I think Redhat is
>>> evaluating it.
>>>
>>
>> Well I will give it a shot probably. My case scenario is that a bunch of
>> sync-happy VMs on top of lvm+raid seem to be crushing performance
>> (unless there are other reasons), even with very small disk usage.
>>
>> Out of curiosity - is the journal in writeback mode controllable in some
>> way (e.g. frequency of how often it flushes to raid disks, whether it's
>> space or time (or both) based ?).
> 
> It is combination of both time and space:
> 
> /*
>   * log->max_free_space is min(1/4 disk size, 10G reclaimable space).
>   *
>   * In write through mode, the reclaim runs every log->max_free_space.
>   * This can prevent the recovery scans for too long
>   */
> #define RECLAIM_MAX_FREE_SPACE (10 * 1024 * 1024 * 2) /* sector */
> #define RECLAIM_MAX_FREE_SPACE_SHIFT (2)
> 
> /* wake up reclaim thread periodically */
> #define R5C_RECLAIM_WAKEUP_INTERVAL (30 * HZ)
> /* start flush with these full stripes */
> #define R5C_FULL_STRIPE_FLUSH_BATCH(conf) (conf->max_nr_stripes / 4)
> /* reclaim stripes in groups */
> #define R5C_RECLAIM_STRIPE_GROUP (NR_STRIPE_HASH_LOCKS * 2)
> 
> However, we didn't expose knobs to tune these on a live system.
> 

Would (probably) be awesome one day to have those exposed somehow.

Few extra questions:

1) if I have journal in w-b mode, will echoing write-through to 
journal_mode block until all the data is safe on the actual raid devices ?

2) if (for any reason) I need to remove the journal device live - 
assuming (1) is sufficient - is --fail & --remove the correct way to do so ?

