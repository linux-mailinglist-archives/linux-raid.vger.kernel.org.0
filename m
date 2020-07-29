Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CA22317C9
	for <lists+linux-raid@lfdr.de>; Wed, 29 Jul 2020 04:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbgG2Cvd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 22:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730407AbgG2Cvd (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 28 Jul 2020 22:51:33 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 507892076E
        for <linux-raid@vger.kernel.org>; Wed, 29 Jul 2020 02:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595991092;
        bh=6n3e6vuKQvb/X1WMseHb/QrAq+uK3dRcdwgHb3/yCk8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BZMyhEJOqsdxkJ7GOGBSV+Sguxnf+rpl03ezfGSw0CX7JgmL0lEmU9vKg37TB22xf
         r8gsRgfZkhjCdrRlI9cJdvl/Rb9Ik/Q4MRI6Le2Hna3Q52b8DwP7piJueI6NJjgFke
         7h2ny2GtdyFShhZb1aFeQRaAEdyUMEhxTyR+GdSA=
Received: by mail-lf1-f47.google.com with SMTP id h8so12136048lfp.9
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 19:51:32 -0700 (PDT)
X-Gm-Message-State: AOAM531vdss8xXUaVoGt7Hq2J3Tmlu5F71ZsIdctOXoWjIr4tZn6Ujsg
        eqb2VPS9/1JiHCFUHw4yOar318v2F0ukhnqphmM=
X-Google-Smtp-Source: ABdhPJxcFv+AZNS1XPnVCV8vW6+xzhWdoaMWIDy4igrt45WizcffuH1/HXt4+Q4NJrRMiVVEk4OPqySw3EpuhtibQYQ=
X-Received: by 2002:a19:7710:: with SMTP id s16mr15972137lfc.162.1595991090590;
 Tue, 28 Jul 2020 19:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <1593503737-5067-1-git-send-email-xni@redhat.com>
 <1593503737-5067-2-git-send-email-xni@redhat.com> <CAPhsuW7WY7kQ77BKBqev2CVFPS63C7u0HtBqkB49XtbRCysWmg@mail.gmail.com>
 <9626595c-cdd8-f46d-629e-67f9b11d2b6a@redhat.com> <CAPhsuW5RAEb7i-VQ+MS0XfGKNyd=2_=VoGVjk2SU6A30cW9PKg@mail.gmail.com>
 <22684ab9-7c20-f0a3-4045-3357bbf53125@redhat.com>
In-Reply-To: <22684ab9-7c20-f0a3-4045-3357bbf53125@redhat.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 28 Jul 2020 19:51:19 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4Vty+k1gS_Eiw7=2a+pGoPnGAS72wmt1U7PimeMnMWUQ@mail.gmail.com>
Message-ID: <CAPhsuW4Vty+k1gS_Eiw7=2a+pGoPnGAS72wmt1U7PimeMnMWUQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] super1.0 calculates max sectors in a wrong way
To:     Xiao Ni <xni@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Nigel Croxon <ncroxon@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jul 28, 2020 at 6:15 PM Xiao Ni <xni@redhat.com> wrote:
>
>
>
> On 07/29/2020 08:43 AM, Song Liu wrote:
> >> Hi Song
> >>
> >> This calculation of bitmap is decided by mdadm. In mdadm super1.c
> >> choose_bm_space function,
> >> it uses this way to calculate bitmap space. Do I need to add comments
> >> here to describe this?
> >> Something like "mdadm function choose_bm_space decides the bitmap space"?
> > Thanks for the explanation.
> >
> > I merged the two patches, made some changes, and applied it to md-next. Please
> > let me know whether it looks good.
> >
> The function super_10_choose_bm_space can make people confused. All
> types of super1 calculate
> bitmap space in the same way (super1.0, 1.1 and 1.2). Could you change
> the function name to
> super_1_choose_bm_space?

Updated. Thanks!

Song
