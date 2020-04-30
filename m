Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B185F1BF0DB
	for <lists+linux-raid@lfdr.de>; Thu, 30 Apr 2020 09:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgD3HKm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 Apr 2020 03:10:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgD3HKm (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 30 Apr 2020 03:10:42 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C4D32186A
        for <linux-raid@vger.kernel.org>; Thu, 30 Apr 2020 07:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588230641;
        bh=WFvfXW6GdSUi1su6OZwdmWtQAhm+wfVf7mw6HPZCZ1M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ShhL16rpFGjRLjCb0y+MVzXrkzn5G7GgKZ9/2+iBERCp0Duol01XifVOsBbEnXq5T
         ql6g0KyTbBKDEOeDuX9dc4N7AjQFx+QhGfpqnUEBqjD6SptYxTB3JGBFgvwzmm5XjM
         153jh4X9dzElTgDmV4JCTeinlFeYrmXULp36/oiA=
Received: by mail-lf1-f41.google.com with SMTP id 188so311569lfa.10
        for <linux-raid@vger.kernel.org>; Thu, 30 Apr 2020 00:10:41 -0700 (PDT)
X-Gm-Message-State: AGi0PuZH74QIonIFslOR3kQ6+whNckcZLPJ8kMvgiM1lLzablgjLJwXk
        sQXEK52k20vWvS4+2+anhKUOPjYaKGy5/ewqwB8=
X-Google-Smtp-Source: APiQypJ19P0cHmC3AfWbYYEiJd3Ti22aioKB20z3YFRD3Z4jdDUZQ5HKJs7FsS+1J4HdLBGYSjdG9+kK/bW9hXrLp18=
X-Received: by 2002:ac2:4836:: with SMTP id 22mr1157699lft.52.1588230639308;
 Thu, 30 Apr 2020 00:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <6a7c0aba219642de8b3f1cc680d53d85@AM0P193MB0754.EURP193.PROD.OUTLOOK.COM>
 <CAKm37QWKVcPkF0fXKk2499CsYXfU3aMuMWgwa8Nk9HFzVxG7CA@mail.gmail.com>
In-Reply-To: <CAKm37QWKVcPkF0fXKk2499CsYXfU3aMuMWgwa8Nk9HFzVxG7CA@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 30 Apr 2020 00:10:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7e-xMNbk5ZJw2XQ3KSnnPiN5gwwR4hdMMhyjjVNRnfkQ@mail.gmail.com>
Message-ID: <CAPhsuW7e-xMNbk5ZJw2XQ3KSnnPiN5gwwR4hdMMhyjjVNRnfkQ@mail.gmail.com>
Subject: Re: Fw: some questions about uploading a Linux kernel driver
To:     Xiaosong Ma <xma@qf.org.qa>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        =?UTF-8?B?5aec5aSp5rSL?= <ty-jiang18@mails.tsinghua.edu.cn>,
        Guangyan Zhang <gyzh@tsinghua.edu.cn>,
        wei-jy19@mails.tsinghua.edu.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Xiaosong,

On Wed, Apr 22, 2020 at 5:26 AM Xiaosong Ma <xma@qf.org.qa> wrote:
>
> Dear Song,
>
> This is Xiaosong Ma from Qatar Computing Research Institute. I am
> writing to follow up with the questions posed by a co-author from
> Tsinghua U, regarding upstreaming our alternative md implementation
> that is designed to significantly reduce SSD RAID latency (both median
> and tail) for large SSD pools (such as 20-disk or more).
>
> We read the Linux kernel upstreaming instructions, and believe that
> our implementation has excellent separability from the current code
> base (as a plug-and-play module with identical interfaces as md).

Plug-and-play is not the key for upstream new code/module. There are
some other keys to consider:

1. Why do we need it? (better performance is a good reason here).
2. What's the impact on existing users?
3. Can we improve existing code to achieve the same benefit?

> Meanwhile, we wonder whether there are standard test cases or
> preferred applications that we should test our system with, before
> doing code cleaning up. Your guidance is much appreciated.

For testing, "mdadm test" is a good starting point (if it works here).
We also need data integrity tests and stress tests.

Thanks,
Song
