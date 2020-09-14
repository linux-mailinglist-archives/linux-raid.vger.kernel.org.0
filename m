Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D1B268200
	for <lists+linux-raid@lfdr.de>; Mon, 14 Sep 2020 02:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgINADn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 13 Sep 2020 20:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgINADm (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 13 Sep 2020 20:03:42 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C35AC06174A
        for <linux-raid@vger.kernel.org>; Sun, 13 Sep 2020 17:03:41 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c2so17050609ljj.12
        for <linux-raid@vger.kernel.org>; Sun, 13 Sep 2020 17:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJm9KjLMwyTPK4ICgujEEUJLcua0Lo6oTR6AltJtpXk=;
        b=TUff45u56W2dIX0uMZBpP9F8A6O77LVaLycutFJRU5bnTue2vCXXP53BY+etVjEqIW
         D23JtgUyK5w0TPuEZ/UWp5Wb7NOQuXHX7qS19zFaLUxFyyRILrSW3RUSkmir1Tacytfb
         jl2PPa6Pt5LDNgHedIljtbI9xaZ37cJSH49lzBBNjHHSx++z5OlThwOSDeV2xFR6aSht
         0azhMbJ9bKuLbzSMORd5feW26WpJsDNSzj041MI6sOcZ/osRUWX2wYbLpnKAnuonvOL6
         8qX1aNX6Y84lrzUeGv7/35PolkFASfhZKuQbipEuiUl/vkYAre+6ctErTWdc3YGtd3Rq
         jZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJm9KjLMwyTPK4ICgujEEUJLcua0Lo6oTR6AltJtpXk=;
        b=YIvhNifA0BkdE1BXv94MUOnyMmqJ9Mv3K8LHUxFKn719wDUrysXHdWkBBhn+t6pSeb
         lSmMk3ETFmVZ9G9JCMchAZzCmd8dkwdXvsSMmepHQk9GTnWpckCU7+HgcvRH+rZPO2O6
         DjK0wBAuD9rQzcNY4/XwgA0z/GURH787eV4wmn8Nb5SqPAjNwbEeN38NtTkgHmVCVgSZ
         hhZc2IVsIuX5mXDl58ihhytSz6Cxm/36curxeFab/CgUWuUaab5b6R0Zg2EaAdS4Xnu0
         sLmitKRFpuM/XeAOTnX1FVBcQ/c6AzTlaILKfVl0u660ZdR2WqDs7xHi4KdnSloVI2Ih
         IEbA==
X-Gm-Message-State: AOAM5304pZ5gHZhsp1b1AFkDBQaYLczL31hplbpYJktyyaVN0X5RDsP7
        F2COCMzswqGnfo/a2qaUJ2CE87cVUtGHyD8Bhi4=
X-Google-Smtp-Source: ABdhPJz2IFPgE4wfvaC4/A8xagsTSHNPANuW2TaBeS0Z5M+hw5DuPyIyhNStu1CwvKSvK/Q+HQwtqIIYacZ3haCbAlw=
X-Received: by 2002:a2e:8841:: with SMTP id z1mr4029964ljj.292.1600041816200;
 Sun, 13 Sep 2020 17:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <a5f14765-4da8-e965-beed-3d01ac496c61@suse.de>
In-Reply-To: <a5f14765-4da8-e965-beed-3d01ac496c61@suse.de>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Sun, 13 Sep 2020 19:03:24 -0500
Message-ID: <CAAMCDed81-NbMaqcBG3UV=7X7yp7jQ=rX9vs50_6jviTbiDk0Q@mail.gmail.com>
Subject: Re: unexpected 'mdadm -S' hang with I/O pressure testing
To:     Coly Li <colyli@suse.de>
Cc:     Linux RAID <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <songliubraving@fb.com>, xiao ni <xni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

You might want to see how high Dirty is in /proc/meminfo. That is how
much write io has to finish if fio runs a sync call, and it would also
apply to the stop since it should also call a sync.

On most oses the default is some percentage of your total ram and can
be quite high especially if the io rates are low.  ie if you had 1gb
of data and your write rate was 1MB/sec (random IO) then 1000 seconds.

If you test and this is the issue you should be able to from another
window watch dirty slowed go down.

I set mine low as I don't ever want there to be a significant amount
of writes outstanding.  I use these values (5MB and 3MB).

vm.dirty_background_bytes = 3000000
vm.dirty_background_ratio = 0
vm.dirty_bytes = 5000000
vm.dirty_ratio = 0
