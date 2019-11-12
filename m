Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B708F9B38
	for <lists+linux-raid@lfdr.de>; Tue, 12 Nov 2019 21:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKLUuB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 12 Nov 2019 15:50:01 -0500
Received: from sender11-op-o12.zoho.eu ([185.20.211.226]:17499 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfKLUuB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 12 Nov 2019 15:50:01 -0500
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Nov 2019 15:50:00 EST
ARC-Seal: i=1; a=rsa-sha256; t=1573590893; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=PbbiwMSXczqDwlPQo6O5oprC1+XqknazqBv3FC1cJx92glOj4Bp6OiJn0cFpL8fOyh6nJGjhwPwW7qPK/Fh0D3/Ufoqy6d4tzaxuw7LlU2wJrDFRC+E6Y8aqQxPhoXhbNpvhxHT22Ol/wGVsEZMGsgrms8VfROQ06XU6VQDDO5U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1573590893; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=VLp0mNOtokQrCk6zZw94genWc4f7v2SprvO9YdaoL4Y=; 
        b=DhLWYBmetdaaMVicl6AF6TvBehQCH9NUQi6onZKIjY9GXMTkgZNf2oCH3TZIvzHeAbgDkQEgkhXmisSZOzqsdzDurmdUmYtzeLyMWZ4u6VkUOqkFth0Qyr/eI8eh+q1ZRnpPbswfHNRrBl4ptGnuFQDN//RTp/7wO1cxjrJP34s=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=trained-monkey.org;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [172.30.223.21] (163.114.130.128 [163.114.130.128]) by mx.zohomail.com
        with SMTPS id 1573590892188270.69376897409927; Tue, 12 Nov 2019 21:34:52 +0100 (CET)
Subject: Re: [PATCH] imsm: allow to specify second volume size
To:     Krzysztof Smolinski <krzysztof.smolinski@intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20191108105911.13963-1-krzysztof.smolinski@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <806afd27-a862-72a5-502f-384911d4c320@trained-monkey.org>
Date:   Tue, 12 Nov 2019 15:34:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191108105911.13963-1-krzysztof.smolinski@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/8/19 5:59 AM, Krzysztof Smolinski wrote:
> Removed checks which limited second volume size only to max value (the
> largest size that fits on all current drives). It is now permitted
> to create second volume with size lower then maximum possible.
> 
> Signed-off-by: Krzysztof Smolinski <krzysztof.smolinski@intel.com>
> ---
>   super-intel.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)

Applied!

Thanks,
Jes



