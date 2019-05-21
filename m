Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 802B6256D6
	for <lists+linux-raid@lfdr.de>; Tue, 21 May 2019 19:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbfEURiP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 21 May 2019 13:38:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48671 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbfEURiP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 21 May 2019 13:38:15 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1hT8iL-0006rV-4w
        for linux-raid@vger.kernel.org; Tue, 21 May 2019 17:38:13 +0000
Received: by mail-wm1-f72.google.com with SMTP id q3so669873wmc.0
        for <linux-raid@vger.kernel.org>; Tue, 21 May 2019 10:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcNXBZFJb+DLhnDXLU3vOO28yF5WtLq1sqqHjjzYzVE=;
        b=LU1d8v1WFdLURalJ8JrO+6aYGle1x4FEwNYmrGCiM3olrVzN09Qvtlp4rBzWsOeaqT
         cT1x9caaxAIZWqW7wPP/4PObUaWIvbi/AtPD+8xpiIcW+1lKri5YQXeKruGWJBcCvxYF
         /f5UPMZB1Q6oL9gxzY5AXUbGIBokzC7ECMtsRDqwW5ImuFwqLt1tAVY+UF2pL0sPceOI
         YicBlkvtQpLaE7jSOz7KH7DCKSSrPwADF0GzwjEL1BkXKgC0vS9pUa4wO2HHRzwd26r7
         cMeMPHtgmCF6MiBsleo27D92zbrQQTe3Fs8p7uanAkefOT5DLCgcPzrFw8wQANUMaqvr
         OAwA==
X-Gm-Message-State: APjAAAUXvL5Bjf4r5WA4b3NrH+GGZnCqjjKrgvYPdnnCUsMQhR3Zenz7
        QkKkSIdYcCo35dIztjI6neN7PjC0GN8O4tBM4vHrI95Mo19AtMIvpvw4xJ7/06wG6b7KAf6fkt9
        8gXpWtzp0/vP5nuI6g5bBm7nrrYe24dy+/Q7GJz7uygIwNRhk4+vNyUM=
X-Received: by 2002:a7b:cd0e:: with SMTP id f14mr4127767wmj.127.1558460292820;
        Tue, 21 May 2019 10:38:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw81v2o+MMfWEy/WTk62q4WO4dG0iEhjtk0hLe0Eaytx5oKhO+Tt7BlfcmAgqlKnhfh6p/m/uVVK26fQg8gQI8=
X-Received: by 2002:a7b:cd0e:: with SMTP id f14mr4127752wmj.127.1558460292640;
 Tue, 21 May 2019 10:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190520220911.25192-1-gpiccoli@canonical.com>
 <20190520220911.25192-2-gpiccoli@canonical.com> <20190521125634.GB16799@infradead.org>
 <CAHD1Q_z23AO+NRid1xYTeke_5GAe6hPianEZKBf5P30FrfZGFg@mail.gmail.com> <20190521172258.GA32702@infradead.org>
In-Reply-To: <20190521172258.GA32702@infradead.org>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Tue, 21 May 2019 14:37:36 -0300
Message-ID: <CAHD1Q_zgBxE-nD6zY4koJGJC9K53+6d6-xGpEpA6W4sudu0Pgg@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] md/raid0: Do not bypass blocking queue entered for
 raid0 bios
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>, dm-devel@redhat.com,
        axboe@kernel.dk, Gavin Guo <gavin.guo@canonical.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Ming Lei <ming.lei@redhat.com>,
        Song Liu <liu.song.a23@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, May 21, 2019 at 2:23 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, May 21, 2019 at 11:10:05AM -0300, Guilherme Piccoli wrote:
> > Hi Christoph, thanks for looking into this.
> > You're right, this series fixes both issues. The problem I see though
> > is that it relies
> > on legacy IO path removal - for v5.0 and beyond, all fine. But
> > backporting that to
> > v4.17-v4.20 stable series will be quite painful.
> >
> > My fixes are mostly "oneliners". If we could get both approaches upstream,
> > that'd be perfect!
>
> But they basically just fix code that otherwise gets removed.  And the way
> this patches uses the ENTERED flag from the md code looks slightly
> sketchy to me.  Maybe we want them as stable only patches.

OK, it makes sense to me, if that is a possibility. The fist one is
clearly a small
and non-intrusive fix. The 2nd indeed is more invasive heh

Please let me know how to proceed to have that added at least in stable trees;
this would help a lot the distro side of the world hehe

Cheers,


Guilherme
