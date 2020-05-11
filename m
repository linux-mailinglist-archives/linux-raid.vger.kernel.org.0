Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE161CE946
	for <lists+linux-raid@lfdr.de>; Tue, 12 May 2020 01:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgEKXjk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 11 May 2020 19:39:40 -0400
Received: from azure.uno.uk.net ([95.172.254.11]:56630 "EHLO azure.uno.uk.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgEKXjk (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 11 May 2020 19:39:40 -0400
X-Greylist: delayed 3321 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 May 2020 19:39:39 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sabi.unospace.net; s=default; h=From:References:In-Reply-To:Subject:To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YsjuqXzbfFXLl+ageWmnR0JDvKr2JT+gF/2z4V8b2vw=; b=OEs4GsPL+nkJ3/2SrwAG35o5yN
        YSUjHZU6gZzj/JvVaIV8aNfA+VM3D+Nx9rZQ8/fnFZF+9yhyTHwkX0LuOAdMb76oC//I7yQqdFETf
        GMCWGkAPgPxTMDhtZXzf8+1LUg/JZD9dkek9WhrYDyoxfAKCZ9/KaYHFK+dJ4PgI5drCCMGIeE+5O
        TjoiuNyZKc2eEM+RGhROBgyTgpriEFNNLpY0OU+YZa23erp6rmpKUmY6EQH8sKjetVviC9PpnIkJ/
        JBw3m1UKTfWSejoOpq+6H3GCU5ucXM8SFvZR7cmeeQGqICvT6zKOPM7IZGZtAdZsbilx06VLjN8YJ
        KbHc+Lsw==;
Received: from [95.172.224.50] (port=44048 helo=ty.sabi.co.UK)
        by azure.uno.uk.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <postmaster@mail.for.sabi.co.uk>)
        id 1jYH9l-00A8Wr-8d
        for linux-raid@vger.kernel.org; Mon, 11 May 2020 23:44:17 +0100
Received: from from [127.0.0.1] (helo=base.ty.sabi.co.uk)
        by ty.sabi.co.UK with esmtps(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)(Exim 4.93 5)
        id 1jYH9f-0080sb-K5
        for <linux-raid@vger.kernel.org>; Mon, 11 May 2020 23:44:11 +0100
Message-ID: <24249.54587.74070.71273@base.ty.sabi.co.uk>
Date:   Mon, 11 May 2020 23:44:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To:     Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: raid6check extremely slow ?
In-Reply-To: <23d84744-9e3c-adc1-3af1-6498b9bcf750@cloud.ionos.com>
References: <20200510120725.20947240E1A@gemini.denx.de>
        <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>
        <20200511064022.591C5240E1A@gemini.denx.de>
        <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com>
        <20200511161415.GA8049@lazy.lzy>
        <23d84744-9e3c-adc1-3af1-6498b9bcf750@cloud.ionos.com>
X-Mailer: VM 8.2.0b under 26.3 (x86_64-pc-linux-gnu)
From:   pg@lxraid.list.sabi.co.UK (Peter Grandi)
X-Disclaimer: This message contains only personal opinions
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - azure.uno.uk.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mail.for.sabi.co.uk
X-Get-Message-Sender-Via: azure.uno.uk.net: authenticated_id: sabity@sabi.unospace.net
X-Authenticated-Sender: azure.uno.uk.net: sabity@sabi.unospace.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>>> With lock / unlock, I get around 1.2MB/sec per device
>>> component, with ~13% CPU load.  Wihtout lock / unlock, I get
>>> around 15.5MB/sec per device component, with ~30% CPU load.

>> [...] we still need to avoid race conditions. [...]

Not all race conditions are equally bad in this situation.

> 1. Per your previous reply, only call raid6check when array is
> RO, then we don't need the lock.
> 2. Investigate if it is possible that acquire stripe_lock in
> suspend_lo/hi_store [...]

Some other ways could be considered:

* Read a stripe without locking and check it; if it checks good,
  no problem, else either it was modified during the read, or it
  was faulty, so acquire a W lock, reread and recheck it (it
  could have become good in the meantime).

  The assumption here is that there is a modest write load from
  applications on the RAID set, so the check will almost always
  succeed, and it is worth rereading the stripe in very rare
  cases of "collisions" or faults.

* Variants, like acquiring a W lock (if possible) on the stripe
  solely while reading it ("atomic" read, which may be possible
  in other ways without locking) and then if check fails we know
  it was faulty, so optionally acquire a new W lock and reread
  and recheck it (it could have become good in the meantime).

  The assumption here is that the write load is less modest, but
  there are a lot more reads than writes, so a W lock only
  during read will eliminate the rereads and rechecks from
  relatively rare "collisions".

The case where there is at the same time a large application
write load on the RAID set and checking at the same time is hard
to improve and probably eliminating rereads and rechecks by just
acquiring the stripe W lock for the whole duration of read and
check.
