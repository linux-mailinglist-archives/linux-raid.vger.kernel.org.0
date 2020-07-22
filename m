Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7998C229109
	for <lists+linux-raid@lfdr.de>; Wed, 22 Jul 2020 08:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgGVGka (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jul 2020 02:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgGVGka (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 22 Jul 2020 02:40:30 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 434DF207BB;
        Wed, 22 Jul 2020 06:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595400029;
        bh=55rpauAhzVgR6FwpmFAWLHbR2LAKN1/g2HefQPBweag=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bfCFlN4c7KDwRBdE39U7N1CQ4rkmxW6dLv3QRIJBm7tysVXNSYXrrADHWkQVTdGY5
         udhKexSMH67kL4chrrmere0bkLniTVuatZddM8P7l5dJRxWVbiO2b5DBr6B4dJmL8P
         BDydbKc5GQE1ZiWqILnZZ/HW+t3muU4Xf8RvRrSI=
Received: by mail-lj1-f173.google.com with SMTP id j11so1263308ljo.7;
        Tue, 21 Jul 2020 23:40:29 -0700 (PDT)
X-Gm-Message-State: AOAM5309RuYCj94vcl+dy3wTmFOuqsu9BrCikyMJvOQTyLhU/sJg6pf2
        7bCJunMVKeYWEKPbBFUIuVIJxsR6ALRXogg6zq0=
X-Google-Smtp-Source: ABdhPJwMMcOo7FU02TM1OwIIdL8VE4cdJEzaCOKzNEjZFPauU6B2EXZ+ELowyqn0yrKndRqfybodVWL6D3Qp21g6LE8=
X-Received: by 2002:a2e:9996:: with SMTP id w22mr15651735lji.446.1595400027569;
 Tue, 21 Jul 2020 23:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de> <20200720155530.1173732-20-a.darwish@linutronix.de>
In-Reply-To: <20200720155530.1173732-20-a.darwish@linutronix.de>
From:   Song Liu <song@kernel.org>
Date:   Tue, 21 Jul 2020 23:40:16 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Cd1FyV7SgH5AtCEYHREOeG75nFqeZKNObPt3bA12Ygg@mail.gmail.com>
Message-ID: <CAPhsuW7Cd1FyV7SgH5AtCEYHREOeG75nFqeZKNObPt3bA12Ygg@mail.gmail.com>
Subject: Re: [PATCH v4 19/24] raid5: Use sequence counter with associated spinlock
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Jul 20, 2020 at 8:57 AM Ahmed S. Darwish
<a.darwish@linutronix.de> wrote:
>
> A sequence counter write side critical section must be protected by some
> form of locking to serialize writers. A plain seqcount_t does not
> contain the information of which lock must be held when entering a write
> side critical section.
>
> Use the new seqcount_spinlock_t data type, which allows to associate a
> spinlock with the sequence counter. This enables lockdep to verify that
> the spinlock used for writer serialization is held when the write side
> critical section is entered.
>
> If lockdep is disabled this lock association is compiled out and has
> neither storage size nor runtime overhead.
>
> Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>

Acked-by: Song Liu <song@kernel.org>
