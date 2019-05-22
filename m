Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1831F267FA
	for <lists+linux-raid@lfdr.de>; Wed, 22 May 2019 18:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfEVQUE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 May 2019 12:20:04 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:41360 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfEVQUE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 22 May 2019 12:20:04 -0400
Received: by mail-qt1-f169.google.com with SMTP id y22so3053468qtn.8
        for <linux-raid@vger.kernel.org>; Wed, 22 May 2019 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxDDRaj0dH4SodtSqKwZzpPMyRlnPR4DphnYQQPFiwo=;
        b=DfMyUb4eC0kMZ9MbEbnATWoVeVJ1rEOuWK6MVpDobTlP2FNeSS/Czojo11s/rjjiSK
         pQLx26a/s0IfMCNAJvuHi//JYQo19/u6C2nv3ofPwXp3gpyxGnnCYqkyPq0jhzP/qCz5
         4TG5axKEZ7ENenYPNLMOCCd+2//WBBkzx4zHA+faA5qgt82LtaWPJ6qt1euVorIxGRKU
         GmMwhnDKjYPjwWj20VtT21/LS7rhgsytDs9wKfx0IRPfUkLbFltUnI/kS7u6nYXOWnX5
         xL21S7NmynL/1Xzih8C3hcLbVUGDm4mnFbTcOR4JkuceShgxkgdAHIFNrPFbnhCx3iAc
         gsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxDDRaj0dH4SodtSqKwZzpPMyRlnPR4DphnYQQPFiwo=;
        b=QsY7UhxaFDunhHYaNjX7MOQrwcbRQrKqUOSWfsv6fljngGKJ9INy8YJxRRFfIpTdli
         a/NdZy5lYDVLq6vEKaP8jmvJRdEvcHqutc3nPJzn6hA4eblpbVbbDK8v2WoI33MAexWu
         pe4YopXM4y+fhAnIr1LOdB/EEL4hVG6f4lHwbjdF/cxFSQZjXXLo0ttmzttfY1xe5gNF
         LWSSSlxxhh1jG9jilfDn6mNsuOiOZRa7GRG3Kb6Z5VDct/OwsN4auuiXooXYYRtzydL0
         PIBYiReky4JczWaUzsuP/fIy4OR0ziLrbb1zDkJkq013AxiLxAgf7pH+Vl7ImNt1rBnR
         csyw==
X-Gm-Message-State: APjAAAXB+Q45Mm85g83YHEs1YkuzA0ErNFvGNqb5o32xfw4fkE9p2+/m
        PBj3nA6A0dNscOqbFY8fCb960ZSGAaklN6tqegO12w==
X-Google-Smtp-Source: APXvYqxcFeY6oqVAxoCmWNOiKMGy+Q30FxZUK9df4HsQAr4byswWf/1ryY6uTDPEMPbafOFT30imTbc2soShgyBMj90=
X-Received: by 2002:ac8:30bb:: with SMTP id v56mr62039243qta.183.1558542003177;
 Wed, 22 May 2019 09:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <69b2ca6b-2ccb-db3b-1fde-62e5b7483293@thorsten-knabe.de>
In-Reply-To: <69b2ca6b-2ccb-db3b-1fde-62e5b7483293@thorsten-knabe.de>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 22 May 2019 09:19:51 -0700
Message-ID: <CAPhsuW5Fvd0i-ezmsEpr977kiNfvdTKb5ZXTOi2D1oN5HdXP0w@mail.gmail.com>
Subject: Re: BUG: RAID6 recovery broken by commit 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef
 (Linux 5.1.3)
To:     Thorsten Knabe <linux@thorsten-knabe.de>
Cc:     Shaohua Li <shli@kernel.org>, Nigel Croxon <ncroxon@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Thorsten,

Thanks for the report. I will follow up with stable@ to fix them.

Best regards,
Song

On Wed, May 22, 2019 at 5:26 AM Thorsten Knabe <linux@thorsten-knabe.de> wrote:
>
> Hello.
>
> BUG: RAID6 recovery broken by commit
> 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef (Linux 5.1.3+)
>
> Replacing a failed disk of a MD RAID6 array causes file system
> corruption and data loss on kernels containing commit
> 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef.
>
> Affected kernels: 5.1.3, 5.1.4 possibly others.
> Unaffected kernels: 5.1.2
>
> OS: Debian stretch amd64
>
> Steps to reproduce the BUG:
>
> 1. Create a new 4-disk RAID6 array, create a file system and mount it:
>    mdadm /dev/md0 --create -l 6 -n 4 /dev/sd[bcde]
>    mkfs.ext4 /dev/md0
>    mount /dev/md0 /mnt
> 2. Store some data (a few GB should be fine) on the RAID6 arrays file
> system:
>    cp -r whatever /mnt
> 3. Fail a disk of the RAID6 array and remove it from the array:
>    mdadm /dev/md0 --fail /dev/sdd
>    mdadm /dev/md0 --remove /dev/sdd
> 4. Drop caches:
>    echo "3" > /proc/sys/vm/drop_caches
> 5. Compare data copied to the RAID6 array in step 2 with its source:
>    diff -r whatever /mnt/whatever
>    There should be no differences and no file system errors.
> 6. Add a new empty disk to the RAID6 array:
>    mdadm /dev/md0 --add /dev/sdf
> 7. RAID6 recovery should start now, wait for the RAID6 recovery to finish.
> 8. Drop caches again:
>    echo "3" > /proc/sys/vm/drop_caches
> 9. Compare data copied to the RAID6 array in step 2 with its source again:
>    diff -r whatever /mnt/whatever
>    diff now reports a lot of differences and the kernel log gets filled
> with file system errors. For example:
>    EXT4-fs warning (device md0): ext4_dirent_csum_verify:355: inode
> #918549: comm diff: No space for directory leaf checksum. Please run
> e2fsck -D.
>
> Reverting commit 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef from kernel
> 5.1.4 resolves the issues described above.
>
> Kind regards
> Thorsten
>
>
> --
> ___
>  |        | /                 E-Mail: linux@thorsten-knabe.de
>  |horsten |/\nabe                WWW: http://linux.thorsten-knabe.de
>
