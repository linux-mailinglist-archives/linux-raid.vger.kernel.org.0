Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E132B3F5C
	for <lists+linux-raid@lfdr.de>; Mon, 16 Nov 2020 10:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgKPJFX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 16 Nov 2020 04:05:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgKPJFW (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 16 Nov 2020 04:05:22 -0500
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA9BB221F9
        for <linux-raid@vger.kernel.org>; Mon, 16 Nov 2020 09:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605517522;
        bh=DvbiJy0iSTennO42V6wcT538HDtcwdpKwTaboc1zrBg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eEhxw66+aS/2Ru90HjLkpy5kos51mRn4fBIAx36vJXI9xaRO6ILQYe3xFZq3SiZ9Z
         pBB0CBYCQYGx8EkHqFCIWNmYM4OKCG0ajhgzSfMsF8Q36aswQEti5c8ZteIXutK3iz
         gnhahi99Q3AcdovalKYUKcJ3ocMRwccBpYs/hs7M=
Received: by mail-lf1-f44.google.com with SMTP id u18so24041404lfd.9
        for <linux-raid@vger.kernel.org>; Mon, 16 Nov 2020 01:05:21 -0800 (PST)
X-Gm-Message-State: AOAM533PjkrsDawvJW8XZ9MKfjMCSgA3hehOSDXvXhIaNESbUfEI3bH7
        vd8CwG3uEGWx9x2sZX7vEebdP10dPejrNZelc+c=
X-Google-Smtp-Source: ABdhPJyxhWKOE0x62cbDcqTImxL/AnB6Tw3ZN/ikIXf+mMz1yRnkhD03FlaHSKeSF4mHtayEE5294bRGLtxCApQgDIQ=
X-Received: by 2002:a19:643:: with SMTP id 64mr5630165lfg.515.1605517519977;
 Mon, 16 Nov 2020 01:05:19 -0800 (PST)
MIME-Version: 1.0
References: <1605414622-26025-1-git-send-email-heming.zhao@suse.com> <1605414622-26025-2-git-send-email-heming.zhao@suse.com>
In-Reply-To: <1605414622-26025-2-git-send-email-heming.zhao@suse.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 16 Nov 2020 01:05:09 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6UHbZt+34JhppjhHHUj9Z8-Fh6jwOHxbJrk9Lv1kevSw@mail.gmail.com>
Message-ID: <CAPhsuW6UHbZt+34JhppjhHHUj9Z8-Fh6jwOHxbJrk9Lv1kevSw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] md/cluster: reshape should returns error when
 remote doing resyncing job
To:     Zhao Heming <heming.zhao@suse.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Xiao Ni <xni@redhat.com>, lidong.zhong@suse.com,
        NeilBrown <neilb@suse.de>, Coly Li <colyli@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sat, Nov 14, 2020 at 8:30 PM Zhao Heming <heming.zhao@suse.com> wrote:
>
[...]
>
> Signed-off-by: Zhao Heming <heming.zhao@suse.com>

The fix makes sense to me. But I really hope we can improve the commit log.
I have made some changes to it with a couple TODOs for you (see below).
Please read it, fill the TODOs, and revise 2/2.

Thanks,
Song


md/cluster: block reshape with remote resync job

Reshape request should be blocked with ongoing resync job. In cluster
env, a node can start resync job even if the resync cmd isn't executed
on it, e.g., user executes "mdadm --grow" on node A, sometimes node B
will start resync job. However, current update_raid_disks() only check
local recovery status, which is incomplete. As a result, we see (TODO
describe observed issue).

Fix this issue by blocking reshape request. When node executes "--grow"
and detects ongoing resync, it should stop and report error to user.

The following script reproduces the issue with (TODO:  ???%) probability.
```
# on node1, node2 is the remote node.
mdadm -C /dev/md0 -b clustered -e 1.2 -n 2 -l mirror /dev/sdg /dev/sdh
ssh root@node2 "mdadm -A /dev/md0 /dev/sdg /dev/sdh"

sleep 5

mdadm --manage --add /dev/md0 /dev/sdi
mdadm --wait /dev/md0
mdadm --grow --raid-devices=3 /dev/md0

mdadm /dev/md0 --fail /dev/sdg
mdadm /dev/md0 --remove /dev/sdg
mdadm --grow --raid-devices=2 /dev/md0
```

Cc: <stable@vger.kernel.org>
Signed-off-by: Zhao Heming <heming.zhao@suse.com>


> ---
>  drivers/md/md.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 98bac4f304ae..74280e353b8f 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
[...]
