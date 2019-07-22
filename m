Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD8370C55
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jul 2019 00:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfGVWHY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 22 Jul 2019 18:07:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45160 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfGVWHY (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 22 Jul 2019 18:07:24 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so29681875qkj.12
        for <linux-raid@vger.kernel.org>; Mon, 22 Jul 2019 15:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6dswDnLyjuQ/1rMEARbw1M/8eJJuV2EAeb7t7vDGsk=;
        b=KcTGD8d5p4xWJmDz9KJZ/4S/EHInF2pDDiNQzDcEXNXFIzCiXR8ZPceeGPlgd7vh2P
         PgeYBHHqtQAlakWvLUPcMdE9BbCrKahRdHHzKUXVDXN0F2iDnf5lSBlcQrl7JMQaR2vP
         gCb9WJqoe62GAacci2LZ08xBsh3mRBkK2LU+35epXgYmJNBTZY0d2kifDBkDaQgYnXEM
         LjSByTeV7gmXrgXFwcCv7nGC7kQrHZvULXtud75ftLG+CcgR8Gbsd4gfvkMvrqeK1y4E
         pcBVTLwNY0Oj85Pvj2M3F7XzPnU+1jkSw/fTyX6BXiZkCTIJtzb3FlhS9vdQ0A9dYTTL
         1DMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6dswDnLyjuQ/1rMEARbw1M/8eJJuV2EAeb7t7vDGsk=;
        b=WVyrYOetfPEuJGjDw6c1SzUtRIHKdBuQBqzntLm0X9yPBFH16fUgQbuZsCLriqYc9L
         66CkNbWwSI6jdNCozJWjMM3rH7oCVQxK2WOq4oIepXg1fOohlP8r8D/Aazpy3AUPqCd6
         HlHlX3FScLE3xwqlYKa2tnbJZdHhvX7VngfOMDSGkb5ISDfQAIGqOVSk6+wx8JJuIehE
         b5qkJ/pq7eZC+R+aqG7+AXgoGi/aNWYsgoubxnL/E41eHnqoirdokV27naPZfjQ3zmoO
         NkUMPJddSubpLNDeFtNgBsEv6oxePyqADj+QztWALCvsNMG/YJcLTMV+OHacLAidtNgr
         RFbA==
X-Gm-Message-State: APjAAAUtUUx4UXlf/JAtdujemklZsXD4ACFF4gNpcbqmjrO7lJW5SIlS
        tmZsXMZ2cW4T6s6ll+VeqmklTg987QCrIS2gMWY=
X-Google-Smtp-Source: APXvYqzZmWhWR/5JHN5vjRFjXUsRKt0Sh0LwBf7UiMuXpPb9JHszGOeGnXQByMxlw6maHZQRv4zk2rRyrNlom8lcdc0=
X-Received: by 2002:a37:6d85:: with SMTP id i127mr47892187qkc.74.1563833243028;
 Mon, 22 Jul 2019 15:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <1562552072-5098-1-git-send-email-xni@redhat.com>
In-Reply-To: <1562552072-5098-1-git-send-email-xni@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 22 Jul 2019 15:07:12 -0700
Message-ID: <CAPhsuW5rAGufksMWYzXPuP26pM=0-u=wTYFHTNiiXXEY6r3iXw@mail.gmail.com>
Subject: Re: [V2 PATCH] Set R5_ReadError when there is read failure on parity
 disk of raid6
To:     Xiao Ni <xni@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Nigel Croxon <ncroxon@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sun, Jul 7, 2019 at 7:14 PM Xiao Ni <xni@redhat.com> wrote:
>
> In 7471fb77(md/raid6: Fix anomily when recovering a single device in RAID6.) It avoids to re-read P
> when it can be computed from other members. But it misses the chance to re-write the right data
> to P. Now it sets R5_ReadError if the re-read fails. Because it avoids the re-read, so it misses
> the chance to set R5_ReadError. The re-write is submitted in state machine when r5dev has flag
> R5_ReadError. So it doesn't re-write the right data to disk. We need to do this to keep the raid
> having right data.
>
> Because it don't send re-read, so it also misses the chance to reset rdev->read_erros to 0. It can
> fail the disk when there are many read errors on P member disk(other disks don't have read error)
>
> V2: upper layer read request don't read parity/Q data. So there is no need to consider such situation.
> This is Reported-by: kbuild test robot <lkp@intel.com>
>
> Fixes: 7471fb77(md/raid6: Fix anomily when recovering a single device in RAID6.)
> Signed-off-by: Xiao Ni <xni@redhat.com>

The commit log should be 75 byte or narrower. checkpatch.pl should report this.

Applied with modified commit log (see below). Please let me know if anything is
not accurate.

Thanks,
Song

md/raid6: Set R5_ReadError when there is read failure on parity disk

7471fb77ce4d ("md/raid6: Fix anomily when recovering a single device in
RAID6.") avoids rereading P when it can be computed from other members.
However, this misses the chance to re-write the right data to P. This
patch sets R5_ReadError if the re-read fails.

Also, when re-read is skipped, we also missed the chance to reset
rdev->read_errors to 0. It can fail the disk when there are many read
errors on P member disk (other disks don't have read error)

V2: upper layer read request don't read parity/Q data. So there is no
need to consider such situation.

This is Reported-by: kbuild test robot <lkp@intel.com>

Fixes: 7471fb77ce4d ("md/raid6: Fix anomily when recovering a single
device in RAID6.")
Cc: <stable@vger.kernel.org> #4.4+
Signed-off-by: Xiao Ni <xni@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
