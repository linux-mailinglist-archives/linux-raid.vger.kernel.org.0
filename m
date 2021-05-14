Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40613380BEE
	for <lists+linux-raid@lfdr.de>; Fri, 14 May 2021 16:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhENOgo (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 May 2021 10:36:44 -0400
Received: from vps.thesusis.net ([34.202.238.73]:59760 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234450AbhENOgn (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 14 May 2021 10:36:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id 01BFE21043;
        Fri, 14 May 2021 10:35:32 -0400 (EDT)
Received: from vps.thesusis.net ([127.0.0.1])
        by localhost (vps.thesusis.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id husKeRs7cn2j; Fri, 14 May 2021 10:35:31 -0400 (EDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id BE45C21042; Fri, 14 May 2021 10:35:31 -0400 (EDT)
References: <CAC6SzHJLG=0_URJUsgQshpk-QLh6b8SBJDrfxiNg4wikQw4uyw@mail.gmail.com> <2140221131.2872520.1620837067395.JavaMail.zimbra@karlsbakk.net> <87a6oyr64b.fsf@vps.thesusis.net> <3f3fd663-77e4-8c23-eb22-1b8223eaf277@turmel.org>
User-agent: mu4e 1.5.7; emacs 26.3
From:   Phillip Susi <phill@thesusis.net>
To:     Phil Turmel <philip@turmel.org>
Cc:     Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        d tbsky <tbskyd@gmail.com>,
        Linux Raid <linux-raid@vger.kernel.org>
Subject: Re: raid10 redundancy
Date:   Fri, 14 May 2021 10:30:07 -0400
In-reply-to: <3f3fd663-77e4-8c23-eb22-1b8223eaf277@turmel.org>
Message-ID: <87y2ch4c3w.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


Phil Turmel writes:

> No, rebuild isn't just writing to the new disk.  You have to read other 
> disks to get the data to write.  In raid6, you must read at least n-2 
> drives, compute, then write.  In raid10, you just read the other drive 
> (or one of the other drives when copies>2), then write.

Yes, but the data is striped across those multiple disks, so reading
them in parallel takes no more time.  At least unless you have a
memory/bus bottleneck rather than a disk bottleneck.  so again, you're
probably right if you are using blazing fast NVME drives, but not for
conventional HDD.
