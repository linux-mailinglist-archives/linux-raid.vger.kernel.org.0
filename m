Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1D47E9EB8
	for <lists+linux-raid@lfdr.de>; Wed, 30 Oct 2019 16:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfJ3PSk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 30 Oct 2019 11:18:40 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:10139 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbfJ3PSk (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 30 Oct 2019 11:18:40 -0400
Received: from [86.155.171.62] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iPpk5-0003oT-95; Wed, 30 Oct 2019 15:18:38 +0000
Subject: Re: Cannot fix Current_Pending_Sector even after check and repair
To:     Marc MERLIN <marc@merlins.org>, Tim Small <tim@buttersideup.com>,
        Jorge Bastos <jorge.mrbastos@gmail.com>,
        Roman Mamedov <rm@romanrm.net>
References: <20191030025346.GA24750@merlins.org>
Cc:     linux-raid@vger.kernel.org
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5DB9A9CC.9090007@youngman.org.uk>
Date:   Wed, 30 Oct 2019 15:18:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20191030025346.GA24750@merlins.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 30/10/19 02:53, Marc MERLIN wrote:
> On Tue, Oct 29, 2019 at 12:05:02PM +0000, Jorge Bastos wrote:
>> > Same, especially with WD drives, they appear to be false positives, if
>> > you can take the disk offline a full disk write will usually get rid
>> > of them.

> I see. So somehow reading all the sectors with hdrecover does not
> trigger anything, but dd'ing 0s over the entire drive would reset this?

Because a "pending" error is a sector that is unreadable, but if you
don't write to it, the drive can't test whether the error is "transient"
corruption, or whether the sector needs to be relocated. And of course,
because it can't read the sector it can't do a transparent write because
it doesn't know what was there to start with to write back ...

Cheers,
Wol
