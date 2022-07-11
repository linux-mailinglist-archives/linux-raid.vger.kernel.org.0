Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CB55698ED
	for <lists+linux-raid@lfdr.de>; Thu,  7 Jul 2022 05:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiGGD6Y (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 6 Jul 2022 23:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiGGD6X (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 6 Jul 2022 23:58:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B1329804
        for <linux-raid@vger.kernel.org>; Wed,  6 Jul 2022 20:58:21 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y9so2635534pff.12
        for <linux-raid@vger.kernel.org>; Wed, 06 Jul 2022 20:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JxCvx3Wm6aJVrrCk9KxbfLNMLkjb2WQRHJLc9xDV7wo=;
        b=H9LFGZCSA2LuADklmnd2mY5ca/5IZfgA7lt/vP+GxQPOHG6Eoc+SRSUtdiWbeV5G2c
         mzi6WcAlyXYhcPcnOFtTB3YtuLHUPEUVox+cOrEbaZNGt/ddTlFPO1AmzHsD1GPDHa2k
         pV3Jh0ZoXFNYKlRvCTjk1l4nTQfHqGNtLLuAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JxCvx3Wm6aJVrrCk9KxbfLNMLkjb2WQRHJLc9xDV7wo=;
        b=ffT4YLLH052hs3Sc+S5YyoeaThbDAnrIzVo8fmoOChyEqhMc3zU3NI1ZG1cEfdzKjS
         12JTf6foU3wkH6KrEAM06wLa77edUMZqS4rrU4kUSHQvBDyZFZLFB3OcY7j2wbFgC7LQ
         UzxHj9y+eBXzr3/khXJa3LYUXZDrdzP/FNou4ukzelv1nlocFtL3FGcyjk3CajIUwlSX
         GfqmSxrJd8Vp0BgulVz+RVpFMzBaeFGVCjTr44QtTDpA3lEpiZlC2NW+jIo2RPy+6s6Y
         xYxfaNY2PGyX7tZD2TEAQ3O5Pzf8vcNxzzHOTaISKYmi/wIvojOt0nMJr5mSAvny6AdZ
         Z1bg==
X-Gm-Message-State: AJIora8nhwvXG+KDfORuEzhEmW5wg0kXVNGnzDlyL1U3cF5mEx0cr6nv
        p3kenZcLsVf+ixjNtU6FLnTG0g==
X-Google-Smtp-Source: AGRyM1t4S2EttzYuHEUjp0/XnuFNsoOvI4ExjjU9puQ2Rr17H7beMyUoSMv6NJayHK6t/EwYutkiyw==
X-Received: by 2002:a17:903:1c7:b0:16a:2844:8c1f with SMTP id e7-20020a17090301c700b0016a28448c1fmr51071550plh.30.1657166300753;
        Wed, 06 Jul 2022 20:58:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c10-20020a170903234a00b0016b9b6d67a2sm17284819plh.155.2022.07.06.20.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 20:58:20 -0700 (PDT)
Date:   Wed, 6 Jul 2022 20:58:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Douglas Anderson <dianders@chromium.org>,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        linux-security-module@vger.kernel.org,
        Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH v7 0/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <202207062058.49046961A4@keescook>
References: <20220627153526.3750341-1-mka@chromium.org>
 <YsWmPt7xwTlvTfAf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsWmPt7xwTlvTfAf@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jul 06, 2022 at 11:11:58AM -0400, Mike Snitzer wrote:
> On Mon, Jun 27 2022 at 11:35P -0400,
> Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > As of now LoadPin restricts loading of kernel files to a single pinned
> > filesystem, typically the rootfs. This works for many systems, however it
> > can result in a bloated rootfs (and OTA updates) on platforms where
> > multiple boards with different hardware configurations use the same rootfs
> > image. Especially when 'optional' files are large it may be preferable to
> > download/install them only when they are actually needed by a given board.
> > Chrome OS uses Downloadable Content (DLC) [1] to deploy certain 'packages'
> > at runtime. As an example a DLC package could contain firmware for a
> > peripheral that is not present on all boards. DLCs use dm-verity [2] to
> > verify the integrity of the DLC content.
> > 
> > This series extends LoadPin to allow loading of kernel files from trusted
> > dm-verity devices. LoadPin maintains a list of root digests of verity
> > devices it considers trusted. Userspace can populate this list through an
> > ioctl on the new LoadPin securityfs entry 'dm-verity'. The ioctl receives
> > a file descriptor of a file with verity digests as parameter. Verity reads
> > the digests from this file after confirming that the file is located on the
> > pinned root. The digest file must contain one digest per line. The list of
> > trusted digests can only be set up once, which is typically done at boot
> > time.
> > 
> > When a kernel file is read LoadPin first checks (as usual) whether the file
> > is located on the pinned root, if so the file can be loaded. Otherwise, if
> > the verity extension is enabled, LoadPin determines whether the file is
> > located on a verity backed device and whether the root digest of that
> > device is in the list of trusted digests. The file can be loaded if the
> > verity device has a trusted root digest.
> > 
> > [1] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/dlcservice/docs/developer.md
> > [2] https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/verity.html
> 
> Hi Kees,
> 
> Please pick this series up, thanks.

Thanks for the Acks! I'll get this into -next shortly.

-- 
Kees Cook
