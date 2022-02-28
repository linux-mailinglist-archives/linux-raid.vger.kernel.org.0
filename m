Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CCD4C6500
	for <lists+linux-raid@lfdr.de>; Mon, 28 Feb 2022 09:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiB1ItM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 28 Feb 2022 03:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiB1ItL (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 28 Feb 2022 03:49:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C1E31218
        for <linux-raid@vger.kernel.org>; Mon, 28 Feb 2022 00:48:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 858611F3A2;
        Mon, 28 Feb 2022 08:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646038109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oIl4TCAsntWfHRhoWRXm/3sc0oOrrazRga8qUgVuIAE=;
        b=UxZmUk+L7sOF8xUNDoho/tenawIy2yW0b0E+kEZXl+XEiM/v1w+unGYF9FWR3tANP+8Pzu
        wHTJJoYzFX32BcoHLBOa9NWbKaOGK+IsGzBIoDGRY8tdM5aPwMFopn0ZLo0dHZXqzpg0Jd
        F7BX6xJtbM2yyjJ33W6/6vDMSiwsdt0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23D2512FC5;
        Mon, 28 Feb 2022 08:48:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Kd6BBl2MHGJsQwAAMHmgww
        (envelope-from <mwilck@suse.com>); Mon, 28 Feb 2022 08:48:29 +0000
Message-ID: <ff8030340e30963a1772f43e8bdfb6b610219887.camel@suse.com>
Subject: Re: [PATCH] udev-md-raid-assembly.rules: skip if
 DM_UDEV_DISABLE_OTHER_RULES_FLAG
From:   Martin Wilck <mwilck@suse.com>
To:     Jes Sorensen <jsorensen@fb.com>, NeilBrown <neilb@suse.de>
Cc:     Peter Rajnoha <prajnoha@redhat.com>, Coly Li <colyli@suse.com>,
        lvm-devel@redhat.com, linux-raid@vger.kernel.org,
        dm-devel@redhat.com, Heming Zhao <heming.zhao@suse.com>
Date:   Mon, 28 Feb 2022 09:48:28 +0100
In-Reply-To: <164557016782.28944.17731814770525408828@noble.neil.brown.name>
References: <20220216205914.7575-1-mwilck@suse.com>
        , <164504936873.10228.7361167610237544463@noble.neil.brown.name>
        , <e8720e3f8734cbad1af34d5e54afc47ba3ef1b8f.camel@suse.com>
        , <20220217130934.lh2b33255kyx2pax@alatyr-rpi.brq.redhat.com>
        , <164548656531.8827.3365536065813085321@noble.neil.brown.name>
        , <4b61ca1eafb35e3fdfbc9bb260dc89d56d181499.camel@suse.com>
         <164557016782.28944.17731814770525408828@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, 2022-02-23 at 09:49 +1100, NeilBrown wrote:
> 
> But if libdevmapper.h is the best you have, then maybe it'll have to
> do.
> It is up to Jes what he accepts of course.

Jes, have you made up your mind on this patch yet?
Please contact me if you have remarks or questions.

Note that the patch that started this thread is broken; the v2 is
correct. With the v2, I was able to reach 1000 consecutive reboots on
a system with MD on top of multipath that would otherwise hang during
boot about once every 50-100 reboots.

Regards
Martin


