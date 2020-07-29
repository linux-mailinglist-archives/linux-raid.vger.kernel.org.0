Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50247231712
	for <lists+linux-raid@lfdr.de>; Wed, 29 Jul 2020 03:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgG2BO2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 21:14:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgG2BO2 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 28 Jul 2020 21:14:28 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8F9020829
        for <linux-raid@vger.kernel.org>; Wed, 29 Jul 2020 01:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595985268;
        bh=oRGDc/HpGJ0clnP7zTvGg+kVz+w3QFGBAHljclzLfQI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GCMBGBQNO2CXn/mOs5SOqnBS89kjSpZtIa+ni6JCw9rNB3EJ9o+1hY2TnxUYoZy39
         4B0EtGCc5spkyev7nfM7TtbU9AYk5FhoEoXEgnDIN42YUKk4r4ONbQ/OdfQbZETd+P
         DwbMJPO462iwT9Es+K1zSRI8grXVRKBnSlcFYYgA=
Received: by mail-lj1-f181.google.com with SMTP id d17so23216753ljl.3
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 18:14:27 -0700 (PDT)
X-Gm-Message-State: AOAM532qzvAKJHAg1QlaN8AdBuLSI/H6lbkXTj9FZrgzacO+5wqTbE6t
        Tj0GpQ1adpqqBe9VbUQ3PbfxHaGlDytWyI4dQqQ=
X-Google-Smtp-Source: ABdhPJyCm/3LiO4RMUSRHxv5VMul3xTnbDmVjLW9jWgwn6UtDXiMSWfxOwWwugQ9aR51fVD+2kqEgOB8ITbr5vQAO6s=
X-Received: by 2002:a2e:7c14:: with SMTP id x20mr13807626ljc.41.1595985266144;
 Tue, 28 Jul 2020 18:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200728100143.17813-1-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20200728100143.17813-1-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 28 Jul 2020 18:14:15 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6xOwv134mKX9amtcC1nTz1QTJ=Y-9P14pD2mX6CTBrcA@mail.gmail.com>
Message-ID: <CAPhsuW6xOwv134mKX9amtcC1nTz1QTJ=Y-9P14pD2mX6CTBrcA@mail.gmail.com>
Subject: Re: [PATCH 0/5] misc patches for md
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jul 28, 2020 at 3:02 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> Hi,
>
> Please review the patchset which has quite small change, :).
>
> Thanks,
> Guoqing


Applied to md-next. Thanks for the fixes!
