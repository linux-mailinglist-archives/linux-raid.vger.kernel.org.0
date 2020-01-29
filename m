Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAFCE14C4CD
	for <lists+linux-raid@lfdr.de>; Wed, 29 Jan 2020 04:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgA2DRx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jan 2020 22:17:53 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:40929 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgA2DRx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 Jan 2020 22:17:53 -0500
Received: by mail-ot1-f53.google.com with SMTP id i6so10370891otr.7
        for <linux-raid@vger.kernel.org>; Tue, 28 Jan 2020 19:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=tzcROn970ohhw8a3NuG0iHPp5m8G7czekzJ44YY3gE8=;
        b=JbKTcvFzwykpJVatVyFKf+yH2oBiJ6CQd5RRUVDWcWIEVXPB/VB5IhYQ2kCizWVst8
         f1deFvWIlDDaLUnaFbzst9QwbXGfT2Q8bZ2cXbKlGzOdQ7s6gj2F4Db8ItSdvYakT/P8
         b8TxZlteQDMAT/3TpXfFW1pS6SsjWqk9+qQOfgDrDb/AZlAEw8nfxb6huYTIA8mtF8up
         GSPJFtqh+Y5iSFgFAB+D7eyH2511nxWPZvOeLfZJxsoIjlYReOZOzfY1hsUb6dAnU608
         RELGju3GC+ieMIlM6e4Cd+WXVPVDa+D9EjSH7P/vxrKGbMLMrZ/LAYsqXewaXUzbZdc0
         U23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=tzcROn970ohhw8a3NuG0iHPp5m8G7czekzJ44YY3gE8=;
        b=FYV6X4Hj2olYqsQofi/YbL3ZgsjEtyG+KOnoPGHVYVHvEsfWEAC6Fr0o59gobOc62p
         u+P7FMpQXw6qAqmKdq+oe3FMYJzKHd6UCDTzIJ4VfejHYO1wFIBKRGfOMiZyDuYYYdM1
         H/uBI7oPoC6DQWsJQ32Q/Dd6TpJDu9Oo9LDcJEuSKbqoBeZwV+QqYq84ajD4dQLPmMoe
         1Hf9it5iOQ1LIK+zH3nFfY2lF1PlcFjRWfHNZzkdwOM+nZ0NQvo+sIB3fLrXIXPm4KXY
         xUgKRpzGoQRgHsct1qjTskdh5iDVfd1d2fqIxsibQxz7VW17hIjpD3ziecIQaC8DT1vg
         NEMQ==
X-Gm-Message-State: APjAAAVkGj2UUXQEBO0gBbI/40lURkZR3LHaEYS6pp0OS0Havj0rVGXu
        571WxavHEJahfhmwV2xmSDam9r/o
X-Google-Smtp-Source: APXvYqwDVLKA4ezXk2023qfHvMyemQM+a+d+zZMVml5G0vEF3/c2Pet1hXYyMWbpzytMMiyYa6WNQQ==
X-Received: by 2002:a9d:7a47:: with SMTP id z7mr7040330otm.179.1580267871896;
        Tue, 28 Jan 2020 19:17:51 -0800 (PST)
Received: from [192.168.3.59] ([47.187.193.82])
        by smtp.googlemail.com with ESMTPSA id j5sm246785otl.71.2020.01.28.19.17.51
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 19:17:51 -0800 (PST)
To:     Linux Raid <linux-raid@vger.kernel.org>
From:   Ram Ramesh <rramesh2400@gmail.com>
Subject: Is it possible to break one full RAID-1 to two degraded RAID-1?
Message-ID: <1120831b-13e6-6a5d-8908-ee6a312e7302@gmail.com>
Date:   Tue, 28 Jan 2020 21:17:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I have my entire debian 9.0 installation (root/usr/home etc) in two nvme 
RAID-1 mirror. Is it possible to break them in to two degraded arrays?

Specifically I want to do this.

 1. Break current debian 9 full RAID1 into two degraded RAID1 A & RAID1  B
 2. Boot only A and upgrade to debian 10 and make sure it works
 3. If it works, add B back into A and get Debian 10 in fully complete RAID1
 4. If it does not work, I boot B and add A back and get back debian 9
    in full working RAID1

Is this possible?

Ramesh

