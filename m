Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEB51D1E51
	for <lists+linux-raid@lfdr.de>; Wed, 13 May 2020 20:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390547AbgEMS5b (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 May 2020 14:57:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390543AbgEMS5b (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 13 May 2020 14:57:31 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C4322065C;
        Wed, 13 May 2020 18:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589396251;
        bh=DXaopRrXMqxDPVBm3gO6IzeV89tqWDGVddYfqRUjVcI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WzzsLB9KMIlur/KMtg/LshvJFepBTBMPOP6vujc84LJUZN4G0nC49jE528Ce0nLqE
         0BACzeMYnLy+rFdvGm3Nl0tBWX0us95vM3dKRPUcKFFmg/L1/Xx2O+ib/9zlJUN6AR
         Bvm8DKqheh6IhE5PHTA5O0y8SsGgjZcxOvPOhqbc=
Received: by mail-lf1-f44.google.com with SMTP id d22so405600lfm.11;
        Wed, 13 May 2020 11:57:30 -0700 (PDT)
X-Gm-Message-State: AOAM530uTpspYHS4PfPRmx8y3SKY04aLrqHKKBZcl4HfSh25tDswmjis
        JqhGaoPxLFjaTVeY0tNCK3pavTwVzhjb3qEd2Wk=
X-Google-Smtp-Source: ABdhPJy20e6jsGTjYzJ1DlnobVzirgnIcaqJg+qWxM13QTii/2GyRK6w8qwMQ5agspcZMAPMtWXr3afPWrk2n8QrM3Y=
X-Received: by 2002:ac2:5628:: with SMTP id b8mr555764lff.172.1589396248682;
 Wed, 13 May 2020 11:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <1589185405-39519-1-git-send-email-wangxiongfeng2@huawei.com>
In-Reply-To: <1589185405-39519-1-git-send-email-wangxiongfeng2@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 13 May 2020 11:57:17 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7ZCo9Sd28tViebXB49-nTvZhn+P8=TcfqL4sfnk2pKfg@mail.gmail.com>
Message-ID: <CAPhsuW7ZCo9Sd28tViebXB49-nTvZhn+P8=TcfqL4sfnk2pKfg@mail.gmail.com>
Subject: Re: [PATCH] md: add a newline when printing parameter 'start_ro' by sysfs
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, May 11, 2020 at 1:29 AM Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
>
> Add a missing newline when printing module parameter 'start_ro' by
> sysfs.
>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

Applied to md-next. Thanks for the patch!
