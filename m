Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709A11D2208
	for <lists+linux-raid@lfdr.de>; Thu, 14 May 2020 00:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbgEMW1A (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 May 2020 18:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731135AbgEMW07 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 13 May 2020 18:26:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD11AC05BD09
        for <linux-raid@vger.kernel.org>; Wed, 13 May 2020 15:26:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a2so995793ejx.5
        for <linux-raid@vger.kernel.org>; Wed, 13 May 2020 15:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gtvWq/MeF/6oEmnw1qXQmZlv3KNk4h6BjoEUKhO/AI=;
        b=qnuaqcZyt8F/fu6JacXR348SsoSa3Tm7AzZNuvdyRoTov1keyBvQu8pXUwf75HxiOf
         Kp75KOKoGDVG9AVOlHoBHnEOZ+aGnlYmnNxamZckzNM5gr/kauOLnvq8RbJVSj57g1cw
         9NN4htlh7EN6fcqVbepwUivXJDqDlyuHYUdtHPY21wxmzjXy/ZgI5w7jQM2uM22NfFtA
         q8lS8JkKuJziplyt33amkKJeLTRetS+ezNJTjHtj9SEkChz+0OHqn2TMVceqrJ2eD/4/
         0tsEvnEt2hykkPAkDhJ48WHxBHzBhAZBdTwTt86tywE0BQeuxSyyhNQdkXE9MGPz7xQ5
         Snkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gtvWq/MeF/6oEmnw1qXQmZlv3KNk4h6BjoEUKhO/AI=;
        b=j+3ltB7/JOkmWbQk2S+e9nxP5LtfZuqr6mOP/LXGumKiOpR7B87F4TglP3LiyFlUHB
         VbbMbBL0dAbbNwQKjq+Uwj6j86o1vyFXXamJKSJJ5suoA4x88wbgVk4tlLCMQupriyuL
         GAsNnz+nib8cs1r7/1UbodATcfH3MiBoYWu0UvHDicqgGwS9/Ysu9r2wQ0PDvRfITxrk
         tZpL7fEYfthgFBPL49fWR7zHMOt0PTL1g47vICBHBzJg0WYLLDOkOk3uYFTX5HOwf+Nm
         matfy/h3JkBuKxah9qXtFMtOCs/gzrE0UHuDa48lKyTJBY0TfRE8bWy56vmPCB8h1gie
         /NHw==
X-Gm-Message-State: AOAM531kdFVmyFTkXvWAZuFO43k0G+IvT+zHZPZaFpOjjml++LvttS2r
        /lSjx2aNZsqGBsxOf0SSLpFcC8+x+4dnnxAHxTuuAA==
X-Google-Smtp-Source: ABdhPJz1YkZyiu1OaSAVXpO2AAQnxlh/qNnka1A5+jaiVwuM2r/ADoB+8k1+qusteX+AGprilg7rK2SWSnm96LhSDK4=
X-Received: by 2002:a17:906:1f8b:: with SMTP id t11mr1180169ejr.201.1589408817417;
 Wed, 13 May 2020 15:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200508161517.252308-1-hch@lst.de> <CAPcyv4j3gVqrZWCCc2Q-6JizGAQXW0b+R1BcvWCZOvzaukGLQg@mail.gmail.com>
 <20200509082352.GB21834@lst.de> <CAPcyv4ggb7_rwzGbhHNXSHd+jjSpZC=+DMEztY6Cu8Bc=ZNzag@mail.gmail.com>
 <20200512080820.GA2336@lst.de>
In-Reply-To: <20200512080820.GA2336@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 May 2020 15:26:45 -0700
Message-ID: <CAPcyv4iWB=ZMmpc1aWfpJabSbCdvB28dCeSp_xj7AZMfbF_rjg@mail.gmail.com>
Subject: Re: remove a few uses of ->queuedata
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jim Paris <jim@jtan.com>,
        Geoff Levand <geoff@infradead.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-m68k@lists.linux-m68k.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-bcache@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, May 12, 2020 at 1:08 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sat, May 09, 2020 at 08:07:14AM -0700, Dan Williams wrote:
> > > which are all used in the I/O submission path (generic_make_request /
> > > generic_make_request_checks).  This is mostly a prep cleanup patch to
> > > also remove the pointless queue argument from ->make_request - then
> > > ->queue is an extra dereference and extra churn.
> >
> > Ah ok. If the changelogs had been filled in with something like "In
> > preparation for removing @q from make_request_fn, stop using
> > ->queuedata", I probably wouldn't have looked twice.
> >
> > For the nvdimm/ driver updates you can add:
> >
> >     Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> >
> > ...or just let me know if you want me to pick those up through the nvdimm tree.
>
> I'd love you to pick them up through the nvdimm tree.  Do you want
> to fix up the commit message yourself?

Will do, thanks.
