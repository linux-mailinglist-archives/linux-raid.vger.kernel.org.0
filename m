Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DF55B7C6F
	for <lists+linux-raid@lfdr.de>; Tue, 13 Sep 2022 23:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiIMVDn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 13 Sep 2022 17:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiIMVDk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 13 Sep 2022 17:03:40 -0400
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B57A6A489
        for <linux-raid@vger.kernel.org>; Tue, 13 Sep 2022 14:03:39 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id BE5C466F;
        Tue, 13 Sep 2022 21:03:35 +0000 (UTC)
Date:   Wed, 14 Sep 2022 02:03:34 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     Pascal Hambourg <pascal@plouf.fr.eu.org>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
Subject: Re: change UUID of RAID devcies
Message-ID: <20220914020334.37598234@nvm>
In-Reply-To: <e143cf52-d8fb-f00b-3a54-82af71f759f5@thelounge.net>
References: <2341a2a9-b86e-f0e5-784a-05dbd474dec5@thelounge.net>
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
        <20220914003228.4377cc6a@nvm>
        <93ea4d09-d6f9-0c5f-1b8e-e610af592834@thelounge.net>
        <20220914012801.5b2dce25@nvm>
        <75a3c54a-c436-32a3-10c9-e9bc75d8a143@thelounge.net>
        <20220914014841.0d42fd4b@nvm>
        <e143cf52-d8fb-f00b-3a54-82af71f759f5@thelounge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_PORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, 13 Sep 2022 22:56:00 +0200
Reindl Harald <h.reindl@thelounge.net> wrote:

> [root@srv-rhsoft:/var/lib/mpd/playlists]$ mdadm --detail /dev/md1 | grep 
> Name
>                Name : localhost.localdomain:1  (local to host 
> localhost.localdomain)

I have serverhostname.mydomain.net:1 there, perhaps due to creating arrays
not on install time, but long after the OS has been already installed and set
up properly with all the networking, domains and hostnames.

In any case, you can change that name to your liking, and then replace
"UUID=..." with "name=..." in mdadm.conf, if that helps anything with your
intended configuration.

-- 
With respect,
Roman
