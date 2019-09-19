Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35C47B87EA
	for <lists+linux-raid@lfdr.de>; Fri, 20 Sep 2019 01:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392269AbfISXCR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 19 Sep 2019 19:02:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40393 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392190AbfISXCR (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 19 Sep 2019 19:02:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so202319wmj.5
        for <linux-raid@vger.kernel.org>; Thu, 19 Sep 2019 16:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ll/IFhFbgbp6kK2WIL4W7/BKROf/sUamaKfI4BE/9Qs=;
        b=Ti/SuyVHT+f/9kHa27iriN5huro9Vtr5GTZFuOZFJRS25tk59esJg+YYJvb/Gy4RVT
         wzcUmwdNj2XShFqAcMaf0JsZ5+T5pxz58S0eSadBC0OQPDl8BqB4lZ0xl9lw9fv3Gfy7
         Tk2PygtQtUbgCMWze7u6S3vh0zlef2Grud6QGT7plFODA/q/yqcgFwgaNHXdulrrYJmZ
         a2C1M7QqrDTCnKA+qKaeZl6HozdwglRzhxFIbn5y+9taKRQh+WgWC+D8Lh4uVXVPxGjp
         u/k/i+vC1nPsU4Ng0hxchk+NzTx5qvz9TP0a4gvbYYkqvAid054AKtB3g3Kwg58ZR5hP
         RTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ll/IFhFbgbp6kK2WIL4W7/BKROf/sUamaKfI4BE/9Qs=;
        b=P466t9jkoS5kWqTR9nPUejwmiOgzprg3n2wDYVCd6yuNwh5JM9SP+wVvAUeWsdslYj
         jg9T4aKTuFMkn/vKLzqu5Gsh/bBxeFcqUd62E1L23K8QhtRoavLKR/0ugN/tGjutUTTG
         U7cGY8Xariliqe6FYA3tE1KqFSuF2XAyQhIXOs92PN8Y1gpgwbT+DTl5rPwB78lp7D12
         UoQcEWQwx4sQhXdXqK5omeXJomDoIxcGKzPm3ptgBxpILdlrN2CupbZnjUALevh+iAd3
         ZmEfRJAQ9A49jesY9OR5+4L0xiNSbEHn3QMM3l4qmcI430w6m04pZkVyUdHuYs14zO3T
         AdYg==
X-Gm-Message-State: APjAAAXECH7v8oy8kNMjYaDo+Kzh0+CPokPoKkdztJGBAMA9wjXp5YU3
        ICFBfnoYOjkNFpkkV3sF4jHeXHHlBjoNoZ42o0U=
X-Google-Smtp-Source: APXvYqyc8vnZ/y7oPpr9f6zWfwecb33fTmz4t8nrIFD1YzupPFgQiUZcxjnSN6/6bjv/V6bnXucq3bv/Lm0jdPo55O0=
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr206135wmt.81.1568934133470;
 Thu, 19 Sep 2019 16:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <87impq9oh4.fsf@notabene.neil.brown.name>
In-Reply-To: <87impq9oh4.fsf@notabene.neil.brown.name>
From:   "David F." <df7729@gmail.com>
Date:   Thu, 19 Sep 2019 16:02:02 -0700
Message-ID: <CAGRSmLsH4a20Hed10ekGbprQXoXXasazgQT6cz+6dps7E1CUAA@mail.gmail.com>
Subject: Re: [PATCH] udev: allow for udev attribute reading bug.
To:     NeilBrown <neilb@suse.de>
Cc:     Jes Sorensen <jes.sorensen@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

does this apply to eudev as well?  I'm thinking of upgrading from an
older udev to eudev on our boot media.

On Tue, Sep 17, 2019 at 11:11 PM NeilBrown <neilb@suse.de> wrote:
>
>
> There is a bug in udev (which will hopefully get fixed, but
> we should allow for it anways).
> When reading a sysfs attribute, it first reads the whole
> value of the attribute, then reads again expecting to get
> a read of 0 bytes, like you would with an ordinary file.
> If the sysfs attribute changed between these two reads, it can
> get a mixture of two values.
>
> In particular, if it reads when 'array_state' is changing from
> 'clear' to 'inactive', it can find the value as "clear\nve".
>
> This causes the test for "|clear|active" to fail, so systemd is allowed
> to think that the array is ready - when it isn't.
>
> So change the pattern to allow for this but adding a wildcard at
> the end.
> Also don't allow for an empty string - reading array_state will
> never return an empty string - if it exists at all, it will be
> non-empty.
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  udev-md-raid-arrays.rules | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/udev-md-raid-arrays.rules b/udev-md-raid-arrays.rules
> index d3916651cf5c..c8fa8e89ef69 100644
> --- a/udev-md-raid-arrays.rules
> +++ b/udev-md-raid-arrays.rules
> @@ -14,7 +14,7 @@ ENV{DEVTYPE}=="partition", GOTO="md_ignore_state"
>  # never leave state 'inactive'
>  ATTR{md/metadata_version}=="external:[A-Za-z]*", ATTR{md/array_state}=="inactive", GOTO="md_ignore_state"
>  TEST!="md/array_state", ENV{SYSTEMD_READY}="0", GOTO="md_end"
> -ATTR{md/array_state}=="|clear|inactive", ENV{SYSTEMD_READY}="0", GOTO="md_end"
> +ATTR{md/array_state}=="clear*|inactive", ENV{SYSTEMD_READY}="0", GOTO="md_end"
>  LABEL="md_ignore_state"
>
>  IMPORT{program}="BINDIR/mdadm --detail --no-devices --export $devnode"
> --
> 2.14.0.rc0.dirty
>
