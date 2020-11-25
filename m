Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A832C4B93
	for <lists+linux-raid@lfdr.de>; Thu, 26 Nov 2020 00:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbgKYXWf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Wed, 25 Nov 2020 18:22:35 -0500
Received: from sender11-op-o12.zoho.eu ([31.186.226.226]:17380 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbgKYXWf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 25 Nov 2020 18:22:35 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1606345647; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=W5gtn5PhQti0VM7YrcGEvr5ktykNBi8ewatTIseJ8hRbdCS+thRGSKPm5RMnRcG9hIOvQR0Uju7LURm2XaP8W89K5ueASul9X9t3hW4w0jjE2zT3yxxDQPqv6z/KStQ7C3EhIxnmFzetXCkpSeQLvKiBInP42PzNzgTB5FqykRQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1606345647; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=bsiicdBKnzozFH0CkAnZ5D7vgTEB9rsQrhIm/EWAakI=; 
        b=F1n+yOqxe0QFrGDnOxHLZ1oPQOM/wRoeNSIKfAWPNrGwbjQRLVHdEkL4/VKRaxsBsdqyZN+1AUwGupOroTfCYqcOITSfPuj032TCI+W3e5FRzYMb/1fbH3CUuP2zrN57JwaPlOJwcCtoPFhYfb44oycgYloCuOTeV6b5R3E1x/Q=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [IPv6:2620:10d:c0a8:1102::1844] (163.114.130.3 [163.114.130.3]) by mx.zoho.eu
        with SMTPS id 1606345647447800.0511187711163; Thu, 26 Nov 2020 00:07:27 +0100 (CET)
Subject: Re: [PATCH] imsm: update num_data_stripes according to dev_size
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20201124131515.1133-1-mariusz.tkaczyk@linux.intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <7a7efa84-2abd-0fb0-97a7-ad2ecf85c2a9@trained-monkey.org>
Date:   Wed, 25 Nov 2020 18:07:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201124131515.1133-1-mariusz.tkaczyk@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/24/20 8:15 AM, Mariusz Tkaczyk wrote:
> If array was created in UEFI there is possibility that
> member size is not rounded to 1MB. After any size reconfiguration
> it will be rounded down to 1MB per each member but the old
> component size will remain in metadata.
> During reshape old array size is calculated from component size because
> dev_size is not a part of map and is bumped to new value quickly.
> It may result in size mismatch if array is assembled during reshape.
> 
> If difference in calculated size and dev_size is observed try to fix it.
> num_data_stripes value can be safety updated to smaller value if array
> doesn't occuppy whole reserved component space.
> 
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> ---
>  super-intel.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 78 insertions(+), 6 deletions(-)

Applied

Thanks,
Jes



