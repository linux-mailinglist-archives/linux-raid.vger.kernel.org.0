Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58741176595
	for <lists+linux-raid@lfdr.de>; Mon,  2 Mar 2020 22:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgCBVJm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Mar 2020 16:09:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39868 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgCBVJm (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 Mar 2020 16:09:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so1633532wrn.6
        for <linux-raid@vger.kernel.org>; Mon, 02 Mar 2020 13:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9QswciP3wdHNv+w803sl+SLWahnoA6G+f+wYlMoX4oc=;
        b=weYt2YERY7IMYXEsOn17wAYGylalkpalmy3CoXQYoHSxlCF2gxoetTyW34cFIk+aUF
         z3X6+CFbdaGPViuAE2UvxJPeDlFCg22Uy/P7hjOEpgy16FT4Wg9TOA3JgJqa6hmkP5NR
         Jh8AJTtcmHyhUrZ8uej+1/0a319YHgimuRuZuArb4oS6n4PGqg/+BH+9mWfEeyEnbIIm
         DhnG+4YjA/1RKIb/uqrzdCECYcgOzV/Q12zTsi25/L4x430pqXDitEJg5j2T4E9BeTX/
         e+ywJy17p6coE6bShzpSh7frebvxbf2kPBm2UAXQH1qvA+EKc4ZjAbE5OTQ1Biq0x5hJ
         57fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9QswciP3wdHNv+w803sl+SLWahnoA6G+f+wYlMoX4oc=;
        b=XctdAVEDawHqqYQuaQ4N9gIdJ+7r7pzSjY0ciVEHHuy8Z4aRyzeKbKzhWidVr+adwr
         8q/uzqUn8OFW25COFzin1syIbzjhoy919IaKvBkxnzQe+Y24Fr+ILuJfybU+bNtFfm1u
         Gop7gugiLvfLTsAL07W8sk8vJumCnKeMvxXtJP9OF6TWpnglykRVTOU+b5cUsz+SiT6Q
         Kqy9WdMinSchBM9NDX5kLkO6ywvlXXUlg1EwtlA8x1Hzxrj8nxy8hEiTeI2/xbmq5KJ9
         yhq5QeAAjnSD6EWmIpFvvkYzvHdhYxh0gQPXrnKcdmxYnt26lpg9uFCVKPEWvr47hTKl
         4A5Q==
X-Gm-Message-State: ANhLgQ1irn1eFRiAnxV2B8M3bhAhxzve0xX2s8yPqm4zkh0tN9lj+ijY
        591hXYn9LgbmoSXSTEESCyhQKa//mUJzZrOdPW5RcX2j
X-Google-Smtp-Source: ADFU+vtnhGFUkIqmyRDG3yGFMhFQS74hvYj8cHulzF3gvity3Rh5JGuIllyo9scnpPffqllCEQe4DWGVh9mws92VtwQ=
X-Received: by 2002:a5d:5303:: with SMTP id e3mr1361907wrv.274.1583183379239;
 Mon, 02 Mar 2020 13:09:39 -0800 (PST)
MIME-Version: 1.0
References: <e46b2ae7-3b88-05f2-58d7-94ee3df449e4@suddenlinkmail.com>
 <20200302102542.309e2d19@natsu> <920df583-1d9e-6037-1d61-cbd5e1133d4d@suddenlinkmail.com>
 <20200302115141.1e796b7c@natsu> <c5d8e6d2-a572-5602-6562-795ea52168ac@suddenlinkmail.com>
 <CAJCQCtTOJrvm7BnyqSSuCUa82ehZbtHgSGaQo1bzcepgdtazSw@mail.gmail.com> <9e31d56a-a35d-2413-b6c7-4a97445d487d@suddenlinkmail.com>
In-Reply-To: <9e31d56a-a35d-2413-b6c7-4a97445d487d@suddenlinkmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 2 Mar 2020 14:09:23 -0700
Message-ID: <CAJCQCtSfGZ3BUt9+Si4iRWO5CwK1_Yi05ivDsGzAaBH4GAUa6g@mail.gmail.com>
Subject: Re: Linux 5.5 Breaks Raid1 on Device instead of Partition, Unusable I/O
To:     "David C. Rankin" <drankinatty@suddenlinkmail.com>
Cc:     mdraid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Mar 2, 2020 at 2:27 AM David C. Rankin
<drankinatty@suddenlinkmail.com> wrote:
>
> On 03/02/2020 01:08 AM, Chris Murphy wrote:
> > smart also reports for /de/sdc
> >
> >   40 53 00 ff ff ff 0f  Error: UNC at LBA = 0x0fffffff = 268435455
> >
> >
> > So I'm suspicious of timeout mismatch as well.
> > https://raid.wiki.kernel.org/index.php/Timeout_Mismatch
> >
> >
> > Chris Murphy
> >
>
> The strace between the virtualbox host and guess show and number of I/O waits
> that would seem to fit some timeout issue like that. But according to the
> page, both drives in this array provide:
>
> SCT capabilities:              (0x1085) SCT Status supported.
>

Check the value 'smartctl -l scterc /dev/'
Change the value 'smartctl -l scterc,70,70 /dev/'

Of course no change needed if it's a value already below sysfs timeout
value for each block device. Note that SCT ERC times are deciseconds.

This is on the host.

> Which should be able to handle the correction without stumbling into the
> timeout problem. Something is FUBAR. On a Archlinux guest running on that
> array, At a text console when you type your user name and press [Enter], the
> login may timeout before the password: prompt is ever displayed. So this is
> really giving virtualbox fits.

Weird, I'm not sure what's causing that kind of latency in a vbox guest.


>
> On the host itself, you don't really notice much, other than a bit of slowdown
> with readline and tab-completion every once in a while, but apps looking to
> that array -- all bets are off.
>
> And still not a single error in the journal or mailed from mdadm. You would
> think if it was going to take 26 days to scrub a 3T array, some error should
> pop up somewhere :-)

Yes. At the least the default SCSI command timer should spit back a
hard link reset, both in the journal and to the device. I don't think
mdadm will report that.


-- 
Chris Murphy
