Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D2424EA7
	for <lists+linux-raid@lfdr.de>; Tue, 21 May 2019 14:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfEUMIT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 21 May 2019 08:08:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41056 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfEUMIS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 21 May 2019 08:08:18 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1hT3Z2-0006uf-Ci
        for linux-raid@vger.kernel.org; Tue, 21 May 2019 12:08:16 +0000
Received: by mail-wr1-f69.google.com with SMTP id x1so7953394wrd.15
        for <linux-raid@vger.kernel.org>; Tue, 21 May 2019 05:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXhU7/Nn4406vWILE1V7HnwbpPCsuskWXUNv5gI4pr8=;
        b=iJCLOxoBeyVQdCz1cF5zrS2LqyY9KlYj1COw8eOD2odJxj5kjEJ9tXeZLqOfStkWMI
         /g1T4tewfqLlX6bY0RW0lx5hloVsx9D/7dM/WBgfl8MqmACNwNmGcFfOIC7VKsqaRMzH
         6pYEpKNU5BlnLKrr9lUkUUy3MXNJeF/IDky0v7jv2ArAh2ebVZevUBrdzRFrMb4bde89
         PpJwmQoGKeVhuQ6TJIfmcePMw3VNmj7V7jfDAzMAR/sfJs5EsPMx6yDZ9yFsBrJl+P+X
         DBv+B3/ibQ4ZinIDARTe5vyZKqVRxP6FifF9vwtGqiD9hrLAHViRrLtkaRLyNZqkMeNV
         83uw==
X-Gm-Message-State: APjAAAV3caZ9YVyymWn0ds3ycmOrSH+PSdm/GegLCbyu5OJjY2BMX6Ii
        GDdrhuIUqKnv0Rp9CxHWir8Nj/NZmCbIYa/RXU3hs0xq+EXgZ9oO+KdL60Shkl3DDtDvhLYolNS
        7o+03j6XdknqNecOdt3PUy0c/JceQlOuZOXnj35VMfBcfZaUXfQSUyX0=
X-Received: by 2002:adf:8306:: with SMTP id 6mr37224325wrd.155.1558440496033;
        Tue, 21 May 2019 05:08:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxFs6jLle8rolj8Uvchcc0hIOU9iziAkdiGdWrTuNrb0vVhuvAlwYbeJAsL050r5pHjQwVAgcnfki4xEyGbzcU=
X-Received: by 2002:adf:8306:: with SMTP id 6mr37224310wrd.155.1558440495856;
 Tue, 21 May 2019 05:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190520220911.25192-1-gpiccoli@canonical.com> <CAPhsuW6KayaNR-0eFHpvPG-LVuPFL_1OFjvZpOcnapVFe2vC9Q@mail.gmail.com>
In-Reply-To: <CAPhsuW6KayaNR-0eFHpvPG-LVuPFL_1OFjvZpOcnapVFe2vC9Q@mail.gmail.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Tue, 21 May 2019 09:07:38 -0300
Message-ID: <CAHD1Q_wkziJYx4z0JcBavmQRzTh3a4g5xZG8bhVX+TYTkhaTrg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] block: Fix a NULL pointer dereference in generic_make_request()
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>, dm-devel@redhat.com,
        axboe@kernel.dk, Gavin Guo <gavin.guo@canonical.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Eric Ren <renzhengeek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, May 21, 2019 at 2:59 AM Song Liu <liu.song.a23@gmail.com> wrote:
> Applied both patches! Thanks for the fix!
>

Thanks Song!
