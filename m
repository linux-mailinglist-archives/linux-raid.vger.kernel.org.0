Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F6F2C4B99
	for <lists+linux-raid@lfdr.de>; Thu, 26 Nov 2020 00:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbgKYXZJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 25 Nov 2020 18:25:09 -0500
Received: from sender11-op-o12.zoho.eu ([31.186.226.226]:17308 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgKYXZJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 25 Nov 2020 18:25:09 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1606345803; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=kQAjdA/O+L7l5nIX6nGvdIuq0PDIx0ieDkUSAEQRmLd4tVfqxu1Cmvu9CWJAmz7j5Crb5ChkhzxKkCGrrlWxby3CYdaQgtHbaAF+N0qv+EyfqiA4agPpoDyLOzvGQ2URuO84LQjxexbK3f1ubtfetdpIcuoAhqALxZ5Xwaft0tQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1606345803; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=MJJDa5qcD+cjiZ7Dv+3dBCxJAL5cmBtZ5zsFci0CD+k=; 
        b=HWF2fdwchkRTt2YzWM8sJjTMZ1QC2BaqpqT3R2tbuHZWmh79oNAnh9T/n5REd6gDOF/1J02qilk5bIEDXWhc0/vypu44GYDwGcl9wa7mWjnvvTpl+LugSszKHB82GOG22ARn+TSN0THheITtgWGgAKA79St5rYLVejTRfVuv+5M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [IPv6:2620:10d:c0a8:1102::1844] (163.114.130.3 [163.114.130.3]) by mx.zoho.eu
        with SMTPS id 1606345803098766.2756473933701; Thu, 26 Nov 2020 00:10:03 +0100 (CET)
Subject: Re: [PATCH] imsm: limit support to first NVMe namespace
To:     Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20201104090128.17096-1-mariusz.tkaczyk@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <7c2d0164-8ca1-539e-d1fc-e1d3752cd981@trained-monkey.org>
Date:   Wed, 25 Nov 2020 18:10:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201104090128.17096-1-mariusz.tkaczyk@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/4/20 4:01 AM, Mariusz Tkaczyk wrote:
> Due to metadata limitations NVMe multinamespace support has to be removed.
> 
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
> ---
>  platform-intel.c | 31 +++++++++++++++++++++++++++++++
>  platform-intel.h |  1 +
>  super-intel.c    | 11 ++++++++++-
>  3 files changed, 42 insertions(+), 1 deletion(-)
> 

Applied!

Thanks,
Jes


