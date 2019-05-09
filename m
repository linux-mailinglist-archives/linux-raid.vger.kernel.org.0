Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB0DC182D9
	for <lists+linux-raid@lfdr.de>; Thu,  9 May 2019 02:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfEIAVZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 May 2019 20:21:25 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:41618 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbfEIAVZ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 8 May 2019 20:21:25 -0400
Received: from [81.155.195.4] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1hOWoM-0002Ld-9l; Thu, 09 May 2019 01:21:22 +0100
Subject: Re: ID 5 Reallocated Sectors Count
To:     Roy Sigurd Karlsbakk <roy@karlsbakk.net>
References: <1471924184.12974949.1557351707986.JavaMail.zimbra@karlsbakk.net>
 <2aff655d-0495-1f7d-a305-adf23f9800bb@eyal.emu.id.au>
 <1426313842.12996928.1557357572484.JavaMail.zimbra@karlsbakk.net>
Cc:     Linux Raid <linux-raid@vger.kernel.org>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5CD37280.9080309@youngman.org.uk>
Date:   Thu, 9 May 2019 01:21:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <1426313842.12996928.1557357572484.JavaMail.zimbra@karlsbakk.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 09/05/19 00:19, Roy Sigurd Karlsbakk wrote:
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
I'm not sure of the exact meaning of "pending sectors", but I'm pretty
certain your question doesn't make sense. Sectors go "pending" BEFORE
they are re-allocated, not after.

I suspect that if a read fails, the sector goes pending. If a "write
then verify" fails, the sector is re-allocated. And if the disk runs out
of space to re-allocate, it commits suicide.

So you can have thousands of "pendings", and it's independent of
"reallocated". But if there's a real problem (like surface damage) any
attempt to rewrite those pendings will result in a rapidly climbing
reallocated count - like you've just seen - and as others have said, it
looks like your drive is on the way out ...

> As for the growth, at May 7 19:42 CEST, reallocated sectors were 53. When this email was posted, it was 1812. Currently it's at 1883, so it's still climbing rapidly. Pending is till zero. This shows the numbers over the day for reallocated sectors (the dots in front was before I turned up the check frequency and zabbix 3.4 apparently isn't smart enough to draw the graph for them there) https://karlsbakk.net/tmp/reallocated-sectors-hba-skrothaug.png 
> 
Cheers,
Wol

