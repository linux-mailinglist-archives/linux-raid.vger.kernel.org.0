Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23A9141FEE
	for <lists+linux-raid@lfdr.de>; Sun, 19 Jan 2020 21:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgASUMu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 19 Jan 2020 15:12:50 -0500
Received: from mail-vs1-f43.google.com ([209.85.217.43]:46546 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgASUMu (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 19 Jan 2020 15:12:50 -0500
Received: by mail-vs1-f43.google.com with SMTP id t12so17767797vso.13
        for <linux-raid@vger.kernel.org>; Sun, 19 Jan 2020 12:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QTRKVv3SWvQLRJdzComyopeZ9zl6r3gkSTsv/UX1LIY=;
        b=h/Bqbq8P47M67IME1VQ8/yHzctfF8pHSVFEgqPltrANMkyv52WHZleqaT/pXmXSHSR
         WcAgOtDvykNdI7AhllXuuvjadFW0VM7seIGfD9GvNWdNuiU8NIMZ91GfczWu0V1QND46
         Irt0L8YTG349r89VHcJMqLzNQhtQQN5kXn6ySIEZlbiF/f6tCA9RkGbb0IwaBbH9T8Oa
         lzLHkniyKCJs50NTydeGjkNdWMa9Ed2oj80Pmcxx9c1e2HzYa9eO/TubRjGzDtGr4Rbn
         Cl/6L8svWGxEegDQXt1PycZ+HzF55TS2BNq33Dwu+2DMiUg/e7MURjYkTEjsd1Tb5W+F
         O70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QTRKVv3SWvQLRJdzComyopeZ9zl6r3gkSTsv/UX1LIY=;
        b=O2TZvyUft+CQNrfOtUZP0b1cPl3Uf811w9pncsHB8dfbfOO6VQ8B3W9Q5p259gALnz
         KYcGGO17LOj2Dm5UyciBvyPT5q+RWDlnLB5xGRV163WRe0+G42w98U6ybTdpaF74W4Hn
         +fMvj6xuS9XnAA9Of17aUoOboUm2lSmVjQaWBQ+3FdXRxyo44rV7dQUPGhdr5MVewcxZ
         GT3aknBgZhqTO+I/T5cxIDMLYeITBSav4u2EX17lzPXd6yE8hoCwEckw0m8xZz1bBgVN
         vP3W6eKi+e2OSMXBF6yLnlZ/wrt9Hi8/hOwjKBKeRkRl2WfBJ4BSJMptyj/kf2U6Feya
         xfmg==
X-Gm-Message-State: APjAAAVeXTd5HH01JzcXXlsRoJgv0oPIGBBmtc3oMThjv9BlGn78c25k
        lLYYzkx2JClOLKsJpyE4B/7XevELgXW2pdlU/+kueGhe
X-Google-Smtp-Source: APXvYqwr54KyCxEoq8cfxL+CommKLrSyx+HfreirIOs4/2PNfU0b1ndoZ6IsBrvXqHMHdI6fH+50WyN6On0oy0vHWVQ=
X-Received: by 2002:a67:f541:: with SMTP id z1mr9674410vsn.70.1579464769169;
 Sun, 19 Jan 2020 12:12:49 -0800 (PST)
MIME-Version: 1.0
References: <CALc6PW4OKR2KVFgzoEbRJ0TRwvqi5EZAdC__HOx+vJKMT0TXYQ@mail.gmail.com>
 <959ca414-0c97-2e8d-7715-a7cb75790fcd@youngman.org.uk> <CALc6PW7276uYYWpL7j2xsFJRy3ayZeeSJ9kNCGHvB6Ndb6m1-Q@mail.gmail.com>
 <5E17D999.5010309@youngman.org.uk> <CALc6PW5DrTkVR7rLngDcJ5i8kTpqfT1-K+ki-WjnXAYP5TXXZg@mail.gmail.com>
 <CALc6PW7hwT9VDNyA8wfMzjMoUFmrFV5z=Ve+qvR-P7CPstegvw@mail.gmail.com>
 <5E1DDCFC.1080105@youngman.org.uk> <CALc6PW5Y-SvUZ5HOWZLk2YcggepUwK0N===G=42uMR88pDfAVA@mail.gmail.com>
 <5E1FA3E6.2070303@youngman.org.uk> <CALc6PW4-yMdprmube0bKku0FJVKghYt4tjhep26sy3F9Q5cB4g@mail.gmail.com>
 <5E2494B3.9010006@youngman.org.uk>
In-Reply-To: <5E2494B3.9010006@youngman.org.uk>
From:   William Morgan <therealbrewer@gmail.com>
Date:   Sun, 19 Jan 2020 14:12:38 -0600
Message-ID: <CALc6PW6r8jn7nJcq-ceTboRkP5TYj0863bo856SS3TAus0mTSA@mail.gmail.com>
Subject: Re: Two raid5 arrays are inactive and have changed UUIDs
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> You didn't do anything daft like partitioning one disk, and then just
> dd'ing or cp'ing the partition table across? Never a good idea.

No, I didn't. Here are the partition UUIDs for disks j,k,l,m:

bill@bill-desk:~$ for i in {j,k,l,m} ; do udevadm info --query=all
--name=/dev/sd"$i" | grep -i UUID ; done
E: ID_PART_TABLE_UUID=bbccfe6f-739d-42de-9b84-99ca821f3291
E: ID_PART_TABLE_UUID=f42fd04d-96e3-4b0c-b20c-5286898b104f
E: ID_PART_TABLE_UUID=f467adc9-dba4-4ee9-95cc-f1a93e4a7d98
E: ID_PART_TABLE_UUID=4805ef03-5bd1-46d1-a0e1-5dde52b096ec

> Well it LOOKS to me like something has changed all the partition UUIDs
> to the array UUID, and then the array UUID has changed to avoid a
> collision.
>
> I dunno - let's hope someone else has some ideas ...

Well, here is some further info that shows 2 UUIDs for the single array md0:

bill@bill-desk:~$ udevadm info --query=all --name=/dev/md0 | grep -i UUID
S: disk/by-uuid/ceef50e9-afdd-4903-899d-1ad05a0780e0
S: disk/by-id/md-uuid-06ad8de5:3a7a15ad:88116f44:fcdee150
E: MD_UUID=06ad8de5:3a7a15ad:88116f44:fcdee150
E: ID_FS_UUID=ceef50e9-afdd-4903-899d-1ad05a0780e0
E: ID_FS_UUID_ENC=ceef50e9-afdd-4903-899d-1ad05a0780e0
E: UDISKS_MD_UUID=06ad8de5:3a7a15ad:88116f44:fcdee150
E: DEVLINKS=/dev/md/0 /dev/disk/by-id/md-name-bill-desk:0
/dev/disk/by-uuid/ceef50e9-afdd-4903-899d-1ad05a0780e0
/dev/disk/by-id/md-uuid-06ad8de5:3a7a15ad:88116f44:fcdee150

Still not sure why /dev/disk/by-id/ and /dev/disk/by-uuid/ would have
differing UUIDs, but maybe that's normal.

Maybe someone can shed some light here?

Cheers,
Bill
