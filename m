Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8E51CC051
	for <lists+linux-raid@lfdr.de>; Sat,  9 May 2020 12:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgEIKZP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Sat, 9 May 2020 06:25:15 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:44313 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgEIKZO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 9 May 2020 06:25:14 -0400
Received: by mail-ej1-f43.google.com with SMTP id b20so3472550ejg.11
        for <linux-raid@vger.kernel.org>; Sat, 09 May 2020 03:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/fNnHL82veG7y5sqmVXBK2HhG96owXsiq2clauk9hBA=;
        b=sEXhnvP8/zSb3bqSe//FjcBLloupEZpJk3aL0VXuIkUAYKWZjkWx3LEUmsOPU+AW6x
         JtGlOZ4TFq8qpm/dFBL11DUJK+Ev7zpNvp2bUkJooHo+Kc8HL+HmyfLz1XE086nlqgsP
         tiZbKk+/Fd0XO+Y/seNHbVw3cLqJMuY7hClGj/Ax8Zv/37dK30eU0UXfkdAWzAQTB0N4
         yPhmyI1D4ppunG+IwvVtdkKXaHXdc0FvsOI4yxDZAx6rlYAa8P1zXoFYuSEYtJGMN62r
         i6+zvuWV8RzGvfRocXV5yrVillF0zTIWmGuoNGUqSBD6+Qsyt8t8i7kJQBj+lVsJgLlL
         Q84g==
X-Gm-Message-State: AGi0PuaNsbr4DksDcTMKpe0UxWvGMFbAdDvcFLAkqDHZfxhBgh6LiuqR
        rEP0ttPNJazFKYE+kV5viEjKZD3gVo9IKt5WQhE=
X-Google-Smtp-Source: APiQypIDf9RlGaNPjeFjiEVedm/kPjcCXJDkjbVZfjOBDeR3ZIEqdHg3tdFBu9opq71tkOOcewEG3MOMXwmBd3blQ+c=
X-Received: by 2002:a17:906:359b:: with SMTP id o27mr5629712ejb.282.1589019912426;
 Sat, 09 May 2020 03:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <6a7c0aba219642de8b3f1cc680d53d85@AM0P193MB0754.EURP193.PROD.OUTLOOK.COM>
 <CAKm37QWKVcPkF0fXKk2499CsYXfU3aMuMWgwa8Nk9HFzVxG7CA@mail.gmail.com> <1b9dc66b2afd49d1bc260691e62858fc@AM0P193MB0754.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <1b9dc66b2afd49d1bc260691e62858fc@AM0P193MB0754.EURP193.PROD.OUTLOOK.COM>
From:   Xiaosong Ma <xma@qf.org.qa>
Date:   Sat, 9 May 2020 13:25:01 +0300
Message-ID: <CAKm37QUUGao4Bv2GiTYcd+cE-5uXvciyPNFHo6nwFCQ-myHL2A@mail.gmail.com>
Subject: Re: Fw: some questions about uploading a Linux kernel driver
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        =?UTF-8?B?5aec5aSp5rSL?= <ty-jiang18@mails.tsinghua.edu.cn>,
        Guangyan Zhang <gyzh@tsinghua.edu.cn>,
        "wei-jy19@mails.tsinghua.edu.cn" <wei-jy19@mails.tsinghua.edu.cn>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Song, Paul, and other Linux-RAID kernel management members,

Thank you so much for your detailed reply and we apologize for our
delayed response. We faced uncertainty in school reopening in China,
as till this day the Tsinghua campus is not open, making full testing
and debugging hard (which requires physical access to our testbed).
Meanwhile, we can make plans to clean up the code and set up the mdadm
test as Song suggested.

Yes, the major advantage our module offers is performance, targeting
larger all-flash arrays increasingly common today. Its main source of
improvement comes from shortened/simpler write path, real-time
light-weight SSD performance spike detection, and RAID declustering.
As a result, it improves median write latency by up to several times,
and tail latency by nearly 400 times compared to existing RAID5 with
md, on multiple storage traces and YCSB running on RocksDB. The
declustering part of our work can be found in our FAST 2018 paper:
https://www.usenix.org/node/210543.

As to the other questions:
(2)  What's the impact on existing users? and (3) Can we improve
existing code to achieve the same benefit?
Their answers are related. As our module is targeting larger RAID
pools, such as SSD enclosures of 20 or more drives, to modify existing
md would not deliver benefits to small array users (for sizes like 7+1
RAID5). The code base is close to 5000 lines in C and we believe it
would work better as an alternative module which can be used by larger
arrays. Its internal workings are entirely transparent, with no new
user interfaces.

If the university opens by the end of May, we will target mid-late
June to finish basic testing and cleaning, and then release our code
for your review by a private github repo. Is that acceptable?

Best regards,

Xiaosong, Tianyang, Guangyan, and Junyu

Dr. Xiaosong Ma
Principal Scientist
Distributed Systems

Qatar Computing Research Institute
Hamad Bin Khalifa University
HBKU – Research Complex
P.O. Box 5825
Doha, Qatar
Tel: +974 4454 6190
www.qcri.qa
<http://www.qcri.qa>

On Thu, Apr 30, 2020 at 10:10 AM Song Liu <song@kernel.org> wrote:
>
> Hi Xiaosong,
>
> On Wed, Apr 22, 2020 at 5:26 AM Xiaosong Ma <xma@qf.org.qa> wrote:
> >
> > Dear Song,
> >
> > This is Xiaosong Ma from Qatar Computing Research Institute. I am
> > writing to follow up with the questions posed by a co-author from
> > Tsinghua U, regarding upstreaming our alternative md implementation
> > that is designed to significantly reduce SSD RAID latency (both median
> > and tail) for large SSD pools (such as 20-disk or more).
> >
> > We read the Linux kernel upstreaming instructions, and believe that
> > our implementation has excellent separability from the current code
> > base (as a plug-and-play module with identical interfaces as md).
>
> Plug-and-play is not the key for upstream new code/module. There are
> some other keys to consider:
>
> 1. Why do we need it? (better performance is a good reason here).
> 2. What's the impact on existing users?
> 3. Can we improve existing code to achieve the same benefit?
>
> > Meanwhile, we wonder whether there are standard test cases or
> > preferred applications that we should test our system with, before
> > doing code cleaning up. Your guidance is much appreciated.
>
> For testing, "mdadm test" is a good starting point (if it works here).
> We also need data integrity tests and stress tests.
>
> Thanks,
> Song
