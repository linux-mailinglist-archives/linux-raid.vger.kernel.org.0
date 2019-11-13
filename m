Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0FCFBBD0
	for <lists+linux-raid@lfdr.de>; Wed, 13 Nov 2019 23:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfKMWnp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 Nov 2019 17:43:45 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:36899 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfKMWnp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 13 Nov 2019 17:43:45 -0500
Received: by mail-pg1-f171.google.com with SMTP id z24so2304871pgu.4
        for <linux-raid@vger.kernel.org>; Wed, 13 Nov 2019 14:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kW1Qp/RQ0OrXX4mVAsXnno09FC+EowXyQ6TOedyPzRE=;
        b=nXY4hlFaFjtZXzK1DCLTzyZGY8X/tRSepjmHcoGS7gc0GXGpzwvYKBM/ypuSIzF5qD
         d9uG9Df+HpbQa0b4CYTKMrS22Wcer0HQQqFv7DhLQ7XBmmCFH3TfKjFK/DPtwioOUYs2
         gTbQm/B/7dZW/ntVSivQEc4VN4uzbLUWNhwnDbQgKpT2WZ74yF+MW802LTiySyg1gw/S
         X69Z3jDFxGWjh4u93x6RbdbXpRhMLDVcDeFKa7bBXQ81b6gixtUvjoHRblcp531r+CHy
         xgJmzK+ecSgwvvEHLcuGFY/J1CeCO/zNp+lCWZ+PPqTSa1b93an3to4ErdbyuaXXb0zm
         K7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kW1Qp/RQ0OrXX4mVAsXnno09FC+EowXyQ6TOedyPzRE=;
        b=F7xJLLjGnfTBTeDfRinXgeVfQi1pXIJWAzWQ1jubOcKyILsFvopjzDLRoZm2+awspx
         oI0VZeKH0CeQXd6z3AJsE7Xv8LKgZbHZdHcfkDcVPDj5lJ2zkZsGsE/tW9L37ui3FEle
         maQfr0EXq/gXPMG7zImy53HuNAwA0VrsLCbkBAYjZ5/2BLYAOEflmcEjbDPnKnhAEQgK
         YDHS2r0ee2qL0QvOTDk+e8bv3ekJRwDBSFymKYTOkypK0ZKrKH7kP+oHQ3GqgB4QLfY7
         0l+o7LbxAGoJd+WkiB0zeRl+qs8dq5x/gciMAD31m2oJ0bVR+cJTKQtMZpvB+3n3Fk9H
         illQ==
X-Gm-Message-State: APjAAAV5MjwLVL7DM9BUz2YWVCGR/kbnnI9GmZVX6lWBliNN9bzor3Qs
        03mkl30KQAktmwCG2eA2VGY3OQ==
X-Google-Smtp-Source: APXvYqxpH0HY/u/tsLngVF14Nn0bfdJTJWFJVsxno4M5e4v+7QIut3ynmNm3rP/HdNP9rwDeG3EkgA==
X-Received: by 2002:a65:68d7:: with SMTP id k23mr6358054pgt.157.1573685023756;
        Wed, 13 Nov 2019 14:43:43 -0800 (PST)
Received: from [192.168.1.182] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id v23sm3891766pfm.175.2019.11.13.14.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 14:43:42 -0800 (PST)
Subject: Re: [GIT PULL] md-next 20191113
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>, Yufen Yu <yuyufen@huawei.com>,
        John Pittman <jpittman@redhat.com>
References: <FE2DE0EF-F9F9-4970-8B73-CEC074391DD7@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <83f080c7-ba18-c04e-8faf-4f5f83f6657b@kernel.dk>
Date:   Wed, 13 Nov 2019 15:43:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <FE2DE0EF-F9F9-4970-8B73-CEC074391DD7@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/13/19 3:39 PM, Song Liu wrote:
> Hi Jens,
> 
> Please consider pulling the following changes for md-next on top of your
> for-5.5/drivers branch.

Pulled, thanks Song.

-- 
Jens Axboe

