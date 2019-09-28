Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8829C1243
	for <lists+linux-raid@lfdr.de>; Sat, 28 Sep 2019 23:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfI1VqS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 28 Sep 2019 17:46:18 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:50306 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbfI1VqR (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 28 Sep 2019 17:46:17 -0400
Received: by mail-wm1-f46.google.com with SMTP id 5so9400265wmg.0
        for <linux-raid@vger.kernel.org>; Sat, 28 Sep 2019 14:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QZkeOx+aNFTprjPlGSIFp/kR1sp2qaO3UGAVXMLzdTY=;
        b=tfUab4KCM9HSIjjYJNv5JwVZCBf4mG+jFbg859S2hPUcCMu3Wfvsp2sFhXkBCyyXwQ
         TOLtF7+bmKXWpDj8XLTkSgL/3kHAch3Ocha5RMu+2J9Ao7ANth5g1QH6Xlfp2TuUNCdC
         ybeLnlXDveWa5gEVbLhFJHfE8ACEleO/46clXaYUCDkCBmuKtytMSBNebeHtkM7Q+tQb
         cPFicXryc5rvkM1E6QwtPSwCXN4Oo0+kq8DXmJjn4MWjhUSX1QAZTBK9dqY/cTxJokNQ
         8VVKNZG082M091XCFllLRgTB7rbm3qz4HQiluj3+tGmrDRDeTRcho9Q0tY8HvyYWRaJ2
         yiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QZkeOx+aNFTprjPlGSIFp/kR1sp2qaO3UGAVXMLzdTY=;
        b=BhCPeWPrUA09G8U/bCzWjuFf12m092pSLFZNY3l0mmsVdNv3vy4fVVfubAZMnSmWh5
         c5ijIZjsR+0XA7PuhUJMZ+b7ztZNosIPb629G+5djRunbBmhQSg8eAJ+TvAwLM9vLxKj
         rX2uvEBrCShwsehnvx3dxGliMmHM7DQxhfPXCpLIEr7RyuEqdSjm2YNS1R7v6H3Mj8WM
         Axg1UNXF20QI/SzwJ3K8C+cCquCiY2n2+fSz5plM099eUgYtmMIeuwxB1CLpQIJ/5gFW
         MU9ysYAI7kpCJtqRqpqx5keQLIm00qjJoD2QTBUTM0pJ60siRQVbyUe43kYbGnEol/ks
         DNMg==
X-Gm-Message-State: APjAAAUfiSYqiqXQ4lsZBc03NIibkmteJ5QLDn/uRHE+qwVTE+ueJIZm
        n4LKgYg6k2KD+WOTETxyPhXjeCC5dkUDTLyUXhj+Gw==
X-Google-Smtp-Source: APXvYqxN/VAEUgWVmRdXMVFkvoZLkGQQgR8elLk09URmCT+rHqSBzeTqz5I9DThsSd1DX1kA6DPksmb2V+zH9Gzsrfg=
X-Received: by 2002:a1c:2d44:: with SMTP id t65mr11747104wmt.12.1569707176058;
 Sat, 28 Sep 2019 14:46:16 -0700 (PDT)
MIME-Version: 1.0
From:   "David F." <df7729@gmail.com>
Date:   Sat, 28 Sep 2019 14:46:05 -0700
Message-ID: <CAGRSmLu3+=irY+mafat4WbLKimk2uwSJinVs9w91vFHYK58now@mail.gmail.com>
Subject: upgraded mdadm now scans floppy drives?
To:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

I updated a bunch of stuff, from udev, lvm, and mdadm, but now mdadm
with the --scan is hanging up for a long time trying to read from
floppy drive and cd drives.  How do I stop it from doing that?

LVM has a filters option to filter out devices to not scan, how does
mdadm do it?  Did I miss a configure option?

Thanks!!
