Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73BA611BC63
	for <lists+linux-raid@lfdr.de>; Wed, 11 Dec 2019 20:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfLKTBW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Dec 2019 14:01:22 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45878 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLKTBW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 11 Dec 2019 14:01:22 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so20518800qkl.12
        for <linux-raid@vger.kernel.org>; Wed, 11 Dec 2019 11:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fd5GtCKd+yqwa9RexV0SMSODQOu9qw0PW6fZ2+9WQ58=;
        b=B9ex8uPniop6arv9Gcv7zpXlxpkkwWjtTewEjkUp62UGZnWr3OB/aRynDXsZzZ+o7s
         T2IULVvrF9yvRcFqfXGbWCENFoKGLl5k+gqMk4oZfOPDL4dLMiIIGvQZX42UU1bzIgdI
         zNYTraaGJqJuZo4LFhcQnqwkXVZoF3ki+zCxyppMs9ROAZ9XttZfgdxalMv7INlP/tOx
         HGZiLG/ErOwnOUP567Nrase5drOX/LAGs8sAd08THV6vvqRF4eSmT2iPt9SA/eCmiLDH
         +msqvtr8ZKhCkGLVu8vlkPckGkkf5Ww5+S/d5arAM4Fc5vURa+hZIx63P2aHmyGBRIOg
         iEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fd5GtCKd+yqwa9RexV0SMSODQOu9qw0PW6fZ2+9WQ58=;
        b=bp+7hbRXoPzWwMceVs6DV5W4KYA2NiXffXRcmeerzKq/ia6rsti6aC6oXS8ogQpNtZ
         mYakgFBdTdQqBHnTUloMi+H8AGmPYAJO5dPDsiNdmnJJmYdY4pSOR7Lz9fAkTrKiyeu+
         /cyvFWaL58CZnyX81O+qLt+cSMFjcoCBha9PJPpwOM5XTYq7kNXqFL7KTvPBVFU21Lyb
         7e7KdHgkCSIaak5XgZa3631ps7ImxnGVx03eqCZehZLY59qnLFnCP2FCRYL0I1+8TOhF
         xeTNNvOWSIMbivAW2UNm0ur/o+ubANumcqo6ocVVeHL9aanlbBtX6bx2dL8RYYuNrZX/
         wxQA==
X-Gm-Message-State: APjAAAXDHltC6A17fwKnyLXeMVW0izuywRJYJmT3FF2ha0mWP+M5qpnM
        pOS2lL0/UJ4PJtaGxqYCedG2c7OfnAnWs3g5fFc=
X-Google-Smtp-Source: APXvYqwnAMq0LFjkOg6BDKQYlYGo/h3kkPfRQaROblD40jkrDq7GzeZL8RNktv5kgZvLw1OMp1s/vWIjmSFdWwWVxF4=
X-Received: by 2002:ae9:f502:: with SMTP id o2mr4202132qkg.89.1576090881539;
 Wed, 11 Dec 2019 11:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20191127165750.21317-1-guoqing.jiang@cloud.ionos.com> <2ab18390-7d0d-0b97-65f6-170ea0bf6e32@redhat.com>
In-Reply-To: <2ab18390-7d0d-0b97-65f6-170ea0bf6e32@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 11 Dec 2019 11:01:10 -0800
Message-ID: <CAPhsuW7CsaUy85DnrjJHgEGgG-kx9d3=HTfZsYxR-Fch8Ojq+Q@mail.gmail.com>
Subject: Re: [PATCH] raid5: need to set STRIPE_HANDLE for batch head
To:     Xiao Ni <xni@redhat.com>
Cc:     Guoqing Jiang <jgq516@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Dec 2, 2019 at 5:18 PM Xiao Ni <xni@redhat.com> wrote:
>
>
>
> On 11/28/2019 12:57 AM, jgq516@gmail.com wrote:
> > From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> >
> > With commit 6ce220dd2f8ea71d6afc29b9a7524c12e39f374a ("raid5: don't set
> > STRIPE_HANDLE to stripe which is in batch list"), we don't want to set
> > STRIPE_HANDLE flag for sh which is already in batch list.
> >
> > However, the stripe which is the head of batch list should set this flag,
> > otherwise panic could happen inside init_stripe at BUG_ON(sh->batch_head),
> > it is reproducible with raid5 on top of nvdimm devices per Xiao oberserved.
> >
> > Thanks for Xiao's effort to verify the change.
> >
> > Fixes: 6ce220dd2f8ea ("raid5: don't set STRIPE_HANDLE to stripe which is in batch list")
> > Reported-by: Xiao Ni <xni@redhat.com>
> > Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> > ---
> >   drivers/md/raid5.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> > index f0fc538bfe59..d4d3b67ffbba 100644
> > --- a/drivers/md/raid5.c
> > +++ b/drivers/md/raid5.c
> > @@ -5726,7 +5726,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
> >                               do_flush = false;
> >                       }
> >
> > -                     if (!sh->batch_head)
> > +                     if (!sh->batch_head || sh == sh->batch_head)
> >                               set_bit(STRIPE_HANDLE, &sh->state);
> >                       clear_bit(STRIPE_DELAYED, &sh->state);
> >                       if ((!sh->batch_head || sh == sh->batch_head) &&
>
> Tested-by: Xiao Ni <xni@redhat.com>

Applied to md-fixes. Thanks!

Song
