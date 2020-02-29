Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B9117448E
	for <lists+linux-raid@lfdr.de>; Sat, 29 Feb 2020 03:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgB2Crt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 28 Feb 2020 21:47:49 -0500
Received: from mail-qv1-f41.google.com ([209.85.219.41]:38234 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB2Crt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 28 Feb 2020 21:47:49 -0500
Received: by mail-qv1-f41.google.com with SMTP id g16so2336504qvz.5
        for <linux-raid@vger.kernel.org>; Fri, 28 Feb 2020 18:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0SLPOQX5HZi6FET6fK62zviW5WeHhX7MlkvsF5K1aPc=;
        b=d1HjLsINb7yn0R6Dx+WEZ1BQO7IPiMxtuF6p/qFe0IBzS0UcWYa9h18mgJi1byMPX1
         5m+YOJwM8AmDCGBaZ6msY9CCIhXJ562Iaazqxg3dnHfpT80YsJssOLpY49CS5pjcjkx+
         b8Lt9jFvRRyRBvBvKWYXKMnT/p65ts1ReU5effUfeBB6GGXAA3wk2uckhWrX/K1MGn2W
         QWklcMNELkt2g6WbOLqwNilc3Mnett4LDaXb9Yl5obR7iVX+oLzJIJ6nSwqnRb2s7Bfv
         Scp152Q9CfC74sTBscc5apYAdCv2CWmRXHMoJnGOLhFoWroEVS1S4+ZHOm8upu6DzE+0
         T1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0SLPOQX5HZi6FET6fK62zviW5WeHhX7MlkvsF5K1aPc=;
        b=qHOv4c/eSNGwk8HO4s5uc40fkyuF/FIipC46Lh00v+d+f0ng0V3QdIlUciWF0M7vd5
         2TPDtd605+Q8fe/XhIkZOxvuV62x8VTuE5nyCPt7Dr5wkQsSBw9zsLmYzx5aUDVudY5m
         4bMpYq51D1B5aWZzBJRpmcgkr9I61RcJFVqqrfmWzLp+bbS8Gdr+xEPzdxAeQdgIEO+F
         5p4tk8WWy89Y96hVJdTG5aS1iQEVutbZN+s+T6f0r2D/qtWaxXfuMYal0Bux2zD9eFmt
         tVag6SDoqpaeu6PqEt+xpMVJ3+wP6PmrpQDKoTB0/17j6ROWcugKWG2CzUWzL/iFZY5N
         d6ww==
X-Gm-Message-State: APjAAAWNn7t/FRiOP6CGthM2L348rLw+wylBeYk6UKC8mKpz81CaTAWu
        lunxfmU9/sBj93OyxpWEVF/Ps74fE4E1afS0N9llQg==
X-Google-Smtp-Source: APXvYqzgURb/X7ketEmafLnYECkPmg0MKBDgxQ4451kFgU/ZpT6bgxi3fAsyHqrYLgRNX324+hfPEo+D4VGJu9MpxHw=
X-Received: by 2002:ad4:4aa2:: with SMTP id i2mr6521689qvx.4.1582944468035;
 Fri, 28 Feb 2020 18:47:48 -0800 (PST)
MIME-Version: 1.0
From:   Hans Malissa <hmalissa76@gmail.com>
Date:   Fri, 28 Feb 2020 19:47:37 -0700
Message-ID: <CAG6BYRzw4i6mtTfEVnMpwGAVW0r=BwODiN+0o-UggiaEyo4VSw@mail.gmail.com>
Subject: Choosing a SATA HD for RAID1
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I'm trying to select suitable SATA HD for RAID1 via mdadm. I've been
reading through
https://raid.wiki.kernel.org/index.php/Choosing_your_hardware,_and_what_is_a_device%3Fand
https://raid.wiki.kernel.org/index.php/Timeout_Mismatch but I'm still
confused. I understand that I can use smartctl in order to determine
whether a drive is suitable, but what can I do to figure this out
before I purchase the drives? I've looked at
https://raid.wiki.kernel.org/index.php/Drive_Data_Sheets but I'm not
sure which information I'm looking for.
My planned mdadm RAID1 should serve to accommodate the /home
directory, so I will not need to boot from the array, and the workload
is going to be moderate. I just need to keep the data in /home secure
- I'm doing regular backups anyway, but I want to make sure that the
/home directory remains useable at all times.
The drives will be used on an openSUSE 12.3 x86_64 system with kernel
version 3.7.10 and mdadm version 3.2.6 on an Intel Desktop Board
DH67BL with SATA 6.0 Gb/s or 3.0 Gb/s. I am aware that these are
somewhat dated, but I have some specialized hardware and software
installed, and I'm therefore hesitant to update the system with newer
versions of the OS.
I'm considering Western Digital WD Gold, either 2TB (WD2005FBYZ) or
4TB (WD4003FRYZ). It says 'Enterprise Class', but I cannot find a
definitive confirmation that the drive does not suffer from the TLER
or SCT/ERC issue. Is it known whether these drives are suitable for
mdadm RAID1? Are there drives that are more suitable for my
application?
Thanks a lot,

Hans
