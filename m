Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4DE5139BC5
	for <lists+linux-raid@lfdr.de>; Mon, 13 Jan 2020 22:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgAMVlh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 13 Jan 2020 16:41:37 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:41413 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgAMVlh (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 13 Jan 2020 16:41:37 -0500
Received: by mail-io1-f53.google.com with SMTP id c16so11503218ioo.8
        for <linux-raid@vger.kernel.org>; Mon, 13 Jan 2020 13:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pWazVMOmHzaOUtcU+FiUiw5RhB3z9UoELGtPgC0EWiY=;
        b=IERLt5Dzc1vlVv8tMQtfyXzxYzce2ZWpA72GSXT9450fBnHXvvNCCfiJkH29mvl7qv
         798lUflsM5skZMFIwYXQgwgiDBaz0dqyqG+Nx09SFYvzSlQyqBbGznuAiV7VFoWVBYas
         QU+UzQEm+qaxjQtOmsSur11trFFjKN4EdRe7AcFlHmbk+RIvIsaXGgOMSOOENTNjboru
         J6d6I9hJ7KIxamtNUSkylNlSvJYokuCDWFF0I7xebDGsLZZOysfam8WOjSqGBBFlqrfz
         7rq20Su9n8t86wxxny6MBH1kg9KL65OPLn7vbcG77p3XGQ1jfur0w2K7teIu9vyCAOcx
         r+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWazVMOmHzaOUtcU+FiUiw5RhB3z9UoELGtPgC0EWiY=;
        b=U8vXTnFuL5M1QAMUQLMfG05tib6Wo4EmEPTEbOqfyLjYFN01i2NZSQVVfblxUNNCXd
         mG7R1Lm4loNaXMlWuQoYY43teW1zeSt04IoEkEdBtNbSYQxfC8h+CEVMvZ1IL+hXplzk
         OuvMFS4ykg9nSTzOKRcKNC/tFwFAk+8D4ea1gVghz8FkOsBWpZzWT8jbzOKKCtzpc+je
         2aueKD8PMMZHftkasokB2baKGMrenLgyar6y4z5+KB1f1pHRxo/jGIHQaH/uE5bScpUE
         dCTbL+rWbOenxtgV0rjRucKEOaHvCm6poTOjUQisbdS900j96+wrQdAn24BcPbmyuGoS
         MH1Q==
X-Gm-Message-State: APjAAAW/YmoDZnF+MqLtMUII71uOG3XqulHu1LnMwD+p929igXwkAiEq
        yPo0AezGT9jfcv/UDt++EsAcG7V1jAERtWGw0hk=
X-Google-Smtp-Source: APXvYqxZeZlCxIuPAVJ6nlbCoCwNlZ0XsgSjpxTvTGEftmi0aiYSRVfkp5w2PVZfIfGIjomOMVVZrY2fKJLsT9d/izI=
X-Received: by 2002:a6b:6118:: with SMTP id v24mr14598612iob.73.1578951696654;
 Mon, 13 Jan 2020 13:41:36 -0800 (PST)
MIME-Version: 1.0
References: <CAJH6TXhnkB10BUENn0P+qXy4nunwY6QVtgDvaFVpfGDpvE-V=Q@mail.gmail.com>
 <CAPhsuW6srGADYYD4dsUbVVBcz4bfJ-taoOy6ccpXjyU26jVTEg@mail.gmail.com>
 <20200113181654.GA7645@lazy.lzy> <CAPhsuW6urOBa5s9od-znfn9J2jhz3cCOxmqu6tABvyoCEx5BHQ@mail.gmail.com>
In-Reply-To: <CAPhsuW6urOBa5s9od-znfn9J2jhz3cCOxmqu6tABvyoCEx5BHQ@mail.gmail.com>
From:   Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date:   Mon, 13 Jan 2020 22:41:25 +0100
Message-ID: <CAJH6TXjN8V4a4jE6AECCg=quMd9FPA=ST0_9ZtZcGKUzvY5wYg@mail.gmail.com>
Subject: Re: dm-integrity
To:     Song Liu <song@kernel.org>
Cc:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        dm-devel@redhat.com,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Il giorno lun 13 gen 2020 alle ore 19:58 Song Liu <song@kernel.org> ha scritto:
> Right now, md_done_sync() doesn't really print any message. I think this is
> easy to add. However, md check/recovery is at block granularity, so we
> probably cannot print exact which sector got fixed.

Well, having the exact sector fixed is not mandatory, but really useful.
Better than nothing would be md logging that has fixed "something" and
it's location (a setor, a block, ....)
9 times out of 10 the dm-integrity log would be just above the md log,
so a match between dm-integrity sector and md block would be easy,
just read the line below or above.

I think that md should be a little bit more verbose on certain
actions. (in example, saying what was fixed, the last time of scrub
and it's result, as per my previous thread and so on)
