Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892F315133A
	for <lists+linux-raid@lfdr.de>; Tue,  4 Feb 2020 00:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgBCXcK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 3 Feb 2020 18:32:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgBCXcK (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 3 Feb 2020 18:32:10 -0500
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C28020732
        for <linux-raid@vger.kernel.org>; Mon,  3 Feb 2020 23:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580772729;
        bh=5JPofP/X/jyFVREJLeybeYnwApJj5RZaqr/2OSbtDmg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0SzB9ahB3BtZ0CmP6Mrsr8wHlFlBsxg8WlarJOjudjwUpMhOh9n9NEtM/ZumwXduy
         YV8Tm4XfaYVDJsmf0K3Szju0Pv3WineHUgciS8diUpzb5EkvJyJem/crvPwzK76QQS
         Yvi2secdwHiBeZmxYp0/RCZ4l6bgLugef30S7EUs=
Received: by mail-lf1-f42.google.com with SMTP id y19so10919654lfl.9
        for <linux-raid@vger.kernel.org>; Mon, 03 Feb 2020 15:32:09 -0800 (PST)
X-Gm-Message-State: APjAAAUh9d6aND+CK4729MwfdsrRBhRbMR7Q7o6jXGtwrGEBNtHJq7fx
        ODxk/RK+oTD4IhG3lPD9aHh9eNXBTHpPY5H7lhs=
X-Google-Smtp-Source: APXvYqyYrf576toNn6ZmLWpmX/c792xEpfDvxXoyxZv9KBreo9KneURLSeINJ3RGRps8fqQx8o79+7nsX8n8kAnfZlI=
X-Received: by 2002:ac2:555c:: with SMTP id l28mr13130560lfk.52.1580772727515;
 Mon, 03 Feb 2020 15:32:07 -0800 (PST)
MIME-Version: 1.0
References: <2ce8813c-fd3e-5e78-39ac-049ddfa79ff6@icdsoft.com>
 <CAPhsuW4Jc-qef9uW-JSut90qOpDc_4VoAFpMU8KwqnK7EeT_xg@mail.gmail.com>
 <ac3ae81d-8dad-8b4e-bc61-fc37514e3929@icdsoft.com> <CAPhsuW4JJiDroE33m0=XE9PxtUOncK3--waY_zxxbAT9j+1m6g@mail.gmail.com>
 <cc483055-45de-4bd2-8a4f-71e9c8ed6b90@icdsoft.com>
In-Reply-To: <cc483055-45de-4bd2-8a4f-71e9c8ed6b90@icdsoft.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 3 Feb 2020 15:31:56 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6wZ_n1BVP6+nZ12MgnkM1OgmzSs+KeC0tGDvX-RG3KvA@mail.gmail.com>
Message-ID: <CAPhsuW6wZ_n1BVP6+nZ12MgnkM1OgmzSs+KeC0tGDvX-RG3KvA@mail.gmail.com>
Subject: Re: Pausing md check hangs
To:     Georgi Nikolov <gnikolov@icdsoft.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sat, Feb 1, 2020 at 6:26 AM Georgi Nikolov <gnikolov@icdsoft.com> wrote:
>
> The output of this command was empty:
>
> cat /proc/$(pidof md2_raid6)/stack # md2_raid6 process was consuming
> 100% cpu

Hmm... This is weird. Could you try use perf or some other tools to get insights
on what the thread is doing?

Thanks,
Song
