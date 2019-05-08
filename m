Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C4B1824D
	for <lists+linux-raid@lfdr.de>; Thu,  9 May 2019 00:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfEHWgO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 May 2019 18:36:14 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:59284 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfEHWgN (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 8 May 2019 18:36:13 -0400
Received: from [192.168.28.30] (unknown [86.74.176.27])
        (Authenticated sender: julien.robin28)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id F219BB00539
        for <linux-raid@vger.kernel.org>; Thu,  9 May 2019 00:36:10 +0200 (CEST)
Subject: Re: ID 5 Reallocated Sectors Count
To:     Linux Raid <linux-raid@vger.kernel.org>
References: <1471924184.12974949.1557351707986.JavaMail.zimbra@karlsbakk.net>
From:   Julien ROBIN <julien.robin28@free.fr>
Message-ID: <458766bc-bd91-88b3-6075-8fde270c7222@free.fr>
Date:   Thu, 9 May 2019 00:36:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1471924184.12974949.1557351707986.JavaMail.zimbra@karlsbakk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi!

The maximum I saw from an healthy drive on which the value never 
increased anymore - despite 8 years of intensive read/write work (and 
frequent full read/write) is 107 reallocated sectors (was 106 in 2011, 
Maxtor 6L160M0). This disk is almost 15 years old. This is a funny but 
rare case.

I often see some cases with like 30 or 40 reallocated sectors and it's 
not growing anymore (even with full read/write from time to time) 
despite a year of two (around me, 1 samsung and 2 seagate ones).

May be those cases were due to shocks which shot just some sectors, and 
then no more sectors? If you run 1 full read test per day, you will 
quickly see if the value keep very low, or if it's rising. If it's 
rising everyday, your disk has cancer, and its growing. My condolences!


Beware of short term tests:
Recently a Seagate ST2000DM001 (2TB), had lot of pending sectors: after 
a full rewrite test, it was fine, full read back too (pending sectors 
were back to zero and only few reallocated sectors remained like 10 or 
something). So I decided to keep it... But few days later, I came back 
and saw that the disk was completely dead - not even starting.

Long time ago in the past I had a disk which experienced 1 startup 
failure (some clicks sounds then it turned off). Insisting a second time 
just to be sure of what I saw, it started fine, so I did a complete test 
and backup (seemed to be fine) and I decided to keep it. 2 days later, 
at power on, it made the clicking sound again. And never started anymore.


My advice: if your disk show some signs of cancer or heart attack at 
least once, you can put it somewhere with "shred -n 5000 -b 
/dev/yourdisk" just for fun to see if it stabilizes. In some rare cases, 
it will stabilize and keep running longer than new fresh ones ^^ so it's 
always funny to do the test. But most of the time, it will fail quickly. 
So keeping it on real work should be avoided while you aren't sure.

As you are on RAID 6 it's less dangerous to wait and see. But what you 
are likely to see is a very quickly coming failure ;)


Le 08/05/2019 à 23:41, Roy Sigurd Karlsbakk a écrit :
> Hi
> 
> I'm monitoring this box and it seems ID 5 Reallocated Sectors Count (from SMART) is climbing frantically on one disk. It's a r6 so it shouldn't be much of an issue once the disk eventually fails, but does anyone out there know how many reallocated sectors you can have on a drive? This is an older 1TB ST31000524NS
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
