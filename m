Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDE3200B23
	for <lists+linux-raid@lfdr.de>; Fri, 19 Jun 2020 16:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgFSOQL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 19 Jun 2020 10:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgFSOQJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 19 Jun 2020 10:16:09 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE9AC06174E
        for <linux-raid@vger.kernel.org>; Fri, 19 Jun 2020 07:16:08 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id t21so7693951edr.12
        for <linux-raid@vger.kernel.org>; Fri, 19 Jun 2020 07:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wnRv7ZO/+hIEBpVm8uHuNDLIQJ+F0xbx5hryFxt8Ub0=;
        b=XzI2Q5LEu7qnT5fAl5Iv/vOlXfKOcZFEu8O9wwlHyRjCh+IUy9c5e9aHZC/4GfSxJg
         77glo23LkIYXmsg00OULOOT2jQLnCFTQ3xJrLD0gbP+5HaY19LWne4xkHQC7y59BIroo
         jS57cuVVaYB4+zMJ56Fb3xRiPmpkSol7irZIrcN08edWNmYWieTyWV7b/LLcDjWsQ/nv
         cFMLtjP7SVhf2nY8LMjeegDjgzE+2I1jcZq/NaS9er5LIMhZhfJmBaM6ANB1ZmHsrTt3
         nPQ06Tq/W+WzPRrejscjGtVoJXS/c7dr+LYzegKh78L7G/09/TtZVPwzoAoiFLacYHXE
         0NzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wnRv7ZO/+hIEBpVm8uHuNDLIQJ+F0xbx5hryFxt8Ub0=;
        b=HPwUievx/pEpcX9NXGd2CS1/gYQmJZVSwzIN3IPF9Vi2hEhTalGFb3/pFG4mCWnlF9
         hIYxCSYCJNlS+HV1JmJwWsFab6Nza+f+a1X52Se0UjLIHS9nt3sONE38K9qUJMfqMfHo
         qypELXOy/FGvtMYfrXfF9clsa+OHWAjgqg+ldWrU3FE+gy1Kb4s+HctCr/8cjkmBc1rU
         WVBlmzTYn5SCiQzeRDyhTqExmUm7fH6CpF5nUJj8mERuh3SCBON+rl86CwtTK9I9/LwJ
         cHg9/z/o24fnq0r4Iwje2U3f9buZulECHZae2AsU8PeD73BRDO0JaPNMhK71KKjcCbyO
         WBZA==
X-Gm-Message-State: AOAM5300R+1CqoGVyrGmWajZ/98ycSJmlPv0VptZ4LtUmi/ieFW3J7EE
        H81XmJLjUPTPTSUi+nqMmlALz35lwnC+Yw==
X-Google-Smtp-Source: ABdhPJxW7blQ/YmOnyvwOERHtPHi04gV5Uyj9eG3AhUcSuJRSKVm3cB2WyMTLqfm6ZBdZYzXSOdu9Q==
X-Received: by 2002:aa7:c157:: with SMTP id r23mr3616240edp.139.1592576167415;
        Fri, 19 Jun 2020 07:16:07 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48f6:5100:b0c1:1cd:44ba:a39f? ([2001:16b8:48f6:5100:b0c1:1cd:44ba:a39f])
        by smtp.gmail.com with ESMTPSA id be19sm4738373edb.5.2020.06.19.07.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 07:16:06 -0700 (PDT)
Subject: Re: [PATCH 1/3] raid5: call clear_batch_ready before set
 STRIPE_ACTIVE
To:     linux-raid@vger.kernel.org
Cc:     song@kernel.org
References: <20200616092552.1754-1-guoqing.jiang@cloud.ionos.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <acdb9e17-acf4-1e0e-f3cc-b90a1bf9748c@cloud.ionos.com>
Date:   Fri, 19 Jun 2020 16:16:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616092552.1754-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/16/20 11:25 AM, Guoqing Jiang wrote:
> [593764.644269] stripe state: 2003
> kernel: [593764.644299] ------------[ cut here ]------------
> kernel: [593764.644308] WARNING: CPU: 12 PID: 856 at drivers/md/raid5.c:4625 break_stripe_batch_list+0x203/0x240 [raid456]

This happens with our own kernel, so the line number can't match with 
upstream kernel.

static void break_stripe_batch_list(struct stripe_head *head_sh,
                                     unsigned long handle_flags)
{
         struct stripe_head *sh, *next;
         int i;
         int do_wakeup = 0;

         list_for_each_entry_safe(sh, next, &head_sh->batch_list, 
batch_list) {

                 list_del_init(&sh->batch_list);

*WARN_ONCE(sh->state & ((1 << STRIPE_ACTIVE) |*

The warning was happened at above line.

Thanks,
Guoqing
