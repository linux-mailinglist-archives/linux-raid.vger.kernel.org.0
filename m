Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 387F6A1E28
	for <lists+linux-raid@lfdr.de>; Thu, 29 Aug 2019 17:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfH2PAE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 29 Aug 2019 11:00:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41633 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2PAE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 29 Aug 2019 11:00:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id w5so4386556edl.8
        for <linux-raid@vger.kernel.org>; Thu, 29 Aug 2019 08:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AJ+29D9nAk1LMjcRL3MCptKbRRxLHYMEOsyS4OSFBZ4=;
        b=MEYMhRi72faEo2FLnZKbNodn+IeCxN/pg9nNun+TLjNfSyPM1eHhvf3eBJhUjfFr3K
         SU3D6Pm4gacWBuJPZ1EuKoMqhP3rOwUypDqq8pyLwEyWsdip/aZpDY7cLMgLr40mIuBK
         EuxckywlXr0vrGJiVGOSUkRR3HP2L/jaELZH4EF3oKlTB2zeZMqNu/oMTplRWqOb9Svn
         zKg2XIs02kEE8ym5qo6SPdgGms54kBPYRpfuFKtwQdL0dKP/aij9TsPAymHWl2Fv5wJ2
         fdarA3asXMP4Iq1pH1KvK+ESIfxyPUDcxEVqGQnVy6ylid39hBUaSbNJOV74E8Mt+muh
         CnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AJ+29D9nAk1LMjcRL3MCptKbRRxLHYMEOsyS4OSFBZ4=;
        b=O/ca5EfwXjC3MJBYNvzD/4Isu/nqYDsFHr+GGQt4fe/RfMy4b378l1qJtGfdz3DOfZ
         D+darPHFDTfuLYX+7W4WirgzCsHKk/NkiC1WBRp4giSCkckPcvOzguQhVIK3oUsSKAim
         BlRGhwvwwflVU6tzWIUzGDiXrKMm4P5jU1fMTzaBlYhnSvxnxktl0bTQEOfkeCTSpadm
         069ZC74SLAebfRnkCjFd8+U+CJwNtxRJBnzIjGqZPw+Dtyqa0YB2hMHCzVZPSasqrndy
         1pDwpPHT0W+Q+iaveGEMKnhKMXyvRXltjCP/5xPGBsz4gkrw6kg+0vPGloXy21g7GVde
         wtlw==
X-Gm-Message-State: APjAAAV6aHiXGj6vMcEyVCtxwisMU/c9kX5FYEREqBPBPTAlWauppnr3
        X1h9GfVbQ/vpEzfMTT3wDt+iQUqyGrM=
X-Google-Smtp-Source: APXvYqyhFIZXqAJBtfpWRxTThT5qJYaKW1BC+hxXRYbEavjtkHgV2P89GIDwkf9EMiGlEeTSj16l+w==
X-Received: by 2002:a17:906:75b:: with SMTP id z27mr8697233ejb.67.1567090801863;
        Thu, 29 Aug 2019 08:00:01 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:182d:f323:8d0f:5bd6? ([2001:1438:4010:2540:182d:f323:8d0f:5bd6])
        by smtp.gmail.com with ESMTPSA id h38sm486128eda.58.2019.08.29.08.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 08:00:01 -0700 (PDT)
Subject: Re: [PATCH] raid5: don't warn with STRIPE_SYNCING flag in
 break_stripe_batch_list
To:     Song Liu <songliubraving@fb.com>, Guoqing Jiang <jgq516@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20190828072956.30467-1-guoqing.jiang@cloud.ionos.com>
 <DD8E1764-7CA6-4D9E-8CA7-4988C2FE5740@fb.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <781b7172-4ddf-4c1c-0817-d6ce11df6bcc@cloud.ionos.com>
Date:   Thu, 29 Aug 2019 17:00:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <DD8E1764-7CA6-4D9E-8CA7-4988C2FE5740@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Song,

On 8/29/19 7:42 AM, Song Liu wrote:
> I read the code again, and now I am not sure whether we are fixing the issue.
> This WARN_ONCE() does not run for head_sh, which should have STRIPE_ACTIVE.
> It only runs on other stripes in the batch, which should not have STRIPE_ACTIVE.

 From the original commit which introduced batch write, it has the 
description
which I think is align with your above sentence.

"With below patch, we will automatically batch adjacent full stripe write
together. Such stripes will be added to the batch list. Only the first 
stripe
of the list will be put to handle_list and so run handle_stripe().".

Could you point me related code which achieve the above purpose? Thanks.

BRs,
Guoqing


