Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D1BF1AA4
	for <lists+linux-raid@lfdr.de>; Wed,  6 Nov 2019 17:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732022AbfKFQAL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 6 Nov 2019 11:00:11 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39328 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731973AbfKFQAL (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 6 Nov 2019 11:00:11 -0500
Received: by mail-ed1-f68.google.com with SMTP id l25so19773252edt.6
        for <linux-raid@vger.kernel.org>; Wed, 06 Nov 2019 08:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=4sIrEe8AGLpcDCPA65f1B+3QJ2WNXrn8OjlIEzOTzBE=;
        b=PVomm/lbeCDHkDQ0sIWzTpEYf0eEevqBey2/QHgEOb/rtHV0hdY5/PQ1he0BL4D5AG
         oRHGeSHKrzFPKFAgF3rvv4DgHMqNyiqF76A9zpCBSOjir4UxHGaiwipPUfcT+e4c+nwU
         XaSSkH+6LlDXAM07VjE1ZJrVhWfeLTzDmR6qbHikMcuXYDZjv/EC77xRgHWJywfOH/S9
         wx/Ikj5eQeJ2n0rd8AhdVrZ//Vy55DFNViYyk28ZyWxmmyh+as7x8I3gvcMmSyVS07jf
         MAykOPQoV5aof6FeAQSEuGFgw1i26KfLErJ8rUKslXdHPZxtLpvdasUwTrm6sZZspEgQ
         HWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4sIrEe8AGLpcDCPA65f1B+3QJ2WNXrn8OjlIEzOTzBE=;
        b=mPUIEQ7GDcTTIFOOeb/YSaw6EtBvM2wv67RbbYQPHLueU0xF+e8L6KFqejLct+p7wk
         u9Utj2XzIS1OXeUgIqXkHSnrZXJ5YQ3fXn+0kvMJRmqGZgbdmxuHs9OmA86CLlePglZ2
         b8/79BAMv1XaAEioRCRq4q1mZ0u3RiXrjLXVDKsSMpLxXjiseEitg44z0Mq29fNHk+L6
         Pqff2Q+NWJQ+HRv1pmzTxo11OxMTo8b0EyxC0PBEZjchIo6aMGOEM2ifxpWhtXS/6Sd1
         7DsRr2c0LeWLpjegLd2cjaIS0/1RNrl1b8ZGQmQRsT0x4eUrXK9aKUesg6w3X7Z1EH50
         BBPQ==
X-Gm-Message-State: APjAAAWRqsSqNZa2nXDpMjIdQej02crJAISyt+GdagmB8VaMkdGth2RW
        x9JHMWb4il3FgDXOQGVxxfICb1ipUxBjPA==
X-Google-Smtp-Source: APXvYqw9ytOOpQnNlo5rlxXZZsTgGlkm2/fPxLDZpSfJLbXBGY/Lvgy2npmRqW2vMWeCb5UXumIcDg==
X-Received: by 2002:a17:906:1611:: with SMTP id m17mr36374702ejd.281.1573056009660;
        Wed, 06 Nov 2019 08:00:09 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:1c1:e73c:e916:21a0? ([2001:1438:4010:2540:1c1:e73c:e916:21a0])
        by smtp.gmail.com with ESMTPSA id x29sm1189923edi.20.2019.11.06.08.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 08:00:08 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: Re: [PATCH] raid456: avoid second retry of read-error
To:     Nigel Croxon <ncroxon@redhat.com>, linux-raid@vger.kernel.org,
        liu.song.a23@gmail.com
References: <20191104200157.31656-1-ncroxon@redhat.com>
Message-ID: <e9556de8-c3d5-f9ef-7f0b-434b2b032fbd@cloud.ionos.com>
Date:   Wed, 6 Nov 2019 17:00:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191104200157.31656-1-ncroxon@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 11/4/19 9:01 PM, Nigel Croxon wrote:
> +static ssize_t raid456_retry_re_store(struct mddev *mddev, const char *buf, size_t len)
> +{
> +	int retry;
> +
> +	if (!mddev->private)
> +		return -ENODEV;
> +
> +	if (len > 1 ||
> +	    kstrtoint(buf, 10, &retry) ||

Maybe kstrtobool fits better here if the value should only be 1 or 0.

> +	    retry < 0 || retry > 1)
> +		return -EINVAL;
> +
> +	set_raid456_retry_re(mddev, retry);
> +	return len;
> +}

I'd suggest use raid5 instead of raid456 since all the levels are 
implemented inside
raid5.c.


Thanks,
Guoqing

