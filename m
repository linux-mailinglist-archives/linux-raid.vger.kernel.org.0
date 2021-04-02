Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB3352FDE
	for <lists+linux-raid@lfdr.de>; Fri,  2 Apr 2021 21:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhDBTlo (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 2 Apr 2021 15:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBTll (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 2 Apr 2021 15:41:41 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BF1C0613E6
        for <linux-raid@vger.kernel.org>; Fri,  2 Apr 2021 12:41:39 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id o16so6568182ljp.3
        for <linux-raid@vger.kernel.org>; Fri, 02 Apr 2021 12:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=etAu6Dt4WoL+s9XQ3AwjLJn4O0n+5wsRdmEpUf6cZNc=;
        b=R1KW6068sq3XCqUYnkB05oSVnd/nRSTXVTOK5+w7+FxXIExsYypl5eWWi0+jLDsczw
         7eKMakwwlEvwEOen5eafg1hU46IFFgNT28sR3Ou/EmhO9Yzj9UdodfOKwI+YLVbq0DIz
         hoTzSleOYiiIy16LMUL1J6tLG6/eQd5xGL2lv87tDeIwI2PGExLMbQkrkL+XDHnZeqKI
         ulRejLIuwkfSIJ04HWyH50ydAiyOzAV4PlCQcVKj2FKm/UeTKZX3AOCZHSatLIx3sulf
         UNy0s1DfE1HQmTfrSIV6c2X3kPMAkAUAFaJNEU21PpIj9jK4qSKXQL2f8C7caBGaKtb+
         XMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=etAu6Dt4WoL+s9XQ3AwjLJn4O0n+5wsRdmEpUf6cZNc=;
        b=Fg1XmDXvR1cKknv55wrMQh1E5tJmTJbYNY3T9aQZH5zHYGTVkDKkq2tVvtYSBFRz6X
         8xg2PhLGSHIMatiiQBbMQs7Z8womeFHXsgU9XnyOvMtw80I3/rNGctv8Bkyk8yVEhIYB
         W4zYZ673KaSG45b+sZLgcqUQ6DmeylF8A9cz3Me25DRBEwVS8Vp/kWuYnymcfS84tBgr
         SjY1Euyss/4duInUM6kUte6Tz/wZtsFJU3DDmq7QVvRHQco+VpwwxFaWnOUvMpkQ3V8+
         v9MzBDOSX6Us7dboos/MCYqc65LQ13GY2PJp7coTTDqy2KHuieW+BeyGsMnSBc/5qsO3
         4IxA==
X-Gm-Message-State: AOAM531zWyJwc0NOfB/LWW2oz3CJDxYjfZJ/Oxkuqb9nQmpiLXGLLM/N
        UxCJ2yc0E3WHuRL6bgHJdwC2qS0UeLc80Fp7N4zPzW3UMkY=
X-Google-Smtp-Source: ABdhPJykgAfodOqhg4GkoLQP+GLAzuxY4LAchq+6uKB2NsrDY5P5T5iS0RHwLZCDwCqfH76e3H8u6drnNJDJuPl2LrY=
X-Received: by 2002:a2e:2d02:: with SMTP id t2mr8879103ljt.488.1617392498165;
 Fri, 02 Apr 2021 12:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210328021210.GA1415@justpickone.org> <20210402004001.GH1711@justpickone.org>
 <62cc89ea-b9cf-d8a3-3d52-499fd84f7cc3@youngman.org.uk> <20210402050554.GF1415@justpickone.org>
In-Reply-To: <20210402050554.GF1415@justpickone.org>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Fri, 2 Apr 2021 14:41:26 -0500
Message-ID: <CAAMCDecNM8X9tdWo-WKpQA3BE=_J=XKc1D75rcQiQN0owZ9kJQ@mail.gmail.com>
Subject: Re: how do i bring this disk back into the fold?
To:     David T-G <davidtg-robot@justpickone.org>
Cc:     antlists <antlists@youngman.org.uk>,
        Linux RAID list <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The re-add will only work if the array has bitmaps.  For quick disk
hiccups the re-add is nice because instead of 9 hours, often it
finishes in only a few minutes assuming the disk has not been out of
the array for long.

On Fri, Apr 2, 2021 at 12:08 AM David T-G <davidtg-robot@justpickone.org> wrote:
>
> Wol, et al --
>
> ...and then antlists said...
> %
> % mdadm --re-add?
> [snip]
>
> Thanks!  Sure enough, --re-add didn't work, but --add happily got under
> way.  Only nine hours to go ... :-)
>
>
> Thanks again & HANW
>
> :-D
> --
> David T-G
> See http://justpickone.org/davidtg/email/
> See http://justpickone.org/davidtg/tofu.txt
>
