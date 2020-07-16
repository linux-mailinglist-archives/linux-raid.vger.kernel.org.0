Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E29221C66
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jul 2020 08:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgGPGKg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jul 2020 02:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgGPGKf (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 16 Jul 2020 02:10:35 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C758C20771
        for <linux-raid@vger.kernel.org>; Thu, 16 Jul 2020 06:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594879835;
        bh=MrDQ2RA4QjjM0ffcbON8sawuIVFeB9aSqb4Pz66upX0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wU8RoXBtTVV3jTDLh5AEnxnw34b5KkuCcYNdXlaSdVEv6znMWaZgPDbXWFwlMO+/W
         XMwB+7sSsNhvxZiBEh59E99WlYKoG22ZrI8CvYsQijUjs1Je5HscNYwn2f+65UYX50
         bttdXxSfrZcDQnA5xemwIkE4W1BBYS0WPs2+6M98=
Received: by mail-lf1-f48.google.com with SMTP id t9so2651587lfl.5
        for <linux-raid@vger.kernel.org>; Wed, 15 Jul 2020 23:10:34 -0700 (PDT)
X-Gm-Message-State: AOAM5304oxzpw+Jl9nihmh7Oj3Org5zh1XOKrc1PX7QM6GcgPa5EGowz
        JST4VNT7hDlue4YUA6ci6A5nSCdrNT2A3vnx8Ig=
X-Google-Smtp-Source: ABdhPJxjStTW9McEesvgdN80+bB7SH1u9KkCZl0nb5xDHe91O0i03Av67Aancir9/fPs96/dgBFuKvs4Mqy877O8fBA=
X-Received: by 2002:a19:ec12:: with SMTP id b18mr1308307lfa.52.1594879833121;
 Wed, 15 Jul 2020 23:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <a29f8374-cc64-cc87-71cb-507c43aff503@suse.com>
 <87zh80wa71.fsf@notabene.neil.brown.name> <149fa87e-2c77-ec44-af15-b0ffc996c3df@suse.com>
In-Reply-To: <149fa87e-2c77-ec44-af15-b0ffc996c3df@suse.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 15 Jul 2020 23:10:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5SYO5B-DifzwpFvrnhe8UFuJ0Ds5kwspj1zAA7B6XHQA@mail.gmail.com>
Message-ID: <CAPhsuW5SYO5B-DifzwpFvrnhe8UFuJ0Ds5kwspj1zAA7B6XHQA@mail.gmail.com>
Subject: Re: cluster-md mddev->in_sync & mddev->safemode_delay may have bug
To:     "heming.zhao@suse.com" <heming.zhao@suse.com>
Cc:     NeilBrown <neil@brown.name>,
        linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jul 15, 2020 at 10:53 PM heming.zhao@suse.com
<heming.zhao@suse.com> wrote:
>
> Hello Neil,
>
> Thank you for your comments, you gave me great help.
> I will file new patches according to your comments.

Thanks to Neil and Guoqing for these insightful inputs.

Hi Heming,

As Guoqing mentioned, I cover kernel part of the md work. For patches in
mdadm, please CC Jes Sorensen.

Thanks,
Song

[...]
