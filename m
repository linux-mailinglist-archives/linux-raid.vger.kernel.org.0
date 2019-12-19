Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 280551262D4
	for <lists+linux-raid@lfdr.de>; Thu, 19 Dec 2019 14:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLSNEd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 19 Dec 2019 08:04:33 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45974 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfLSNEc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 19 Dec 2019 08:04:32 -0500
Received: by mail-ed1-f65.google.com with SMTP id v28so4783285edw.12
        for <linux-raid@vger.kernel.org>; Thu, 19 Dec 2019 05:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yHR05MsLFUBMSpS3mstmS9wP0wF2fxbCYumk3bYclDc=;
        b=U/PyEpl+lvSt58KppdTJPrAYtfjibzq2j8ZtDqZMwH0Y55KuFXGK4jfMN07lu6uKtI
         rbcomTXIh5fmjuaC3fyBEnKd6vYUabahLBUcDoNfWwbwKecPXJwZrVmotogkhzJ/PEsv
         OM6AGm8lWU2TEGHE0Q/KpJ4UxE0Mbb4ZR/w9YbbGqQG1AbeMuVNjTIBnUqjqF/HtQLQ7
         CcM0JSV1XxmhUnZ+ndH//ZauJvg4JUG/QODDng6MTLOXr/PEOkh6huYVUp6XYeftADn1
         fATCeS8/JiPnjlgFE+A4W2TditLofmYXXWkSd17C90JE4G1yR5FWGl8LJ7/i50qOCDt0
         o/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yHR05MsLFUBMSpS3mstmS9wP0wF2fxbCYumk3bYclDc=;
        b=H13jBcTXqHOg0YhcIwNX2TgVx4LCKLkzLUGBSx52ku+XLLW0WOc5dcXVR07PNv/RBQ
         zkv1+QrPC5yKrBdXr27tZRJW3diHdzVrCrn6gZqiwrzJvUfCZQMMLdqy/zi6WghdE0JH
         qUapjtQERX9Ug9xS2XFJqlf7kvsBi2JmNolOt84JwdIOcM3sPhxRVcgXLQbMZ4ZeoQE1
         Ydxrp0l60T689HQ9tMNUrgTUduRb9/X1TtfOXhvQuCEQCRnFFdD95GdoaTg7cQGv8sgH
         63+yz1hgWNzTDtXjSGKcTOTQWXLZ3zffWZRt8gjCYIuJggDf8P9avIZ0fTTAHLWPPyQ9
         1QOw==
X-Gm-Message-State: APjAAAX6DfcruodJHo9np1CWp3wPm/R07iMHeuvvzv/uoKmp0dpVphl3
        rB2Gxbc2wt+tpK7//jvbeowsvpDKCRY=
X-Google-Smtp-Source: APXvYqx6f1fVE9xbOwnnlp7trqNopfaePCem8wR4AVImoWE6KDLGcIVFNcQcl74FqXIf4OxuCmcIHg==
X-Received: by 2002:a05:6402:1484:: with SMTP id e4mr9201176edv.286.1576760669808;
        Thu, 19 Dec 2019 05:04:29 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:980f:fddd:828f:9ec3? ([2001:1438:4010:2540:980f:fddd:828f:9ec3])
        by smtp.gmail.com with ESMTPSA id cw10sm482504ejb.56.2019.12.19.05.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 05:04:29 -0800 (PST)
Subject: Re: [PATCH v2 7/9] md: introduce a new struct for IO serialization
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20191121103728.18919-1-guoqing.jiang@cloud.ionos.com>
 <20191121103728.18919-8-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW6e451GhHaTXt8_o=PeV4WGeBKKjn0qvG+tq213SXTr5g@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <708b69d9-f459-eef0-f570-393e4604cd39@cloud.ionos.com>
Date:   Thu, 19 Dec 2019 14:04:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6e451GhHaTXt8_o=PeV4WGeBKKjn0qvG+tq213SXTr5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 12/18/19 8:15 PM, Song Liu wrote:
> On Thu, Nov 21, 2019 at 2:37 AM <jgq516@gmail.com> wrote:
>> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>
>> Obviously, IO serialization could cause the degradation of
>> performance a lot. In order to reduce the degradation, so a
>> rb interval tree is added in raid1 to speed up the check of
>> collision.
> Could you please share some performance measurement with and
> without the new data structure?

TBH, I didn't compare the difference, and I guess the performance
could be better if there is difference, because:

1. If the three members are embedded into rdev, their memory could
be allocated from different memory location, means there could be
potential cache miss when use the three members.

2. With the new struct, the memory of the three members should be
live adjacent if not in the same cacheline, so cache coherency is honored.

Another bonus is the code is more cleaner with the new struct.

> Otherwise, the set looks good to me.

Thanks for your review.

Thanks.
Guoqing
