Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A3B1E14CC
	for <lists+linux-raid@lfdr.de>; Mon, 25 May 2020 21:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390015AbgEYTfY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 15:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389904AbgEYTfY (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 May 2020 15:35:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE8BC061A0E
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 12:35:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id n5so997005wmd.0
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 12:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=p1909D3tK1SCDDD6+P9YjrrAoN6lGbi2OAVVljvum9g=;
        b=DEGNCM7RCJ8+lhZxI4Z0gEksTOL0H7ogEomuVgcVrJ0DPI+l86t0GJD/k7BGz9w8Qb
         5L+qIutj0G55ORIkLVV4+EyLpfR41EMFdAjxTTJ1JYE8athUOX1DVRPRpbSW+SSbzLGf
         4rxReZBNjyuD/dRtOpd3Sn7ydW92jycNsXl+1ArONleCxtXwkm8J5h4+TubL7N5tf3M1
         lvzPoGFuJDmwQ8OF0s9/KjkcLNVFRK3hshYVHR5hIT4/cnOvN8IX/1YryeW6afQdYu9d
         LeXz+IOe8PoPMQlYwn1vXCdxLM4ZwtLaO1NkEM1qI4tgHL7DGMl6i/MnvF2aTmYY2aq4
         x+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=p1909D3tK1SCDDD6+P9YjrrAoN6lGbi2OAVVljvum9g=;
        b=YQcbNWQ2peSLjpzxpH044M/H3GzkVGgNkeVidrfgCb/NImCi7RsPQSe6UxPqgnIsIr
         dKIfuo3SRfhwtNk+E3J4QWq7kaOm+M8scGDO09enxWaAGaHlN6JvWx3Oc6jPxHikSEHv
         A7zAUyOJ3gMcV6abkq6wV781dvCruMRQkKW46/Y8vOB7ij9fanJp8P2TXR8rowlSvPEp
         79BvjkYVP7MVauTuW9YoJe+EU0hm740IdAQ5Fe/ylrFshFH+gb0ypxRN6Xsm9o/zZYSW
         pdG76SSqioovnaVNeSa3aErtrZYrObI7o9xYQHKQf33SkvMfOotOV7SBolbzMvP1ZXfl
         c5lw==
X-Gm-Message-State: AOAM531yywuSDYH7SsQqYyuTBSbKWWLfcQwz6DIbCRr65bQPUNeG7c0p
        Q92nqppdptckxzJQTfeE2FM5on2teBQ=
X-Google-Smtp-Source: ABdhPJwMUaUEr5/lyOxFKJpYViyhy/9PxurExgjUCFHkHO28dzb6VCxGr7wXYVAWJkRUkwQK5hZarA==
X-Received: by 2002:a05:600c:2944:: with SMTP id n4mr1179868wmd.135.1590435322481;
        Mon, 25 May 2020 12:35:22 -0700 (PDT)
Received: from [192.168.188.88] ([46.28.163.233])
        by smtp.gmail.com with ESMTPSA id j4sm17303850wrx.24.2020.05.25.12.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 12:35:22 -0700 (PDT)
Subject: Re: help requested for mdadm grow error
To:     Mikael Abrahamsson <swmike@swm.pp.se>
Cc:     linux-raid@vger.kernel.org
References: <7d95da49-33d8-cd4d-fa3f-0f3d3074cb30@gmail.com>
 <5ECC09D6.1010300@youngman.org.uk>
 <ff4ea9cd-ab35-0990-5946-4a72d4021658@gmail.com>
 <5ECC1488.3010804@youngman.org.uk>
 <4891e1e8-aaee-b36b-4131-ca7deb34defd@gmail.com>
 <alpine.DEB.2.20.2005252132080.7596@uplift.swm.pp.se>
From:   Thomas Grawert <thomasgrawert0282@gmail.com>
Message-ID: <a755c889-a5bd-1ff3-6a9f-4274b7d7fc83@gmail.com>
Date:   Mon, 25 May 2020 21:35:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.2005252132080.7596@uplift.swm.pp.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> On Mon, 25 May 2020, Thomas Grawert wrote:
>
>> The Debian 10 is the most recent one. Kernel version is 
>> 4.9.0-12-amd64. mdadm-version is v3.4 from 28th Jan 2016 - seems to 
>> be the latest, because I can´t upgrade to any newer one using apt 
>> upgrade.
>
> Are you sure about this? From what I can see debian 10 ships with 
> mdadm v4.1 and newer kernels than 4.9.
>
I shall check before yelling out some shit...
It´s currently running Debian 9.

I´m just running an upgrade to Buster. Lets see how things will work.
