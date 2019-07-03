Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 443EF5E3B2
	for <lists+linux-raid@lfdr.de>; Wed,  3 Jul 2019 14:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfGCMTa (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 3 Jul 2019 08:19:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54693 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCMTa (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 3 Jul 2019 08:19:30 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1hieER-0004xw-Ka
        for linux-raid@vger.kernel.org; Wed, 03 Jul 2019 12:19:27 +0000
Received: by mail-wm1-f72.google.com with SMTP id c190so497537wme.8
        for <linux-raid@vger.kernel.org>; Wed, 03 Jul 2019 05:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hl4IN+UFShyWybz5Y9nFx/v6kLwn65u0JGDKlBXalYE=;
        b=qH+Rm5px5WuXdBZ1ttnK6HGYrDMtL/VpbKmo/v7ApsoCW63P6kv2OA+0wDNLdMRRrh
         viXI8olYv02qZKWbli2Czs6NZ1Xx1vfkySMVIizUe/uAs0KOGDTnj8II1CdqhubofpQM
         t9AnyXPiqHw8UykLKXUZ3FjpZb45/fZnKAKIuDpLJDFtA5Tr1ZfSgEMpzqCJ7gXm1u3h
         zaHczEC805C93Dwx29dy4mSnctJCtlrkWD1QiKcwF+OrzU6XZRwRnKf1WdotTffMOamr
         PIyuaweCobR7zgYNwmu7pUI54cDB/vEZwkujNJtuPtcEx1dgshxlqkNa9TRF/2iXJe8V
         pZFg==
X-Gm-Message-State: APjAAAUw83cxYvCoWbHYWNmPWKCUpTf4ZED57ue9JVKWwntPMhR3jBAY
        fjUFuYmXsG5sWHy6QbAlR4Xw7yaisbJZIG7v5QBtKc1rd6OFMzemhZyRvmDBZlQbJNb+WtP34Sm
        qFnsoE8T3xB7UYdrjat1AHwXz4v0vLnPyKMoj1LDCDLyMHtqKOmfd9U0=
X-Received: by 2002:a1c:7304:: with SMTP id d4mr7806060wmb.39.1562156367411;
        Wed, 03 Jul 2019 05:19:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzWDxudz+dZ2eL2tgM1xv05DBOxBXD5d9mfD6trqmEZtBgjgFSRf5Jats2GQunAnlnOsWSWp007ri9L831lJAw=
X-Received: by 2002:a1c:7304:: with SMTP id d4mr7806046wmb.39.1562156367242;
 Wed, 03 Jul 2019 05:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190628221759.18274-1-gpiccoli@canonical.com> <20190703121700.GE7784@kroah.com>
In-Reply-To: <20190703121700.GE7784@kroah.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Wed, 3 Jul 2019 09:18:51 -0300
Message-ID: <CAHD1Q_z+V7NgL1cT3hWioWwWfpViNHDLbhpK=USbBnE=MY7X+A@mail.gmail.com>
Subject: Re: [4.19.y PATCH 1/2] block: Fix a NULL pointer dereference in generic_make_request()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <songliubraving@fb.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Eric Ren <renzhengeek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jul 3, 2019 at 9:17 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> [...]
> Both patches now queued up, thanks.

Thanks a lot Song and Greg!
Cheers,


Guilherme
