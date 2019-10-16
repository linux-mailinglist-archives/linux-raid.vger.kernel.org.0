Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09E57D97D9
	for <lists+linux-raid@lfdr.de>; Wed, 16 Oct 2019 18:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404582AbfJPQtl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 16 Oct 2019 12:49:41 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:34617 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbfJPQtl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 16 Oct 2019 12:49:41 -0400
Received: by mail-il1-f175.google.com with SMTP id c12so3308392ilm.1
        for <linux-raid@vger.kernel.org>; Wed, 16 Oct 2019 09:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rwIFB0uH6HJJSTqf2C9lLurbyYJFMd5BQz+HjC/Jgqs=;
        b=Z4/4VSzNDsyv2jGtjAaodXbeCA63fvyHy7JmcSzNeyyPgzMCAwNF/+zGMwNB/q5bop
         UW8sVQwNQdj96clzOM1Cdof2S2avu3/U9ifUGtLhZdyTQ1qx0ZeF0ePm4EOM3p/9vLJH
         pUKgOniDvbCE7Fl+AKirUIA/Fc58wRrntMaq/9iCVPhpJYpexjxHr8ueHBPyaSPl/o/O
         w7OMtJ6QwBw4qWkhVo3rwy5qMr0XZdm0vItEm4KIKpLO8lcyYrRELp4Qd32HKiCpuz15
         +rS4xky9IAOSrn9kau/dI7qA/IiNMrR5gu32tgFdGn8koNnfEeSmucfC/gkQDCc6CLfY
         NM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rwIFB0uH6HJJSTqf2C9lLurbyYJFMd5BQz+HjC/Jgqs=;
        b=UYDVvsUhw2/AuRYfECSvS+VzSzPo7nuI8PIxUr0IuHkkdZteoUkTGzZgid6btvvTkK
         lxroWUE3aYJRLuKChEp7kRlLiYw9/WkNJYYuAdyACtPiLKDnYvNYm+piQH0hXTtS0d4h
         jYxEZFQ4rVHrGEkzoqY7JtWk8xscXuvSxOAX3imfny+s2e24/tayJZLZyo2GlJvpvBEa
         SHYh/AcjyWgCCcDbnqcru1tzfKPfH97HASVXh4J2Olt8fXLeqc5WwPNPJRvJRSXVrT3Q
         X1m92k3nq0Z+Orn0L8F+pD6HCHMECKQLGtbxoFapx/mYNAMjOmJRq3eFq0BFX8OyJVyU
         F/bw==
X-Gm-Message-State: APjAAAWgXPBi/lFPWuh6CvLQQiofKqlFDKVNCyDE4cB3yRgVCdgOFCfA
        F/4lDIofLcolJHxsSkoDs4EeRQ==
X-Google-Smtp-Source: APXvYqyIGklExyvFxfvYF+tjd/8WKW33z8zQJ/5rQ3JqcsdPbsBM2YVB1B070hlrP6sCuDHSqar15A==
X-Received: by 2002:a92:a144:: with SMTP id v65mr13134737ili.240.1571244578905;
        Wed, 16 Oct 2019 09:49:38 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e139sm17412062iof.60.2019.10.16.09.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 09:49:37 -0700 (PDT)
Subject: Re: [GIT PULL] md-fixes 20191016
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Kernel Team <Kernel-team@fb.com>
References: <0EEBEA3E-141D-40E5-8E7E-DD1540124ED3@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0bfb0227-16f2-2d1c-1514-e8de44040ef2@kernel.dk>
Date:   Wed, 16 Oct 2019 10:49:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0EEBEA3E-141D-40E5-8E7E-DD1540124ED3@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/16/19 10:48 AM, Song Liu wrote:
> Hi Jens,
> 
> Please consider pulling the following fix for md on top of your for-linus branch.

Pulled, thanks.

-- 
Jens Axboe

