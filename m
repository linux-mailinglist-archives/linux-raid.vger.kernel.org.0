Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB81EE712
	for <lists+linux-raid@lfdr.de>; Mon,  4 Nov 2019 19:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfKDSN6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 Nov 2019 13:13:58 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43443 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbfKDSN5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 4 Nov 2019 13:13:57 -0500
Received: by mail-lf1-f65.google.com with SMTP id j5so12964972lfh.10
        for <linux-raid@vger.kernel.org>; Mon, 04 Nov 2019 10:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gcdBwYAv1m6HtUsjm3q1KorRaxp96LTbzY1Aj+QTF0Y=;
        b=YsyfCNd9P48IND8M7zcd0FULs09ldYvjxXRkkZBdiMx/Dy9aTx8DtncXH6/kbZbp8D
         ob3Yalggxlq2hoNxWZ+VQWPjdKV0dNRHvc2rUaAmmcxerqSiy4hPnJIUvTJiSAYWeO+8
         3nSyFK2kTlrwA4Q2RxEG0LZfB1hFqAonKmxYrFKspaDzk4j9eET0FsGK3WcWcxMxCNmd
         OHQCW1bFga05Fxo5fnVaoEfaPn3lsQbujAtYGWU1FrRqM8hdCalUfSvJPTHX9S5m3UjT
         bzSe2ddLlyBbPRZ4ZYxSCRsqqcD6ND5WNtpfpq5+jhg7yq9BCGIv1tSihLEq4NpdC9k8
         zcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gcdBwYAv1m6HtUsjm3q1KorRaxp96LTbzY1Aj+QTF0Y=;
        b=CXz32+/yfwk7/8OQ1XvHt6p9rroowBxcfUVrj84IamN0+S7mniIoEcKQL7mX2dg/M+
         RrCNWrbwxW4PiyeLL8VsLCVqoT5/3zIOp+uGpqaOrzTiLy+/VvDih+NfIzo9/5iqko83
         bB8KXr4NPMe/u93bD+lI3lX6JXC3xnkuovEXEGT2ZaNpBjOAW50fLrLzo3MoAW2YQ39j
         MPSwNW04CE0P10KQuDnE+h6jn7Qf/H0IXxLRD9M20UgCTtQFnAPRe5FHkMfBzU6Koind
         VoD/4cR9wvVACOE+1FtdwcpvTUvAmAwPtyxsNlkK/NMLOV86eFIqA/OmClA3PYGTDcrI
         MS6w==
X-Gm-Message-State: APjAAAWQHSxc2QslXftclFOc8N0kibPn0Hy9+2OC/9oZ0ud0df3PIzfZ
        cPjvRKBS0yKTLqHObQAN9pCBYUuL4MVNfbsniP8=
X-Google-Smtp-Source: APXvYqwmEqo4ZuXjYi0zb5Z4ADRvi4XS/lFfDSC5/X5SyXR9U3o1umcntuLtZSwFWAZZ+/nIwIBsTZ/eQsX8bArE/z8=
X-Received: by 2002:ac2:52b3:: with SMTP id r19mr17027967lfm.109.1572891235808;
 Mon, 04 Nov 2019 10:13:55 -0800 (PST)
MIME-Version: 1.0
References: <20191104161957.30123-1-ncroxon@redhat.com>
In-Reply-To: <20191104161957.30123-1-ncroxon@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 4 Nov 2019 10:13:44 -0800
Message-ID: <CAPhsuW5sVw5CiFHbG-E0_21kUMKy7DK3QOdE3tk6M7UE4FUWQQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] raid456: avoid second retry of read-error
To:     Nigel Croxon <ncroxon@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Nov 4, 2019 at 8:20 AM Nigel Croxon <ncroxon@redhat.com> wrote:
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

I am seeing weird characters, like "=3D" below:

+static int sysctl_raid456_retry_read_error =3D 0;

Is this sent in plain text?

Thanks,
Song
