Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9621137BEC
	for <lists+linux-raid@lfdr.de>; Sat, 11 Jan 2020 08:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgAKHHK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 11 Jan 2020 02:07:10 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:35542 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgAKHHK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 11 Jan 2020 02:07:10 -0500
Received: by mail-io1-f52.google.com with SMTP id h8so4517892iob.2
        for <linux-raid@vger.kernel.org>; Fri, 10 Jan 2020 23:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/2WFF1hlfnSMxprVweNRchylNvZq260qDVqqKZYZ6mQ=;
        b=FcwBXsLYESc5TZNeHnUYh6ruH7LDwLXk9ZgZ2j5op+yN9KVWDEdRBiZPYufNHhyG7s
         /aDu+p2avjYuIZRRPK1CB63DdTQ5Hz9LaF73m9KTcGiigL9Xe9VoY3lUCxg2hyDajr4c
         Ff+YSkeaxiWv/ik67dLgvVeQ7SpkXcQjHKfIG4uJCGWnYDVwIN/NJgDqTJAJv9fkhvQM
         Sgkt2d+ws8QjYEaZYh3bIaE7E9WtxRvHf4MqbqxTw4xHKU+BL7ho20ALu0Ja6Vh1ycTV
         OGNu08mRGy22kaLpHHpPnb+3up1NvlHK7IxhP9yjnvTIlj/CaWICv8mAQHNXe3zC+s+a
         iJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/2WFF1hlfnSMxprVweNRchylNvZq260qDVqqKZYZ6mQ=;
        b=BCdQIKb8mSBJnKv0SbDIXGKQEgGqipPX6NNSu1r/wcIF6D9NIj8/jftH00qEFPvOa7
         Hys1Ons5NtWlZeUh19KyxtWx3Vnm6ROlmF/XVzJTlAcTuO9Ykcp1/xkEhOc43nyY/+Bu
         qjwA7P1yEpEsOttzq1Efo6Nwcfx6fWWjp6eZMvTFR5e2vXu2ehXmE2iM/amrerJsH4uu
         6bdpESUuQ3/CiqL41+PduI9FFCTCoqdqHXbFtZQxjt+GOw0aX9vGxGofU4+0zkCTdk9U
         AA1havZiO8S6SqWsti+KT3ip/HVZ0Df6tKJrXRYgf6GuoDtCoGdQJlIulaXLhS9SEkTl
         TJSw==
X-Gm-Message-State: APjAAAVJFxVf6FScPRE+x27txYwCDPVVNrZzLkr2jUe8bWcPwbkAWXeC
        5tYtBwua2PHiSBhucelEc7rbTjl4Pu8LJxpBhRoLME7p
X-Google-Smtp-Source: APXvYqyCrKPnlhQi9Hv27Yzb0WQSDac9veqfKhYId0+zqUrY+MA2C8pno2nepITWQio7C4lOK2qQY7s92WSOZWxQAZs=
X-Received: by 2002:a5d:85ce:: with SMTP id e14mr5387620ios.181.1578726429097;
 Fri, 10 Jan 2020 23:07:09 -0800 (PST)
MIME-Version: 1.0
From:   Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date:   Sat, 11 Jan 2020 08:06:58 +0100
Message-ID: <CAJH6TXhWd-AGi0_KnbnepxZXsOvpMQGwkisFuuX14dMe157jWw@mail.gmail.com>
Subject: RAID10, 3 copies, 3 disks
To:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi to all
i've read that with md is possible to create non-standard RAID layouts
like RAID10 but without being forced to use an even number of disks to
create the mirrors (like a standard RAID10)

So, would be possible to create a 4-disks RAID10, with redundancy set
to 3 (I need to survive up to to ANY 2 disks failures, like with
RAID6) ?

I think it would be something like the following?

A1 A1 A1 A2
A2 A2 A3 A3
A3 A4 A4 A4

Currently, when i need something similar, i use a 3-way RAID1 with LVM
on top of it to aggregate multiple mirrors in one bigger volume, but
this requires 3 drives for each mirror.

Other solutions ? I don't wan't to use any parity raid this time.
(wasting space with a 3way mirror and LVM on top would be ok, is
nothing better is available)

The raid *must* be scalable, i need to grow it on-the-fly by adding
one or more disks, when needed.
