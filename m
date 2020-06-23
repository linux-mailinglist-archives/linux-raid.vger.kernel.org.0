Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2287E20474C
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jun 2020 04:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbgFWCcT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 22 Jun 2020 22:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbgFWCcT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 22 Jun 2020 22:32:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80715C061573
        for <linux-raid@vger.kernel.org>; Mon, 22 Jun 2020 19:32:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y6so15200363edi.3
        for <linux-raid@vger.kernel.org>; Mon, 22 Jun 2020 19:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wfIsUtsVfwZhsBIX4/Zg6mFSFdzW+dbrwLq9/GBV5ao=;
        b=GA0+6wKju6HUK41NWRU9Y9pWO3zPWg9mEK1vgXDG9AXKx/Vg/DsWaeb/jWQegudzSi
         QZXD5Yf9rQ2HZkOEdTWTo8MwUmvwuIbbddSNq897FCayH7e7pTZNSi/TSlgVfRBKut0/
         mYcWIG6Egt7JYCObzBaM31VDo/jwmoRR6tyXvirQfe3yUukKbmbOqfowxKzcz3Sl7QEi
         9n8p6BzlPPVL3XMDRgSZB7C7E0w1wXYV438zcODkVbq/duHnXdxbYMr0+XkTsY9GImnn
         iRAbe8YKAdTgeerRKOaGIjuUXS4pBLZiKU6JjNUCkxV1tpyZ0U6t8SpQnjbQdOEcWvaz
         v50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfIsUtsVfwZhsBIX4/Zg6mFSFdzW+dbrwLq9/GBV5ao=;
        b=joo+Df7nUSdD/UP7HrhGJoB7zmY0OGUaLAQLqZsVDE3DsuCaJCcFrK83cQbDUQ71hu
         9ly8SKLzaSSXzKFEywttXLY/Xa7QtHLtnkTh8f5vK1rjNX6GzzpYEm228iSIAEeGH3sn
         X/Vy8WZHuF0KKM/GPkGSff7UiUOYN4A0XYXj1CIKoxgn2UzHQnd5GT7CBARmI/r46ivK
         wMtsjdalz52P9paCgwODlj/OU3ZIr7HuvCQoqqUxq0TqzgiHW51zmAk2MWcsJQgG6bt5
         fKWZv6okSGEV76LWEJUnbGymBcsGSoSKOzn4YNa/IyHJb9tX56sRrYRTdm8s73kEuLPF
         sviQ==
X-Gm-Message-State: AOAM530VeAwhViHpf4b+Wf6IX0LhC9lvOCBeI2NX/qFGnlEyGWCkABbI
        Q/YDp4nJYvrME8TeFJTxlqr+iudVEb4wK9jE5Bc=
X-Google-Smtp-Source: ABdhPJysP1V7ExwpgzB0UzOrd9gmWtH+QsE+ld2rVwpRa7Rai8viTFjQb8BfWU7hXqEb6s6Lsvu/RNSPYLFAN2xPquM=
X-Received: by 2002:aa7:c15a:: with SMTP id r26mr19126722edp.21.1592879536154;
 Mon, 22 Jun 2020 19:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <rco1i8$1l34$1@ciao.gmane.io> <24305.24232.459249.386799@quad.stoffel.home>
In-Reply-To: <24305.24232.459249.386799@quad.stoffel.home>
From:   o1bigtenor <o1bigtenor@gmail.com>
Date:   Mon, 22 Jun 2020 21:31:40 -0500
Message-ID: <CAPpdf5-RWyGX4Q9qaZBDfxUXedf+MnV3wnXh6R3XSF7-LomKzQ@mail.gmail.com>
Subject: Re: RAID types & chunks sizes for new NAS drives
To:     John Stoffel <john@stoffel.org>
Cc:     Ian Pilcher <arequipeno@gmail.com>,
        Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jun 22, 2020 at 9:06 PM John Stoffel <john@stoffel.org> wrote:
>
snip

> In any case, make sure you get NAS rated disks, either the newest WD
> RED+ (or is it Blue?)  In any case, make sure to NOT get the SMR
> (Shingled Magnetic Recording) format drives.  See previous threads in
> this group, as well as the arstechnica.com discussion about it all
> that they disk last month.  Very informative.
>
> Personally, with regular hard disks, I still kinda think 4gb is the
> sweet spot, since you can just mirror pairs of the disks and then
> stripe across on top as needed.  I like my storage simple, because
> when (not if!) it all hits the fan, simple is easier to recover from.
>
Did you mean 4 TB or 4 GB as you wrote?
(Somewhat of a difference I do believe.)

Regards
