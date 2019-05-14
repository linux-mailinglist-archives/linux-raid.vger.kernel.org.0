Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B82921CF6D
	for <lists+linux-raid@lfdr.de>; Tue, 14 May 2019 20:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfENSxU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 May 2019 14:53:20 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:21597 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfENSxU (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 May 2019 14:53:20 -0400
Received: from [192.168.8.29] ([86.214.62.250])
        by mwinf5d07 with ME
        id CJtH2000D5Px8Mi03JtHeN; Tue, 14 May 2019 20:53:18 +0200
X-ME-Helo: [192.168.8.29]
X-ME-Auth: ZXJpYy52YWxldHRlNkB3YW5hZG9vLmZy
X-ME-Date: Tue, 14 May 2019 20:53:18 +0200
X-ME-IP: 86.214.62.250
Reply-To: eric.valette@free.fr
Subject: Re: Help restoring a raid10 Array (4 disk + one spare) after a hard
 disk failure at power on
To:     Reindl Harald <h.reindl@thelounge.net>, linux-raid@vger.kernel.org
References: <87d22dc0-4b45-e13f-86e1-d3e9fbd7f55d@free.fr>
 <1bc43f99-3c57-db16-64d2-e5ab7d2e27cf@thelounge.net>
 <dd7cd835-23f5-38de-0bb7-e13a408ef83a@free.fr>
 <5a28b0de-c50a-fdd1-f6ea-7746da3c9a6e@thelounge.net>
 <9fcb4980-b0d4-9f20-8e37-fd2dc4768e78@free.fr>
 <66e55468-4d42-ab61-7621-90af2d37f78e@thelounge.net>
From:   Eric Valette <eric.valette@free.fr>
Organization: HOME
Message-ID: <fb758347-7206-4dd9-688a-1c958a92aaaa@free.fr>
Date:   Tue, 14 May 2019 20:53:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <66e55468-4d42-ab61-7621-90af2d37f78e@thelounge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14/05/2019 20:38, Reindl Harald wrote:
> 
> 
> Am 14.05.19 um 20:33 schrieb Eric Valette:
>> Fine. Again where is it documented? The documentation the contrary. So
>> go and fix the doc instead of ranting again end user.
> 
> you better cool down given that *i am* an enduser and when you think you
> reach anything by piss off ousers hwich show you how your setup should
> look like you are likely wrong
I only say two things:

    1) you were not helping me on my important problem which was 
restoring the array and recovering my data, just blaming a config file 
content,
    2) explaining here by blaming someone who carefully followed the 
wiki,faq and mdadm readme how RAID should be created and mdmadm config 
file should be written is probably not efficient. Update the docs luke,

BTW it appears, device naming was not the real problem in the end rather 
that if a device disappears after a reboot, you have nothing special to 
do except reassembling the array  and force rebuilding the needed spare 
if you have sufficient spare. I just expected it to be automatic.


-- eric



