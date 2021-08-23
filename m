Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4523F537B
	for <lists+linux-raid@lfdr.de>; Tue, 24 Aug 2021 00:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhHWWrl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 23 Aug 2021 18:47:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46584 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhHWWrj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 23 Aug 2021 18:47:39 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C0CBF1FFEE;
        Mon, 23 Aug 2021 22:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629758813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJ6RklilnkK1oUwIenr6n7i9f/uTrGUeB7z2lOYP4l0=;
        b=ElUTY65RzASt7V4KDV2ix5HVHpzbdS5m0+BR9Egl1e83Pb+lCizcvHT+t4/0e3lZj1NPQe
        sMwtctsuQlBPhdGiwO7kjCcOmKhjCmHd2zk2HFDUP3t6oIBFxH9yQdUYZkGisHWFGcNtaF
        ssJ3fvPwVrDdCnmhIhNVqVwed2gyl0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629758813;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJ6RklilnkK1oUwIenr6n7i9f/uTrGUeB7z2lOYP4l0=;
        b=oQWs9GRPl/PE5Txus94+6I+HmL8/g9f6zSgEXTBtfqpvitT91sq+iJuCViV5JZeiLs+Wm+
        kZGjkGhtO/T2dcCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EF8113BFF;
        Mon, 23 Aug 2021 22:46:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Cm+UN1slJGHFJgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 23 Aug 2021 22:46:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Tkaczyk, Mariusz" <mariusz.tkaczyk@linux.intel.com>
Cc:     "Nigel Croxon" <ncroxon@redhat.com>, jes@trained-monkey.org,
        xni@redhat.com, linux-raid@vger.kernel.org
Subject: Re: [PATCH V2] Fix buffer size warning for strcpy
In-reply-to: <5d28eff3-d693-92c5-6e84-54846b36a480@linux.intel.com>
References: <20210819131017.2511208-1-ncroxon@redhat.com>,
 <5d28eff3-d693-92c5-6e84-54846b36a480@linux.intel.com>
Date:   Tue, 24 Aug 2021 08:46:49 +1000
Message-id: <162975880927.9892.4170329329993823938@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, 23 Aug 2021, Tkaczyk, Mariusz wrote:
> On 19.08.2021 15:10, Nigel Croxon wrote:
> 
> > +	memset(ve->name, '\0', sizeof(ve->name));
> > +	if (name) {
> > +		int l = strlen(ve->name);
> > +		if (l > 16)
> > +			l = 16;
> > +		memcpy(ve->name, name, l);
> > +	}
> 
> What about:
> if (name)
> 	/*
> 	 * Name might not be null terminated.
> 	 */
> 	strncpy(ve->name, name, sizeof(ve->name));

I really like the idea of using strncpy().  I didn't realize it would
nul-pad to the full size, and that is exactly what we want.
So

  strncpy(ve->name, name?:"", sizeof(ve->name));

would be a complete solution.

Thanks,
NeilBrown
