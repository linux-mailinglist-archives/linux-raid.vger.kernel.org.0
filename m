Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE6BB1970D3
	for <lists+linux-raid@lfdr.de>; Mon, 30 Mar 2020 00:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgC2Wkn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 29 Mar 2020 18:40:43 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:28162 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbgC2Wkn (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 29 Mar 2020 18:40:43 -0400
Received: from [81.153.42.4] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jIgbh-000Agn-6m; Sun, 29 Mar 2020 23:40:41 +0100
Subject: Re: Requesting help repairing a RAID-6 array
To:     Roman Mamedov <rm@romanrm.net>
Cc:     "crowston.name" <kevin@crowston.name>, linux-raid@vger.kernel.org
References: <etPan.5e80defb.10afc736.32ba@crowston.name>
 <fc847f59-b221-c97c-28d6-813f8d79f15f@youngman.org.uk>
 <20200330033539.6171d8a5@natsu>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <34bdb153-b2fc-9fd6-f48f-95bbacfe7149@youngman.org.uk>
Date:   Sun, 29 Mar 2020 23:40:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330033539.6171d8a5@natsu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 29/03/2020 23:35, Roman Mamedov wrote:
> On Sun, 29 Mar 2020 23:31:35 +0100
> antlists <antlists@youngman.org.uk> wrote:
> 
>> On 29/03/2020 18:45, crowston.name wrote:
>>> === START OF INFORMATION SECTION ===
>>> Device Model:     ST3000DM001-1CH166
>>> Serial Number:    Z1F50Y21
>>> Firmware Version: CC29
>>
>> Seagate Barracuda :-( Not suitable as a raid drive.
> 
> Not suitable as a ...drive.
> 
> That model is literally the only hard drive in the world to get its own
> Wikipedia article[1] for its awful reliability.
> 
Well, I've got two of them, and they've been very reliable. Bear in mind 
that that batch was just after the floods that disrupted production, I 
suspect that quality slipped because demand was excessive. Later 
production seems to have been fine. Barracudas generally are just crap 
for raid.

Cheers,
Wol
