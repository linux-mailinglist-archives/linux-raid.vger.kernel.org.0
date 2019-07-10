Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9936464D50
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jul 2019 22:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfGJUO0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 10 Jul 2019 16:14:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34728 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfGJUOZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 10 Jul 2019 16:14:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id k10so3925384qtq.1
        for <linux-raid@vger.kernel.org>; Wed, 10 Jul 2019 13:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PJog9HpKRZeBNpnYPIFcBoGK71v9O8PjiFiFsVDIoW8=;
        b=icRrV+kAeT5+cyROJd3AO5SY8aGki18HySa0nnHT6c02pHn4JZGg3baYyOurxAnrxC
         E5+9pU4Hqvf1feUf+b9rnKDBOftHO9cMRq/aum0CN+pCqZuXW82j1DB8C3adgDJFtCV8
         LZN07wd3zvKm+VivjXhbHoDHu8CjWzrOe0vFnD4mj6vuXuDPAKCYikqrgf86xeB03zHs
         fW0tgLnTmUfHKWxvRcQxwdgXPGllkppC/KNnouR086wQ7HOAHgV4RhdZ+B+chmTsqKsn
         99Tj8Tp/HG9/llBfFSEfMb9eojFWXtXZ1uDV72X3ee+x0qpp921iI0yBhQowTGhOyPqu
         j9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PJog9HpKRZeBNpnYPIFcBoGK71v9O8PjiFiFsVDIoW8=;
        b=qeLw1HKh6Ahsy6AuilDv5nxYMduPbmxv4qFgDutt+ZM0IFuWMi1WGESVGSbA3C8qG9
         s92mS4/wMjwsXel1usaYqL1DlvbbYyvF94UKTUrRfVrg3wwluL+Aio1rAl692z54Hmvz
         exs9sDeYO3XU9RxjE76xetMUU20o0r6hYPLdoSd2Fv5c30KYOo/SIljLxHeae/6+DdoD
         +509yN5BfcPSc9lEePp1/RP4rGjHjkAWN3p4Z0CCfUAMa7uNjaRjmiuehQuxvpIN7k7x
         aSS12ZLa575YMTobL5UQN95FAUbxqzxNvoCDhJPVZ/jCuepb19IBOQp1H1vhNSTAo2uO
         mzQw==
X-Gm-Message-State: APjAAAXUDd7i5YVRtD6LWB2HH1fqCNV65pQ+eTTYG7P8ef0F+V3ccuxa
        fp7hIxS6NIMd0GvAIJx8XPo=
X-Google-Smtp-Source: APXvYqyDjhyTHq4+33bdI35YQR82w4X9CrybN5XFeFDxQHNReyiN2pkHJ8GQF5CueA7zcHf3bGH5UQ==
X-Received: by 2002:aed:3b94:: with SMTP id r20mr25129520qte.207.1562789664359;
        Wed, 10 Jul 2019 13:14:24 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::1004? ([2620:10d:c091:480::b609])
        by smtp.gmail.com with ESMTPSA id c74sm1590624qke.128.2019.07.10.13.14.22
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 13:14:23 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH v2] mdadm: load default sysfs attributes after
 assemblation
To:     Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Cc:     linux-raid@vger.kernel.org,
        Krzysztof Smolinski <krzysztof.smolinski@intel.com>
References: <20190710113853.12160-1-mariusz.dabrowski@intel.com>
Message-ID: <0fdc11a5-bac3-b235-18b1-63a41cbe0040@gmail.com>
Date:   Wed, 10 Jul 2019 16:14:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710113853.12160-1-mariusz.dabrowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/10/19 7:38 AM, Mariusz Dabrowski wrote:
> Added new type of line to mdadm.conf which allows to specify values of
> sysfs attributes for MD devices that should be loaded after the array is
> assembled. Each line is interpreted as list of structures containing
> sysname of MD device (md126 etc.) and list of sysfs attributes and their
> values.
> 
> Signed-off-by: Mariusz Dabrowski <mariusz.dabrowski@intel.com>
> Signed-off-by: Krzysztof Smolinski <krzysztof.smolinski@intel.com>
> ---
>  Assemble.c    |  12 +++--
>  Incremental.c |   1 +
>  config.c      |   7 ++-
>  mdadm.conf.5  |  25 ++++++++++
>  mdadm.h       |   3 ++
>  sysfs.c       | 158 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 202 insertions(+), 4 deletions(-)

Seems reasonable, applied!

Thanks,
Jes

