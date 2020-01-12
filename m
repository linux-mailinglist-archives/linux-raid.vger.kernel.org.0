Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97D581386CE
	for <lists+linux-raid@lfdr.de>; Sun, 12 Jan 2020 15:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbgALOfd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 12 Jan 2020 09:35:33 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:42325 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733023AbgALOfc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 12 Jan 2020 09:35:32 -0500
Received: by mail-io1-f42.google.com with SMTP id n11so6860295iom.9
        for <linux-raid@vger.kernel.org>; Sun, 12 Jan 2020 06:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6f61roFMwn9imwglUJ5lH6bZ4A1VftqE2Dlw4XgUtw=;
        b=BXzAaQYNbF2afd4UM2RnxJsEYUTQhGbnem6XPQo70boESrE8pqCcZD81jDfu0XUWB5
         zvZFWCP0Kq4J5P65l65sTriXkiU1ZI1dswX42VN2eilyDeF1b7X3X0Q+77Er65865jbO
         8Lgj6Z1GZlGkeb3k3lrkeGbpMuaYBktDMraBL1Gy0fgmLns8BF3p4p8+SUsMc50DVLHB
         Z0cAtaWNHBBWnYCvCgLDLQ1FyUUIMAJds0qBKSFbp1E0SpbM11jUYyoURD+MRe+gXctw
         D66BGntOw6X8bjHuLQhwNaa27ppzUagGiRAp8bz7nqrC1NKvVUguzt+6D+kQY4Oa8KKw
         HToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6f61roFMwn9imwglUJ5lH6bZ4A1VftqE2Dlw4XgUtw=;
        b=KFkPltALKqUis3LyXCPpEE9kMJ+tEYaUcjtqLEqtax2uXhEAfOxj1Rj6KnUw584V5R
         rXs9VnU6YLyPPyL0ud4OGuigHBB9ErAaiWe0f1IR1VcFo9soKYmNkrm1rjCCBIZ2Bc/x
         QSR8TAaXiP9aqxfYLLQYK1VU5yHIOONZFEyhtS7z2SBHGNhqgkuB2DNJcweHQhaRHg77
         SP3jr8SWreW7i+8dHpao9qCsHIUVOBGw+GmDfzyxn6U7180AcBlc0Ts6Mbe8oPx0ZmnJ
         gZRTC/inV2TPI7q30y9/v2wwJFq5FiQVddyFUs0AJR2YGPe8SaVh7fDqyofhPhea32Ao
         JNxQ==
X-Gm-Message-State: APjAAAXPT/KfMB7MVwpqv5GRtTceJNnfzz49jdpELn18GrGbvSz+Mt7E
        hcU79fZqFpQ/X4sRqh3IFpkhCeKYn3Jj5v0QOm2XZyTV
X-Google-Smtp-Source: APXvYqweAGgFJ5uRFc1ASfpWvi6rOCfGDU21tp1jJO7HcTDmtWtqwblaqC2OyUc99onhXhND7qaAOS+8dpG9S6GNV3s=
X-Received: by 2002:a6b:cb06:: with SMTP id b6mr1817545iog.181.1578839732017;
 Sun, 12 Jan 2020 06:35:32 -0800 (PST)
MIME-Version: 1.0
References: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
 <5D25196A.9020606@youngman.org.uk> <9a71fbbd-8a41-5d59-dd89-5e98bb22a11a@gmail.com>
 <8033f679-84cc-78f9-064d-dc0a191f5a31@websitemanagers.com.au>
 <006fbf98-ec73-818d-f9d1-fbe315dc0f60@thelounge.net> <30c63d5e-34fb-47ce-71f7-272fb4ef3d17@websitemanagers.com.au>
 <0640dd81-a4fe-5847-ec26-3a7dedd5872f@thelounge.net> <cb440d7c-e7eb-1826-3f9d-e7b44ab359f6@websitemanagers.com.au>
 <5e40eefb-8158-8c2c-f28d-e9fb657fe6ce@thelounge.net> <4c4338ea-f5a2-21cf-1c54-2a3a5819d89f@websitemanagers.com.au>
 <72148027-089c-3f7f-1bf7-a7747e9f8f63@thelounge.net>
In-Reply-To: <72148027-089c-3f7f-1bf7-a7747e9f8f63@thelounge.net>
From:   Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date:   Sun, 12 Jan 2020 15:35:20 +0100
Message-ID: <CAJH6TXg_aJ2wa59HuEgNZdaAT_P+NSh_h41_jX3O5705H8Qdbw@mail.gmail.com>
Subject: Re: Raid 1 vs Raid 5 suggestion
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     Adam Goryachev <mailinglists@websitemanagers.com.au>,
        Luca Lazzarin <luca.lazzarin@gmail.com>,
        Wols Lists <antlists@youngman.org.uk>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Il giorno mer 10 lug 2019 alle ore 05:23 Reindl Harald
<h.reindl@thelounge.net> ha scritto:
> i yet need to see an array with 6 different disks where 2 are failing at
> the same time which in this case needs to be the two right ones making a
> stripe-mirror.... at least you have decent write performance while a
> RAID1 with 6 mirrors sucks

Happened to me. Two times in a row.
6 disks RAID10: 2 disks failed in a couple of hours, both disks were
part of the same mirror.

10 days later, another server with the same raid topology.

It's not unusual, if you buy 6 disks at once, you have a very hight chance that
these disks are coming from the same batch from the same factory (most of the
time, the serial number is sequential). In a RAID1 (even if not part
of a RAID1+0)
you are writing the same date at the same time to both disks, thus you have the
same write pattern on both disks.

When one disk fails, you have to read the other disk, putting an
additional stress
in addition to the same pattern used by both disks for years. The
probabily to hit a new failure
is high.

Also, you have to consider some hardware issue not directly related to
disks. I had multiple disks kicked out
during a rebuild. One disk failed, another disk was kicked out,
hopefully this time I had a RAID-6
The first 2 ports on the backplane was defective, but with a RAID10,
if this happens, you are fucked.

Disks are not the only thing that could fail on a server. A RAID10 is
based luck. You have to be luck that a second failure is not impacting
the same mirror.
