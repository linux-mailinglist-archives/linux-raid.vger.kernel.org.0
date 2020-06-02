Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511EB1EB5C5
	for <lists+linux-raid@lfdr.de>; Tue,  2 Jun 2020 08:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgFBGXB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 2 Jun 2020 02:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgFBGXA (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 2 Jun 2020 02:23:00 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42E47206A2
        for <linux-raid@vger.kernel.org>; Tue,  2 Jun 2020 06:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591078980;
        bh=HZ4OR7mRmvV9HuZ53qUZWBikPor/lJrZm9WEGcH7Jyw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A1uuIto6t2HPKN2H55c0ECuSfUEuowaPnM47joDCEOls0EvjrUjwuZQ23GEAW4n+e
         8k8uyu0yfS4Ko2bgInhx+PlhNszdz624DQq8TuE4q7VOGeKx5qOTemMaoBQM/FpXV2
         bVdZgutrX1wRc0l1DiJmgCdjabMA9ARchXNHAhDk=
Received: by mail-lj1-f171.google.com with SMTP id m18so11120083ljo.5
        for <linux-raid@vger.kernel.org>; Mon, 01 Jun 2020 23:23:00 -0700 (PDT)
X-Gm-Message-State: AOAM5307Rn5S1gASau/4RWFCEKwBjipT/LzJVVfLrrXwPk9wuM2LGWTC
        CT5c9oELdGTj2Rm7SoLUYCFJecvSn0GQuuS0zo8=
X-Google-Smtp-Source: ABdhPJzHMpPnt7uYL/MI5aHqvNq4OZff0ExEYbg1aHdU3D7rW3O7H74nrK5k0jIGa55cj59CITK/W4VxTORa0bn/e7g=
X-Received: by 2002:a2e:99da:: with SMTP id l26mr5341096ljj.446.1591078978617;
 Mon, 01 Jun 2020 23:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200601161256.27718-1-artur.paszkiewicz@intel.com> <202006020549.F4anhkPI%lkp@intel.com>
In-Reply-To: <202006020549.F4anhkPI%lkp@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 1 Jun 2020 23:22:47 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5AKgHQaAOhqxd+4BEXL+Dc8SDiR+N27Y9AHnLXnjSQgw@mail.gmail.com>
Message-ID: <CAPhsuW5AKgHQaAOhqxd+4BEXL+Dc8SDiR+N27Y9AHnLXnjSQgw@mail.gmail.com>
Subject: Re: [PATCH] md: improve io stats accounting
To:     kbuild test robot <lkp@intel.com>
Cc:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        kbuild-all@lists.01.org, linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi kbuild test robot,

On Mon, Jun 1, 2020 at 3:03 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Artur,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on next-20200529]
> [cannot apply to linus/master md/for-next v5.7 v5.7-rc7 v5.7-rc6 v5.7]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the

I am able to apply this to

https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next

Please use that branch for testing.

Thanks,
Song
