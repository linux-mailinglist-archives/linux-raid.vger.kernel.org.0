Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B45B829657
	for <lists+linux-raid@lfdr.de>; Fri, 24 May 2019 12:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390595AbfEXKve (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 24 May 2019 06:51:34 -0400
Received: from drutsystem.com ([84.10.39.251]:51200 "EHLO drutsystem.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390560AbfEXKve (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 24 May 2019 06:51:34 -0400
Subject: Re: Few questions about (attempting to use) write journal + call
 traces
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ziu.info; s=ziu;
        t=1558695064; bh=BSoNk7LvHbwLiwsOzMm88yYTL6qLTa4D8iXvUiyPLOA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WeMYZ9YNe/hQK/FW1JBDJ9E0ozrJZRxw21wcYdMFs11ODWefMxaXw9SMcklTRX1kk
         HHZPiPuuHdpxt5FQt/SEsQUwrK6UellHq2oyi8BwMlXK91C5ySBfUq/lsqq6h1B149
         YpGpgzFoNa7ghAlheY2eBI10rsaMmKkFCKKb1TvE=
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <0fd0ab3a-7e7e-b4d5-fffe-c34f3868a8dd@ziu.info>
 <CAPhsuW4ZetsxTjuACOBekboNTtbqc0pYbXn01KtE1oZ8MoKU3w@mail.gmail.com>
 <ae69671c-7763-916e-5b45-0ff4741293eb@ziu.info>
 <CAPhsuW4yMSjzb0FCQsRWJCYmXNQM5Y2o_LCOE-6C7gTOcCNrEQ@mail.gmail.com>
From:   Michal Soltys <soltys@ziu.info>
Message-ID: <32f8bf8c-6a81-0490-f702-fa9cc41c38e9@ziu.info>
Date:   Fri, 24 May 2019 12:51:03 +0200
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4yMSjzb0FCQsRWJCYmXNQM5Y2o_LCOE-6C7gTOcCNrEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-MailScanner-ID: 4357F748D3A.A1184
X-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailScanner-From: soltys@ziu.info
X-Spam-Status: No
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/23/19 8:09 PM, Song Liu wrote:
>>>
>>
>> Actually, this seems to be unreleated to underlying devices - the culprit seems to be attempting to write to an array after adding journal, without stopping and reassembling it first. Details below.
> 
> Thanks for these experiments. Your analysis makes perfect sense.
> 
> Do you think you can continue the  experiments with the write journal before
> this issue got fixed?
> 
> I am asking because this is not on the top of my list at this time. If
> this is not
> blocking other important tests, I would prefer to fix it at a later time.
> 
> Thanks,
> Song
> 

Yea it's fine. I can help with testing (whenever you sit down to this 
issues) as well.

Question though - other than trying to add journal to existing live raid 
- is this feature overall safe to use (or are there any other know 
issues one should be aware of beforehand) ?

