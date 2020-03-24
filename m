Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9D4191248
	for <lists+linux-raid@lfdr.de>; Tue, 24 Mar 2020 14:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgCXN6d (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 24 Mar 2020 09:58:33 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:50885 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgCXN6d (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 24 Mar 2020 09:58:33 -0400
Received: by mail-pj1-f42.google.com with SMTP id v13so1527195pjb.0
        for <linux-raid@vger.kernel.org>; Tue, 24 Mar 2020 06:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x5fXAGIMuTapier1gsbREHE5uidSK9jkxwBjZYaSvro=;
        b=GuHVyfLtEaQS6ua0IdE6tBWddbpDehK1t8pnI71T5sIFDkffsobUKQ4A4ckdACJlzi
         PerQQX9Qo6BJLQXl5vXmyumu2j+Oo/6WJgUeRrWlcScm6FdOlDNkXyueSmJJW7WrQY7X
         ZgkNC/Ym/lLm264Jbgd1w3jrXs/Sjbv+FeVrpPu8GQziZ+l2HH/bAuwdBIMts78UKzu2
         PgLG8T99SXdT7U7Ea6n9HF/10Yfbcw3mSga8g2/gdmzOcr5YJs5Rw/kHSGUnPGIm0M3i
         0Ft6bu+IiOn2ReSIc1tPlou6GSLa/FdCbHTrWDNLhJMPg2455K1qJihwbRXTKnklQn4e
         Njqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x5fXAGIMuTapier1gsbREHE5uidSK9jkxwBjZYaSvro=;
        b=rcsILjWPLyfRuYUI5ZyWmCzYaAOQLary3q9aZYo15zf6i04osoiOOzRh7eKv9OfvYN
         +OddcDwwzdrcPzjZpvgYGD1nyPqCkkgppQ53BAxDHUYz3KllZv1yJfYq0O3g+8aonrXL
         zRLHHHu/FNjnxei1P6CzFveoL2QQDs44Trc0JK6S1GXUOhP4+pD+XJAo2ALFNeeUZ+Ig
         4ibNa1tjJMvSOjgGUV8U7IYyIT29ktk2Qgf5zmQU/VvfE47EKT0+9W/mPhs+zHXtd4WI
         dO2KUT/afQd2XFJ3U7P6FpnXi5CbZOLjo7r7NdKW1JFCEIjbkPKx4w3VZKTBhFSi9FsS
         a50g==
X-Gm-Message-State: ANhLgQ0fbY4a8pTUWjNyrowFcLTpecnAI/UBFXO4hWS7Azu4E59w0Xqh
        5SJjtBtgPgdk32aDSIQkT2gcvA==
X-Google-Smtp-Source: ADFU+vsaJGMoiCAPmnmgto+goF4pP8bLqDaR5wU/oSKkxBsKicj5W2+zA/ckcACIUVr+G6j5uxGbPQ==
X-Received: by 2002:a17:90a:e7c8:: with SMTP id kb8mr5523042pjb.79.1585058311952;
        Tue, 24 Mar 2020 06:58:31 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id 141sm761887pfu.174.2020.03.24.06.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 06:58:31 -0700 (PDT)
Subject: Re: cleanup the partitioning code v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, reiserfs-devel@vger.kernel.org
References: <20200324072530.544483-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bafcc626-16bc-baeb-a0fe-2c2fe4cda14b@kernel.dk>
Date:   Tue, 24 Mar 2020 07:58:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200324072530.544483-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 3/24/20 1:25 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up the partitioning code.
> 
> Changes sinve v1:
>  - rebased to for-5.7/block

Applied, thanks.

-- 
Jens Axboe

