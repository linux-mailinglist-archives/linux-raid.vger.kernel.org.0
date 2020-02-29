Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E2A174895
	for <lists+linux-raid@lfdr.de>; Sat, 29 Feb 2020 19:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgB2SI0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 29 Feb 2020 13:08:26 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:44790 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbgB2SI0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 29 Feb 2020 13:08:26 -0500
Received: by mail-qk1-f181.google.com with SMTP id f140so6230377qke.11
        for <linux-raid@vger.kernel.org>; Sat, 29 Feb 2020 10:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=2QXL3G7EH+3aTVdqZts7jPQFCK2RH8LR06qQsubiVHk=;
        b=UkoWI51L4iXGMqaZg6cIohrcn3+ewZBVgyEYbEOsl46T4VzMsjnaDX0zgm1vtd9nRd
         H3jRw2ZWLx9XHreMJZXmXgfqmblKfK2voBpwHgXX9NDqi5kMoN1tDVBmzWwUf/AR2nzj
         n68JToA1t3epwcXRB88amPpBlXsg9mfE5twhNuDN7r0DWxmT02rE787cPUbWTBi/Dj5x
         Ujyc/a7vdy8id6jyrZgOmv6aMn3wDCSbKlPfaWbr/bPixq8tZS/R3S1UKzPh4/eQjhdW
         wvozeZ9pewHJKXUCXYWZD8Qwqvyiz/KeyOYpQGBOHJqjPqQSUVHCyscEBLjltgToMV1t
         O+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2QXL3G7EH+3aTVdqZts7jPQFCK2RH8LR06qQsubiVHk=;
        b=KcD0oiO5XMsfOQ/jORwkAFB67DJND/ya/WRZuLs2LHG+3WAdQblQUpp9jA+5I+TOy5
         NegVXaJI6CL2jObFt6h4LDdEie8eKnCdZpTf8LpGmpW4t1rf9ErK/9flPLUlQP9uGnUi
         tC7i2kYIRz3Za4gFVzwpO6kFZNTC2CNucFQO7V17v04dAZjYJ9SV7WxyESfM4dHx7l7B
         E7wz/r6GlJamZwDsV1lLBbarEHTu81JP5XEKrzSa7K076M76P1E836dldqdwNoJIowzW
         sJj6u6kZGP9l4W2HE9A/NgEw/xB8eYvpHzuZN1wWA118BijJfoiKmV/h0NsIXr3HIPSa
         JLAw==
X-Gm-Message-State: APjAAAX6j73px1aN8ZezJOvFjEDMShYDvHFz6wBcRqm9TjFId/sVBNyx
        fDNrRqBmPz5XXDyzs0mj4TaK2322shDpbdXGXY0vqw==
X-Google-Smtp-Source: APXvYqxYu/iAHq9mTXYigM86UXu68nj3aBb7fCjhMOAAn+/Mppepb85JZb1wNbblBGOvYtXvl7s6kF7vxc8rK6BhaLs=
X-Received: by 2002:a37:4dc6:: with SMTP id a189mr9667013qkb.122.1582999704781;
 Sat, 29 Feb 2020 10:08:24 -0800 (PST)
MIME-Version: 1.0
References: <CAG6BYRzw4i6mtTfEVnMpwGAVW0r=BwODiN+0o-UggiaEyo4VSw@mail.gmail.com>
 <5E5A2C65.3090006@youngman.org.uk>
In-Reply-To: <5E5A2C65.3090006@youngman.org.uk>
From:   Hans Malissa <hmalissa76@gmail.com>
Date:   Sat, 29 Feb 2020 11:08:13 -0700
Message-ID: <CAG6BYRzUw=QOegxd8DmNkyUb-oCQgiz-_GHzkJ1-284G6AoB7g@mail.gmail.com>
Subject: Re: Choosing a SATA HD for RAID1
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sat, Feb 29, 2020 at 2:18 AM Wols Lists <antlists@youngman.org.uk> wrote:
> I notice that the WD RE4 drive is listed with almost exactly the same
> model number you give. It also looks like these drives are known as WD
> Gold, so it's extremely likely the drives you are looking at are okay.

Thanks a lot for this information. WD's product names are confusing;
could it be that Gold is a newer version of the RE?
Greetings,

Hans
