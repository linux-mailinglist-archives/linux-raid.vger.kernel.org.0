Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080496585DE
	for <lists+linux-raid@lfdr.de>; Wed, 28 Dec 2022 19:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiL1Svy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 28 Dec 2022 13:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiL1Svw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 28 Dec 2022 13:51:52 -0500
Received: from mail.aperture-lab.de (mail.aperture-lab.de [IPv6:2a01:4f8:c2c:665b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E058914D33
        for <linux-raid@vger.kernel.org>; Wed, 28 Dec 2022 10:51:50 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A4D8740A19;
        Wed, 28 Dec 2022 19:51:47 +0100 (CET)
Date:   Wed, 28 Dec 2022 19:51:45 +0100
From:   Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To:     John Stoffel <john@stoffel.org>
Cc:     linux-raid@vger.kernel.org
Subject: Re: RAID6 recovery, event count mismatch
Message-ID: <Y6yQQX/CA7bpTsLt@sellars>
References: <Y59Zby6E3qvf7QVE@sellars>
 <25504.51221.928625.446259@quad.stoffel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25504.51221.928625.446259@quad.stoffel.home>
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Dec 19, 2022 at 03:22:45PM -0500, John Stoffel wrote:
> [...]
>
> Yikes!  I'm amazed you haven't had more problems with this setup.  It
> must be pretty darn slow...

Speed is actually decent for my use-cases. Just a full RAID check or
replacing a disk can take a bit longer. It was a different story
with my first try with a Pi 3 and its USB2 ports :D.

> [...]
> 
> > https://raid.wiki.kernel.org/index.php/RAID_Recovery#Trying_to_assemble_using_--force
> -> "mdadm /dev/mdX --assemble --force <list of devices>"
> 
> I would try this first. Do you have an details of the individual
> drives and their counts as well?  

The event counts are as follows (as can be seen in the full mdadm
outputs at the bottom of my previous email):

dm-9: 2554492
dm-10: 2554488
dm-11: 2554490
dm-12: 2554495
dm-13: 2554495

Are these the counters you were asking for?

Regards, Linus
