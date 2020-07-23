Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB1922A717
	for <lists+linux-raid@lfdr.de>; Thu, 23 Jul 2020 07:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgGWFyv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 23 Jul 2020 01:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgGWFyv (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 23 Jul 2020 01:54:51 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55DDF207F5
        for <linux-raid@vger.kernel.org>; Thu, 23 Jul 2020 05:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595483690;
        bh=/kFKbjhSMKYij9pdPu4ClmBvZk/s3fJEtLCZIc48LhI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bNW+HCEHpT2/rEoKbmlPChzYKaJ5/vyzyLM3MGfeP6QKB4BTYYlswqq+qdf93XwUu
         tfDg4zet4Ev+OcnNGOGKbPtJXTpVtNP+2cMcznkLL4B58wukKvb/Yyt+70hTPXcJvE
         Cz38cM+qvSkegkH5vweXc0LP0n6JOt9eoNzwqGJ4=
Received: by mail-lj1-f179.google.com with SMTP id h22so5024218lji.9
        for <linux-raid@vger.kernel.org>; Wed, 22 Jul 2020 22:54:50 -0700 (PDT)
X-Gm-Message-State: AOAM530wp6oC0Ih2apBIaTMGaQDKgRAJ3TaWCXulkL9bPet1NfMBiBxr
        lNTVfukYQsIW1mVtEJbpHjEztkK/PkBmfayuENA=
X-Google-Smtp-Source: ABdhPJxSe0Qk8mUusIBM8fVeUun9PpC589qwVglUeFq8kyRptChvFIgCnL95gVDzlm4WfKAiQ0qkBdZQDSSB8D9bRsY=
X-Received: by 2002:a2e:b175:: with SMTP id a21mr1243452ljm.10.1595483688694;
 Wed, 22 Jul 2020 22:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200723032905.864569-1-yuyufen@huawei.com>
In-Reply-To: <20200723032905.864569-1-yuyufen@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 22 Jul 2020 22:54:37 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7CmLH3c4gO+cGUVd8w6h1dbyHhF7RpqutbrK7ORf7R3g@mail.gmail.com>
Message-ID: <CAPhsuW7CmLH3c4gO+cGUVd8w6h1dbyHhF7RpqutbrK7ORf7R3g@mail.gmail.com>
Subject: Re: [PATCH] md/raid5: use do_div() for 64 bit divisions
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jul 22, 2020 at 8:28 PM Yufen Yu <yuyufen@huawei.com> wrote:
>
> On 32-bit architectures (e.g. m68k):
>
>   ERROR: modpost: "__udivdi3" [drivers/md/raid456.ko] undefined!
>
> Since 'sync_blocks' is defined as 64bit, we should use do_div() to
> fix this error.
>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

I modified the commit log and applied it to md-next. In the future, please
add Fixes tag for bug fix.

Thanks,
Song
