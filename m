Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94425B7B72
	for <lists+linux-raid@lfdr.de>; Tue, 13 Sep 2022 21:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiIMTfC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 13 Sep 2022 15:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiIMTef (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 13 Sep 2022 15:34:35 -0400
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599317647B
        for <linux-raid@vger.kernel.org>; Tue, 13 Sep 2022 12:32:55 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id 6912F5B0;
        Tue, 13 Sep 2022 19:32:30 +0000 (UTC)
Date:   Wed, 14 Sep 2022 00:32:28 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     Pascal Hambourg <pascal@plouf.fr.eu.org>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
Subject: Re: change UUID of RAID devcies
Message-ID: <20220914003228.4377cc6a@nvm>
In-Reply-To: <15f573c4-0c96-885f-659f-bfa2cbd698a7@thelounge.net>
References: <2341a2a9-b86e-f0e5-784a-05dbd474dec5@thelounge.net>
        <729bdc01-b0ae-887a-6d2a-5135d287636c@youngman.org.uk>
        <05a1161b-d798-c68f-d37c-a9fc373c6e73@thelounge.net>
        <0023fefe-aad1-e692-48dd-e354497f6e41@plouf.fr.eu.org>
        <1fb05e0f-34b7-3ec4-bc00-ec540e592f19@thelounge.net>
        <3fc0b889-3ef9-652e-6452-2eeede918683@plouf.fr.eu.org>
        <9e537739-2fbd-2c99-8191-54faf0a69a8b@thelounge.net>
        <6b4a5399-5053-4a51-26d7-2f62c47c2981@plouf.fr.eu.org>
        <65ee1134-60e4-4577-74c7-0ba15ae39225@thelounge.net>
        <97b66977-97c7-21aa-f1d9-f0d34a0fcf9b@plouf.fr.eu.org>
        <b428f8c6-cf8b-218c-3cae-8f36327901f7@thelounge.net>
        <ec3b9673-688b-18c8-188b-246e9c63a2d0@plouf.fr.eu.org>
        <071b8b8a-7a50-3eec-22d4-5880ff3f80e9@thelounge.net>
        <8babedc5-a2e7-326f-3340-10e354aecb45@plouf.fr.eu.org>
        <15f573c4-0c96-885f-659f-bfa2cbd698a7@thelounge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, 13 Sep 2022 15:02:41 +0200
Reindl Harald <h.reindl@thelounge.net> wrote:

> > I would not convert existing arrays. Rather create new arrays on the new 
> > disks and copy the data
> i want my identical machines to stay as they are with all their UUIDs 
> which is the main topic here
> 
> it's not funny when you are used to rsync your /etc/fstab over 11 years 
> that doing so would lead in a unbootbale system on the other side

For this I'd suggest to use LABEL=rootfs (and so on) in fstab, instead of
UUIDs.

Or with LVM, /dev/vgname/lvname.

It's kind of the point of UUIDs that they are supposed to be (even globally)
unique, and there should not be the same UUID on two different machines.

-- 
With respect,
Roman
