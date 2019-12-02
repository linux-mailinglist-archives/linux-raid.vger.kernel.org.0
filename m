Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E41010EDF8
	for <lists+linux-raid@lfdr.de>; Mon,  2 Dec 2019 18:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfLBRNq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Dec 2019 12:13:46 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42034 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfLBRNq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 Dec 2019 12:13:46 -0500
Received: by mail-qv1-f65.google.com with SMTP id q19so106583qvy.9
        for <linux-raid@vger.kernel.org>; Mon, 02 Dec 2019 09:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rZmOSD5mnS4iwDUkSAVmGGdIj0c4m4pKG5vTz9Lzv80=;
        b=u3tVNE4H0fMNSEg5bUIFLkMtnNE9uD1qsoMwQR7mLhEIP6rYnjoZRidd+PeBVx+H3Q
         MYQyAN5oUmFRj8lbx+EPXjH7trjTSx7OLteV3K2plZO4eAvFFiBS7DqZg6tVRyeBvkhd
         yYoy1frZqlxdo5mLjyp53xNm88ywolFS6wJ4b7PZG8KfmVMmPlFgilkGlEa+WfNXK0OT
         QXHAoKc+kCyoqvaX5rAPE8Bp1+6dc8694p6xGJBLCjYy9zsG8WM4qFhB8MhCLSbtm6qo
         v411FvTrdfI8d+mTVZyXYe6lxGDvlsM4WgdjXmLCJdhytS0Z2yEaMur+iQ/KY2eY8D6P
         BkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZmOSD5mnS4iwDUkSAVmGGdIj0c4m4pKG5vTz9Lzv80=;
        b=YYnPUB6XCAHknbjiz8WOE5QgmzdXTTKJsRVbcmPsxClRigQ7/cZbRSOlShjwSsFwqv
         gGULj7DKy/RrOa5t2LbKkHQBSDnCbAgjOl67cFLwU0m/C90vMyQE2VTo52gIA5pspUmX
         7qu1F6p3NimqZBSE1vh6i6g0sJq6AmoP4fpqdkbLiBaIH/mOWyrfUaeQXlQLhB+RTjHV
         xurj/xFOyMjUC6zpDIowoT30Sjb425XXyeF4dXHrOYAO9uS07fDtDaBZ/WbS1uqmUmdl
         Uriwi7AWO14Z+jExUQqF9/BLUVNd0fE9dRY6kzra04QmlPgebVDZtEYiRmPvHo/o+LHN
         2ZBw==
X-Gm-Message-State: APjAAAWnZyUnRKx/VXdRMkAoXbckD2Tjt3zLFL+213rlB+7zUOZjfAHF
        UrfNb/dS9UthuaXnGqlQuTlkxaMu/LDxBe0WQUIrZQ==
X-Google-Smtp-Source: APXvYqycrigTp5uTmmN88JP5LFVGuzM7pSk/UEF+9xglA11fh0yQKW+070vFjDM8uvGWYctqblx5nD+kyKxSCWdaOjI=
X-Received: by 2002:ad4:580b:: with SMTP id dd11mr33568191qvb.242.1575306825111;
 Mon, 02 Dec 2019 09:13:45 -0800 (PST)
MIME-Version: 1.0
References: <1574759811-11360-1-git-send-email-liuzhengyuan@kylinos.cn>
In-Reply-To: <1574759811-11360-1-git-send-email-liuzhengyuan@kylinos.cn>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 2 Dec 2019 09:13:32 -0800
Message-ID: <CAPhsuW7rcBoMTpxd4O76+JVe47Waox0vOSL9itMmYUyF=9xR-w@mail.gmail.com>
Subject: Re: [PATCH] md/raid6: fix algorithm choice under larger PAGE_SIZE
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc:     linux-raid <linux-raid@vger.kernel.org>, hpa@zytor.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Nov 26, 2019 at 1:17 AM Zhengyuan Liu <liuzhengyuan@kylinos.cn> wrote:
>
> For raid6, we need at least 4 disks to calculate the best algorithm.
> But, currently we assume we are always under 4k PAGE_SIZE, when come
> to larger page size, such as 64K, we may get a wrong xor() and gen().

Please provide more information about the error. Something like "function x()
will generate wrong value."

>
> This patch tries to fix the problem by supporting arbitrarily page size.
>
> Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
> ---
>  lib/raid6/algos.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/lib/raid6/algos.c b/lib/raid6/algos.c
> index 17417ee..0df7d99 100644
> --- a/lib/raid6/algos.c
> +++ b/lib/raid6/algos.c
> @@ -118,6 +118,7 @@ const struct raid6_recov_calls *const raid6_recov_algos[] = {
>
>  #ifdef __KERNEL__
>  #define RAID6_TIME_JIFFIES_LG2 4
> +#define RAID6_DATA_BLOCK_LEN   4096

Why define this inside "#ifdef __KERNEL__"? This would break ! __KERNEL__
case, right? Have you tried this with lib/raid6/test/ ?

Thanks,
Song
