Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C196C28B9
	for <lists+linux-raid@lfdr.de>; Mon, 30 Sep 2019 23:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbfI3VWG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Sep 2019 17:22:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44419 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732265AbfI3VWG (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Sep 2019 17:22:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so6297092pfn.11
        for <linux-raid@vger.kernel.org>; Mon, 30 Sep 2019 14:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WAWxAM4MiYYR9staQmE3LGTC6hw+7DJK+Y5Quf5l8qU=;
        b=G4plOpiASC0lArw6GgkMwNawC6h0jBsJYcb3QvL1NeSdzWK5ZiuaMYEkz+P96volcM
         o8ZHKRGWxBaCpmkf/un9A6GI6sEdG0aKGh6HRGbsfy2Mj7RLh1CMvKR6DmJFktSxxCde
         3eJsJcUpwLVy5yLphYtKyt1PrziGa2LFNbRZosthKgBb0wOTFyeNJ4e4Y3R7TP5y81zq
         xIEojbxSE7D9HSsOaCcm0WCp+hztML9ZVOjJilc7wgS//vgM0uFbTp2q0G3o5JEEgWtd
         mud0AhiGyHFQmoLscJeAvZ6WlKIO/oiJEofbu62/dfjQQPiru6vA4IEMUCGAZQMHOpDL
         AQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WAWxAM4MiYYR9staQmE3LGTC6hw+7DJK+Y5Quf5l8qU=;
        b=UomFu1T52ezJAMq8O1ZcuF78MnkxPsFRbj1qNhgqqsCUQwo6St4ImuaRr94UJTzh41
         Cwhs6UwsGcEVsUkfK2LHSxzhvn750JsVx9bozbFUH5066zGi3NzrnmJ4lyKK0Xp7BHNM
         z+n/5SoYzf/IPb362Lt315HH4taCMLErvo7ytB32M+k1trnUMjeTxdx98S6+W2L/13Ja
         0yE8OVQNUuf2Gi0EqE8WDbdxsNZVZY4eTVclgSe3wgOqJmch3ZhPRFuBx7HzqQRW7QKz
         pNFKEJDST7wOmAv5DC99D4s86EthKk4ycedrCB1+BKIf+fOeTYSfLLyAEX/BE+zBdwR2
         PGEg==
X-Gm-Message-State: APjAAAVJzgwDVshjTtHSyuEx3ttJWJBtjxWZBmz13XZVF3Oz4fdizksX
        Wo5dxK8ETQRAfdjWeYmDcvm8rCnoEHM=
X-Google-Smtp-Source: APXvYqwOa+843o2OLaSZ1PXOD4gNfdFuznZH+HKf2hxsZbctK8pLJplHKh1ejd/6svzgGK0mEFjfog==
X-Received: by 2002:a62:5f83:: with SMTP id t125mr23561520pfb.125.1569871868072;
        Mon, 30 Sep 2019 12:31:08 -0700 (PDT)
Received: from [172.19.249.239] ([38.98.37.138])
        by smtp.gmail.com with ESMTPSA id b5sm14973839pfp.38.2019.09.30.12.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 12:31:07 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [mdadm PATCH 0/2] Fix two bugs of md cluster testing
To:     Xiao Ni <xni@redhat.com>, linux-raid@vger.kernel.org
Cc:     ncroxon@redhat.com, heinzm@redhat.com, zlliu@suse.com
References: <1569844080-5816-1-git-send-email-xni@redhat.com>
Message-ID: <a000d8ce-998b-c427-1b95-6f431bd3307c@gmail.com>
Date:   Mon, 30 Sep 2019 15:30:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1569844080-5816-1-git-send-email-xni@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9/30/19 7:47 AM, Xiao Ni wrote:
> Xiao Ni (2):
>    Init devlist as an array
>    Don't need to check recovery after re-add when no I/O writes to raid
> 
>   clustermd_tests/02r1_Manage_re-add | 2 --
>   clustermd_tests/func.sh            | 3 +++
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 

Applied!

Thanks,
Jes

