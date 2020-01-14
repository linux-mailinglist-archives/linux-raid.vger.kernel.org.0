Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A06F113A27E
	for <lists+linux-raid@lfdr.de>; Tue, 14 Jan 2020 09:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgANII6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jan 2020 03:08:58 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:36570 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgANII6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Jan 2020 03:08:58 -0500
Received: by mail-io1-f43.google.com with SMTP id d15so12870348iog.3
        for <linux-raid@vger.kernel.org>; Tue, 14 Jan 2020 00:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kD53nLEULqQATX/ariOKcqa3ViMz3/Dv8++o17SiXhs=;
        b=fJWFvw+IJ1KJWbYafMSTI1Ctb2TG3tiP2gTVJpVBsmNI23d4KDztKMI4HvZFKkexx5
         +jAxLO84i+eDjx9/bqyL+O3mZ+hFZ02Ze/KP92I0ahzrbJd1wd3wIZnCIsfPQh+2qhxo
         QQImJ7nf92IvtK39svMUwHaPMa5s+qZtex7JG10fiXFPTtTd/xrX4/0P+tNPWKvcIxaC
         yBhMyjeOqFb3gQya08gitqH2+xY0Wq4FR+bdM+5+eBR30pbXocR+z2DOgGnlbDUxC35B
         Nz5JTBNi2HP145GkSIy+0Wyk/lnwGi0g1QJEjJUk8HbUKkN5W8mWFsQYWZ4fFm8rbP1s
         GG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kD53nLEULqQATX/ariOKcqa3ViMz3/Dv8++o17SiXhs=;
        b=MTxRBK5KHkaImXL3NQi4OWHlSKPu0GvC0YgfcQB0iOPO6Qfj1rLBmWsPbAvFFx2GyL
         rmWJfbQum96shJDu1930G4vIifbQY8A+23ZheybGsw0uiTNwxe5HDpFjELNxzT6HKPAV
         zo3tAsOi/YVMCThV706YKiD5GwivacveUUAUXX8SlB72MEx2qmYkwdFjWL+ou6ZIge9c
         rfXEve7ZgtxsWNIuFcqACCFPzCF4mxOl1zf5047bAHyEAeo8VVQLSBfRiH74DCFjc4GW
         0iR1IEuTvD+QAVR48GqC2Ivc3Zw83J6yofJgCV5VGZ6XL/tb3BWdJTNcLb44eBRURoKC
         s1vw==
X-Gm-Message-State: APjAAAWSn3G1jy480jt2sfVsQM/QZgEY6T4juUE9N4APT4odE35cun+A
        51AP5ts4+K18g+02moV6fJgxCVEY1NAqs5NByLc=
X-Google-Smtp-Source: APXvYqwX9HnPLYO9gyXi6QqskBejWIKfXOJJKWvC37jspmDiryVArgNi20/cpemgxtHCRnSUuwvAx0QVuqGBOBKv+hI=
X-Received: by 2002:a6b:6118:: with SMTP id v24mr16388526iob.73.1578989337699;
 Tue, 14 Jan 2020 00:08:57 -0800 (PST)
MIME-Version: 1.0
References: <CAC4UdkbjUVSpkBM88HB0UJMqXh+Pd7CRLaya=s81xMGs-9+m_Q@mail.gmail.com>
 <5E1D6C8E.8030607@youngman.org.uk>
In-Reply-To: <5E1D6C8E.8030607@youngman.org.uk>
From:   Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date:   Tue, 14 Jan 2020 09:08:46 +0100
Message-ID: <CAJH6TXjaTiSyXLF61irJdZ4QUyMwdc0+dGV+sYRDGJsO15P_XQ@mail.gmail.com>
Subject: Re: Debian Squeeze raid 1 0
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     Rickard Svensson <myhex2020@gmail.com>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Il giorno mar 14 gen 2020 alle ore 08:24 Wols Lists
<antlists@youngman.org.uk> ha scritto:
> The fact that the three event counts we have are near-identical is a
> good sign. The worry is that sde2 disappeared a long time ago - have you
> been monitoring the system? If you ddrescue it will it give an event
> count almost the same as the others? If it does, that makes me suspect a
> controller issue has knocked two drives out, one of which has recovered
> and the other hasn't ...

But as I can see, two drives are out on a RAID1+0 array, so the array is gone.
I think we can only hope that these two disks were on different
mirrors (but this isn't
easily readable on mdadm output, I think i've sent an email asking for
a better output
some days ago)

That's why I really really really hate anything with redundancy < 2,
like a standard RAID1+0
Only 3way mirrors or RAID6 here.
