Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98210142E3F
	for <lists+linux-raid@lfdr.de>; Mon, 20 Jan 2020 16:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgATPA4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Jan 2020 10:00:56 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:40940 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATPA4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 20 Jan 2020 10:00:56 -0500
Received: by mail-ua1-f50.google.com with SMTP id z24so11579405uam.7
        for <linux-raid@vger.kernel.org>; Mon, 20 Jan 2020 07:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=TNscfkSPBdJitzZOMqIhTk/hkD5+UePoWSed3HBM6Js=;
        b=Jjk9iuznoR95M0TBINkyLN6do+0IGNZLOmIpBtbot4tbtl05i4RzmNU74tpEIg6a6E
         qiXzocKpvQzVuz/TlZ+E5uxYNc0qbyCjvszxXNdKfN0h2PtTpWsKzXb+sbT7F7E87JEL
         V4gkQsXZhHnX+jVugWCYSm0EZXPO15Q83LeYz1k1PWOEGbJ4u1gdhfLRD7A3wTMjGR+p
         Sb7Sz5rXwaCNorpCuDh1sbl2d6UoGYASbPZVV7sSoKEKzmH1lftgFfCK+P/hjFQYlOko
         G/RiLFzjInhi+uNQrvof6a9nQhZstTEoyk7mK9ucZ4JYaBUXnQb3owF/NNaMBjTERYkz
         O76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=TNscfkSPBdJitzZOMqIhTk/hkD5+UePoWSed3HBM6Js=;
        b=XA5axCHBBB6YrauqSCLFcvqUMdXPYS4lGoggoujgTKP7Eg6E1BjTfaePxfe/rz5Q2n
         G7S9uhPDHjPQ2UErCwfIdnLfudwyI5+1QAL7CjQkB5tgkB8c2YFGABo77gtfXhU5MS/o
         nGyNasyynXpwrWeJfzUKoppJU8XnnhoGqWsIi+qOe54fJhUkjzU2ld2iCxgNrcJ6YL7t
         zbLuegPUT88HHVVGeCohS5t3HGKGnXf06WA4EUaFpLoqsndFrY8NqE7V0NkLiWSW5A5N
         MhBQ+jdo/f91GOmFUKZQm+HKrkJ6Rw14RwwZX0omZstEA9a4Bh6GGJxpc8/m+/zxU6gC
         vIgw==
X-Gm-Message-State: APjAAAULCXC0hk10BHp+K6peGixS0voeSrMa8ZmSIQmz5DxxYAhArpxh
        5GqdjCWlO6nytysGhmQJpaohFb+ZpGV1YTSrQog=
X-Google-Smtp-Source: APXvYqxvj6s5LltdfDLrOG8RZOz/Cj0ur149q6LauLsqNURN/Pe4RtU4SEQyJAl7ySRSp9oxCP72onqsXmht91WKVA4=
X-Received: by 2002:ab0:6017:: with SMTP id j23mr91828ual.3.1579532455272;
 Mon, 20 Jan 2020 07:00:55 -0800 (PST)
MIME-Version: 1.0
References: <CALc6PW4OKR2KVFgzoEbRJ0TRwvqi5EZAdC__HOx+vJKMT0TXYQ@mail.gmail.com>
 <959ca414-0c97-2e8d-7715-a7cb75790fcd@youngman.org.uk> <CALc6PW7276uYYWpL7j2xsFJRy3ayZeeSJ9kNCGHvB6Ndb6m1-Q@mail.gmail.com>
 <5E17D999.5010309@youngman.org.uk> <CALc6PW5DrTkVR7rLngDcJ5i8kTpqfT1-K+ki-WjnXAYP5TXXZg@mail.gmail.com>
 <CALc6PW7hwT9VDNyA8wfMzjMoUFmrFV5z=Ve+qvR-P7CPstegvw@mail.gmail.com>
 <5E1DDCFC.1080105@youngman.org.uk> <CALc6PW5Y-SvUZ5HOWZLk2YcggepUwK0N===G=42uMR88pDfAVA@mail.gmail.com>
 <5E1FA3E6.2070303@youngman.org.uk> <CALc6PW4-yMdprmube0bKku0FJVKghYt4tjhep26sy3F9Q5cB4g@mail.gmail.com>
 <20200120084944.GA8538@cthulhu.home.robinhill.me.uk>
In-Reply-To: <20200120084944.GA8538@cthulhu.home.robinhill.me.uk>
From:   William Morgan <therealbrewer@gmail.com>
Date:   Mon, 20 Jan 2020 09:00:43 -0600
Message-ID: <CALc6PW5AmfFTYUzp74ucsiLGAOZ2HfSr839Vi=pQ1Peq-4eEFw@mail.gmail.com>
Subject: Re: Two raid5 arrays are inactive and have changed UUIDs
To:     William Morgan <therealbrewer@gmail.com>,
        Wols Lists <antlists@youngman.org.uk>,
        linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> One is the UUID for the array (starting with "06ad") - this is what you
> use in /etc/mdadm.conf. The second is the UUID for the filesystem you
> have on the array (starting with "ceef") - that's used in /etc/fstab. If
> you recreate the filesystem then you'll get a different filesystem UUID
> but keep the same array UUID.
>
> Cheers,
>     Robin

Thank you Robin, this is helpful. Can you recommend some place to read
up on UUIDs and raid arrays, or some general UUID documentation?

Cheers,
Bill
