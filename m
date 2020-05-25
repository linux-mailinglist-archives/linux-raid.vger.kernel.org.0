Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15AC1E149B
	for <lists+linux-raid@lfdr.de>; Mon, 25 May 2020 21:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389661AbgEYTFZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 15:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389437AbgEYTFY (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 May 2020 15:05:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40862C061A0E
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 12:05:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u13so862840wml.1
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 12:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=cawoeiK0wPEbSBvLwnAvSpMhvrr5W4Jzvg48pekR89I=;
        b=IExeEbSVyz5if+8Lio7Qr/1zWT+7X/iH4dl3LEY4NpC/jNI13zU0/MyOEOhj/GgM7A
         cw7dsY+D37yYnNiPFVS1K+fsefP+QpppStNXzyn2QXkZJ1JvW0WdMGifWIXCttKMHSrh
         jxDQCeZu7H32MHx1EXGnh42VO/J10GNMAqukxJdDLH7VogdhuUe1/m9Nu7oUe47fkhjw
         zcGTpp9Tcvh5RrMwStaPmxKGgJyHBYNdAtQ2478JwexF7dAQ8wNE/bAAhkE2m3piW3ej
         ztO5JtLEnIb5YfmWDwPt8J2BZ3B+2uQNGENcyf5bhAxyJsKXayrHD+0ATc6A45r3AHQn
         agtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=cawoeiK0wPEbSBvLwnAvSpMhvrr5W4Jzvg48pekR89I=;
        b=JGecH9RQ5n1zVZ5V5FNrHzqTGj8wbYPvFBmceYUICcDacd0+TJHOzz/UWqQ2vYAR4w
         6OKdsonQGHpJvimifBCFk9cYz9kUp4GqRyIoTmbqTFYJfeCytfxczxHfxNJQPD3yNL0Z
         csMYcUYOsIPINCabc2uTP5tR4PWKljoVryADlD03YviUMYm+HZQgZC50AFkMAW8obYRt
         CSgFNpYPrw3VMhcgY1OWMGCl2YSC8ut3ovCgW4OkHVIxApNXVlplnQghmDchxY9ZyPHA
         PgGcwcK3UozfGMj7B6YhDPNATw9bL6DOy1KfyDQikW+4w0eqwbD6+av48T9tF5V+s5fK
         2keQ==
X-Gm-Message-State: AOAM533q8X89gp42oE8i+I0RaPSpMCCqHIi9rC3v3NtHsDDF86oaaL5/
        /VxlOAhUSOTTOHQbj4xM3/4im3tSi/4=
X-Google-Smtp-Source: ABdhPJwBKxDUfrXj3UOKfreMciBJ3mIO1lb5BcJBYSt6LaAytaItZxZcyobWMf8nxnLwNJC1NL8yJA==
X-Received: by 2002:a1c:208e:: with SMTP id g136mr24838637wmg.80.1590433522840;
        Mon, 25 May 2020 12:05:22 -0700 (PDT)
Received: from [192.168.188.88] ([46.28.163.233])
        by smtp.gmail.com with ESMTPSA id p7sm18824769wmc.24.2020.05.25.12.05.22
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 12:05:22 -0700 (PDT)
Subject: Re: help requested for mdadm grow error
To:     linux-raid@vger.kernel.org
References: <7d95da49-33d8-cd4d-fa3f-0f3d3074cb30@gmail.com>
 <5ECC09D6.1010300@youngman.org.uk>
 <ff4ea9cd-ab35-0990-5946-4a72d4021658@gmail.com>
 <5ECC1488.3010804@youngman.org.uk>
From:   Thomas Grawert <thomasgrawert0282@gmail.com>
Message-ID: <4891e1e8-aaee-b36b-4131-ca7deb34defd@gmail.com>
Date:   Mon, 25 May 2020 21:05:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5ECC1488.3010804@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The EFAX had me worried a moment, but these are 12TB Reds? That's fine.
> A lot of the smaller drives are now shingled, ie not fit for purpose!
>
> Debian 10 - I don't know my Debians - how up to date is that? Is it a
> new kernel with not much backports, or an old kernel full of backports?
>
> What version of mdadm?
>
>
> That said, everything looks good. There are known problems - WITH FIXES
> - growing a raid 5 so I suspect you've fallen foul of one. I'd sort out
> a rescue disk that you can boot off as you might need it. Once we know a
> bit more the fix is almost certainly a rescue disk and resume the
> reshape, or a revert-reshape and then reshaping from a rescue disk. At
> which point, you'll get your array back with everything intact.

yes, that´s the 12TB WD-Red - I´m using five pieces of it.

The Debian 10 is the most recent one. Kernel version is 4.9.0-12-amd64. 
mdadm-version is v3.4 from 28th Jan 2016 - seems to be the latest, 
because I can´t upgrade to any newer one using apt upgrade.

I don´t think I need a rescue disk, because the raid isn´t bootable. 
It´s simply a big storage.

Thanks a lot for your support.

