Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C4B32C350
	for <lists+linux-raid@lfdr.de>; Thu,  4 Mar 2021 01:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbhCDAAA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 3 Mar 2021 19:00:00 -0500
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17211 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359794AbhCCOvF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 3 Mar 2021 09:51:05 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1614781848; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=jyOwMbcKQhT8jhTrWagygS8rqQBPQNnp4uPy9nS1KXUscLOJ5CEVBGWv3/Q35td1no+oXBQ8sbm8B5WIyJMCdm29EYMxuAxMhKCNB2/EhqGqfbgCuRFtYdUeBZQSjk83L+5ql2idJKS/sBAXuM6UaXK2LvRaUpSFAZwEwQN5iNI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1614781848; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=WEglday9F+Cu/nMW2wdWWetKLScSqnn4UuUu/oCEAME=; 
        b=ZpbxxYK9MJPgmgioXiWX71tjUNdAoLaqFt9RMPPRDR2dYKsnNHv5W4LPkPaiQ/Ox80LurcVm/hDqRF7Q3mr0DEsejrenxs84pqLacPh611S99a4rO2aPPI0rj1NSNVOYidUo8LrZslGHBl+HkxEwoVXVlharfzM8Wso9qxdWMlQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [192.168.99.29] (pool-72-69-75-15.nycmny.fios.verizon.net [72.69.75.15]) by mx.zoho.eu
        with SMTPS id 1614781846511738.6210972608803; Wed, 3 Mar 2021 15:30:46 +0100 (CET)
Subject: Re: [PATCH] super1: fix Floating point exception
To:     Zhao Heming <heming.zhao@suse.com>, linux-raid@vger.kernel.org
Cc:     lidong.zhong@suse.com, xni@redhat.com
References: <1612000194-6015-1-git-send-email-heming.zhao@suse.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <16ff61e7-b59c-639a-62ac-c6cacb1b4781@trained-monkey.org>
Date:   Wed, 3 Mar 2021 09:30:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1612000194-6015-1-git-send-email-heming.zhao@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 1/30/21 4:49 AM, Zhao Heming wrote:
> write_bitmap1 didn't check return value of locate_bitmap1, which will
> operate bitmap area under invalid bitmap info.
> 
> mdadm core dumped when doing below steps:
> ```
> node1 # mdadm -C /dev/md0 -b none -e 1.2 -n 2 -l mirror /dev/sda /dev/sdb
> node1 # mdadm -Ss
> node1 # mdadm -A -U home-cluster --home-cluster=abc /dev/md0 /dev/sda /dev/sdb
> Floating point exception (core dumped)
> ```
> 
> Signed-off-by: Zhao Heming <heming.zhao@suse.com>
> ---
>  super1.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied!

Thanks,
Jes

