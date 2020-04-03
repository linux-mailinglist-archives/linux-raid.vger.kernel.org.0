Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFBA19DE24
	for <lists+linux-raid@lfdr.de>; Fri,  3 Apr 2020 20:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgDCSm3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 3 Apr 2020 14:42:29 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34166 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDCSm3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 3 Apr 2020 14:42:29 -0400
Received: by mail-vs1-f65.google.com with SMTP id b5so5641778vsb.1
        for <linux-raid@vger.kernel.org>; Fri, 03 Apr 2020 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iowni-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8tCDeNPZFSBDpnDn7ZQ5esJLwkgiHKf5aW5Gg3JGhg=;
        b=uqHeFe/TB7U+w+IC1Pqllk2HgZCWkWxia6GUXbxpaorFj/xMeH+TrSlUXVmyxlUyFu
         xRYF0UlfaFpqwkLI374TwvqHjezn0eNnXxDwT16OZJvRP/hVgg3o+ezUoLubG6HYOXMl
         BtcvJ4hOldycqnseQjoX69aAiXGBSnR8J4x55MrCQIdMcNXOVt57sWjnzvK2ISeSHZGd
         x5BRCVpsaWgTyvi32aAPF7SvZ7aw+uINkDXnXhuc6iCipB9gIs+jJqarAbGdaIKrtbvD
         +ej5IC7br20XWHb98U0DoBt+ggO9HNN4wtdLXJsi0KELs3FfIZF04ouT+y34XkEkDZ9R
         3Icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8tCDeNPZFSBDpnDn7ZQ5esJLwkgiHKf5aW5Gg3JGhg=;
        b=UOn7/jI4mTXAV/3zNvZdwoBXt9oKr16Y7utbi1z2ZNRrFWc7b5R/Q5iiMzbnCZz8Er
         bXQASgoh12tXyGO0fwvLOcKnbDYTQ+cGDCaEMSGBMa+WiEq1EBBVid9KFDhGqCod6PDL
         iotG/6Bp1HP+yInALrC8PjJ6zsViT+vvM7oXTai16ODgu5L6Fdin4zzNouw/dCOEhDmL
         OiqTMyKgMKW1OUZ7ONb7SjTWA/vZb4HIsdNowiGnhWB9zCNAQhKUTzuVnN7ZvFb5P4Iy
         oeObcBOUvg89j9TaV1tOxaV7INc0KOGyfWuXMl/6TuCLjEBja1TLaJr8KrXMr9BvEp+w
         rNHg==
X-Gm-Message-State: AGi0PuaO0IpvK1ijsTKYw/fB3Ch0FBCir5ZTzbCNgmPSiRmo0DbqSKRm
        43KAU980lmF7LCj+l5ubVaDLgi0hcepRDLCpRMKGcSTHAIs=
X-Google-Smtp-Source: APiQypLFVRNmg8g71eIvuB3DAy+EH4auj7tSVeeTIdmGLrCj1BReRlCUKtyawTzg9dd1JIK/fPflnsAFTJRvorKVJxQ=
X-Received: by 2002:a67:fc4b:: with SMTP id p11mr7719075vsq.135.1585939348182;
 Fri, 03 Apr 2020 11:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAB00BMjPSg2wdq7pjt=AwmcDmr0ep2+Xr0EAy6CNnVhOsWk8pg@mail.gmail.com>
 <CAB00BMgYmi+4XvdmJDWjQ8qGWa9m0mqj7yvrK3QSNH9SzYjypw@mail.gmail.com>
 <1d6b3e00-e7dd-1b19-1379-afe665169d44@turmel.org> <CAB00BMg50zcerSLHShSjoOcaJ0JQSi2aSqTFfU2eQQrT12-qEg@mail.gmail.com>
 <e77280ef-a5ac-f2d8-332c-dec032ddc842@turmel.org> <CAB00BMj5kihqwOY-FOXv-tqG1b2reMnUVkdmB9uyNAeE7ESasw@mail.gmail.com>
 <061b695a-2406-fc00-dd6d-9198b85f3b1b@turmel.org> <CAB00BMi3zhfVGpeE_AyyKiu1=MY2icYgfey0J3GeO8z9ZDAQbg@mail.gmail.com>
 <5E8485DA.2050803@youngman.org.uk> <9a303b9b-52b8-f0c6-4288-120338c6572f@turmel.org>
 <CAB00BMig177NjEbBQgfjQ5gZE3QPTR-B6FD9i8oczHqf7mMqcg@mail.gmail.com>
 <1f4b8c74-4c38-6ea4-6868-b28f9e5c4a10@turmel.org> <e75f80f4-70d4-e283-b3bc-c78bd0d55a8a@turmel.org>
 <CAB00BMhU76rjvQv9v-HxM8Harc9ssLBANWfPsW9abbSRNgwoUQ@mail.gmail.com>
 <bb554b86-3dc0-8cb2-c279-f8841742195c@turmel.org> <CAB00BMgwCbtGYJ_hX3_rZv3uaOd7vrHuEebqsPLHp3S96tJaRw@mail.gmail.com>
 <5985cc5b-a332-eb69-2d84-cb54f8f5b0fc@turmel.org>
In-Reply-To: <5985cc5b-a332-eb69-2d84-cb54f8f5b0fc@turmel.org>
From:   Daniel Jones <dj@iowni.com>
Date:   Fri, 3 Apr 2020 12:42:16 -0600
Message-ID: <CAB00BMjxywFn_K_D=Xn7ySHp404nvULTXarA7EwjxtuTJSOqQg@mail.gmail.com>
Subject: Re: Requesting assistance recovering RAID-5 array
To:     Phil Turmel <philip@turmel.org>
Cc:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

After the "--create missing /dev/sdc1 /dev/sdd1 /dev/sde1"  and the
fsck, is "mdadm --manage /dev/md0 --add /dev/sdb" the correct syntax
for attempting to add?

-DJ

On Fri, Apr 3, 2020 at 12:34 PM Phil Turmel <philip@turmel.org> wrote:
>
> On 4/3/20 2:29 PM, Daniel Jones wrote:
> > Hello again,
> >
> >> Don't do the --add operation until you've copied anything critical in the array to external backups (while running with 3 of 4).
> >
> > Everything from the array has been backed up elsewhere.
> >
> > Up until now the only writes intentionally done to the physical drives
> > have been the new partition tables.  Everything else has been through
> > the overlay.
> >
> > Now I think I'm ready to run a --create as follows on the physical drives:
> > mdadm --create /dev/md0 --assume-clean --data-offset=129536 --level=5
> > --chunk=512K --raid-devices=4 missing /dev/sdc1 /dev/sdd1 /dev/sde1
> >
> > After that I'd try to re-add the rejected drive?
> > mdadm --manage /dev/md0 --add /dev/sdb1
> >
> > Part of me wonders about just rebuilding the whole thing and then
> > copying the data back, but I don't know that would be any better then
> > this path.
>
> Sounds like a risk-free decision.  mdadm --create --assume-clean
> followed by a proper fsck will be lots faster than mdadm --create, mkfs,
> and copying.
>
> I'd go fast.
>
> Phil
