Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46ED388EA3
	for <lists+linux-raid@lfdr.de>; Wed, 19 May 2021 15:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbhESNJR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 19 May 2021 09:09:17 -0400
Received: from vps.thesusis.net ([34.202.238.73]:35542 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241090AbhESNJR (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 19 May 2021 09:09:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id 4834C2192D;
        Wed, 19 May 2021 09:07:57 -0400 (EDT)
Received: from vps.thesusis.net ([127.0.0.1])
        by localhost (vps.thesusis.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uhkYOLzQXq8Q; Wed, 19 May 2021 09:07:57 -0400 (EDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 0A5A52192C; Wed, 19 May 2021 09:07:57 -0400 (EDT)
References: <CAC6SzHJLG=0_URJUsgQshpk-QLh6b8SBJDrfxiNg4wikQw4uyw@mail.gmail.com> <2140221131.2872520.1620837067395.JavaMail.zimbra@karlsbakk.net> <87a6oyr64b.fsf@vps.thesusis.net> <3f3fd663-77e4-8c23-eb22-1b8223eaf277@turmel.org> <87y2ch4c3w.fsf@vps.thesusis.net> <947223877.4161967.1621003717636.JavaMail.zimbra@karlsbakk.net> <87cztpm68z.fsf@vps.thesusis.net> <60A2EC87.9080701@youngman.org.uk> <874kf0yq31.fsf@vps.thesusis.net> <d7c8b22d-f74a-409e-4e08-46240bb815e4@youngman.org.uk> <35a2f34e-178c-dcd2-b498-cf3fc029ae11@websitemanagers.com.au>
User-agent: mu4e 1.5.7; emacs 26.3
From:   Phillip Susi <phill@thesusis.net>
To:     Adam Goryachev <mailinglists@websitemanagers.com.au>
Cc:     antlists <antlists@youngman.org.uk>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Linux Raid <linux-raid@vger.kernel.org>
Subject: Re: raid10 redundancy
Date:   Wed, 19 May 2021 09:02:48 -0400
In-reply-to: <35a2f34e-178c-dcd2-b498-cf3fc029ae11@websitemanagers.com.au>
Message-ID: <87im3e50sz.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


Adam Goryachev writes:

> Jumping into this one late, but I thought the main risk was related to 
> the fact that for every read there is a chance the device will fail to 
> read the data successfully, and so the more data you need to read in 
> order to restore redundancy, the greater the risk of not being able to 
> regain redundancy.

Also the assumption that the drives tend to fail after about the same
number of reads, and since all of the drives in the array have had about
the same number of reads, by the time you get the first failure, a
second likely is not far behind.

Both of these assumptions are about as flawed as the mistaken belief
that many have that based on the bit error rates published by drive
manufacturers, that if you read the entire multi TB drive, odds are
quite good that you will get an uncorrectable error.  I've tried it
many times and it doesn't work that way.

