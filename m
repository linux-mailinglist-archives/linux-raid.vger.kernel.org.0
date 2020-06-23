Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE354205B30
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jun 2020 20:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbgFWSzG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Jun 2020 14:55:06 -0400
Received: from li1843-175.members.linode.com ([172.104.24.175]:37530 "EHLO
        mail.stoffel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733170AbgFWSzF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 23 Jun 2020 14:55:05 -0400
Received: from quad.stoffel.org (066-189-075-104.res.spectrum.com [66.189.75.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id E0EE11F2E3;
        Tue, 23 Jun 2020 14:55:04 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 6EEC5A64B0; Tue, 23 Jun 2020 14:55:04 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24306.20488.394049.265699@quad.stoffel.home>
Date:   Tue, 23 Jun 2020 14:55:04 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     antlists <antlists@youngman.org.uk>
Cc:     John Stoffel <john@stoffel.org>,
        Ian Pilcher <arequipeno@gmail.com>, linux-raid@vger.kernel.org
Subject: Re: RAID types & chunks sizes for new NAS drives
In-Reply-To: <290bc100-6fb4-84bc-83ac-eed1be3d8cb6@youngman.org.uk>
References: <rco1i8$1l34$1@ciao.gmane.io>
        <24305.24232.459249.386799@quad.stoffel.home>
        <290bc100-6fb4-84bc-83ac-eed1be3d8cb6@youngman.org.uk>
X-Mailer: VM 8.2.0b under 26.1 (x86_64-pc-linux-gnu)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>>>>> "antlists" == antlists  <antlists@youngman.org.uk> writes:

antlists> On 23/06/2020 02:45, John Stoffel wrote:
>> In any case, make sure you get NAS rated disks, either the newest WD
>> RED+ (or is it Blue?)  In any case, make sure to NOT get the SMR
>> (Shingled Magnetic Recording) format drives.  See previous threads in
>> this group, as well as the arstechnica.com discussion about it all
>> that they disk last month.  Very informative.

antlists> I'd just avoid WD completely. They advertise REDs as
antlists> raid-capable, and they are (mostly) SMR and unfit for
antlists> purpose. BLUEs are supposedly the "desktop performance"
antlists> drives, so sticking them in a raid is not advised
antlists> anyway. But you've only got to start hammering your BLUE
antlists> performance drive, and performance would be abysmal. If you
antlists> are going for WD then RED PRO is what you need.

Don't throw out all WD drives, just because they screwed up on their
low end NAS drives.  And I do recommend that people buy drives with
the longest warranty possible, so you get a drive that the
manufacturer expects to support for quite a while.  

antlists> At least Seagate don't advertise unsuitable drives - DON'T
antlists> touch Barracudas! They say Ironwolf or Ironwolf Pro for
antlists> raid, both are fine to the best of my knowledge.

Agree.  I remember when Barracudas were the best Seagate drives... no
sticktion there.

antlists> And nobody seems to buy Toshiba but - I think it's the N300
antlists> - they do a raid range as well.

I have Toshiba drives.  Another good thing to do is to buy competing
vendor drives and pair them, because you're less likely to get hit by
a bad batch of drives.  

antlists> Don't buy REDs or Barracudas or other known-problematic
antlists> drives. They will appear to work fine until there's a
antlists> problem, at which point they will bork the raid and lose
antlists> your data. A good raid drive will tell the raid it's failed
antlists> and let the raid recover. These problem drives DON'T tell
antlists> the raid what's going on, and by the time the raid finds out
antlists> it's too late.

The RED+ I think are all supposed to be CMR drives no matter what.

As Wols has said in the past, getting drives with SCTERC support is
key.  They're going to be more expensive, but how much is your data
worth?

I think Wols and I are in agreement overall, just differing in
details.  He's done a great job with the RAID wiki and helping people
when they get into trouble.  
