Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 086BA18D4CE
	for <lists+linux-raid@lfdr.de>; Fri, 20 Mar 2020 17:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgCTQrm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 20 Mar 2020 12:47:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40021 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgCTQrm (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 20 Mar 2020 12:47:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id w26so1528502edu.7
        for <linux-raid@vger.kernel.org>; Fri, 20 Mar 2020 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+nKO7jZ5/9ISrYv6lQzr+mqjf7T+1WdqiI1tlZfa9U8=;
        b=EWYCb0/iVxzJuQUk+92xOxzssn0zz++JIb1hoFxJxQNPpx7yNeeqmzCycmFhpadELp
         5egGTpXW3usnv6qHO8SYKx7ZeGm/cRThK/v/bKQdlRgbYD8Q0JCenuokIta+TBWtiWvt
         8IV3dGBkw7tx80Mmvoe1ZU4N8zM4sWZrML6NXGsFeMRMCwoHP4i8YBd62KRcYfDdaTDL
         JCuCAiVL0w/WH/70cvHIfNtY07BjY9opUD1LTYB1Nryik7RMX+EQJpfQyzzJ6ffMD7ul
         05E8T8XIVdzG5vMOnbCpx8uadqFkkL/VDWA6aVrS6Tn3E1FsGr4au5bVXernPsf/Y3MS
         67DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+nKO7jZ5/9ISrYv6lQzr+mqjf7T+1WdqiI1tlZfa9U8=;
        b=Kyc7Y/TAF7c2jbbLlaSSXE2iFh1zyJNr8m90KdnTXEtnb0MPcjr0HaW3cryjqc0zSl
         S6+cQ0Apx5U8CdSdUYlvGH/vAcuoAzoxv/7XvA7nxyMJ2nUZ/wMyiBheZFVlmvq5Klrq
         eSx0VsNRgBdg0Eo9KznTFeHVooEJN5owJwS0Ym3/hmpoSp2Ih7oyfIn721Qm7bPxyEC2
         cSEXKq/sRSIrUlrQzQDo0pt9RCVXaPoI4lMNhwSMW0332lcXOerQVmVOGalwqJOIjsIW
         TGoXynKUZwcgEdYrR4gkooLCvXTg6KfvS0NeYZThUupKoxTB+wewj1nWkriZd0VbSP7s
         s5Zg==
X-Gm-Message-State: ANhLgQ3b5R9kziruMeYqPtES6MNm4DlQm5SZlBNWHtQnJW4p50Zermw+
        v/Mo/m1OKN4blIgOHIQMh7C9ck4XOrKdanL09vMLUy/z
X-Google-Smtp-Source: ADFU+vvuE/STE3vWDWHNRY7oLi/ba8k2aq9OrwfqoWbfnWv5rq1eMdt8bFcf410MGi2TPBqgvKRwtfz/csKxyy03v6I=
X-Received: by 2002:aa7:d0cb:: with SMTP id u11mr8619893edo.373.1584722858152;
 Fri, 20 Mar 2020 09:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAJTWkdvU3of87+-zyUPn7uDBen8ZBswujwMn8wYSiwZb=0V3EQ@mail.gmail.com>
In-Reply-To: <CAJTWkdvU3of87+-zyUPn7uDBen8ZBswujwMn8wYSiwZb=0V3EQ@mail.gmail.com>
From:   Patrick Dung <patdung100@gmail.com>
Date:   Sat, 21 Mar 2020 00:47:11 +0800
Message-ID: <CAJTWkdtYbmSapP0cG+nknTQWcn1ut4NaF4v5rEtS0wwvkuMH=A@mail.gmail.com>
Subject: Re: Please show descriptive message about degraded raid when booting
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,

Bump.

Got a reply from Fedora support but asking me to find upstream.
https://bugzilla.redhat.com/show_bug.cgi?id=1794139

Thanks,
Patrick

On Thu, Mar 5, 2020 at 10:57 PM Patrick Dung <patdung100@gmail.com> wrote:
>
> Hello,
>
> The system have Linux software raid (md) raid 1.
> One of the disk is missing or have problem.
>
> The raid is degraded.
> When the OS boot, it hangs at the message for outputting to kernel at
> about three seconds.
> There is no descriptive message that the RAID is degraded.
> I know the problem because I had wrote zero to one of the disk of the
> raid 1. If I don't know the problem (maybe cable is loose or disk
> failure), it is confusing.
>
> Related log:
>
> [    2.917387] sd 32:0:0:0: [sda] 56623104 512-byte logical blocks:
> (29.0 GB/27.0 GiB)
> [    2.917446] sd 32:0:1:0: [sdb] 56623104 512-byte logical blocks:
> (29.0 GB/27.0 GiB)
> [    2.917499] sd 32:0:0:0: [sda] Write Protect is off
> [    2.917516] sd 32:0:0:0: [sda] Mode Sense: 61 00 00 00
> [    2.917557] sd 32:0:1:0: [sdb] Write Protect is off
> [    2.917575] sd 32:0:1:0: [sdb] Mode Sense: 61 00 00 00
> [    2.917615] sd 32:0:0:0: [sda] Cache data unavailable
> [    2.917636] sd 32:0:0:0: [sda] Assuming drive cache: write through
> [    2.917661] sd 32:0:1:0: [sdb] Cache data unavailable
> [    2.917677] sd 32:0:1:0: [sdb] Assuming drive cache: write through
> [    2.927076] sd 32:0:0:0: [sda] Attached SCSI disk
> [    2.927458]  sdb: sdb1 sdb2 sdb3 sdb4
> [    2.929018] sd 32:0:1:0: [sdb] Attached SCSI disk
> [    3.060855] vmxnet3 0000:0b:00.0 ens192: intr type 3, mode 0, 3
> vectors allocated
> [    3.061826] vmxnet3 0000:0b:00.0 ens192: NIC Link is Up 10000 Mbps
> [  139.411464] md/raid1:md125: active with 1 out of 2 mirrors
> [  139.412176] md125: detected capacity change from 0 to 1073676288
> [  139.433441] md/raid1:md126: active with 1 out of 2 mirrors
> [  139.434182] md126: detected capacity change from 0 to 314507264
> [  139.436894]  md126:
> [  139.455511] md/raid1:md127: active with 1 out of 2 mirrors
> [  139.456739] md127: detected capacity change from 0 to 27582726144
>
> So there are about 130 seconds without any descriptive messages. I
> thought the system had hanged.
>
> Could the kernel display more descriptive messages about the RAID?
>
> If I use rd.debug boot parameters, I know the kernel is still running.
> But it is scrolling very fast without actually knowing what is the the
> problem.
>
> Thanks,
> Patrick
