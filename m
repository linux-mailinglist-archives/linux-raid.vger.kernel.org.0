Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34142139863
	for <lists+linux-raid@lfdr.de>; Mon, 13 Jan 2020 19:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgAMSLN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 13 Jan 2020 13:11:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728664AbgAMSLM (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 13 Jan 2020 13:11:12 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DAAD207FF
        for <linux-raid@vger.kernel.org>; Mon, 13 Jan 2020 18:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578939072;
        bh=5I6Q6w3qZwzu+bKxxJhqxNXlZ1/MxhvMOmbtxtXRlNY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HVUqseNPmAivKn5k/NYjimV5Yofwu44kGLjsNG92RQUNirKByTJVvy7Mg0kaz2XDN
         X3KM6tBetWuVL19x5vdFLW9F1i4qTfztaSho0/OhHpq8WJ+uhb7yerJk+NzzkeQcCl
         i/yuH9QnJDXtIHAXgf0TEO9f0ioM4uz8DJbgWjHk=
Received: by mail-qv1-f41.google.com with SMTP id x1so4425710qvr.8
        for <linux-raid@vger.kernel.org>; Mon, 13 Jan 2020 10:11:12 -0800 (PST)
X-Gm-Message-State: APjAAAVp0ozHzILJnjR9b4REGxtmi+0D2uVdT7MTkgRdQ7w2hss7yonH
        nfJ+Qe1lw8eG6TYSRRPHzVeklGh5W2zpR89Vgaw=
X-Google-Smtp-Source: APXvYqz+oKiylZsxefdGOBUU5aYMjPqCBWQ8EdkHjQlWisvN9+c+ok6tleuOYp2t+OB3htNMcJCufAxPWFR4zGOVEkM=
X-Received: by 2002:a05:6214:14a6:: with SMTP id bo6mr17126975qvb.8.1578939071432;
 Mon, 13 Jan 2020 10:11:11 -0800 (PST)
MIME-Version: 1.0
References: <CAJH6TXhnkB10BUENn0P+qXy4nunwY6QVtgDvaFVpfGDpvE-V=Q@mail.gmail.com>
In-Reply-To: <CAJH6TXhnkB10BUENn0P+qXy4nunwY6QVtgDvaFVpfGDpvE-V=Q@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 13 Jan 2020 10:11:00 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6srGADYYD4dsUbVVBcz4bfJ-taoOy6ccpXjyU26jVTEg@mail.gmail.com>
Message-ID: <CAPhsuW6srGADYYD4dsUbVVBcz4bfJ-taoOy6ccpXjyU26jVTEg@mail.gmail.com>
Subject: Re: dm-integrity
To:     Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>,
        dm-devel@redhat.com
Cc:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

+ dm-devel

On Sun, Jan 12, 2020 at 5:43 AM Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
>
> I'm testing dm-integrity.
> Simple question: when corrupted data are found, repair is done
> immediately or on next scrub?
>
> This is what I have:
>
> [ 6727.395808] md: data-check of RAID array md0
> [ 6727.528589] device-mapper: integrity: Checksum failed at sector 0xe228
> [ 6727.938689] md: md0: data-check done.
> [ 6749.125075] md: data-check of RAID array md0
> [ 6749.664269] md: md0: data-check done.
>
> if repair is done immediatly, would be possible to add a single log
> line saying that ?
> something like:
> [ 6727.528589] md: md0: Repaired data at sector 0xe228

I guess this belongs to dm-integrity instead of md?

Thanks,
Song
