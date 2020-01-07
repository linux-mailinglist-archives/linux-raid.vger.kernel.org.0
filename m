Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B758E132D25
	for <lists+linux-raid@lfdr.de>; Tue,  7 Jan 2020 18:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgAGRfn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 Jan 2020 12:35:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42092 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbgAGRfn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 7 Jan 2020 12:35:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id p9so23468478plk.9
        for <linux-raid@vger.kernel.org>; Tue, 07 Jan 2020 09:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ttJus1s1F1zGcCj/2hQpR/nI0fKRMomquO/5V3/jgVs=;
        b=Vp78XLAAlXG9TEpxpFzKvegCors8NdGKzOaq8w2Fv+9VKXcBN1sOswhgwEO2YTRcEX
         TDrB29OHmqib8zGoQncX6OHbpxgqTdB0nURgH6gYPXHtl7OmTtPFdejMRyt7hZlUVD+F
         5PHCF8SkmeeGk+uK6uqY0vYgqqQNWHrj7f8kWWtTcaoayeX3YHjEtblnPm+j7VDlqlkL
         HDliVa5OR9J8HL5O8BJdNlTEFvWbLoQs7RGPGaY43yksiwYNe/v2J8lK3kZ0HoRwusjX
         soH8XXYRGTsJ0+cuaeufAw5ODd+4Ns3peRSUCvVv7452lAzeGqZ8q5nrMoQME2jB5D6G
         eyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ttJus1s1F1zGcCj/2hQpR/nI0fKRMomquO/5V3/jgVs=;
        b=YtTC5wjGr5UyHGo664ooyhDiKD3sH3dFyuQG9vhvCvMkwWK7It2s40ZtMY444fS2Nm
         Avn/hh0GUtwAVzgaeWiGGnjcBL5OwVRH1WtpyWwI9Huyhyyoh1bYREQ97r8bSiY4Hg6z
         wSkyCFkv3fY31n5jVH6HKYkm+WMIiE/c36oHfG0QRLH4I+9a21bWlMWw6mq3NvFuK91V
         BUoMM+mtUQd6Ge5ffAhrQRbR6KrAUuMWAz3D7SucbNingxUR/3Iu4VRKb+eBC4KZuVYB
         8ZsfeE9J8KBBNbpOemB9P3hVt7x6IL0xGA7asyqj+ZdLX2bwcSxCmnyUB5zUDB/T4gZf
         cShQ==
X-Gm-Message-State: APjAAAUZ5uLItrEx3H3IKK+YdRAEPlPO51CC4qvWmDOzstEVdHy1lQaM
        TMZfoIz8VB4+bLky3ZltiUqKqlLtuah92ammt2qP0w==
X-Google-Smtp-Source: APXvYqxDJ33ZjqFAw+jfbkrG0hQ0OWjQSf16VWE6FUjjxMZ6vSIY1if3KKl5puetpcy11v9awauxeSkGDKwM+ExtpaM=
X-Received: by 2002:a17:90a:77c1:: with SMTP id e1mr934177pjs.134.1578418542439;
 Tue, 07 Jan 2020 09:35:42 -0800 (PST)
MIME-Version: 1.0
References: <202001050333.SnzanhNo%lkp@intel.com> <CAKwvOdmkhS+jmu9erpnqr6+bvxjQD7yxQSvs3scokJ42tkF4mg@mail.gmail.com>
 <8cbfa385-d3c3-b1b9-9bce-1ae109072904@cloud.ionos.com>
In-Reply-To: <8cbfa385-d3c3-b1b9-9bce-1ae109072904@cloud.ionos.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Jan 2020 09:35:31 -0800
Message-ID: <CAKwvOdnLE=wGut-Y4RZAyzdndEy=FPpcy0jHsf1FSCsrDJMTYA@mail.gmail.com>
Subject: Re: [PATCH RESEND] raid5: add more checks before add sh->lru to plug
 cb list
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     jgq516@gmail.com, kbuild@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild-all@lists.01.org, kbuild test robot <lkp@intel.com>,
        liu.song.a23@gmail.com, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jan 7, 2020 at 1:05 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
> On 1/6/20 11:29 PM, Nick Desaulniers wrote:
> > Apologies if it was already reported (working backwards through emails
> > missed during the holidays), but this warning looks legit. Can you
> > please take a look?
>
> Thanks for the report and will fix it, not sure why I didn't receive
> the mail from lkp.

The Clang builds are sent to our list and manually triaged for now.

-- 
Thanks,
~Nick Desaulniers
