Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214303F8C2B
	for <lists+linux-raid@lfdr.de>; Thu, 26 Aug 2021 18:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhHZQ3t (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 26 Aug 2021 12:29:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33616 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbhHZQ3s (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 26 Aug 2021 12:29:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 77D95201D8;
        Thu, 26 Aug 2021 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629995340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpa2fPdWObVWJuLpMykbLvAsDAQOt4pxTYFnBgGTMvg=;
        b=nAAYwdhSMUhAQJVFNeooh2SBsMzRKEUsojKYztBh/ynj3Z+UnRK4SthlByK94n170Oybf8
        1N6yzyvMeDuVAPoe0o1cM76aVHDWhIIWuy3J8vXd2YqAPhwPdblXbcT2+yp543WIfIUKTt
        5AyyIQFj6ptLFnFPu8kMOQGpguTPH6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629995340;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpa2fPdWObVWJuLpMykbLvAsDAQOt4pxTYFnBgGTMvg=;
        b=ndC1VqiAUisf8uEPPUZx/QJYw1S0OGIL1/qyXRbGTLbddoDWFGeiNYx7MTzwD02/rw8KHo
        mTnwZPeN7sV9NaDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A84F413C74;
        Thu, 26 Aug 2021 16:28:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1lRcHEvBJ2ERHQAAMHmgww
        (envelope-from <colyli@suse.de>); Thu, 26 Aug 2021 16:28:59 +0000
Subject: Re: [PATCH] mdadm: split off shared library
To:     Hannes Reinecke <hare@suse.de>, Jes Sorensen <jsorensen@fb.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
References: <7461b27b-2a4b-fbbb-5cfd-8fab416cbc9f@suse.de>
From:   Coly Li <colyli@suse.de>
Message-ID: <fc647fe7-542e-d8d0-920f-33a4edf92962@suse.de>
Date:   Fri, 27 Aug 2021 00:28:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7461b27b-2a4b-fbbb-5cfd-8fab416cbc9f@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 8/25/21 10:35 PM, Hannes Reinecke wrote:
> Hi all,
>
> this is, contrary to the subject, not a patch, but rather a question on
> how to submit a patchset.
> I've been working on splitting off a shared library from mdadm, with the
> aim that it can be included from other programs.
> Reasoning behind it that I've written a monitor program
> (github.com:/hreinecke/md_monitor) and found it a major pain having to
> exec() mdadm, and then keep fingers crossed that things succeed; error
> recovery from _that_ turned out to be a major drag. And so I figured
> that a shared library is possibly the best way to go.
>
> (And, as a side note: having a shared library would also allow to build
> a python binding, which possibly will have even more use-cases ...)
>
> So I've build a patchset to split off a shared library from mdadm, and
> build mdadm against that:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/hare/mdadm.git
> branch shlib
>
> But as it turns out, these are 30+ patches, and I didn't want to flood
> the mailinglist with that.
> So what are the procedures here?
>
> Are you okay with having the entire patchset on the mailing list?
> Or are there other ways?

Hi Hannes,

It is fine for me to receiving a series with 30+ patches in linux-raid 
mailing list. And I also can help to review all the patches when they 
are posted out.

Hi Jes,

If you are too busy to take care of mdadm, and you are glad, it is OK 
for me to take the mdadm maintenance. I can be long term stable for the 
maintenance task.

Thanks.

Coly Li
