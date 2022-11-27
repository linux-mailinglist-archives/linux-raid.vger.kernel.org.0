Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A5F639C38
	for <lists+linux-raid@lfdr.de>; Sun, 27 Nov 2022 19:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiK0SIf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 27 Nov 2022 13:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiK0SIf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 27 Nov 2022 13:08:35 -0500
Received: from len.romanrm.net (len.romanrm.net [91.121.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C440CB1ED
        for <linux-raid@vger.kernel.org>; Sun, 27 Nov 2022 10:08:32 -0800 (PST)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by len.romanrm.net (Postfix) with SMTP id 0D3A840211;
        Sun, 27 Nov 2022 18:08:28 +0000 (UTC)
Date:   Sun, 27 Nov 2022 23:08:28 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Wol <antlists@youngman.org.uk>
Cc:     Reindl Harald <h.reindl@thelounge.net>,
        John Stoffel <john@stoffel.org>,
        David T-G <davidtg-robot@justpickone.org>,
        Linux RAID list <linux-raid@vger.kernel.org>
Subject: Re: how do i fix these RAID5 arrays?
Message-ID: <20221127230828.3cfe728b@nvm>
In-Reply-To: <fd6a2f41-405a-7ec7-e8f1-c970e32973c4@youngman.org.uk>
References: <20221123220736.GD19721@jpo>
        <20221124032821.628cd042@nvm>
        <20221124211019.GE19721@jpo>
        <f58964da-4ded-61a8-bd6a-e2391557b38a@youngman.org.uk>
        <25474.28874.952381.412636@quad.stoffel.home>
        <fd543697-14a6-0868-82a1-be61790e07f3@thelounge.net>
        <62b72b4e-8461-e616-1227-4dcef8853143@youngman.org.uk>
        <7316d29a-bab6-b8a2-5c77-803af8de378b@thelounge.net>
        <fd6a2f41-405a-7ec7-e8f1-c970e32973c4@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sun, 27 Nov 2022 14:33:37 +0000
Wol <antlists@youngman.org.uk> wrote:

> If raid supports trim, that means it intercepts the trim commands, and 
> uses it to keep track of what's being used by the layer above.
> 
> In other words, if the filesystem is only using 10% of the disk, 
> supporting trim means that raid knows which 10% is being used and only 
> bothers syncing that!

Not sure which RAID system you are speaking of, but that's not presently
implemented in mdadm RAID. It does not use TRIM of the array to keep track of
unused areas on the underlying devices, to skip those during rebuilds. And I
am unaware of any other RAID that does. Would be nice to have though.

-- 
With respect,
Roman
