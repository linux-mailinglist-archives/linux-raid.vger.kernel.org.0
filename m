Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682F720F663
	for <lists+linux-raid@lfdr.de>; Tue, 30 Jun 2020 15:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbgF3Nyv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Jun 2020 09:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbgF3Nyt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 30 Jun 2020 09:54:49 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8622C03E979
        for <linux-raid@vger.kernel.org>; Tue, 30 Jun 2020 06:54:49 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f2so8502783plr.8
        for <linux-raid@vger.kernel.org>; Tue, 30 Jun 2020 06:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hKI90P9PUUShWQ5+4wQBc7xPIwXEAfQYKEsGh1MpJZs=;
        b=DTpxaxoBrlqgFtIm8yAQMb341OyK/ndjEYjXK9tGbhGBwisW4MOxBHZ4AF4FDA/02m
         FE1IEvNVNRcPVI4EfkzNjyzKc28vzwvcAXCPa48q88z6AfYJyEqtZavoB08GtaqwIFmZ
         5msOaC6bHwT4f6NJcL2N48MYAird2/Xlj5iei4yfkZKl2Jgrru0q2OyYJkjRAMbDQ2kB
         VDXDrxP8KF6sFSMpn3AGotfAimtzX2YLcVXjs0JutM1wEqD7nRFwq0bLMjlwHPYp5odZ
         e+66w2vtmERdrhz2mTHMd0mWQ0ZRTEcZzcd3acmnQYyNunRekXJ4MMVmPw5lJJ2ybCJv
         oP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hKI90P9PUUShWQ5+4wQBc7xPIwXEAfQYKEsGh1MpJZs=;
        b=KPyIhqjzDUPZqvagwGNZzWNSF4a6N+TuW0okr2xRhN7vCssNrS/2vduzGTai1DoZ/c
         fOWT6E0oQejQ38l1to/6bq0K15cQ+m2EerIM5gGTF4MQ/y9ksZvH6MtmxXgT+4pYYJ36
         tYMO1C/bcGjqw6zuc6pOGrvoPGA6cG3/br7D3beauSPKSXmCPL6KOajovTYmh/bg3cnw
         H+pT/DdUA32PZw4374Rynmi5ODPCVyEqCb2kq+RFlsyg5h2ZYscGYdSV0GY3Y1yJ3GYK
         MQLgD2Vahb6oEb4CNQHWtzNk8k11mtVWfT4xxgJhaK6Cc7zpx5dz+XkLG+ri2x0HWJXW
         MhWA==
X-Gm-Message-State: AOAM533z85Vnt2zyhoXD3QqZPnKgfg1ZzTo6js0ZLnOm2z+u9h0mKvD0
        uwi/2FnLplo/Ngl1hyNHOgQB9A==
X-Google-Smtp-Source: ABdhPJyz40Dk+a8U1c/CjzUO1QAZkxXoTvB1Z5x2Pa5jkubAyLo6SdeOcTzcPuLBVyj9atcxDTr0Bg==
X-Received: by 2002:a17:902:ff0c:: with SMTP id f12mr18122209plj.254.1593525289171;
        Tue, 30 Jun 2020 06:54:49 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:4113:50ea:3eb3:a39b? ([2605:e000:100e:8c61:4113:50ea:3eb3:a39b])
        by smtp.gmail.com with ESMTPSA id l12sm2722675pff.212.2020.06.30.06.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 06:54:48 -0700 (PDT)
Subject: Re: [PATCH 11/20] fs: remove a weird comment in submit_bh_wbc
To:     Christoph Hellwig <hch@lst.de>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
        drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org
References: <20200629193947.2705954-1-hch@lst.de>
 <20200629193947.2705954-12-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <70e8de25-4e26-9c00-1492-e433ebfdbc90@kernel.dk>
Date:   Tue, 30 Jun 2020 07:54:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629193947.2705954-12-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/29/20 1:39 PM, Christoph Hellwig wrote:
> All bios can get remapped if submitted to partitions.  No need to
> comment on that.

I'm pretty sure that comment is from me, dating back to when the bio
code was introduced in 2001. The point wasn't the remapping, just
that from here on down the IO was purely bio based, not buffer_heads.
Anyway, totally agree that it should just die, it's not that
interesting or useful anymore.

-- 
Jens Axboe

