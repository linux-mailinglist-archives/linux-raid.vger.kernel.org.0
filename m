Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A589123115
	for <lists+linux-raid@lfdr.de>; Tue, 17 Dec 2019 17:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfLQQF6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Dec 2019 11:05:58 -0500
Received: from mail-yw1-f47.google.com ([209.85.161.47]:39602 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfLQQF6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 17 Dec 2019 11:05:58 -0500
Received: by mail-yw1-f47.google.com with SMTP id h126so4141395ywc.6
        for <linux-raid@vger.kernel.org>; Tue, 17 Dec 2019 08:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=xcnAMeLzZ/asZVTS9y+dHHtZxfqaTzAw+7x3pTCv+YM=;
        b=QXS7TYWtn/M1r+njYPS801574JJFCW5se0MlIXdSjFlMSnQ7ZM+lCXUcIxkvk3Kk8f
         hu5SiRAQpfDXYnn11V98KywDTxH3MMh8Db5mIlc8uFJJKzC+TmHKe7KDVBqiVqnvIH6X
         jIJg9PhJIiAl9N2LsWNTTVjWUWTpq6xC7XBNAaYlwPJiCOLhfdGjGJ/MT0c2/2XwS5oy
         qHszHQWIKUGyk9EYncOtuMttDywSgcpJpYttuSsvCCQSMO48S4Hjic92KkPqn3mF9dVq
         Shr6xf2qEAFIpPnbDLrbt7aX3szTeez50C6Uz33Gc0BTii9vfR/V6vlK6sh10Z7Vf/mj
         hmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xcnAMeLzZ/asZVTS9y+dHHtZxfqaTzAw+7x3pTCv+YM=;
        b=d8QR+OwJS6vs3U5ZI4LONn7tSPGwkiFEK/79MKcXNq+k/tGWHi82e5hvC3EbBwLoq9
         G71Gfhcjc363sjEd5xWC7bgA0Tx1VW42muwUaLqF+1yfPu/JPhuj7CCqQtuojQ4PsjuD
         FqIzGosKY7VeUwDlxIFRCqrCf52C1c9yLefpAe784BNBIW4mhYRS6pYbhtQ0xVU+OsrM
         YWGh8sxp7ZWgNKKM7/gLeKoyUJ9hk4sJaLCgD6KdjWPy7cMBBkhBSy/mMFkhrKYvVVgd
         z2FHUTlO4IWoDEjXcRWHuCRUyANlYU7318l2mHcAJdrq7rvWpWmET/B0MbDn4LIucvxi
         Iydg==
X-Gm-Message-State: APjAAAUn25ncPwqZniAP9QlUMF5MQn9cZIpOD3J6vwmzvORyu2jC9xCv
        ekIpdZEVhuJZSd/V9CiljFxUdwJqw60=
X-Google-Smtp-Source: APXvYqx2pH/BM47HwEIH5SC9aMIjg2rrfLcCj8EebpYA+d9I0y+MLRcGSpQ/eEIhyMb9uGn3mZolTw==
X-Received: by 2002:a0d:cb0c:: with SMTP id n12mr19433392ywd.375.1576598756986;
        Tue, 17 Dec 2019 08:05:56 -0800 (PST)
Received: from [192.168.125.2] (quantum.benjammin.net. [173.161.90.37])
        by smtp.gmail.com with ESMTPSA id d10sm8771494ywd.107.2019.12.17.08.05.56
        for <linux-raid@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 08:05:56 -0800 (PST)
Subject: Re: Keeping existing RAID6's safe during upgrade from CentOS 6 to
 CentOS 8
To:     Linux-RAID <linux-raid@vger.kernel.org>
References: <e7e9ed61-c611-3b40-2c78-6c5c47f77148@gmail.com>
 <CAAMCDedHgQzQx=0U=7=nrJoBYqfzE-DCfYxMd-L8B-NRft8TNg@mail.gmail.com>
From:   Benjammin2068 <benjammin2068@gmail.com>
Message-ID: <8fff49b9-e2e3-990b-2750-1e950397903b@gmail.com>
Date:   Tue, 17 Dec 2019 10:05:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAAMCDedHgQzQx=0U=7=nrJoBYqfzE-DCfYxMd-L8B-NRft8TNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 12/17/19 8:43 AM, Roger Heflin wrote:
> If you do pull the drives, make sure to pull them with the machine
> off, and make sure to insert them with the machine off.

Absolutely. It's also give me a chance to blow the dust off them.

They're on 24/7 and the server chassis doesn't have filter material in these pull-out trays, so I added some.

With them running for almost 10yrs, vacuuming only sucks out so much dust... it's time to replace. :D


> Not having the machine off would cause mdraid to fail the raid as the
> drives are removed, and not having it off when inserting them would
> make it activate them one at a time which may or may not quite work.

Yep. I'm aware.

I was soliciting for any bad installer behavior on the part of anaconda and the like.

> I have done my updates without pulling the drives (at least 1-2 fedora
> reinstalls) and just made sure to not let anaconda mess with the
> larger raid disks.  Without the conf file it will still find the
> raids, it just won't have the same md* names.  I have also installed a
> disk elsewhere and made sure the dracut config was setup to include
> all drivers (change to hostonly=no).  6 does hostonly=no, 7 does
> hostonly=yes, not sure what 8 does by default.

Thanks for chiming in!

  -Ben
