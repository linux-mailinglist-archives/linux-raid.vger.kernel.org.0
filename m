Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B83B1386BA
	for <lists+linux-raid@lfdr.de>; Sun, 12 Jan 2020 14:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbgALN5n (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 12 Jan 2020 08:57:43 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:33826 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732958AbgALN5n (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 12 Jan 2020 08:57:43 -0500
Received: by mail-io1-f52.google.com with SMTP id z193so6844296iof.1
        for <linux-raid@vger.kernel.org>; Sun, 12 Jan 2020 05:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8wOcNPhMG/rM3eAtTDMSOqNPRG9N8ywwSC4GPTm95w=;
        b=ZY6jg6VzF1H7Gd18lwCQbYByfB8Lf7puV/+HMkdydy3i9mDGm5OcG8cgfmsisOsGCa
         hD3a0jrze58qfPVhUPrOBMwS/QS53pi7/fEMLu75WUb1eOlVw4wJtYJwd86/mBQ0w356
         GzFfP3lRAIWJa7Qe0qfkv4YSL0FdUekZDzXdvvYObddYM8bMpSESsN+cJx0817l1C1e1
         4yuCox5BN/WpfMUdj1wYTsUVoog/vEjm3r+MaBMf81zLwh4x0IfrkFflzvpsxSo8K4Pl
         138bcHggGuAg15GEnHo09EvMklxZvLtG7jSwtj9cK8uk9byxEa8srFdzApVFX1P8O3hh
         Zkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8wOcNPhMG/rM3eAtTDMSOqNPRG9N8ywwSC4GPTm95w=;
        b=VqfjhGX7I7uzstXDo0z87+/nNtZQ8JgkpdODM3RvFONxbpkTCKyo0AvieyxOWmfj7J
         1r95nW16H9eONx7KotaNyqVevkZYwOTIinUAQyPyu5jNBptxh1JWnCx08KpA9UYwkOLS
         9JTO4SSznSxhwRYAPUE7tFM7ARxf39Bz7WAq/FVERmK0qsbT+x7c3h80IoHCKlvLMyuA
         ZHibS7uBwQj6EpiTT8C3Xb8r+i06sun/iLZrl6Nh8643BkJEGfV7dmxoMlUwlrD3h9um
         V/Cv3x3avPxrOGWJ9evd5ADSRz2s2AECuJzVFY2vdASkfuqz+ScUFcxinv3MMJckclQd
         QzzA==
X-Gm-Message-State: APjAAAW75PvdJMia6YqCWXaIOYAzxiZ1bW583ekWxWrZADo/dwiIMRgR
        smWGYLu61i6hs4VscdsXLtq79riX+bAIU/k3QSgJW2oK
X-Google-Smtp-Source: APXvYqwZO39D7b2wxRKG+h3Vj8M3kxr0HQh7+vK1cSjfW+KKLNnMDpHGlih5JMdEWIjbisxmRy1GhXM1YNh9bmK58iI=
X-Received: by 2002:a5e:df47:: with SMTP id g7mr9529738ioq.31.1578837462276;
 Sun, 12 Jan 2020 05:57:42 -0800 (PST)
MIME-Version: 1.0
References: <CAJH6TXjryixcArdcu_oVzmkEyktpMSb62YaUJvUv_Nd7k3mbDg@mail.gmail.com>
 <CAJH6TXgvvgg3w096PJ+wKT==ixxH8VTzzoRjTTcMhTJ_SDf2xQ@mail.gmail.com>
 <20200110173114.GA3701@lazy.lzy> <CAJH6TXgByNnaWkFo25SrkbR15XgN47b5VhzgWLX=LvMhH-A1VQ@mail.gmail.com>
 <20200110181703.GA7028@lazy.lzy>
In-Reply-To: <20200110181703.GA7028@lazy.lzy>
From:   Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date:   Sun, 12 Jan 2020 14:57:31 +0100
Message-ID: <CAJH6TXi9Wdg4TN4XwUxvnonReCPoaPije9+EE2s0sW7cdg3=Vg@mail.gmail.com>
Subject: Re: Last scrub date and result
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Cc:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Il giorno ven 10 gen 2020 alle ore 19:17 Piergiorgio Sartor
<piergiorgio.sartor@nexgo.de> ha scritto:
> well, the time is available at script
> level and this can be logged.
> About the result, I guess it is possible
> to log as well.
> One option to investigate would be the
> "--wait" of mdadm.

What is logged when a scrub finished with errors ?
When everything succeed, "data-chec done" is wrote, but what in case of errors ?

Anyway, i'm still thinking that adding an explicit line on --detail
output would be very useful
