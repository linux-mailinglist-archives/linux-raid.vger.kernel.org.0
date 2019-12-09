Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75944117319
	for <lists+linux-raid@lfdr.de>; Mon,  9 Dec 2019 18:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfLIRsf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 9 Dec 2019 12:48:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52872 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIRsf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 9 Dec 2019 12:48:35 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1ieN96-0005zQ-99
        for linux-raid@vger.kernel.org; Mon, 09 Dec 2019 17:48:32 +0000
Received: by mail-io1-f72.google.com with SMTP id p5so11154433iob.23
        for <linux-raid@vger.kernel.org>; Mon, 09 Dec 2019 09:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8ZwhzlHLWZZsLZVF/XbJet5Jol1/yeYxihv8/oDPC3g=;
        b=UU2RCdWRPjIsHRO1NbuR8ONrT85ui5P9qPIXVAoaCr0FazoEnYizbaD97YthSNwqlS
         LGJcDfW3Te+7Qo2CP8+w7hrvDNpLby90ZSALBoL2t3TkDhm9NCgU9xD6p3Ywt7z9zz5u
         HfsNmNBQ+v7xb2xhn1MEFuPQZcHCRT83qVwbWHuYGyYXnX0mYgo8tCZtqJUBGrbG5UVE
         zdPyM2NGjUN7s2MVpYa6ClUlJBFEmZ4QsTsezaKsd5lVcu0ip9v/gLelgO6a2c9vSUOU
         KGkmfTRPR7QZj0L2o7JCwWlxfJa5TMbfteC+jFQ5JtANZKqcsq8aj3SixdMIKm5M1SXB
         217A==
X-Gm-Message-State: APjAAAUHx0BT3rEVm9G3nawzK2vw6Cc+Px1xsIkPKbTu+3PkzmskzeFM
        oxt71FBgQkrJVku1bBg/u1wQ+rKhktcGeI8v5R/1Be5MkEk5UgYjB0TlNzdDOhDfO2x/t78B5wn
        LVvPFGxoHMfED+KQQN1qoV84uf05LwtV4smLuuVw=
X-Received: by 2002:a02:b385:: with SMTP id p5mr21396272jan.43.1575913711221;
        Mon, 09 Dec 2019 09:48:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxdtyqKwlCghg7HpMf914a4FhgVSP9hd1I0sQvfKlzzKYVpFAomcQQ6UtOvc/AxPMWFtnY4MA==
X-Received: by 2002:a02:b385:: with SMTP id p5mr21396234jan.43.1575913710699;
        Mon, 09 Dec 2019 09:48:30 -0800 (PST)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id i2sm59864iol.29.2019.12.09.09.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 09:48:30 -0800 (PST)
Date:   Mon, 9 Dec 2019 10:48:28 -0700
From:   dann frazier <dann.frazier@canonical.com>
To:     Song Liu <liu.song.a23@gmail.com>, NeilBrown <neilb@suse.de>,
        Jes Sorensen <jsorensen@fb.com>
Cc:     Ivan Topolsky <doktor.yak@gmail.com>, Andreas <a@hegyi.info>,
        linux-raid@vger.kernel.org
Subject: Re: [PATCH v2] md/raid0: Provide admin guidance on multi-zone RAID0
 layout migration
Message-ID: <20191209174828.GA411439@xps13.dannf>
References: <20191112232105.749-1-dann.frazier@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112232105.749-1-dann.frazier@canonical.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

[ + Jes ]

Hi Song, Neil,
 Now that the merge window has closed, I wanted to check in on the
status of this. fyi, this still applies cleanly to 5.5-rc1.

Jes: note that this patch makes an assumption that the next version of
mdadm would be >= 4.2, so seeking your ACK as well.

 -dann

On Tue, Nov 12, 2019 at 03:21:05PM -0800, dann frazier wrote:
> Helping an administrator understand this issue and how to deal with it
> requires more text than achievable in a kernel error message. Let's
> clarify the issue in the admin guide, and have the kernel emit a link
> to it.
> 
> v2:
>   - Add info about setting layout w/ mdadm, using presumed-next-mdadm
>     version.
>   - Add comment to doc to help prevent future changes from breaking
>     the link emitted by raid0.
> 
> Fixes: c84a1372df92 ("md/raid0: avoid RAID0 data corruption due to layout confusion.")
> Cc: stable@vger.kernel.org (3.14+)
> Signed-off-by: dann frazier <dann.frazier@canonical.com>
> ---
>  Documentation/admin-guide/md.rst | 48 ++++++++++++++++++++++++++++++++
>  drivers/md/raid0.c               |  2 ++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guide/md.rst
> index 3c51084ffd379..a736e3b4117fc 100644
> --- a/Documentation/admin-guide/md.rst
> +++ b/Documentation/admin-guide/md.rst
> @@ -759,3 +759,51 @@ These currently include:
>  
>    ppl_write_hint
>        NVMe stream ID to be set for each PPL write request.
> +
> +Multi-Zone RAID0 Layout Migration
> +---------------------------------
> +.. Note: a public URL to this section is emitted in an error message from
> +   the raid0 driver, so please take care to not make changes that would
> +   cause that link to break.
> +An unintentional RAID0 layout change was introduced in the v3.14 kernel.
> +This effectively means there are 2 different layouts Linux will use to
> +write data to RAID0 arrays in the wild - the "pre-3.14" way and the
> +"3.14 and later" way. Mixing these layouts by writing to an array while
> +booted on these different kernel versions can lead to corruption.
> +
> +Note that this only impacts RAID0 arrays that include devices of different
> +sizes. If your devices are all the same size, both layouts are equivalent,
> +and your array is not at risk of corruption due to this issue.
> +
> +Unfortunately, the kernel cannot detect which layout was used for writes
> +to pre-existing arrays, and therefore requires input from the
> +administrator. This input can be provided via the kernel command line
> +with the ``raid0.default_layout=<N>`` parameter, or by setting the
> +``default_layout`` module parameter when loading the ``raid0`` module.
> +With a new enough version of mdadm (>= 4.2, or equivalent distro backports),
> +you can set the layout version when assembling a stopped array. For example::
> +
> +       mdadm --stop /dev/md0
> +       mdadm --assemble -U layout-alternate /dev/md0 /dev/sda1 /dev/sda2
> +
> +See the mdadm manpage for more details. Once set in this manner, the layout
> +will be recorded in the array and will not need to be explicitly specified
> +in the future.
> +
> +Which layout version should I use?
> +++++++++++++++++++++++++++++++++++
> +If your RAID array has only been written to by a 3.14 or later kernel, then
> +you should specify default_layout=2, or set ``layout-alternate`` in mdadm.
> +If your kernel has only been written to by a < 3.14 kernel, then you should
> +specify default_layout=1 or set ``layout-original`` in mdadm. If the array
> +may have already been written to by both kernels < 3.14 and >= 3.14, then it
> +is possible that your data has already suffered corruption. Note that
> +``mdadm --detail`` will show you when an array was created, which may be
> +useful in helping determine the kernel version that was in-use at the time.
> +
> +When determining the scope of corruption, it may also be useful to know
> +that the area susceptible to this corruption is limited to the area of the
> +array after "MIN_DEVICE_SIZE * NUM DEVICES".
> +
> +For new arrays you may choose either layout version. Neither version is
> +inherently better than the other.
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index 1e772287b1c8e..e01cd52d71aa4 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -155,6 +155,8 @@ static int create_strip_zones(struct mddev *mddev, struct r0conf **private_conf)
>  		pr_err("md/raid0:%s: cannot assemble multi-zone RAID0 with default_layout setting\n",
>  		       mdname(mddev));
>  		pr_err("md/raid0: please set raid0.default_layout to 1 or 2\n");
> +		pr_err("Read the following page for more information:\n");
> +		pr_err("https://www.kernel.org/doc/html/latest/admin-guide/md.html#multi-zone-raid0-layout-migration\n");
>  		err = -ENOTSUPP;
>  		goto abort;
>  	}
