Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDF61CEEA
	for <lists+linux-raid@lfdr.de>; Tue, 14 May 2019 20:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfENSTk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 May 2019 14:19:40 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:28045 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfENSTk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 May 2019 14:19:40 -0400
Received: from [192.168.8.29] ([86.214.62.250])
        by mwinf5d07 with ME
        id CJKZ2000B5Px8Mi03JKaCl; Tue, 14 May 2019 20:19:38 +0200
X-ME-Helo: [192.168.8.29]
X-ME-Auth: ZXJpYy52YWxldHRlNkB3YW5hZG9vLmZy
X-ME-Date: Tue, 14 May 2019 20:19:38 +0200
X-ME-IP: 86.214.62.250
Reply-To: eric.valette@free.fr
Subject: Re: Help restoring a raid10 Array (4 disk + one spare) after a hard
 disk failure at power on
To:     Reindl Harald <h.reindl@thelounge.net>, linux-raid@vger.kernel.org
References: <87d22dc0-4b45-e13f-86e1-d3e9fbd7f55d@free.fr>
 <1bc43f99-3c57-db16-64d2-e5ab7d2e27cf@thelounge.net>
From:   Eric Valette <eric.valette@free.fr>
Organization: HOME
Message-ID: <dd7cd835-23f5-38de-0bb7-e13a408ef83a@free.fr>
Date:   Tue, 14 May 2019 20:19:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1bc43f99-3c57-db16-64d2-e5ab7d2e27cf@thelounge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14/05/2019 20:13, Reindl Harald wrote:
> 
> 
> Am 14.05.19 um 17:48 schrieb Eric Valette:
>> I have a dedicated hardware nas that runs a self maintained debian 10.
>>
>> before the hardware disk problem (before/after)

> how does that matter on any proper setup?
> *never* use /dev/xyz anywhere

Fine. Does available online documentation makes it explicit? No .I 
carefully read it before raid creation several years ago

> [root@srv-rhsoft:~]$ cat /etc/mdadm.conf
> MAILADDR root
> HOMEHOST localhost.localdomain
> AUTO +imsm +1.x -all
> 
> ARRAY /dev/md0 level=raid1 num-devices=4
> UUID=1d691642:baed26df:1d197496:4fb00ff8
> ARRAY /dev/md1 level=raid10 num-devices=4
> UUID=b7475879:c95d9a47:c5043c02:0c5ae720
> ARRAY /dev/md2 level=raid10 num-devices=4
> UUID=ea253255:cb915401:f32794ad:ce0fe396

So what? the question was how do I add array member using symbolic 
names. Of course I can use /dev/by--xxx/ but when dumping I do not know 
if it will be lost or net.

Thanks for non helping and only blaming. Glad others have helped instead.

-- eric




