Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2A62F9187
	for <lists+linux-raid@lfdr.de>; Sun, 17 Jan 2021 10:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbhAQJPX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 17 Jan 2021 04:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbhAQJPH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 17 Jan 2021 04:15:07 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7BEC061573
        for <linux-raid@vger.kernel.org>; Sun, 17 Jan 2021 01:14:08 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l12so8308533wry.2
        for <linux-raid@vger.kernel.org>; Sun, 17 Jan 2021 01:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEnhPu/Q/IuQW35RG7DlW7oj6UxvuBAdb4yr/buxqKI=;
        b=o6Nz/wuVhN0cGqE+ishv7UGx3DR8u2vyqjd8qqGHTxPi228/6x6GKCt4yfCeXfech5
         cJzsmMAgG4ESkqGOZjsqJ8VNCK83slUHGvjJ0z9i0FyjlbZygW8Vmghl6TRHtrhKq5Qm
         9VJcj6/375ww1gRmjnjLgPxM4kRvzQu2OeGam1qXRMDyp2PzZtG0s1Z7Ydu8F+OtfaBH
         OI4vAIQ5vVf8B7c9rh+jfyDI/IAERKqNXEmMiEj2NJeaak/Gyb/tpRMPhu4eBwJp+N+0
         MPRjMPQyx1WvNriXFm+7JkDcx95UVYuwlZYY6Mc4apcjUG6/FQTfaJ099psq1kdSDCMy
         Oe1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEnhPu/Q/IuQW35RG7DlW7oj6UxvuBAdb4yr/buxqKI=;
        b=eVlPNkHzT6ujyHppMXdWuk9IJ4rkLcTY7Ijb127fS8+RnwRX870OXx7Io/8DykWnM6
         xr5FIV1GcPNnwRPXLw3V9V8RM96+1xT+dWsktM3tEzVrZ2obGEvLVNchFvIQuHgQfDJ5
         jZ1vN9g4EFLzKdyfGPqRip1HaU5hkjOWjl1TpBAKk4GEhH/QSksMt5Dac4Ta/FlkeTiZ
         8/75sroYvC4BgqLnUeLt2jril0Iky1WOrde/aJWpsChiUysle1qcl6Twv4w3Np9U1e+B
         MweHHtEVdcgk8vY+Xg2imwb99+5H1e1b2HWUoPnyewQeOeLeHgCZKjQC+iSZsSaCCUjw
         6VGw==
X-Gm-Message-State: AOAM530bRquwO7RubedQK8PZw8Y6B46GFl2Q9At0e5Rfi8wmgq2tqg8d
        BGTwxmcrq44mmGFfkyay16G3t4ngSQjzcSO/rD3l5u+H
X-Google-Smtp-Source: ABdhPJzfqgcvZJb3lTQvpDyBn9WKEz1Pt7jItpmbylC2DvB4zXoEqeItxZvqjI9Gbz0UznGP41KY+K+/IM6V0BvsaGI=
X-Received: by 2002:a05:6000:1811:: with SMTP id m17mr20562963wrh.67.1610874846934;
 Sun, 17 Jan 2021 01:14:06 -0800 (PST)
MIME-Version: 1.0
References: <CAM7EtNjpS3yr=3XtGkgfc3=L=fSfqJW7P8mSZ__+L7fwjLu8eA@mail.gmail.com>
 <24576.47848.628487.833800@quad.stoffel.home> <CAPhsuW53Y84PVBgM1q_S8phVKHq00gbxZH0O40BNgNo+qka6mQ@mail.gmail.com>
In-Reply-To: <CAPhsuW53Y84PVBgM1q_S8phVKHq00gbxZH0O40BNgNo+qka6mQ@mail.gmail.com>
From:   Marcus Lell <marcus.lell@gmail.com>
Date:   Sun, 17 Jan 2021 10:13:59 +0100
Message-ID: <CAM7EtNhBv8ahiK0GnL0cL7XTDWJFFuMZkmMjYQ7AJSD_FeYyXA@mail.gmail.com>
Subject: Re: raid5 size reduced after system reinstall, how to fix?
To:     Song Liu <song@kernel.org>
Cc:     John Stoffel <john@stoffel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Song,

On Fri, Jan 15, 2021 at 8:58 AM Song Liu <song@kernel.org> wrote:
>
> Are you running kernel 5.10? If so, please upgrade to 5.10.1 or later.
> There was an
> bug in 5.10 kernel. After upgrading the kernel, the mdadm --grow command above
> should fix this. The --grow will trigger a resync for the newly grown
> area. If the array
> was not in degraded mode, the resync should not change any data.
I was indeed running 5.10.0 a few times.
Upgraded and running "mdadm --grow --size=max /dev/md0" fixed it completely.

>
> Please let me know if this works.
Yes.

Thank you.

marcus
