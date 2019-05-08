Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1FA182C1
	for <lists+linux-raid@lfdr.de>; Thu,  9 May 2019 01:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfEHXlQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 May 2019 19:41:16 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:45979 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfEHXlQ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 8 May 2019 19:41:16 -0400
Received: from [192.168.28.30] (unknown [86.74.176.27])
        (Authenticated sender: julien.robin28)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 2C7DDB00515;
        Thu,  9 May 2019 01:41:11 +0200 (CEST)
Subject: Re: ID 5 Reallocated Sectors Count
References: <1471924184.12974949.1557351707986.JavaMail.zimbra@karlsbakk.net>
 <2aff655d-0495-1f7d-a305-adf23f9800bb@eyal.emu.id.au>
 <1426313842.12996928.1557357572484.JavaMail.zimbra@karlsbakk.net>
From:   Julien ROBIN <julien.robin28@free.fr>
Cc:     linux-raid@vger.kernel.org
To:     roy@karlsbakk.net
Message-ID: <4aadac08-c52f-0fa8-9e6d-121a1530fbc2@free.fr>
Date:   Thu, 9 May 2019 01:41:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1426313842.12996928.1557357572484.JavaMail.zimbra@karlsbakk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Most of the time, Gnome Disk Utility and motherboard RAID systems are 
showing a disk as "officially not OK anymore" around something like 500 
reallocated sectors (which is already very big).
But SMART "Normalized", "Worst", "Threshold" values are quite 
complicated to understand (it may be some easy way to translate them 
into something clear?) so I don't know what is the official "failure" value.

I don't know how many reserved sectors for reallocation are existing on 
most drives, but there is some bits of information here about spare 
sectors area size: 
https://www.passmark.com/forum/general/4257-detrmining-the-size-of-the-sector-spare-area
It seems that you can calculate and see how many sectors aren't 
available for data, so that most of them are probably the "spare sectors 
pool".

Anyway, after more than 1800+ reallocated sectors, by experience, it's 
time to thank your disk one last time, to turn it off, and to let him go 
to hard disk's heaven! The drive is living its really last hours, it may 
die during the night.


Le 09/05/2019 à 01:19, Roy Sigurd Karlsbakk a écrit :
>> On 9/5/19 7:41 am, Roy Sigurd Karlsbakk wrote:
>>> Hi
>>>
>>> I'm monitoring this box and it seems ID 5 Reallocated Sectors Count (from SMART)
>>> is climbing frantically on one disk. It's a r6 so it shouldn't be much of an
>>> issue once the disk eventually fails, but does anyone out there know how many
>>> reallocated sectors you can have on a drive? This is an older 1TB ST31000524NS
>>
>> My rule, and what is often suggested in raid documents, is that once the number
>> start to visibly climb (you say 'frantically') I replace the disk.
> 
> That's more or less my understanding of it as well. The question was more of a theoretical question: How many sectors can it reallocate before theey start to go "pending"?
> 
> As for the growth, at May 7 19:42 CEST, reallocated sectors were 53. When this email was posted, it was 1812. Currently it's at 1883, so it's still climbing rapidly. Pending is till zero. This shows the numbers over the day for reallocated sectors (the dots in front was before I turned up the check frequency and zabbix 3.4 apparently isn't smart enough to draw the graph for them there) https://karlsbakk.net/tmp/reallocated-sectors-hba-skrothaug.png
> 
> Vennlig hilsen
> 
> roy
> --
> Roy Sigurd Karlsbakk
> (+47) 98013356
> http://blogg.karlsbakk.net/
> GPG Public key: http://karlsbakk.net/roysigurdkarlsbakk.pubkey.txt
> --
> Hið góða skaltu í stein höggva, hið illa í snjó rita.
> 
