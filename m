Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A72A5D83AE
	for <lists+linux-raid@lfdr.de>; Wed, 16 Oct 2019 00:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389907AbfJOWbY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 15 Oct 2019 18:31:24 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:19760 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389901AbfJOWbY (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 15 Oct 2019 18:31:24 -0400
Received: from [86.132.37.73] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iKVLe-0006U1-C8; Tue, 15 Oct 2019 23:31:23 +0100
Subject: Re: Degraded RAID1
To:     curtis@npc-usa.com, linux-raid@vger.kernel.org
References: <qo31v1$31rr$2@blaine.gmane.org>
 <5DA5165E.8070609@youngman.org.uk>
 <9bfd62ed-a41c-8093-b522-db0ccbe32b89@npc-usa.com>
 <4e25fa78-846f-42b9-e50a-c4876377a08d@npc-usa.com>
 <be94147a-a244-6f71-5f6a-7c6da8515cf9@youngman.org.uk>
 <1a20554d-1a40-f226-28bc-c3d38f8c7014@npc-usa.com>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5DA648B9.7030506@youngman.org.uk>
Date:   Tue, 15 Oct 2019 23:31:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <1a20554d-1a40-f226-28bc-c3d38f8c7014@npc-usa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 15/10/19 22:44, Curtis Vaughan wrote:
>>> >> The replacement drive is coming tomorrow. I'm certain now there's a
>>> >> major issue
>>> >>
>>> >> with the drive and will be replacing it.
>> >
>> > What makes you think that?
> 
> Ran Spinrite against the drives. It gets about half way through the bad
> drive and basically stops.
> 
> On the good drive it goes from beginning to end without issues.

Doesn't sound good ,,,
> 
> Also after running smartctl on the bad drive, I got this:
> 
> The following warning/error was logged by the smartd daemon:
> 
> Device: /dev/sda [SAT], 1568 Offline uncorrectable sectors
> 
> Device info:
> ST1000DM003-9YN162, S/N:Z1D17B24, WWN:5-000c50-050e6c90f, FW:CC4C, 1.00 TB
> 
> For details see host's SYSLOG.
> 
> You can also use the smartctl utility for further investigation.
> Another message will be sent in 24 hours if the problem persists.
> 
> And this:
> The following warning/error was logged by the smartd daemon:
> 
> Device: /dev/sda [SAT], 1568 Currently unreadable (pending) sectors
> 
> Device info:
> ST1000DM003-9YN162, S/N:Z1D17B24, WWN:5-000c50-050e6c90f, FW:CC4C, 1.00 TB

Urkk

Seagate Barracudas are NOT recommended. Can you do a "smartctl -x" and
see if SCT/ERC is supported? I haven't got a datasheet for the 1GB
version, but I've got the 3GB version and it doesn't support it. That
means you WILL suffer from the timeout problem ...

(Not that that's your problem here, but there's no point tempting fate.
I know Seagate say "suitable for desktop raid", but the experts on this
list wouldn't agree ...)

Cheers,
Wol
