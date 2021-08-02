Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7313DDAEA
	for <lists+linux-raid@lfdr.de>; Mon,  2 Aug 2021 16:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhHBOYq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Aug 2021 10:24:46 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17046 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbhHBOYn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 Aug 2021 10:24:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1627913117; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=G5UfGQE0hIGrAsfQWgTXKss08Z17fUXcJZhqSsbU+WcnaZtXLUiS5NvRWD1W6BaV63180vh0A5fzycQsCCuag4eedr0++AeD98XuQxqNEuSwfcgB2gV9xlXbZJZg+CqsqUI/e7dNpgB8WSnUoPSeCnwsxQTneRIVVO6y6gV2v/4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1627913117; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=YnRx+xcKdXlhXDfGb0361amTLV/SUn9kVdD83DNEkoM=; 
        b=j904yepQCtu6IWTfPgbwzkuRIGsCuHjywmsxvGTX7H5ne3VWdciJvpa0VzxvuWR0wbu8Xleq0Etrc1abnzHjQiA97UeKaGq/DA+JRbPap9jje/8mA3Putz5CENeumhGSe9CnXVdQ1FCU1HWBDRzAYciLC23MTgK/uvGsLZiFIYU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.29] (pool-72-69-75-15.nycmny.fios.verizon.net [72.69.75.15]) by mx.zoho.eu
        with SMTPS id 1627913113537834.2845869251804; Mon, 2 Aug 2021 16:05:13 +0200 (CEST)
Subject: Re: [PATCH] tests: Avoid passing chunk size when creating RAID 1
To:     Mateusz Grzonka <mateusz.grzonka@intel.com>,
        linux-raid@vger.kernel.org
References: <20210728143111.4478-1-mateusz.grzonka@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <bdcc98ec-72bc-d0ab-7e82-7e00bc02447f@trained-monkey.org>
Date:   Mon, 2 Aug 2021 10:05:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210728143111.4478-1-mateusz.grzonka@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/28/21 10:31 AM, Mateusz Grzonka wrote:
> Tests fail because passing chunk size for RAID 1 is now forbidden.
> Failing tests:
> - 14imsm-r1_2d-grow-r1_3d
> - 14imsm-r1_2d-takeover-r0_2d
> - 18imsm-1d-takeover-r1_2d
> - 18imsm-r1_2d-takeover-r0_1d
> 
> Correct tests to not pass chunk size when RAID level is 1.
> 
> Signed-off-by: Mateusz Grzonka <mateusz.grzonka@intel.com>
> ---

Applied!

Would be nice to have a test that catches attempts to pass chunksize to
raid 1 to make sure it fails :)

Thanks,
Jes


