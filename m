Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7E714A8BF
	for <lists+linux-raid@lfdr.de>; Mon, 27 Jan 2020 18:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgA0RML (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 Jan 2020 12:12:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgA0RML (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 27 Jan 2020 12:12:11 -0500
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8785824672
        for <linux-raid@vger.kernel.org>; Mon, 27 Jan 2020 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580145130;
        bh=msCw9Ud1f2MMFKaRctZTqIy+ppCvaV1KeZDN53bhARE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZKTCPpZW6j+7dOIfOX9YrDmjqpJzFKx1cOyPtV/lGqVGfmjx4KYm17ZSGDEj3f8Ue
         M4fHLbQhcZaRsI0xy+y1obShaaU251Of5k1Ep0jrd0Id4N0MKjXxQLDsVxL7CfAkHx
         l6ROrilv2dVzYB68FYiBxli9KwmBhd07I6y4QKOg=
Received: by mail-lj1-f181.google.com with SMTP id w1so11590773ljh.5
        for <linux-raid@vger.kernel.org>; Mon, 27 Jan 2020 09:12:10 -0800 (PST)
X-Gm-Message-State: APjAAAUBMAYtAJ9mWmHt1mrDed+qIbGalk0q2iNqEcnfhRGA9JVU2Auh
        RTdKs5UtXlFsXOKTFgEcYEE7oxJ331j9MqrfZrg=
X-Google-Smtp-Source: APXvYqwcv8et9j+/NKiDktGGXSesHXanFKTiBou8ZoQg3mBEWdOYFizqKQdx78zIV8inmT1Lx8RmvhQyFpfTk6b0G5M=
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr10340571ljn.48.1580145128555;
 Mon, 27 Jan 2020 09:12:08 -0800 (PST)
MIME-Version: 1.0
References: <2ce8813c-fd3e-5e78-39ac-049ddfa79ff6@icdsoft.com>
In-Reply-To: <2ce8813c-fd3e-5e78-39ac-049ddfa79ff6@icdsoft.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 27 Jan 2020 09:11:57 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4Jc-qef9uW-JSut90qOpDc_4VoAFpMU8KwqnK7EeT_xg@mail.gmail.com>
Message-ID: <CAPhsuW4Jc-qef9uW-JSut90qOpDc_4VoAFpMU8KwqnK7EeT_xg@mail.gmail.com>
Subject: Re: Pausing md check hangs
To:     Georgi Nikolov <gnikolov@icdsoft.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jan 27, 2020 at 5:44 AM Georgi Nikolov <gnikolov@icdsoft.com> wrote:
>
> Hi,
>
> I posted a kernel bug about this a month ago but it did not receive any
> attention: https://bugzilla.kernel.org/show_bug.cgi?id=205929
> Here is a copy of the bug report and I hope that this is the correct
> place to discuss this:
>
> I have a Supermicro server with 10 md raid6 arrays each consisting of 8
> SATA drives. SATA drives are Hitachi/HGST Ultrastar 7K4000 8T.
> When i try to pause array check with "echo idle >
> "/sys/block/<md_dev>/md/sync_action" it randomly hangs at different md
> device.
> Process "mdX_raid6" is at 100% cpu usage. cat
> /sys/block/mdX/md/journal_mode hungs forever.
>
> Here is the state at the moment of crash for one of the md devices:
>
> root@supermicro:/sys/block/mdX/md# find -mindepth 1 -maxdepth 1 -type
> f|sort|grep -v journal_mode|xargs -r egrep .
> ./array_size:default
> ./array_state:write-pending
> grep: ./bitmap_set_bits: Permission denied
> ./chunk_size:524288
> ./component_size:7813895168
> ./consistency_policy:resync
> ./degraded:0
> ./group_thread_cnt:4
> ./last_sync_action:check
> ./layout:2
> ./level:raid6
> ./max_read_errors:20
> ./metadata_version:1.2
> ./mismatch_cnt:0
> grep: ./new_dev: Permission denied
> ./preread_bypass_threshold:1
> ./raid_disks:8
> ./reshape_direction:forwards
> ./reshape_position:none
> ./resync_start:none
> ./rmw_level:1
> ./safe_mode_delay:0.204
> ./skip_copy:0
> ./stripe_cache_active:13173
> ./stripe_cache_size:8192
> ./suspend_hi:0
> ./suspend_lo:0
> ./sync_action:check
> ./sync_completed:3566405120 / 15627790336
> ./sync_force_parallel:0
> ./sync_max:max
> ./sync_min:1821385984
> ./sync_speed:126
> ./sync_speed_max:1000 (local)
> ./sync_speed_min:1000 (system)
>
> root@supermicro:~# cat /proc/mdstat
> Personalities : [raid1] [linear] [multipath] [raid0] [raid6] [raid5]
> [raid4] [raid10]
> md4 : active raid6 sdaa[2] sdab[3] sdy[0] sdae[6] sdac[4] sdad[5]
> sdaf[7] sdz[1]
>        46883371008 blocks super 1.2 level 6, 512k chunk, algorithm 2
> [8/8] [UUUUUUUU]
>        [====>................]  check = 22.8% (1784112640/7813895168)
> finish=20571.7min speed=4884K/sec

Thanks for the report.

Could you please confirm the kernel is 4.19.67-2+deb10u2 amd64?
Also, have you tried different kernels?

Song
