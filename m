Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C60C375C53
	for <lists+linux-raid@lfdr.de>; Thu,  6 May 2021 22:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhEFUmB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 May 2021 16:42:01 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17009 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEFUmB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 6 May 2021 16:42:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620333654; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=NUQxgTJ5mx2e7jaHY6uEfeZ6mQ1EqFki0YMJc/NZlrbxt0SxQuaikBjXb1eYd+r/fl1LlqSOG2h2/EhDbzmm5rYcfV+FXz4DMHshhwOVcHMMhWfKcWvJj9NwiG/w0LIZj+6sPXY7y/SPKiUrQWk5vSJNZhpeTVq5vr9B/GX7DeE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1620333654; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=i5qZyX0zBTyYEekvj9xIhj83C8taDkSFnduKXn4HtVk=; 
        b=k0pus1zVv3Vpn5vQtzd70p6D6mlz15qlShIPkCOXkboloSwNCdRbQk3+C04mNa9sFnr2FU+USZhxZAIEdek5gvpGPZSs1wblqHBu5zk8OMG+aoUL4a8QHBhJS/LhAk34CsXaG4W5+9ZF025BimBLtKFt9cTr3Ol9dn5QbMUAzxs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [192.168.99.80] (pool-72-69-75-15.nycmny.fios.verizon.net [72.69.75.15]) by mx.zoho.eu
        with SMTPS id 1620333650711841.0678328939008; Thu, 6 May 2021 22:40:50 +0200 (CEST)
Subject: Re: [PATCH] imsm: change wrong size verification
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20210421145008.8877-1-mariusz.tkaczyk@linux.intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <c3e1e532-b5fc-ca6a-fb36-0664b7ca67e8@trained-monkey.org>
Date:   Thu, 6 May 2021 16:40:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210421145008.8877-1-mariusz.tkaczyk@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/21/21 10:50 AM, Mariusz Tkaczyk wrote:
> Expectation that size is always rounded is incorrect.
> Just confirm that size is smaller to be certain that update is safe.
> 
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> ---
>  super-intel.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied!

Thanks,
Jes

