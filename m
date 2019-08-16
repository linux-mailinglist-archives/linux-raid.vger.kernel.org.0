Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19265903A8
	for <lists+linux-raid@lfdr.de>; Fri, 16 Aug 2019 16:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfHPOIl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 16 Aug 2019 10:08:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35454 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfHPOIl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 16 Aug 2019 10:08:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id u34so6240173qte.2
        for <linux-raid@vger.kernel.org>; Fri, 16 Aug 2019 07:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L6wu3i4v/NqinxoARGaCDvwanbOrLLl62J+KGYO63pU=;
        b=Fu7vyfeUQN+QYWanfTsKFuTnPz+cd3hacw2sU9JLH3qlvZL0XCPWgbmzK4Qrqxhb7D
         CljpoeWgJLjU+m4En37+gfxZMwru6n61VJ/Cz6otAr8jzcD4vQcm5/vEkLOfRSwXkx0F
         vJTiKqsE4XniBTk6prASJ/phFAb+72l809FB2an+fR0LSGfEgIAgHtYcgWbO4MFHOYjU
         c6YfUsUD1K34Vdd2eNlEzWuRauwxnbAvTPRI+ekWR0dzRuFU70Z0xtGbfgY3jVwwqQ08
         TRRfc7vsej2gyDipNuML4ipTuf+M/oG94PwyKNBRyL2lnLpBpjBC5lfJMJorvrkXFoyv
         DnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L6wu3i4v/NqinxoARGaCDvwanbOrLLl62J+KGYO63pU=;
        b=X7H9heMd1CGl86K+hpCz39BO5KN/dV4aw/jVB03UaOlvdU4/rH8pSIYrBixLqUTzzc
         j5KIpknokqI//JohdwFksVUUziS3A9kQtRIYrf6P7RxIBrFHrjAtqFMcKOAMuztzvPRL
         ruQX3x+cETgGJei+AoqWDnjPFG9tXuL21diEBQMNqenY1V+/x9tvJUv0vwiuw9c6iac4
         OPzu3f5jx69aIttblel2UNITT5TxplyFHvOnE7tfz6MTEShx5hZdLpZFGapsSVBAza4H
         Nc/BCDzEAs9+G7qKZX+b7cAHzh5sztPegPGKmQcY3dmlw5Ob8KUI6PScuGAanhgSU+dc
         SXQg==
X-Gm-Message-State: APjAAAUIJGfU9JgR7gjsyC4ImIRfaWgt6GIPd3uyFrzrvZ5ZPnaAlN2f
        lmruR/eeV33gdwR7VhuSzFqZJ1v4
X-Google-Smtp-Source: APXvYqzQmVSsoElbnO0rKCjiJYWujOJwQYgNM5LljxhCCYmvJk4QRI3AgeFbqkW9Eym/rQmZRrjpNA==
X-Received: by 2002:ac8:53c7:: with SMTP id c7mr1283182qtq.162.1565964520120;
        Fri, 16 Aug 2019 07:08:40 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::108b? ([2620:10d:c091:480::e737])
        by smtp.gmail.com with ESMTPSA id v192sm3039645qka.74.2019.08.16.07.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 07:08:39 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH,v2] mdadm: check value returned by snprintf against errors
To:     Krzysztof Smolinski <krzysztof.smolinski@intel.com>
Cc:     linux-raid@vger.kernel.org,
        Mariusz Dabrowski <mariusz.dabrowski@intel.com>
References: <20190816090617.12679-1-krzysztof.smolinski@intel.com>
Message-ID: <d540ec64-ffb2-dab1-c792-f088594330c2@gmail.com>
Date:   Fri, 16 Aug 2019 10:08:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190816090617.12679-1-krzysztof.smolinski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 8/16/19 5:06 AM, Krzysztof Smolinski wrote:
> GCC 8 checks possible truncation during snprintf more strictly
> than GCC 7 which result in compilation errors. To fix this
> problem checking result of snprintf against errors has been added.
> 
> Signed-off-by: Krzysztof Smolinski <krzysztof.smolinski@intel.com>
> ---
>  sysfs.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Applied thanks!

Note my ubi key fried itself so I need to setup a new one before I can
push to kernel.org.

I am glad to see some of this addressed, but the problem is much bigger.
We need to fixup super-intel.c to build with gcc 9, not just gcc 8. I
did a bunch of stuff, but the bigger problems remain. I am not a huge
fan of just hiding it via typecasts, I'd like to see a proper solution.

Cheers,
Jes

