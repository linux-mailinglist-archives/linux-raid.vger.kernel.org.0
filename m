Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80EB4C4182
	for <lists+linux-raid@lfdr.de>; Tue,  1 Oct 2019 22:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfJAUCO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 1 Oct 2019 16:02:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36627 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfJAUCO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 1 Oct 2019 16:02:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id y19so17000290wrd.3
        for <linux-raid@vger.kernel.org>; Tue, 01 Oct 2019 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GRIUfOUw0spd6fma+pqMCS+JA2Xr8wF6o2U1EvsAQwY=;
        b=q2ERC0A6Fr1C/5n+9rsjVR+Av2T+5aVt0jmNE90p+o0+Qowhy8Gjdq6ZOecny3fI/3
         Mci6kmZzTb6fhMqiMZJ2wi5zV06ZcOh6nxesJhbvD0Ck1P+tuTm/9NsbXln4k+NWP4dN
         rrWVFgMqer+vzU0hK1+UqpaLjKjIYZVl5ROxDUTZ88F0ENDHDulCnF/iruZS5ht7iLVf
         mXvb7XxGy1OO0rjZHF5y13TfZL1bnBB/HVxAsptyY4jaaTMWv2I9aYd10BZ7Ri0PwGa3
         dbf8n5J2F/D3DRCHKmTfXomMotciObHyITKxw1egHutYW5YojSE759gsAsw+HHCNmNXF
         c45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GRIUfOUw0spd6fma+pqMCS+JA2Xr8wF6o2U1EvsAQwY=;
        b=br4qOw1QGRUdDHboEES3hfvo/gJJqC12xGytQyugaJT8V6MHKxamrItoEbXJsM1Zuq
         xWdxPX4b0FzEWbzMz/mHPo6ypadDqbYHIVMEsHT8tglVajk2g/Dt8F5jvu4tholp7Rfv
         OdtG80aViGlhLPnDOFnv0B9Ps0lTbC7vA2EkMqtMZ3ao5v1RKTySdtYM3jcKZ4ALXo3E
         6J3TeHQnpJU7gWCgj6UuD07ftdQ26+cOnV2xqn1F4Lu/iWD1X0HQWgGuBF6lnKl4DWo8
         l474xe1qcsru0qZA+6BmWY5ALbrvIsD5wo6M8A71sJ9p4x17ORH1w/IZuQbOToVracK1
         lMWg==
X-Gm-Message-State: APjAAAVSKzlap6yf3hwBTovY6sxid7IFLF5KuiNrIIHaWx7rprNkFeJx
        c10SKMHzPeIqRNVAK5zqOHESxhkxS6iIE08R4Jc=
X-Google-Smtp-Source: APXvYqzwT8kwEOiym3g0GkVDw0NJ0OEiyG4CxVIq4IS74ioBoU1egZSEcayHymsAefx8fQH3o4gQmHJTQzQO/B9mJVk=
X-Received: by 2002:adf:e545:: with SMTP id z5mr20401862wrm.263.1569960132652;
 Tue, 01 Oct 2019 13:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAGRSmLs+nyQ0pp_VPt36MxXDqumcyqLSR_vhkOqtFXir18puEA@mail.gmail.com>
 <20190930101443.GA2751@metamorpher.de> <6026f55f-82c9-7b99-8c2b-8d03dfe8f52e@suddenlinkmail.com>
 <CAGRSmLvHc-gOVmr-fHTo0upUeDNjrQgCk9rSqpALFV1FiHra+g@mail.gmail.com> <20191001195510.GA33475@metamorpher.de>
In-Reply-To: <20191001195510.GA33475@metamorpher.de>
From:   "David F." <df7729@gmail.com>
Date:   Tue, 1 Oct 2019 13:02:01 -0700
Message-ID: <CAGRSmLszFWkaFCd2qLye_ATZcnVyhpTgEbCs=BhGj6ur_sSnpw@mail.gmail.com>
Subject: Re: Fix for fd0 and sr0 in /proc/partitions
To:     Andreas Klauer <Andreas.Klauer@metamorpher.de>
Cc:     "David C. Rankin" <drankinatty@suddenlinkmail.com>,
        mdraid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Right, mdadm should skip those.  For me, I also want the option to not
add at least fd0 to /proc/partitions but that's nothing to do with
mdadm (I maintain a portable emergency boot disk that has to work on
countless unknown system configurations).  That is the way it was
before updating udev which now needs devtmpfs.   I already patched
mdadm to ignore the floppy and cdrom device types so at least it
doesn't hang on boot, only when things like fdisk -l are run.

On Tue, Oct 1, 2019 at 12:55 PM Andreas Klauer
<Andreas.Klauer@metamorpher.de> wrote:
>
> On Tue, Oct 01, 2019 at 11:59:14AM -0700, David F. wrote:
> > mdadm shouldn't be scanning fd0 or sr0 by default
>
> First of all I apologize, it's my misunderstanding completely.
> For some reason I thought you wanted it removed from /proc/partitions...
>
> For mdadm, there are plenty of devices it should not touch.
> Such as device mapper, network block device, and md devices.
> Well, that applies for my system anyway.
>
> Hence my mdadm.conf restricts it to /dev/sd* /dev/loop*
> And loop devices are only included because I like to
> experiment with those.
>
> Since it can be configured I never had an issue with it,
> so not sure what the default should be.
>
> Regards
> Andreas Klauer
