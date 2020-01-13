Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3739139CB8
	for <lists+linux-raid@lfdr.de>; Mon, 13 Jan 2020 23:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgAMWkn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 13 Jan 2020 17:40:43 -0500
Received: from mail-vs1-f53.google.com ([209.85.217.53]:41792 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAMWkn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 13 Jan 2020 17:40:43 -0500
Received: by mail-vs1-f53.google.com with SMTP id k188so6994481vsc.8
        for <linux-raid@vger.kernel.org>; Mon, 13 Jan 2020 14:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eYtee+YhyjaGxGsNP74+8IT2G3PMwJkaYhTgNz85A4U=;
        b=h2KnHruMyKNXG7m4CegX3lHgeejUAx1aK2nTv5QBNqnkXiFplkpEXVAanFd8iVtS0B
         U+jcDAEso+FelNEyNjPN7aC492r4hrDLeZZjJ83NZeAthphkrvHtCY846HX6ToZtTaQh
         Q/F1vlwuUf87pewHN9gnIw+vbkPLEXYK//ea4fSK4cRqdU0r8WjXpZ1s7qDgXwzojLNj
         qcsO6Fq6BWWr9ZGOqI54gFiG6A9ccgV9DXozjEuYMTQUH3e0/cCk5GrEGyrrXfvuqkvS
         G4WQ3YVGu2T/E1xPncNYPNvLyouZEjiWmvjQYvRBfJzcJkI4awgjkXkk8VL44ELqY+SN
         J9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eYtee+YhyjaGxGsNP74+8IT2G3PMwJkaYhTgNz85A4U=;
        b=c1wy+Gdu6O5uFHiMiCMV8oHUxujNP2sNHPG7PkqplHSjzAg6K4WCpsaPdlYlOsUzgr
         mKn/M/2PudD2NcgsB4OH5wFnTkg6bFCN6jlwsEHl84vWwK5lfH3wDqwdi0j1EPiOyr1s
         clWAi1C2HGJJSQL2+detD7Nu8GeZgqhjS4PM9Tq5BAcCBKV9wMGnBbJ2VU1bo3pHMO/x
         J2/X8CqEtUiBQdhtrN5BD3eDpV7DHbFdnhNguima63GYITaabR2l9+Y31NHintSbm/Y8
         B6LvN4vjZQMihuGmL9NLRjWyRAGmPxgxGz/rLENq9dsHr+uK8aSolcm19hx91C5CCHhA
         IPsg==
X-Gm-Message-State: APjAAAXrPp3LMI3dbtErCkadBAavuI1TKDsnBU8l7s2CxdQsXDBFKYp2
        0Lk2MLUx1gpKdORlIPCrmwdM0c6EK22Jt5zR0VKHS6LJ
X-Google-Smtp-Source: APXvYqyMyoltcfj29O4djf3KtFEMn9LID1EULcSaVQ2mC73aXWdVXfaAnOo6WdEry0DLTinrAVUW0/YR38+Uxai3fOU=
X-Received: by 2002:a67:f541:: with SMTP id z1mr7012004vsn.70.1578955242409;
 Mon, 13 Jan 2020 14:40:42 -0800 (PST)
MIME-Version: 1.0
References: <CALc6PW4OKR2KVFgzoEbRJ0TRwvqi5EZAdC__HOx+vJKMT0TXYQ@mail.gmail.com>
 <959ca414-0c97-2e8d-7715-a7cb75790fcd@youngman.org.uk> <CALc6PW7276uYYWpL7j2xsFJRy3ayZeeSJ9kNCGHvB6Ndb6m1-Q@mail.gmail.com>
 <5E17D999.5010309@youngman.org.uk>
In-Reply-To: <5E17D999.5010309@youngman.org.uk>
From:   William Morgan <therealbrewer@gmail.com>
Date:   Mon, 13 Jan 2020 16:40:31 -0600
Message-ID: <CALc6PW5DrTkVR7rLngDcJ5i8kTpqfT1-K+ki-WjnXAYP5TXXZg@mail.gmail.com>
Subject: Re: Two raid5 arrays are inactive and have changed UUIDs
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> >>> md1 consists of 4x 4TB drives:
> >>>
> >>> role drive events state
> >>>   0    sdj    5948  AAAA
> >>>   1    sdk   38643  .AAA
> >>>   2    sdl   38643  .AAA
> >>>   3    sdm   38643  .AAA

> If you're not happy using overlays, having ddrescue'd the disks you
> could always assemble the array directly from the copies and make sure
> everything's okay there, before trying it with the original disks.

I successfully ddrescued all four drives /dev/sd[j,k,l,m], each to new
disk, with no errors reported. I have the copies on /dev/sd[n,o,p,q].

Now if I want to force assemble the three copies with event counts
that agree [o,p,q], should I just do:

mdadm --assemble --force /dev/md1 /dev/sdo1 /dev/sdp1 /dev/sdq1

Or should I assemble the copies into a new array, say /dev/md2?

I'm worried that assembling the copies might merge them into the
existing (inactive) array. Is that what's supposed to happen? I'm
unclear here.

Thanks for your help,
Bill
