Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C5E13839A
	for <lists+linux-raid@lfdr.de>; Sat, 11 Jan 2020 21:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbgAKUz1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 11 Jan 2020 15:55:27 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:46752 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbgAKUz1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 11 Jan 2020 15:55:27 -0500
Received: by mail-io1-f52.google.com with SMTP id t26so5682995ioi.13
        for <linux-raid@vger.kernel.org>; Sat, 11 Jan 2020 12:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ymGU7DpVTmc4LzPSZoUZnDKtnb8OAH25qaKU+mW9ioI=;
        b=BV07lqvGgvtRKgc3lGLaQv9JtxluGwggGeQ5RB2R4KtvuGkdGLGRNzY1QjVMUy6rgh
         KK71+qfvCmZRtzj8LnS4WwhtWGwEmtXgZhdK/UzLiD4VH9X9xcr+JrD4Dx9Fg6DdKZDg
         SjzuM9P9fxvY3cT4qXN4yqj+Gb9xZSyX4wnAAnUKDSbloI5ksQ7SzB9h/GTh5OPF5fGG
         xqKUMMmw+vZQCLd1EwVVSr/QJflwqemgGIzE+nEPXLbLGBEkUqmBMTljBpz8iXzG3C10
         LLI9K5bNRdKypPruz3urGNKyRouLUSRAjajvZvjHwxDWhHdCujs3lUjVAukEuMaGgtO/
         FMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ymGU7DpVTmc4LzPSZoUZnDKtnb8OAH25qaKU+mW9ioI=;
        b=ehDc9bm2cOnnNchq60GjOIfYFyzC3GPiKvkxe0JHaS3a4dYuAKNmr1Jj8GiPWy7lOl
         vz65ft6lltUhDmYXsfYGUtKnkzxl8q72jbSOgYaGR3lrRXgjAOsanjsJaDQ3lsNI8uEw
         Y/wrMJi9lLAV1YQHny3yS+RMluLhuMMzXmi8mUFUGsS5i5I7Et3cqxT5euY3Jf4vkxhP
         AO5YCCUK+vumvm2ArXRd1QoAlp0dTNsXCGPs3bnvrbWZAmiIUrHR6mSxxnt+ke3v6WBN
         fjDIv7GJGzvUQm0/nKoxBI+Qk0Tn+Due5HQXiY7NBU1VtoOVWQAuHYBHn9Qww5XycHPu
         VjkA==
X-Gm-Message-State: APjAAAXKnGu4dBOZusXVDx1Bf9U2ZEB4vbtlpawI5v3EZj5gkp5tuhOk
        6ibJ7lPYC2gtN7qMjF5mdYy710wqPMkNjmATKOPGxqoM
X-Google-Smtp-Source: APXvYqwklSqM/eVZOauYSGRJTB8BRM0gMe2nt4keTuiJK0F4BRGKwqrWlBS6khEx+51oncmVCDO819IyTJnt2cRuDxc=
X-Received: by 2002:a6b:6118:: with SMTP id v24mr7803941iob.73.1578776127062;
 Sat, 11 Jan 2020 12:55:27 -0800 (PST)
MIME-Version: 1.0
References: <CAJH6TXhWd-AGi0_KnbnepxZXsOvpMQGwkisFuuX14dMe157jWw@mail.gmail.com>
 <82a7d9ec-f991-ad25-bf1f-eee74be90b1b@youngman.org.uk>
In-Reply-To: <82a7d9ec-f991-ad25-bf1f-eee74be90b1b@youngman.org.uk>
From:   Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date:   Sat, 11 Jan 2020 21:55:16 +0100
Message-ID: <CAJH6TXji3e1Tp8xDDiqfqy36fpMC4kZTLaYj0Le9A6Cyg8EnGg@mail.gmail.com>
Subject: Re: RAID10, 3 copies, 3 disks
To:     Wol <antlists@youngman.org.uk>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Il giorno sab 11 gen 2020 alle ore 20:11 Wol
<antlists@youngman.org.uk> ha scritto:
> The "standard" as you call it is actually RAID1+0. This is *not* "linux
> raid10", which is as you describe it - the number of disks can be any
> number greater than the number of mirrors.

Actually, what I need to do is simple: a scalable array with at least
3way-mirrors.

I've thought in using multiple 3way mirrors (RAID1) merged together with LVM or
just a single RAID10 (with 3 disks mirrors) and LVM on top of it as
volume manager.

Don't know which one is better, the result is similar.
