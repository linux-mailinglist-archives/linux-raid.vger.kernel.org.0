Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06C24100DE7
	for <lists+linux-raid@lfdr.de>; Mon, 18 Nov 2019 22:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfKRVmg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 Nov 2019 16:42:36 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42419 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfKRVmg (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 Nov 2019 16:42:36 -0500
Received: by mail-qv1-f66.google.com with SMTP id n4so4123479qvq.9
        for <linux-raid@vger.kernel.org>; Mon, 18 Nov 2019 13:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cHZSLl4jn2Zv8yl5i2ZrnA3h/IOq3vYsYfM8BaBsZwk=;
        b=SuNE1vdUXn3CVdtAkgB2J3PoxoastE+HMgZsM4kMeqSaMilTbj9oDFESG3WtdyvOsz
         JXxCJwbft/Yet2ibeqWs68O51gCoqDGW42Hw8BiEPRPjodG6y7zmUNDzfZzHnW5CKiH4
         DE2RV8dGerbnvidqAE3Enio03uHo+8yLsIFEryhJQ5J+t0oxMmJhDenD1lzN4jjNBcRL
         jtEpvS2xoWq6koKBDma/tvppsC1/QYa3ksGDSJ8+WcD2e6ARWx0CbzOOqi39QMA8t9bh
         5jBhD32+vVTpy914/iTBlkeB7eNQdaOlR7Q8401rUMQ/6+HU9/bx0JYZ9wZNTPwx+xwn
         CUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHZSLl4jn2Zv8yl5i2ZrnA3h/IOq3vYsYfM8BaBsZwk=;
        b=HjXYu2B1+sCsPB2xZ0C+cUYhGRFF+O6tNX/bgoPaomqGEcA8SgNMI0aG8LTmqPQVpn
         /2JDnx69HmoTOdSSGDDBZ2XTstcBBb3AWJ13xQx3ML4CSkB+s63tU1iF8gVNxh6saNNN
         BVoenkycak8XsfRbsgaAKLFD7+FjW9C++K9bCPOE5LPF5DrJE6I+ornRu/bFmfGjRU+k
         qpnIKvRPDU87P4SaHRahrO6j+gTwrCC3hryWdEuLdAmm/gkAErRYhK41ELQt9IlC8cCM
         30UO7ras82KG+8D/fHmp7WD8hdH05jc9IiBuHPkAgkjQJaSxvYu0lMynDngDPRhK9Mto
         xodg==
X-Gm-Message-State: APjAAAVqbkrLTRvSTclX5wa9Dzv2TEIprXhWa3490MM6grH+IlL7MSgc
        F7QZkvGRjEPHCwERFxuzhGYgm0wtdJWq7eIbeMs=
X-Google-Smtp-Source: APXvYqxWfSeskVweeoxabURgkS/y8l1Ic0VEtqS8oVPi+Zf0hBhfgcmvwVTwR0LzN0lk9N3XooE9gZinYP6I7ajNyzI=
X-Received: by 2002:a05:6214:852:: with SMTP id dg18mr7452122qvb.8.1574113355619;
 Mon, 18 Nov 2019 13:42:35 -0800 (PST)
MIME-Version: 1.0
References: <3d433e66-d9c5-d30c-2a12-cc145cfb8c17@redhat.com> <20191114194918.16688-1-ncroxon@redhat.com>
In-Reply-To: <20191114194918.16688-1-ncroxon@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 18 Nov 2019 13:42:24 -0800
Message-ID: <CAPhsuW44z1TOzqvpnryOsw_Pm5wTHUmgfSYv377KANEn1iedRA@mail.gmail.com>
Subject: Re: [PATCH] raid5: avoid second retry of read-error
To:     Nigel Croxon <ncroxon@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Nov 14, 2019 at 11:50 AM Nigel Croxon <ncroxon@redhat.com> wrote:
>
> The MD driver for level-456 should prevent re-reading read errors.
>
> For redundant raid it makes no sense to retry the operation:
> When one of the disks in the array hits a read error, that will
> cause a stall for the reading process:
> - either the read succeeds (e.g. after 4 seconds the HDD error
> strategy could read the sector)
> - or it fails after HDD imposed timeout (w/TLER, e.g. after 7
> seconds (might be even longer)
>
> The user can enable/disable this functionality by the following
> commands:
> To Enable:
> echo 1 > /proc/sys/dev/raid/raid456_retry_read_error
>
> To Disable, type the following at anytime:
> echo 0 > /proc/sys/dev/raid/raid456_retry_read_error
>
> Signed-off-by: Nigel Croxon <ncroxon@redhat.com>

Is this just the resend of the earlier patch? If this is a new version,
please highlight the changes from previous version.

Thanks,
Song
