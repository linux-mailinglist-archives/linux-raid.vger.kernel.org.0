Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E995AA77B7
	for <lists+linux-raid@lfdr.de>; Wed,  4 Sep 2019 02:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfIDABD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 3 Sep 2019 20:01:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37860 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfIDABD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 3 Sep 2019 20:01:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id b10so3612327plr.4
        for <linux-raid@vger.kernel.org>; Tue, 03 Sep 2019 17:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RnuUMog/mqADgy4UcbFGn3fI0+nYFMOY2y8uUmfr9MY=;
        b=bGe1vE7vuoSCVHSa75d/I/FSCF5TTNllmTmQZBQqzIMSJ0k3jTWmetc7wjl/M21zPW
         DI/nGczG3tPSksZVBUGC0WxIe9QFFpjFca2NOWY3LzW3QmUj1+xjctBAhp0Kwi9zncJ5
         vw5y9rU5XMy27sGj4AcROCbuvVws98lfgEWWP+Vrrv/GlMawudT825eEkt72a2F03Qka
         OmNBlpbbaZxsAol65z/bcdOukIcri9rl/lCPClxrUc+DmarfYhaQXgBpse4z/0ClZxXI
         6PrNqXw8MVo25I1CN1oxOBZp7Tnuu2/xnuHZDJ88K6rupBlW0f1dsTFaH7TqJduHWbZ0
         Szqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RnuUMog/mqADgy4UcbFGn3fI0+nYFMOY2y8uUmfr9MY=;
        b=A0I8UZcnqE9JY5smEzYcZvjknAf7Ir8xu/4AKDF+tOC+9yjoKMOxVcalexYIRvLjc2
         IFlJvGxxRjf9rSPtOOXvakFD7iJb7IjcV5HoChW5J7x9zic6VhKTldW12DnsKwZQMNvp
         Rf1qNJm0G88wHJ3CZuPuhYMh5DzyEGHAEO8gTA446UnLVEcX//C3vidT5d/O7X6rIJ+v
         nyWdsH6RaooyVP0NMLoH2RJ+U4DBW2F6IFswma3ksjdDaE4SiTa6ug/i6foxMlx2PycP
         RV/+hAlUSI5x5KRYOlc5UORczEn8TlCOK2QS5W2fiw9hVzN1/enNLV1ow8VhXnxXiUj2
         ST4g==
X-Gm-Message-State: APjAAAVUd6ZJo5ye8U+ta7oWvqXLYpS8khPDGjsgTl5K845/JC79FF0C
        tvHdY8oDPK0u7FjeIMWDSeyFfw==
X-Google-Smtp-Source: APXvYqzzNRubWr4FjvVLXyReSV5RzpU13qQvE39A9lVOeFFmAQHw+0a57cws24RAdhCjW8VmIfe0dg==
X-Received: by 2002:a17:902:142:: with SMTP id 60mr38258121plb.155.1567555262237;
        Tue, 03 Sep 2019 17:01:02 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id v67sm31411511pfb.45.2019.09.03.17.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 17:01:01 -0700 (PDT)
Subject: Re: [GIT PULL] md-next 20190903
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Yufen Yu <yuyufen@huawei.com>,
        Guoqing Jiang <jgq516@gmail.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>
References: <F9513FD6-D5AD-485C-9079-FD320F4325AC@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b4955975-2956-6254-0e5f-67a54b44c233@kernel.dk>
Date:   Tue, 3 Sep 2019 18:00:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <F9513FD6-D5AD-485C-9079-FD320F4325AC@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9/3/19 4:00 PM, Song Liu wrote:
> Hi Jens,
> 
> Please consider pulling the following changes for md on top of your
> for-5.4/block branch.
> 
> Thanks,
> Song
> 
> 
> 
> The following changes since commit a22a9602b88fabf10847f238ff81fde5f906fef7:
> 
>    closures: fix a race on wakeup from closure_sync (2019-09-03 08:08:31 -0600)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
> 
> for you to fetch changes up to b0f01ecf293c49d841abbf8b55c4b717936ab11e:
> 
>    md/raid5: use bio_end_sector to calculate last_sector (2019-09-03 14:52:38 -0700)
> 
> ----------------------------------------------------------------
> Guilherme G. Piccoli (1):
>        md raid0/linear: Mark array as 'broken' and fail BIOs if a member is gone
> 
> Guoqing Jiang (1):
>        md/raid5: use bio_end_sector to calculate last_sector
> 
> Yufen Yu (1):
>        md/raid1: fail run raid1 array when active disk less than one
> 
>   drivers/md/md-linear.c |  5 +++++
>   drivers/md/md.c        | 22 ++++++++++++++++++----
>   drivers/md/md.h        | 16 ++++++++++++++++
>   drivers/md/raid0.c     |  6 ++++++
>   drivers/md/raid1.c     | 13 ++++++++++++-
>   drivers/md/raid5.c     |  2 +-
>   6 files changed, 58 insertions(+), 6 deletions(-)

Pulled, thanks.

-- 
Jens Axboe

