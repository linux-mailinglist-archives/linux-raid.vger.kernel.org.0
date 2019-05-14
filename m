Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE5A1CF1E
	for <lists+linux-raid@lfdr.de>; Tue, 14 May 2019 20:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfENSdy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 May 2019 14:33:54 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:38305 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfENSdy (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 May 2019 14:33:54 -0400
Received: from [192.168.8.29] ([86.214.62.250])
        by mwinf5d07 with ME
        id CJZh200045Px8Mi03JZhBV; Tue, 14 May 2019 20:33:41 +0200
X-ME-Helo: [192.168.8.29]
X-ME-Auth: ZXJpYy52YWxldHRlNkB3YW5hZG9vLmZy
X-ME-Date: Tue, 14 May 2019 20:33:41 +0200
X-ME-IP: 86.214.62.250
Reply-To: eric.valette@free.fr
Subject: Re: Help restoring a raid10 Array (4 disk + one spare) after a hard
 disk failure at power on
To:     Reindl Harald <h.reindl@thelounge.net>, linux-raid@vger.kernel.org
References: <87d22dc0-4b45-e13f-86e1-d3e9fbd7f55d@free.fr>
 <1bc43f99-3c57-db16-64d2-e5ab7d2e27cf@thelounge.net>
 <dd7cd835-23f5-38de-0bb7-e13a408ef83a@free.fr>
 <5a28b0de-c50a-fdd1-f6ea-7746da3c9a6e@thelounge.net>
From:   Eric Valette <eric.valette@free.fr>
Organization: HOME
Message-ID: <9fcb4980-b0d4-9f20-8e37-fd2dc4768e78@free.fr>
Date:   Tue, 14 May 2019 20:33:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5a28b0de-c50a-fdd1-f6ea-7746da3c9a6e@thelounge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14/05/2019 20:28, Reindl Harald wrote:

> that /dev/sdX changes *randomly* depending on which drives are available
> and in which order they appear is common knowledge  and exactly what you
> don't want in a setup which shouldn't care if a random drive is missing

I know. Thank you, I only use label instead of uuid in non raid 
configuration and even the raid itself is mounted by label. Don't think 
anyone but you is stupid.

> the above *is not* about /dev/by...
> it's about the UUID of the 3 RAID devices itself

I don't care I use LABEL myself...

> bla, as you can see my mdadm.conf don't contain *any* devices
> it don't contain any scan stuff

Fine. Again where is it documented? The documentation the contrary. So 
go and fix the doc instead of ranting again end user.

> but the kernel line contains mentioning the 3 raid-arrays explicit
> rd.md.uuid=1d691642:baed26df:1d197496:4fb00ff8
> rd.md.uuid=b7475879:c95d9a47:c5043c02:0c5ae720
> rd.md.uuid=ea253255:cb915401:f32794ad:ce0fe396
Do not want to do that messing in grub automatic config files...

-- eric


