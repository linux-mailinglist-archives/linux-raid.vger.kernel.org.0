Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBDC57174
	for <lists+linux-raid@lfdr.de>; Wed, 26 Jun 2019 21:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfFZTUu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 26 Jun 2019 15:20:50 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45658 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZTUt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 26 Jun 2019 15:20:49 -0400
Received: by mail-qk1-f195.google.com with SMTP id s22so2625813qkj.12;
        Wed, 26 Jun 2019 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lkGzhJZUrTj0+tmgK0Jf0WPXCaJE0CvyVAstdFUye6Y=;
        b=fO0WnKAMPAv8VSrgkto9CPT6w4KhA7FqFFxonHN0eY6MqmF7RX6/DpKmWM7xgTj4J5
         3wRHDbvH+CSGzPq0isjpvBjNYQWu2E7NIUhVC0t0qlkApA6myrcM3ZqT20Knb95Dasic
         RhARbyDUVFrjypENQUPnzuGVu6vag5LtO0voJ56RrBMSAymrMPesrwm8LUz3eIGS5BVq
         gnRH9Nha6w04nsyGxhSHJo9F5XMO4aiTmlDi2053nQ6b+7NfMWdBUOKN6Gw/r2PyT9cX
         s+ZrmfNe/Gqi0wn3TMdKWuDXaUrBbRmXb5IPI4DJkEkEbnoHjSw/x5yH6X2841cx4bp3
         fXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lkGzhJZUrTj0+tmgK0Jf0WPXCaJE0CvyVAstdFUye6Y=;
        b=RBM1UP7TsPdhPX9myel9z1xKCaKkXBFjjgM9jnw0nZPC03VK99OYhVnNUG7Fm+aVQq
         beRtU6ZZMjiLsMurAVQBLu0u/94TzUSxWgIM9nuB4b6NwXr53D10Ve5ATBA+2XO9qtO2
         VFXi/BbmMy7vG46KdrtmwhLVuvX+Nxi3qbIbgY7kw8sia9xXMb77FeTwtm2CH+uSDsgd
         Sm3OCkkt6bo17KPZk7+gucokcCyDVe8y3/GOabq96TdUIQSAprpkmUqDf5QvRNLnM8tx
         3Y95ZTcLTd5poIVRPXI7b1zqbUp0cgM9GQbWkJby6HXMdqwp6umjVNEizamO6w4KpSfE
         cfJg==
X-Gm-Message-State: APjAAAVpWz9WEb9B9SRi7DSlyyVRUcCRz262lJB/q9MhbZxv5nyrf/rT
        KVG8tyRCOPrVcj0WqITUy9m8nr5DT1CI3WBFIBHktw==
X-Google-Smtp-Source: APXvYqwjrYshLpMOhKGVzHfqqsPisVSXhrIVM8zGkLp0TbD1AmjvzOERC2n6CuTc8lyuLWegXnjlycNeNk3Eo5T1HrU=
X-Received: by 2002:a37:4d82:: with SMTP id a124mr5323292qkb.72.1561576848807;
 Wed, 26 Jun 2019 12:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190626094251.GA3242@mwanda>
In-Reply-To: <20190626094251.GA3242@mwanda>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 26 Jun 2019 12:20:37 -0700
Message-ID: <CAPhsuW7p14K=6Q7YSxFqKY7j18kyTbP6LwQPt4Ckfx5wZ578pA@mail.gmail.com>
Subject: Re: [PATCH] md/raid1: Fix a warning message in remove_wb()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Shaohua Li <shli@kernel.org>, Guoqing Jiang <gqjiang@suse.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jun 26, 2019 at 2:44 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The WARN_ON() macro doesn't take an error message, it just takes a
> condition.  I've changed this to use WARN(1, "...") instead.
>
> Fixes: 3e148a320979 ("md/raid1: fix potential data inconsistency issue with write behind device")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied. Thanks for the fix.

Song
