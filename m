Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F01C5122F0E
	for <lists+linux-raid@lfdr.de>; Tue, 17 Dec 2019 15:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfLQOn1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Dec 2019 09:43:27 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:39180 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbfLQOn0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 17 Dec 2019 09:43:26 -0500
Received: by mail-lj1-f179.google.com with SMTP id e10so11213554ljj.6
        for <linux-raid@vger.kernel.org>; Tue, 17 Dec 2019 06:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZbi2n+AHThoMrTQ75gF0YUoWX/pH9Z0l9KcVThpJqI=;
        b=TPITn7JJDetV12yZN3QUuEerI8Pv2j28W9GJsAmo1NUOpc+hHLDpmSoihm2s0wu456
         Y0pa7dgZNTZ4mAVkN2WbzW2Id2B1YP+ZIONPnFRPIcEpoCetWI4sJ4rxGTLrgKv6AVmM
         AK5+t2FznjaJqdrX8nUiR61iHfgbnN7X9Xybke7HDRjJXc5nuyMWZxJfv+jgRAJDV1IA
         MDQ3DX8Bq+R5RlZv1avvLPDcvu+0QzP5Vg1qUME2l+JOB/165Us6L3fzBx6b2wTSzlMY
         PTMh+uRuSmjxzhkV8mJxqfQKEimScrg75X4HaN9lT2baLzYewV2Vbomx/1o8m4aNnDlq
         w2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZbi2n+AHThoMrTQ75gF0YUoWX/pH9Z0l9KcVThpJqI=;
        b=M5zW4fmBCBSvZlxUYvEkqE0dN3fS8+M6qf2MCEb1Q+WYa90S1z84jtwUtsPA6B4UQP
         IxrdfBpspScr6/DltsZKy3I4aSUimIAnmshV8iDeOj8nWwxaiE02zS33U7YK5ZD5ypb+
         3kiE5Z9NlUsP2gSL5Y780oqG5498f95jw4wkWbKB7FYeX56ag0/N6sGIHqUtpzMCIxPj
         HHS5NVH8bVBcAz8/3UEnt8ZFA38JsrSs0U6+uourzU9slh1phiV+LxQRNI86qIaBtVwZ
         kE9CA68AntsDjNFLZA2siBuJwPdE6Xc3vonfBMC+Gys9s/z1TwfTlJaQIjetZS/kmfO5
         godw==
X-Gm-Message-State: APjAAAXP/ONGNtkwpcofv3CBk5i9/l176GAF7BtbeaNGBAethGFghfc8
        UfSYTrA9Nnt6uSIqJpycFbIdUsM+8SPjvbA9MDw=
X-Google-Smtp-Source: APXvYqxPlxXlp6QS5RsPyAPwkTB5ZbrpSXarO0we9SuCFHDiaRsWeufVQP3WFB0HLq3dhT/zLnS4QSbLm4p2KdaXAZE=
X-Received: by 2002:a05:651c:321:: with SMTP id b1mr3544503ljp.62.1576593804634;
 Tue, 17 Dec 2019 06:43:24 -0800 (PST)
MIME-Version: 1.0
References: <e7e9ed61-c611-3b40-2c78-6c5c47f77148@gmail.com>
In-Reply-To: <e7e9ed61-c611-3b40-2c78-6c5c47f77148@gmail.com>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Tue, 17 Dec 2019 08:43:13 -0600
Message-ID: <CAAMCDedHgQzQx=0U=7=nrJoBYqfzE-DCfYxMd-L8B-NRft8TNg@mail.gmail.com>
Subject: Re: Keeping existing RAID6's safe during upgrade from CentOS 6 to
 CentOS 8
To:     Benjammin2068 <benjammin2068@gmail.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

If you do pull the drives, make sure to pull them with the machine
off, and make sure to insert them with the machine off.

Not having the machine off would cause mdraid to fail the raid as the
drives are removed, and not having it off when inserting them would
make it activate them one at a time which may or may not quite work.

I have done my updates without pulling the drives (at least 1-2 fedora
reinstalls) and just made sure to not let anaconda mess with the
larger raid disks.  Without the conf file it will still find the
raids, it just won't have the same md* names.  I have also installed a
disk elsewhere and made sure the dracut config was setup to include
all drivers (change to hostonly=no).  6 does hostonly=no, 7 does
hostonly=yes, not sure what 8 does by default.

Good luck.

On Tue, Dec 17, 2019 at 12:44 AM Benjammin2068 <benjammin2068@gmail.com> wrote:
>
> Hey everyone,
>
> I have a quick and (hopefully) easy question...
>
>
> At some point, I'm going to update my CentOS 6.10 system to CentOS 8.x
>
> My biggest concern is dealing with the mdadm based RAID6 that holds my important data.
>
> SO.... What's the safest thing I could do to protect it when I do the upgrade (which is essentially a fresh install of v8)
>
> I'm assuming I should:
>
> * copy /etc/mdadm.conf someplace
> * copy /etc/fstab someplace (for reference more than anything)
> * PULL THE DRIVES FROM THE SYSTEM.
>
> * Once the new OS is installed, plug the drives back in.
> * Patch mdadm.conf and fstab as needed ..... and.....
>
> Anything else?
>
> Thanks a bunch,
>
>   -Ben
>
