Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94260F9E2A
	for <lists+linux-raid@lfdr.de>; Wed, 13 Nov 2019 00:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKLX0p (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 12 Nov 2019 18:26:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41045 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLX0p (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 12 Nov 2019 18:26:45 -0500
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1iUfYZ-00069F-Eh
        for linux-raid@vger.kernel.org; Tue, 12 Nov 2019 23:26:43 +0000
Received: by mail-pl1-f199.google.com with SMTP id a3so108134pls.10
        for <linux-raid@vger.kernel.org>; Tue, 12 Nov 2019 15:26:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V+87JXBOjFis5ZI1JmJ/CXt6Vr0LrHD1p6THbclQ3O0=;
        b=JDOKkEUi8pmUa0zbRMgVk9svByDnaHHMz3nYBc9wYKUfdSRPDI2TS6v8P2DQQSE0O5
         RNtnqdalJBhhkmBCnM6+1u5qljA0NMeXAMd8vc45Z5UzkRovblfAJp8Bi6Chgo3qYqNV
         +1UD0ECN+L0NAI0wU9mMW6qaayaSbEk/PNjaNn0Ah9PLv+/xA1ARSx9S88wtXz9k61xf
         gDkZev227/5P0BBTUGHDIsk5YTRO49gKLYMojEUIYqkO2kTWCguxA39qDC+bl7o+MJsk
         TpWaVMxuHlk99EtfBW1JqeMt6B6aG13TIHnInbAbqSFoxOmaixIkQTsjB4fKwKde9iCR
         bzjQ==
X-Gm-Message-State: APjAAAWQWdY6tCY3UHifnsHGiPIQ7twfThyzK6WvXr+BTeS7krdiR0On
        sXUACgepVhDrYZ+6v5kwIQsLHvjyvwga9Vn/j3ADGTrOjBGyOXTgby6pix+ilzMrkRcnCMN+gHV
        F2Qje3sD1gQaruL8nM1m0l0ACdrTV6tRnb38XoAg=
X-Received: by 2002:a62:e914:: with SMTP id j20mr567322pfh.245.1573601202157;
        Tue, 12 Nov 2019 15:26:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqzY42DgYnIRpnAMh372mJo+p1W2QYo5iWz50FYQtH+S3G/M+cI/lvvFIAEFQcwskpCryL+tAg==
X-Received: by 2002:a62:e914:: with SMTP id j20mr567299pfh.245.1573601201857;
        Tue, 12 Nov 2019 15:26:41 -0800 (PST)
Received: from xps13.canonical.com ([2001:67c:1562:8007::aac:4100])
        by smtp.gmail.com with ESMTPSA id v63sm39956pfb.181.2019.11.12.15.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:26:40 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:26:33 -0800
From:   dann frazier <dann.frazier@canonical.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jes Sorensen <jes.sorensen@gmail.com>, linux-raid@vger.kernel.org,
        Song Liu <liu.song.a23@gmail.com>
Subject: Re: [PATCH 0/2 v2] mdadm: address the RAID0 layout problem
Message-ID: <20191112232633.GA393@xps13.dannf>
References: <157247951643.8013.12020039865359474811.stgit@noble.brown>
 <157283799101.17723.14738560497847478383.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157283799101.17723.14738560497847478383.stgit@noble.brown>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Nov 04, 2019 at 02:27:49PM +1100, NeilBrown wrote:
> This is a second version for my mdadm enhancement to help handle the
> RAID0 layout problem.  Thanks a lot to Dann for the review.
> I suspect these are now ready to land.

Thanks Neil - fwiw, these worked for me. And thanks for making the
layout visible in --detail :) I'm assuming these will land in mdadm
4.2, so I updated the mdadm content in v2 of my admin-guide patch
mentioning that version.

Tested-by: dann frazier <dann.frazier@canonical.com>

  -dann
  
> NeilBrown
> 
> ---
> 
> NeilBrown (2):
>       Create: add support for RAID0 layouts.
>       Assemble: add support for RAID0 layouts.
> 
> 
>  Assemble.c |    8 ++++++++
>  Create.c   |   11 +++++++++++
>  Detail.c   |    5 +++++
>  maps.c     |   12 ++++++++++++
>  md.4       |   21 +++++++++++++++++++++
>  mdadm.8.in |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
>  mdadm.c    |   12 ++++++++++++
>  mdadm.h    |    8 +++++++-
>  super0.c   |    6 ++++++
>  super1.c   |   42 ++++++++++++++++++++++++++++++++++++++++--
>  10 files changed, 168 insertions(+), 4 deletions(-)
> 
