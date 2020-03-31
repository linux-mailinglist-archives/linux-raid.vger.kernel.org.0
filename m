Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E56B19979D
	for <lists+linux-raid@lfdr.de>; Tue, 31 Mar 2020 15:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbgCaNgz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 31 Mar 2020 09:36:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35834 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbgCaNgz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 31 Mar 2020 09:36:55 -0400
Received: by mail-io1-f65.google.com with SMTP id o3so16126309ioh.2
        for <linux-raid@vger.kernel.org>; Tue, 31 Mar 2020 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iowni-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSw57Azi9wSg04NvXfn6I3V1xvzvSNsg+TrrSPQF4BA=;
        b=EfwtdAj4K5h57gcf90WOw9gVl1O2z4hseJ0iiF5MiyfYXtysk6vGzhbJdIJ4XiHs8E
         vKrcMvWhGSwzpomdJMI5ivr9XiQTqMZxVC6MCOGivcMOhn1lWCy6X32ZOD34n8g4PSt2
         Si84ozQx2yhsYEANTlGEgwY5osid3YdSPV1Vtte8vf+W+EbiD7yZw3S05kce3K62xa1I
         V2Fnwy13EqNp9I5XZ+JUXm8MJsFQtYRy4Lif+GPookS9bbGXwWta0vXUQTnWVJErpc/n
         peL1yeE1qGyY0BW0Eus2Qr1KgsubHk31yea01dDr1ZOImZog4Jbtv9kVRCxfQjwFKcs3
         SuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSw57Azi9wSg04NvXfn6I3V1xvzvSNsg+TrrSPQF4BA=;
        b=eZMMLWoH1mSNi3UKzEXhel+wYyI9CBAzTNG2y+ONnApeKe65+vC8nCzypgzY+gn7AH
         nbgjlorKaDs28i/J5y3eft8YtlQ+gMzuT3uckhopsFdBsnJgRxdNZI7gVsaoVzPEVyJ/
         GXr5c9mSlsuWaEwB0BcqHV2ftp0iFHLe4SEuCmNusRQPR+LMhtH4eA7XdCUu1RiJ5+Qs
         o//CkBV9SBkXor1sBRH+sMhciBnWRABLOLmjVMW9K37ZQxY/kkw1Aj0XVgsAREwa7d92
         vY6lW6Wa2U986Qna7D2zmPD4C7T1h6CM/hc9aoQqnTPtGC9LIDBWKThzflz0hIUF5pLY
         G1qA==
X-Gm-Message-State: ANhLgQ3U3pVZZioGGqOeO3zGgMD7d5Bdun1vIuvX/8qVKsH+5wmFWtZF
        d3ooCDwBzJLw+YL90Yi3XPSIwXVWkjCjIj20EIx9avjr
X-Google-Smtp-Source: ADFU+vsisjQw6EhNfAQ3L+5jB3eKEoX1ozJQXv64hSybJ1QR4VaEAVT4txus3pWtKI9CVnPgs+u9bGoQVUINxuL9tQQ=
X-Received: by 2002:a05:6602:199:: with SMTP id m25mr15380496ioo.13.1585661814270;
 Tue, 31 Mar 2020 06:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAB00BMjPSg2wdq7pjt=AwmcDmr0ep2+Xr0EAy6CNnVhOsWk8pg@mail.gmail.com>
 <058b3f48-e69d-2783-8e08-693ad27693f6@youngman.org.uk> <CAB00BMgYmi+4XvdmJDWjQ8qGWa9m0mqj7yvrK3QSNH9SzYjypw@mail.gmail.com>
 <1d6b3e00-e7dd-1b19-1379-afe665169d44@turmel.org> <CAB00BMg50zcerSLHShSjoOcaJ0JQSi2aSqTFfU2eQQrT12-qEg@mail.gmail.com>
 <e77280ef-a5ac-f2d8-332c-dec032ddc842@turmel.org>
In-Reply-To: <e77280ef-a5ac-f2d8-332c-dec032ddc842@turmel.org>
From:   Daniel Jones <dj@iowni.com>
Date:   Tue, 31 Mar 2020 07:36:42 -0600
Message-ID: <CAB00BMiaqRcZsGu39ygop7G7yejAooFAkRdojkrrUvs6cyF7zA@mail.gmail.com>
Subject: Re: Requesting assistance recovering RAID-5 array
To:     Phil Turmel <philip@turmel.org>
Cc:     antlists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Phil,

Thanks for the guidance.  I'll think this through and come back with
any questions.

It turns out that I do have a file in /etc/lvm/backup/ but I believe
it is a red herring.  The file date is from 2016, well before this
array was created, and must represent some long-ago configuration
of this machine.

Regards,
DJ
