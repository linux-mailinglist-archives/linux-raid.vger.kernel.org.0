Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 244491A2F1C
	for <lists+linux-raid@lfdr.de>; Thu,  9 Apr 2020 08:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgDIGWw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Apr 2020 02:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgDIGWw (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 9 Apr 2020 02:22:52 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1793F2075E
        for <linux-raid@vger.kernel.org>; Thu,  9 Apr 2020 06:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586413372;
        bh=mqm1kNzx6uUdv/UZlc6mwCpXT+gXKnhzjiy+49X+lr0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QBDQSoIRq4wCblLx3wOJgQvXZjH3jGhUkLDs3iW9Ron0h4RfoZg/+e5l2TmijdI16
         m0c09BHTMjkTYXjdL/cIS6ansOi2U90TUUGCECY8yjcubjbE6ADFjlVSCjqImkWVLl
         dz+fuspwssIjY0oNnrw3hici0PIgma1RASpNCDvs=
Received: by mail-lj1-f177.google.com with SMTP id m8so2005714lji.1
        for <linux-raid@vger.kernel.org>; Wed, 08 Apr 2020 23:22:52 -0700 (PDT)
X-Gm-Message-State: AGi0PubR09byVvkzmGq1MUeUJ6qVzGuPq60OaAIX8yFVk/ocCvgyPiTR
        vWtnKEGxt+zTz2KyH4UIOot5Bc/hAXZMWO/Sdio=
X-Google-Smtp-Source: APiQypJJP+FfvvSs6+26LwN5Gdg6T2p5gybV6GoQdmLzNDcn2C4+FcSInVnH5x5nwYskexalb+rIu6sDBi8k+WtjrgY=
X-Received: by 2002:a2e:97c2:: with SMTP id m2mr7061897ljj.228.1586413370222;
 Wed, 08 Apr 2020 23:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <57f88946.237df.17159c91b12.Coremail.ty-jiang18@mails.tsinghua.edu.cn>
In-Reply-To: <57f88946.237df.17159c91b12.Coremail.ty-jiang18@mails.tsinghua.edu.cn>
From:   Song Liu <song@kernel.org>
Date:   Wed, 8 Apr 2020 23:22:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW46BnFeVtnoRX9eqYL+RRfioaQYQ6q=v4W48FPA7bGVtQ@mail.gmail.com>
Message-ID: <CAPhsuW46BnFeVtnoRX9eqYL+RRfioaQYQ6q=v4W48FPA7bGVtQ@mail.gmail.com>
Subject: Re: some questions about uploading a Linux kernel driver
To:     =?UTF-8?B?5aec5aSp5rSL?= <ty-jiang18@mails.tsinghua.edu.cn>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Apr 8, 2020 at 5:41 AM =E5=A7=9C=E5=A4=A9=E6=B4=8B <ty-jiang18@mail=
s.tsinghua.edu.cn> wrote:
>
> Hello
> I am Tianyang JIANG, a PhD student from Tsinghua U. We finish a study whi=
ch focuses on achieving consistent low latency for SSD arrays, especially t=
iming tail latency in RAID level. We implement a Linux kernel driver called=
 FusionRAID and we are interested in uploading codes to Linux upstream.
> I notice that I should seperate my changes and style-check my codes befor=
e submitting. Are there any other issues I need to be aware of? Thank you f=
or your time.

Hi,

Welcome to kernel development (I assume you are new here).

Please refer to https://kernelnewbies.org/ for information about
kernel development. Basically,
we take changes in patches. So please follow the directions on this
website. Once you are
familiar with the basic work flow, you can think about how to
integrate your work into the kernel.
If you can share some details (code, paper) about the work, the
community may give you
some hint on which direction to go.

I don't want to discourage you, but it is helpful to set the
expectation. This sounds like a lot of
work. And it is possible that we decide not to include it in upstream
kernel. However, I am sure
you can learn a lot from doing these work. :)

I hope this helps.

Thanks,
Song
