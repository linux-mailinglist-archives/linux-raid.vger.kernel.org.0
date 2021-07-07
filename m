Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552693BF20E
	for <lists+linux-raid@lfdr.de>; Thu,  8 Jul 2021 00:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhGGW2N (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 7 Jul 2021 18:28:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53364 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhGGW2N (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 7 Jul 2021 18:28:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1ABE520126;
        Wed,  7 Jul 2021 22:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625696732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10LXSENjq64RFrA2YwdYVN0tvdY1cFy2lFStc8/8mms=;
        b=bQ8axTlEkUlHsl39CNU1mdVUflzoNOPyIQ2DqGq/KNl3knV3qyZL7MKCcGxNLVaFH6cdxL
        fZybJOVjz/xtxeCZrVaUFiw6soop7PuCKplVHZhDff2/b75osje9r0n5GvayzCIjUnDrZh
        K0Xv2O8uaA79Y1OjRumJ8o9L2J6BKZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625696732;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10LXSENjq64RFrA2YwdYVN0tvdY1cFy2lFStc8/8mms=;
        b=GJmTWjeKx1DfP3gIfQkQ1hiue4MpKbIcoO/a0q1bcIIfK/w5L1MTrkBlUJTMRhwkwGXNKX
        zW1RWXyZTfSFUUCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C852A13AE7;
        Wed,  7 Jul 2021 22:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TgIEHtop5mA0HwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 07 Jul 2021 22:25:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "BW" <m40636067@gmail.com>
Cc:     "Fine Fan" <ffan@redhat.com>, linux-raid@vger.kernel.org
Subject: Re: --detail --export doesn't show all properties
In-reply-to: <CADcL3SBwbiZJgXVOOTqV2UPqTg=eJwG=ZDCwgzTd9Ez8FH5D6w@mail.gmail.com>
References: <CADcL3SDfzw+PZHWabN0mrHFuyt1gVtD6Owf_bNpFT=xV-JrVVA@mail.gmail.com>,
 <CAOaDVC6yNDOVAvMu4gBuc+sTH50UrXD3z4sODa1NtFsV9SEZ9Q@mail.gmail.com>,
 <CADcL3SBwbiZJgXVOOTqV2UPqTg=eJwG=ZDCwgzTd9Ez8FH5D6w@mail.gmail.com>
Date:   Thu, 08 Jul 2021 08:25:27 +1000
Message-id: <162569672750.31036.1684525188878933981@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, 07 Jul 2021, BW wrote:
> I'm using ver. mdadm-4.1-24.3.1.x86_64 / openSUSE kernel 15.3
> 
> It's only when the array is active you get a raid-level, if the array
> is inactive, as in my example, you will not get the raid-level (and
> State, Persistence).
> 

Yes, that is correct.
When the array is inactive, it is not an active array.  It has no level
or state.  It is just a bunch of drives.

If you want to see what might happen when you activate the array, you
need to --examine the indiividual drives.

NeilBrown
