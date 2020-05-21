Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5641DCE53
	for <lists+linux-raid@lfdr.de>; Thu, 21 May 2020 15:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbgEUNmR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 May 2020 09:42:17 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:50365 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbgEUNmR (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 21 May 2020 09:42:17 -0400
Received: from [81.154.111.47] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jblSh-000CmE-DG; Thu, 21 May 2020 14:42:15 +0100
Subject: Re: disks & prices plus python
To:     David T-G <davidtg-robot@justpickone.org>,
        Linux RAID list <linux-raid@vger.kernel.org>
References: <20200520200514.GE1415@justpickone.org>
 <5EC5BBEF.7070002@youngman.org.uk> <20200520235347.GF1415@justpickone.org>
 <5EC63745.1080602@youngman.org.uk> <20200521110103.GG1415@justpickone.org>
 <5EC66C2E.90901@youngman.org.uk> <20200521123059.GN1415@justpickone.org>
 <326faa2c-ba38-6cd4-c09c-ea321779e339@youngman.org.uk>
 <20200521131751.GQ1415@justpickone.org>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5EC68536.4040000@youngman.org.uk>
Date:   Thu, 21 May 2020 14:42:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20200521131751.GQ1415@justpickone.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 21/05/20 14:17, David T-G wrote:
> % So if you really want to use them in a raid array, I'd go for a 6TB
> % raid-10. Okay, you've lost 3TB of disk space, but you've bought a
> % 66% chance of surviving a 2-disk failure.
> 
> Heh.  Except that this box has only three ports, so one was going to
> become USB storage or some such anyway.  But that means I can't have a
> RAID10 vol ...

Three SATA ports? That sounds very stingy! (Or is it four, but one's the
DVD?)

This is what I've bought for my new PC
https://www.amazon.co.uk/StarTech-com-Port-Express-eSATA-Controller-Silver-Black/dp/B00952N2DQ/ref=pd_ybh_a_47?_encoding=UTF8&psc=1&refRID=2B248DH9763DDGHGN5A6

An expensive gaming mobo, with 6 SATA ports, but if I want NVMe, or a
second graphics card, or whatever whatever, some of the lanes get taken
away. And of course I do want a 2nd graphics card (this machine is
destined to be double-headed, when I can get it to work :-)

And then for my old system, I'm planning to buy
https://www.amazon.co.uk/gp/product/B07T8XNQT6/ref=ox_sc_saved_title_2?smid=A32IGEZ3DX93HZ&psc=1

or something similar. That machine has 5 SATA ports (or only 4 if
PATA-mode is enabled), and I'm planning to stick a bunch of 500GB or 1TB
drives in it for playing with. So especially if I split the 1TB drives
into 500GB partitions, that's some humungous raids for testing with :-)

Cheers,
Wol
