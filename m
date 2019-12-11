Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE8811BC64
	for <lists+linux-raid@lfdr.de>; Wed, 11 Dec 2019 20:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfLKTCD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Dec 2019 14:02:03 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33436 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLKTCD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 11 Dec 2019 14:02:03 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so7252470qto.0
        for <linux-raid@vger.kernel.org>; Wed, 11 Dec 2019 11:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gYdSh5c5Wcy5vGVpaLlB1lJZeMJjRkm4NwIPSoSqz3A=;
        b=KEapYFTZHTkY/I5GEnTFtQWInxcZC3yXwty8nAe/b1ouYeshdE1JLEBF2ie/oJ8Ldd
         aEr510MkC8Re6xTTNi9yuX+/ZAyvPWWawCvgU38txwBSg7XWG6K88Whvu1YRhZ/Ukors
         44wdRV5bXxTUKGY88sn5iQW77PaQX3/2ESz6hcBAMJNEjfjjbB0B6f6usge37uUBd8tu
         fPUJAHFNcLg3p1MD5Z0OFDdz9En0wRCQyKIoiWxHmAvsbGcQQ5fE0l2j9I5hnmSROwMG
         WOj37zv1CacaOfQ3NuthRAsOXLZwgrYe9JfyehN6lQ5wzWnLjHhpn0cXBJDxFPDpFl4W
         x5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gYdSh5c5Wcy5vGVpaLlB1lJZeMJjRkm4NwIPSoSqz3A=;
        b=CE2CyM5LzhjiqTglDjLzLdaeLRsQUo9P8ev00QohtgaWJAQ9S67yZnv7hUxBmUGzV/
         dOfda3PRytjoYfTiLBDyzM7Ec4IvP6NvceE4GqMUK7C1iu/smAfEE3xOSFlUKuJGF1K5
         sxMdF3dtywR1G4JhXwRekWIPatq4nowQZlH+2HaSl8rRwdoZy8wrF36OtHEYbVNJeHnZ
         ODcRrq0lcoRVaKqz/WkLruiTwpm6VQA+ylQAANuCl4kNhcVL6f6HJSka7TO7RAv34xH7
         /eDRiZtw06YNLmPQ5gB2/J+dBmaTCvdpVOaLo1PfXTuvS+7WtoDUYdmwqOO1kapXAgBE
         a2DQ==
X-Gm-Message-State: APjAAAX4NXq/8r4/pn7CFnMGfa13o9J3CdUAQirVcmpfjwnkPZP4XJkK
        Acu+yaC+/mFpZ35hyml86nN8dJLZN1glvhdvCqs5lA==
X-Google-Smtp-Source: APXvYqzovsOuGnafU1LUqQBnp4DWofAjZO5fxqFnWyIu9ckzEZulyErn1xuDHAvbSTNgApmL0jU4u1SKSVEiduhLx/w=
X-Received: by 2002:ac8:6f0b:: with SMTP id g11mr4117357qtv.308.1576090922821;
 Wed, 11 Dec 2019 11:02:02 -0800 (PST)
MIME-Version: 1.0
References: <20191210070129.2704-1-yuyufen@huawei.com>
In-Reply-To: <20191210070129.2704-1-yuyufen@huawei.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 11 Dec 2019 11:01:51 -0800
Message-ID: <CAPhsuW4NEVsPTdm=vSwjzmCjdZpgQ-TcSryTiNryUooLgPhC6A@mail.gmail.com>
Subject: Re: [PATCH] md: make sure desc_nr less than MD_SB_DISKS
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Dec 9, 2019 at 11:03 PM Yufen Yu <yuyufen@huawei.com> wrote:
>
> For super_90_load, we need to make sure 'desc_nr' less
> than MD_SB_DISKS, avoiding invalid memory access of 'sb->disks'.
>
> Fixes: 228fc7d76db6 ("md: avoid invalid memory access for array sb->dev_roles")
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

Applied. Thanks!
Song
