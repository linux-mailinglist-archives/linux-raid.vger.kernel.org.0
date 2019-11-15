Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 028E5FD586
	for <lists+linux-raid@lfdr.de>; Fri, 15 Nov 2019 07:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfKOF74 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 15 Nov 2019 00:59:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35788 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfKOF74 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 15 Nov 2019 00:59:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id s10so3903131plp.2
        for <linux-raid@vger.kernel.org>; Thu, 14 Nov 2019 21:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R7sXsD4Dzr02PHfrr4Y4qbLiqVJvewEMr+U59hWZvqw=;
        b=eRtuB8IqfhJ57PgSQ8zmP4lYuqSeeZ3B1nlZsP1JG8A+QDtwKgKrWw7hJV26ipdke1
         oYff07jDK+bXIqgLfOZ1YjYocwXPJGmg1XtsCzTATtEVyaLA+0aWxzv3PlxfpFb3U6aq
         EXidjE8neuA7ifMkuPC80fAPT4JAOjoWKsqAXkmLQh5+SBEXteXsIzBhxj9uyFP3GEMP
         FxyCfumTKHT7DMfB9Q7ZkvNPkEzx/BbmLSVduVr3xKSvhaFF2A7Q/tBiED6D7bDClpYk
         5R4k1AwkpVjP44NXBNNBjapueD4WzCK8o0y26cplbuNdtWaBbQrnHRpGWDidXFTgZmEA
         N5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R7sXsD4Dzr02PHfrr4Y4qbLiqVJvewEMr+U59hWZvqw=;
        b=oiFwkYcJOkISduEgK7k6Iote/glysvZ3lv1+GgC25Fxg72GBpeiTPFb1IzkjX4Lrvu
         /22Er/L2zlXOzICOKgOivaLyZIjCdmpL44wvJ1mbe0n/zR1EoQmWIJmcdlAroPPQTsNw
         mtROAhP9Vjk1yXfVYTgFqHzKYl7lM9rcjraliJlwQEzWf7XrYdSjyNuhDJlCuSv72ER+
         kno/JPZiZgpn22bvZq9rmfJKbxYchQlkkP09CbXYwEOuW35xtPLPZwVjSSBAiUn4Rzl1
         9ebqzWu5VWX9JQyt6yp1/2FiZ7M4qotCQ/3zY6Zf++wXNTQM/oke/FdCWV2eXmbnijOz
         WRlA==
X-Gm-Message-State: APjAAAX2yyl6oCxfR+8saWRRXfsC4lSYjD42KaczHxaBOVLaPZloCHme
        iJDGQrPQ1B0aEUE2mEwLi73BpgZUUBM=
X-Google-Smtp-Source: APXvYqy5p9rZ5aa5Pv8u/gBuy//dnH121T+qLcEXOrAcerMu3wo4GEB7t6+2rokdyRHnuNNaMtVNww==
X-Received: by 2002:a17:90a:d155:: with SMTP id t21mr16824312pjw.84.1573797595402;
        Thu, 14 Nov 2019 21:59:55 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id h3sm8965689pgr.81.2019.11.14.21.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 21:59:54 -0800 (PST)
Subject: Re: [GIT PULL] md-next 20191114
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>
References: <3B22CE6D-0244-41C8-81EA-2FA72505FDCE@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <edd0f5d1-d678-8134-7760-f23c7841cb26@kernel.dk>
Date:   Thu, 14 Nov 2019 22:59:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3B22CE6D-0244-41C8-81EA-2FA72505FDCE@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/14/19 4:09 PM, Song Liu wrote:
> Hi Jens,
> 
> Please consider pulling the following changes for md-next on top of your
> for-5.5/drivers branch.
> 
> Thanks,
> Song
> 
> 
> The following changes since commit 15fbb2312f32cf99bd8e0247ac0240c9bce0ba47:
> 
>    bcache: don't export symbols (2019-11-13 15:42:51 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
> 
> for you to fetch changes up to 0815ef3c019d280eb1b38e63ca7280f0f7db2bf8:
> 
>    drivers/md/raid5-ppl.c: use the new spelling of RWH_WRITE_LIFE_NOT_SET (2019-11-14 14:59:15 -0800)
> 
> ----------------------------------------------------------------
> Eugene Syromiatnikov (2):
>        drivers/md/raid5.c: use the new spelling of RWH_WRITE_LIFE_NOT_SET
>        drivers/md/raid5-ppl.c: use the new spelling of RWH_WRITE_LIFE_NOT_SET
> 
>   drivers/md/raid5-ppl.c | 2 +-
>   drivers/md/raid5.c     | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)

Pulled, thanks.

-- 
Jens Axboe

