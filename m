Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07AC3DD9ED
	for <lists+linux-raid@lfdr.de>; Mon,  2 Aug 2021 16:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbhHBOFN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Aug 2021 10:05:13 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17083 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbhHBOEN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 Aug 2021 10:04:13 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1627913042; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=W4Mv4dp0n6mKxwKNAW+kUciVxFlvxjNYJmeYL5VV0/RffI4+DSJcXUrxFyCijgc+xnQdzoArDH9JmRQHWe0EvBRO5k7YYC7iagvz95ZfwCG51KdNyRxtxfXk0lZmd3CuGObtiCyZUi1Erx1KhqS9sSJ6AxgGUlqVqZAnKodzcRE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1627913042; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=TCyCp60TC6ui3UG8JU/0aNz1L5jW47KZ8RiMWNrLfnU=; 
        b=VNfgpXa/ShPmXesCSNYLgh2OGC76X9puDnqQXgGmPm9vqUkRgdUk3sdadCOodC2lrMxX1Kuh4IGdLzVUqNcqzAd5clqDScezQ3bNa+s+Y2+Mo27V+Ec69UTt9+KiBzcAfFVOEp9iyKnCzLRUfEpZvZm2iObTIb07JTuy+smNgQo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.29] (pool-72-69-75-15.nycmny.fios.verizon.net [72.69.75.15]) by mx.zoho.eu
        with SMTPS id 1627913040240906.7315797561918; Mon, 2 Aug 2021 16:04:00 +0200 (CEST)
Subject: Re: [PATCH] Fix memory leak after "mdadm --detail"
To:     Mateusz Grzonka <mateusz.grzonka@intel.com>,
        linux-raid@vger.kernel.org
References: <20210727082518.10737-1-mateusz.grzonka@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <6ef3205f-26b6-c6b8-b7a6-20f07d19582f@trained-monkey.org>
Date:   Mon, 2 Aug 2021 10:03:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210727082518.10737-1-mateusz.grzonka@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/27/21 4:25 AM, Mateusz Grzonka wrote:
> Signed-off-by: Mateusz Grzonka <mateusz.grzonka@intel.com>

Applied!

Thanks,
Jes


