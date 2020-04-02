Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B98219C451
	for <lists+linux-raid@lfdr.de>; Thu,  2 Apr 2020 16:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbgDBOeN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Apr 2020 10:34:13 -0400
Received: from li1843-175.members.linode.com ([172.104.24.175]:52080 "EHLO
        mail.stoffel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBOeN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 2 Apr 2020 10:34:13 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Apr 2020 10:34:13 EDT
Received: from quad.stoffel.org (66-189-75-104.dhcp.oxfr.ma.charter.com [66.189.75.104])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 7B2A01E866;
        Thu,  2 Apr 2020 10:26:41 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id D89DFA615F; Thu,  2 Apr 2020 10:26:40 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24197.63008.837629.985226@quad.stoffel.home>
Date:   Thu, 2 Apr 2020 10:26:40 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     Adam Goryachev <mailinglists@websitemanagers.com.au>,
        linux-raid@vger.kernel.org
Subject: Re: RAID Issues - RAID10 working but with errors
In-Reply-To: <832cb2b3-e9d3-e1a6-4ba5-f1f1b5d22b97@thelounge.net>
References: <d934f662-9fde-370b-bb4b-b92bd1730c96@websitemanagers.com.au>
        <832cb2b3-e9d3-e1a6-4ba5-f1f1b5d22b97@thelounge.net>
X-Mailer: VM 8.2.0b under 25.1.1 (x86_64-pc-linux-gnu)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>>>>> "Reindl" == Reindl Harald <h.reindl@thelounge.net> writes:

Reindl> Am 02.04.20 um 04:28 schrieb Adam Goryachev:
>> Is there a method to determine if this is a HDD error (ie, 2 drives that
>> have errors) or a cabling issue (with just these two drives) or some
>> strange driver/motherboard issue?

Reindl> just try by start with the cheapest option: cables

Reindl> when nothing changes switch where they disks are connected and you will
Reindl> find out it's the motherboard when suddenly one drive that was completly
Reindl> fine before has the same issue

>> I notice in the output below MD is showing a number of bad blocks on the
>> drives, and logs suggest that the drives have run out of "spare" space
>> to re-allocate these to.

Reindl> from the moment on some software stack is telling you about
Reindl> bad blocks on drives run fast and replace fast

Hear hear!  When the drive is saying it's not happy... go get some
more now.  I wouldn't even question the badblocks you're seeing, that
means it's dying.

John
