Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A266BF07DC
	for <lists+linux-raid@lfdr.de>; Tue,  5 Nov 2019 22:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfKEVLc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 Nov 2019 16:11:32 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40409 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfKEVLc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 Nov 2019 16:11:32 -0500
Received: by mail-qk1-f195.google.com with SMTP id a18so4945279qkk.7
        for <linux-raid@vger.kernel.org>; Tue, 05 Nov 2019 13:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ux8C3pyrQrbTMbeUIHNrN9hXEijWGi7sMC+DuRdBmdY=;
        b=cSWGW3OnhwCdVoDnYRl+vnMlXhPIc6bEwgzspEDOuKXjcJnylZKB2kUMLAbMwMk1/w
         8Z/wVpTcHZ1hfROaHr9h4fNZA93/cpMRmuECXV+wQFHKQmMxFa6cHuYbv4M/tLGXq/vQ
         8dr71EsZmzyq2g9swS6/aYAD+6KMSKjeYaJ3whBYAFWS1DyVa4GDm3r3Qp6LiybrLYD9
         1DYUorWyoAFBkhExiupuF590b6e/QxzsDGVb39zDGyqifxSmF7KnvEU0nXHNTdHe1CUn
         2ItFtgU7C11ZprruHtuuCQBVCpLwQUObduhjJbKBpFrwRzQKlak90qn8RwYTCK0YjW6Y
         La1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ux8C3pyrQrbTMbeUIHNrN9hXEijWGi7sMC+DuRdBmdY=;
        b=SpjZm7d8NMzfaD3Q3OgeLoaymwLw8IiWzjeCbJ2UO0wh2c3ELKPfDFaiZCeEOSfkwt
         9h+kn6T06WzKWOY38VGNM7gFGGBc/cvOg2P4NjTw/cuH7IkEUyt5uPZwA3buFnNLzklS
         u8zrd4m7RuEua4xAlZAzNZKni9ISmN31U0Et7zFI1KEmIxLM6ctIoGRvYQuxa2jKM1Sn
         Mvz9A5GfiPXSaKVrT4IovurzJICNbZHSgN/YSIMEWxTYai4iEQsdtrckLufnZHcCUtj0
         Pi4f0Sms8hfIB35ZO9RNRsbPwk0ctaiCvafo/VEzE3nYQzE1nOBMFQVnBIo9ExYYhJU/
         6mxg==
X-Gm-Message-State: APjAAAXdgFnv5BPIad4amGURryeoVDROLdS2CntSqcb7lfb/KjeYtVCr
        ovgHm58po+6A4vc66M7miDebptPyZXVhQH0Mqm0ZIg==
X-Google-Smtp-Source: APXvYqxTvbMdUdxlac//Gx59A4Xp/D9MQIw9MXo2sfKgfQ/2OMoTfksy/BeoMpe87xzVzrx/4LxBAZyXoAHH6QPJOVg=
X-Received: by 2002:a37:b801:: with SMTP id i1mr9660443qkf.497.1572988291466;
 Tue, 05 Nov 2019 13:11:31 -0800 (PST)
MIME-Version: 1.0
References: <20191104200157.31656-1-ncroxon@redhat.com> <5DC0C34B.1040102@youngman.org.uk>
In-Reply-To: <5DC0C34B.1040102@youngman.org.uk>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 5 Nov 2019 13:11:20 -0800
Message-ID: <CAPhsuW5bkFEk+t06JQufyYbzr-ckUfpQtgctoe6jy4wxzesBhw@mail.gmail.com>
Subject: Re: [PATCH] raid456: avoid second retry of read-error
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     Nigel Croxon <ncroxon@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Nov 4, 2019 at 4:33 PM Wols Lists <antlists@youngman.org.uk> wrote:
>
> On 04/11/19 20:01, Nigel Croxon wrote:
> > The MD driver for level-456 should prevent re-reading read errors.
> >
> > For redundant raid it makes no sense to retry the operation:
> > When one of the disks in the array hits a read error, that will
> > cause a stall for the reading process:
> > - either the read succeeds (e.g. after 4 seconds the HDD error
> > strategy could read the sector)
> > - or it fails after HDD imposed timeout (w/TLER, e.g. after 7
> > seconds (might be even longer)
>
> Okay, I'm being completely naive here, but what is going on? Are you
> saying that if we hit a read error, we just carry on, ignore it, and
> calculate the missing block from parity?
>
> If so, what happens if we hit two errors on a raid-5, or 3 on a raid-6,
> or whatever ... :-)

Based on my understanding (no data on this), the drive will retry read
internally before return error. Therefore, host level retry doesn't really
help. But I could be wrong.

Song
