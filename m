Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E51651970FC
	for <lists+linux-raid@lfdr.de>; Mon, 30 Mar 2020 00:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgC2W6a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Sun, 29 Mar 2020 18:58:30 -0400
Received: from poetics.madmonks.org ([45.124.52.18]:35638 "EHLO
        poetics.madmonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgC2W63 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 29 Mar 2020 18:58:29 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Mar 2020 18:58:28 EDT
Received: from poetics.madmonks.org (localhost [127.0.0.1])
        by poetics.madmonks.org (Postfix) with ESMTP id 4583991E0DA;
        Mon, 30 Mar 2020 09:51:18 +1100 (AEDT)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on poetics.madmonks.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.2
Received: from [192.168.22.61] (202-153-219-35.ca99db.mel.nbn.aussiebb.net [202.153.219.35])
        by poetics.madmonks.org (Postfix) with ESMTPSA id 304E29178BA;
        Mon, 30 Mar 2020 09:51:18 +1100 (AEDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.19\))
Subject: Re: Requesting help repairing a RAID-6 array
From:   Matt Wallis <mattw@madmonks.org>
In-Reply-To: <34bdb153-b2fc-9fd6-f48f-95bbacfe7149@youngman.org.uk>
Date:   Mon, 30 Mar 2020 09:51:16 +1100
Cc:     Roman Mamedov <rm@romanrm.net>,
        "crowston.name" <kevin@crowston.name>, linux-raid@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3F145B73-B356-49DC-9DBC-559A650EAD65@madmonks.org>
References: <etPan.5e80defb.10afc736.32ba@crowston.name>
 <fc847f59-b221-c97c-28d6-813f8d79f15f@youngman.org.uk>
 <20200330033539.6171d8a5@natsu>
 <34bdb153-b2fc-9fd6-f48f-95bbacfe7149@youngman.org.uk>
To:     antlists <antlists@youngman.org.uk>
X-Mailer: Apple Mail (2.3608.80.19)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> On 30 Mar 2020, at 09:40, antlists <antlists@youngman.org.uk> wrote:
> 
> On 29/03/2020 23:35, Roman Mamedov wrote:
>> On Sun, 29 Mar 2020 23:31:35 +0100
>> antlists <antlists@youngman.org.uk> wrote:
>>> On 29/03/2020 18:45, crowston.name wrote:
>>>> === START OF INFORMATION SECTION ===
>>>> Device Model:     ST3000DM001-1CH166
>>>> Serial Number:    Z1F50Y21
>>>> Firmware Version: CC29
>>> 
>>> Seagate Barracuda :-( Not suitable as a raid drive.
>> Not suitable as a ...drive.
>> That model is literally the only hard drive in the world to get its own
>> Wikipedia article[1] for its awful reliability.
> Well, I've got two of them, and they've been very reliable. Bear in mind that that batch was just after the floods that disrupted production, I suspect that quality slipped because demand was excessive. Later production seems to have been fine. Barracudas generally are just crap for raid.


I had 4 of them in an array, they are what made me decide that RAID5 was no longer a viable RAID level, two of them failed, within an hour of each other.

Even a hot spare would not have recovered in that time.

Matt.
