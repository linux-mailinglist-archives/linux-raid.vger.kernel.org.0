Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4968F131B73
	for <lists+linux-raid@lfdr.de>; Mon,  6 Jan 2020 23:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgAFWaH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Jan 2020 17:30:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38182 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgAFWaH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 Jan 2020 17:30:07 -0500
Received: by mail-pg1-f195.google.com with SMTP id a33so27504531pgm.5
        for <linux-raid@vger.kernel.org>; Mon, 06 Jan 2020 14:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9f+RBzW/H0VB//QgCSu1z2IQAotWrzBNPWKJtU8Tq4k=;
        b=mHLOgnhUoynwqWNL6XHz7hESUdR1nx5xriZFQk8gV0zWTrNPh49NDh7Cr6juSYHd+V
         1pgrEobR4R8PnGR1e6irHwHaHxLhwHDbbJHDVLMEsYVVWBNn/aX700nJ1fTWrYPSz273
         FN+wMY0xsIG9xZlRq0r1crnHsw5ZeH65v50uorERd5Vnx7EKZq7UuqxWyescRrG/hYCs
         ktqp6oaJmirFl4gyxXkeejkHo2+qAFspnWSqBPGQgwrFG4bRxT/kQUjtWNkCTuK+oJdY
         iTUZEZ6v21yfhJCEnVM24oXGG8Ep56zFwPeIyrWV8cg0fSbPrvsnyTrHNdK+d/iXivQz
         0IiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9f+RBzW/H0VB//QgCSu1z2IQAotWrzBNPWKJtU8Tq4k=;
        b=smFn1B7yku7LOyOWvth5sdNGC5EWRiKu2XCvFhCrfJUB1Bnl6cBbQKghmoSqw9jdSM
         nUXc/mGy8gqxVjkVyQDRgQaENegRGwIxaqXSCOYcZLyayFa/ixTf5jvu9EJtRgEFLrDY
         rvN5OKt38ti3hcHvKqiNszxokGx2V7+2OjYIy0QSEBJhdLAU+vY+y+FBcTuGb0Pmf0EV
         bkb199BQ+xFhsiXPhalOqNruGwSWuY+Qvb5CAxMlQHpLqYJAohR+Ix2acnUk9QCpjs41
         vSk9gSHd6HeCK25x2r310seQrPYf7Rxyyai03ayqYNwknvwEH8CAH4jvdeNtxEPYodrL
         P6Rw==
X-Gm-Message-State: APjAAAUdTyfvQleMD2xFyUNygcsreBEcDn84RRXn/7vJ83wyQLDRg+4x
        XGSda8JJ2zKr28gUUeHEpvUDCBT9RXb+hK/qMx0kVw==
X-Google-Smtp-Source: APXvYqyzQbJREFl0O3Lx7OTLSPICTLApUVnc+rgl5Ze+oqK8zogwE7oZEQ4rb2kZ9pcndxmUHuR0Ut7vHA5rOmEwHdI=
X-Received: by 2002:a63:d249:: with SMTP id t9mr115853480pgi.263.1578349805868;
 Mon, 06 Jan 2020 14:30:05 -0800 (PST)
MIME-Version: 1.0
References: <202001050333.SnzanhNo%lkp@intel.com>
In-Reply-To: <202001050333.SnzanhNo%lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 6 Jan 2020 14:29:54 -0800
Message-ID: <CAKwvOdmkhS+jmu9erpnqr6+bvxjQD7yxQSvs3scokJ42tkF4mg@mail.gmail.com>
Subject: Re: [PATCH RESEND] raid5: add more checks before add sh->lru to plug
 cb list
To:     jgq516@gmail.com
Cc:     kbuild@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild-all@lists.01.org, kbuild test robot <lkp@intel.com>,
        liu.song.a23@gmail.com, linux-raid@vger.kernel.org,
        guoqing.jiang@cloud.ionos.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Apologies if it was already reported (working backwards through emails
missed during the holidays), but this warning looks legit. Can you
please take a look?

On Sat, Jan 4, 2020 at 11:48 AM kbuild test robot <lkp@intel.com> wrote:
>
> CC: kbuild-all@lists.01.org
> In-Reply-To: <20200103135628.3185-1-guoqing.jiang@cloud.ionos.com>
> References: <20200103135628.3185-1-guoqing.jiang@cloud.ionos.com>
> TO: jgq516@gmail.com
> CC: liu.song.a23@gmail.com, linux-raid@vger.kernel.org, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, linux-raid@vger.kernel.org, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> CC: linux-raid@vger.kernel.org, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> Hi,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.5-rc4 next-20191220]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/jgq516-gmail-com/raid5-add-more-checks-before-add-sh-lru-to-plug-cb-list/20200104-172752
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3a562aee727a7bfbb3a37b1aa934118397dad701
> config: x86_64-allyesconfig (attached as .config)
> compiler: clang version 10.0.0 (git://gitmirror/llvm_project 320b43c39f0eb636c84815ce463893b21befdc8f)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers//md/raid5.c:5484:6: warning: logical not is only applied to the left hand side of this comparison [-Wlogical-not-parentheses]
>            if (!atomic_read(&sh->count) == 0 &&
>                ^                        ~~
>    drivers//md/raid5.c:5484:6: note: add parentheses after the '!' to evaluate the comparison first
>            if (!atomic_read(&sh->count) == 0 &&
>                ^
>                 (                           )
>    drivers//md/raid5.c:5484:6: note: add parentheses around left hand side expression to silence this warning
>            if (!atomic_read(&sh->count) == 0 &&
>                ^
>                (                       )
>    1 warning generated.
>
> vim +5484 drivers//md/raid5.c
>
>   5461
>   5462  static void release_stripe_plug(struct mddev *mddev,
>   5463                                  struct stripe_head *sh)
>   5464  {
>   5465          struct blk_plug_cb *blk_cb = blk_check_plugged(
>   5466                  raid5_unplug, mddev,
>   5467                  sizeof(struct raid5_plug_cb));
>   5468          struct raid5_plug_cb *cb;
>   5469
>   5470          if (!blk_cb) {
>   5471                  raid5_release_stripe(sh);
>   5472                  return;
>   5473          }
>   5474
>   5475          cb = container_of(blk_cb, struct raid5_plug_cb, cb);
>   5476
>   5477          if (cb->list.next == NULL) {
>   5478                  int i;
>   5479                  INIT_LIST_HEAD(&cb->list);
>   5480                  for (i = 0; i < NR_STRIPE_HASH_LOCKS; i++)
>   5481                          INIT_LIST_HEAD(cb->temp_inactive_list + i);
>   5482          }
>   5483
> > 5484          if (!atomic_read(&sh->count) == 0 &&
>   5485              !test_bit(STRIPE_ON_RELEASE_LIST, &sh->state) &&
>   5486              !test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
>   5487                  list_add_tail(&sh->lru, &cb->list);
>   5488          else
>   5489                  raid5_release_stripe(sh);
>   5490  }
>   5491
>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/202001050333.SnzanhNo%25lkp%40intel.com.



-- 
Thanks,
~Nick Desaulniers
