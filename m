Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C803311EB
	for <lists+linux-raid@lfdr.de>; Mon,  8 Mar 2021 16:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhCHPQt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 8 Mar 2021 10:16:49 -0500
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17297 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhCHPQT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 8 Mar 2021 10:16:19 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1615216578; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=KBNEmliZX8w5vuakvoTN9CaqRCih7bk0YjC4Q56ig4YHot/7iOyPPUyVA2sRWP6ne7xY0paR1M2TNhJOtNe4uWDIkVr9eT73xAmcqo2BqAZMp4NgjUlO/wOPc0LMkqwHMkgNeuPUtKbhy5lTDddzZsB5A2x3sYCKVZ1gFlO2OmQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1615216578; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ONcVyUsOivdtaTRSRTvBcZ5+sAOaf5q06hbUkgLX5Jw=; 
        b=aNHfIEa1D5n5b3iWj1pzwrFGYjA+WG7JetIpNSHXdLjueHmZ2e5An6gEKEGyPL93m9L1nl4RMFjGTpxxcvjxDqdwkgsZDhf+JoqfZ8AyXJCcnljAlTkMUb0nr+dfeCxKodL4/+9sjiMW1+HnIhidDHbFHyh8SChylIxVwz6MMKo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [192.168.99.29] (pool-72-69-75-15.nycmny.fios.verizon.net [72.69.75.15]) by mx.zoho.eu
        with SMTPS id 1615216576837729.910513383186; Mon, 8 Mar 2021 16:16:16 +0100 (CET)
Subject: Re: [PATCH v2] Document PPL in man md
To:     Oleksandr Shchirskyi <oleksandr.shchirskyi@intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20210114125920.42675-1-oleksandr.shchirskyi@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <e571a6f6-c8c9-a00e-e74f-d8dfe2a9edd0@trained-monkey.org>
Date:   Mon, 8 Mar 2021 10:16:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210114125920.42675-1-oleksandr.shchirskyi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 1/14/21 7:59 AM, Oleksandr Shchirskyi wrote:
> Partial Parity Log (PPL) was not documented in the man md.
> Added brief info about PPL.
> 
> Signed-off-by: Oleksandr Shchirskyi <oleksandr.shchirskyi@intel.com>
> ---
>  md.4 | 44 +++++++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 15 deletions(-)

Applied!

Thanks,
Jes


