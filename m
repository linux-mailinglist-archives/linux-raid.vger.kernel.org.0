Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F0D2E7B2A
	for <lists+linux-raid@lfdr.de>; Wed, 30 Dec 2020 17:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgL3QyE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 30 Dec 2020 11:54:04 -0500
Received: from li1843-175.members.linode.com ([172.104.24.175]:34088 "EHLO
        mail.stoffel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgL3QyE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 30 Dec 2020 11:54:04 -0500
Received: from quad.stoffel.org (068-116-170-226.res.spectrum.com [68.116.170.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 512A125F8F;
        Wed, 30 Dec 2020 11:53:23 -0500 (EST)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id AE2BDA6ACD; Wed, 30 Dec 2020 11:53:22 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24556.45186.659863.688675@quad.stoffel.home>
Date:   Wed, 30 Dec 2020 11:53:22 -0500
From:   "John Stoffel" <john@stoffel.org>
To:     antlists <antlists@youngman.org.uk>
Cc:     John Stoffel <john@stoffel.org>,
        dannyshih <dannyshih@synology.com>, axboe@kernel.dk,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: [PATCH 1/4] block: introduce submit_bio_noacct_add_head
In-Reply-To: <d841085f-5fd7-bd5c-a40b-fbb953c80598@youngman.org.uk>
References: <1609233522-25837-1-git-send-email-dannyshih@synology.com>
        <1609233522-25837-2-git-send-email-dannyshih@synology.com>
        <24555.49943.411197.147225@quad.stoffel.home>
        <d841085f-5fd7-bd5c-a40b-fbb953c80598@youngman.org.uk>
X-Mailer: VM 8.2.0b under 26.1 (x86_64-pc-linux-gnu)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>>>>> "antlists" == antlists  <antlists@youngman.org.uk> writes:

antlists> On 30/12/2020 00:00, John Stoffel wrote:
dannyshih> From: Danny Shih<dannyshih@synology.com>
dannyshih> Porvide a way for stacking block device to re-submit the bio
dannyshih> which sholud be handled firstly.
>> 
>> You're spelling needs to be fixed in these messages.

antlists>    ^^^^^^

antlists> It is traditional, when correcting someone else's spelling,
antlists> to make one of your own ... :-)

LOL!  Yes, touche!  I'm completely abashed.  

antlists> Sorry, but if we're being pedantic for furriners, it behoves
antlists> us to be correct ourselves :-)

It does for sure, thanks for the nudge.  
