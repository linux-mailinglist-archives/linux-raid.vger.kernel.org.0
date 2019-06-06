Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8089379FE
	for <lists+linux-raid@lfdr.de>; Thu,  6 Jun 2019 18:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfFFQsN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 Jun 2019 12:48:13 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45133 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFFQsM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 6 Jun 2019 12:48:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id j19so3394979qtr.12
        for <linux-raid@vger.kernel.org>; Thu, 06 Jun 2019 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4HjPk0HZbZ8VrTFXb3u0kLmnsEJLAxPJVjLqsGdcTNw=;
        b=eMiHjZJ03LnSOKfY6g1Y9tseek5PMJ66bnDsx6Od5Wl0GFeX7fk+Cc9dUPez2Ti1ZK
         9Sj8xxDwqmodtvnbIwp3RFf4YSxaUK0txJ9+3ixkrFzwIIjwbpW1XXrdjCUKeWKsKYUy
         eIIqfzs+qwSw1c3JxMxwxSIq5AkcRgIp+zbDFXRscTbL5bcxW6v0tO0B1dQZeoqfPrIc
         Pjqs4u4lripV0RtncR8MY8BPRQrbs0M8FMNrWIBsJEt02JWyNtIxF/pPYdk8YK6+I4FZ
         o6tllQ0zW3o1bt71SabRcokdQrGPbT8aFA7bs+B+2sKaeI5eDUfYM5lW6mMD0+inJsTh
         //nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HjPk0HZbZ8VrTFXb3u0kLmnsEJLAxPJVjLqsGdcTNw=;
        b=PF+dAZqb0d116vqNBcIFbwbB/M7JvpjcKOzUk2KkM+pOxBi5UCTLTTtAj08P9dsuJP
         0TXbjGx0sqhaFKLiA2OwzKEbiJUh7rXbmbmuyRgIgWTyvrHbv6DH9J9gdgWfpxrGqYHN
         NEef0By3VRQFUZuciZcqZuu0laqo+FALsHrDHQo13mssgDHosv7FJb8iNXHSl2xNvA31
         71339bAa0r3o1eD1DAo9qOE0M7XAld3vpk+6hBC4BnaAhiP37mxk/8+D43/6NhLPrtSV
         FdNB5t7Q6aPGSwxxROdcqx2a6QvZTHplWPww+42jfkrgD6CD0DYlNXFE0i5bGI2HbGZF
         Yr1w==
X-Gm-Message-State: APjAAAXqEyfgDxQtObZMret0NUScn41PAMJ8mRy5TwOgKXD0SNDVJ6Le
        CQ5IeLZgqUR+20obL2S9qxahJ0hF1RqdZs10o7hnwA==
X-Google-Smtp-Source: APXvYqzDteV72FTyHA3rM7OfF/hpfLQ7depQPxQde4OoqVVN0hukKZc6UrFJXHZYCTxxYqpqjETx1JpPBrSD4LX88mo=
X-Received: by 2002:ac8:25e7:: with SMTP id f36mr29946309qtf.139.1559839691860;
 Thu, 06 Jun 2019 09:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190606142918.36376-1-yuyufen@huawei.com>
In-Reply-To: <20190606142918.36376-1-yuyufen@huawei.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 6 Jun 2019 09:48:01 -0700
Message-ID: <CAPhsuW6Du8919+6f0pNUVbiANqjQpEk7j-8NS7KLg12NYW57jQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] md: fix spelling typo and remove extra blank line
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Jun 6, 2019 at 7:11 AM Yufen Yu <yuyufen@huawei.com> wrote:
>
> Hi,
> This patchset fix a spelling typo and add necessary space for code.
> In addtion, we get rid of some extra blank line and space.

To be honest, I am on the fence for changes like these. For people
who use git-blame, these do make their work more difficult.

I will put these patches in my tree for now. But I may take them off
if someone complains.

Thanks,
Song

>
> Yufen Yu (2):
>   md: fix spelling typo and add necessary space
>   md/raid1: get rid of extra blank line and space
>
>  drivers/md/md.c    | 11 ++++-------
>  drivers/md/raid1.c |  9 +++------
>  2 files changed, 7 insertions(+), 13 deletions(-)
>
> --
> 2.17.2
>
