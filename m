Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D63F1C5F8D
	for <lists+linux-raid@lfdr.de>; Tue,  5 May 2020 20:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbgEESCs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 May 2020 14:02:48 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17111 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbgEESCs (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 May 2020 14:02:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588701764; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Wf3iehzOTJkQ2xYv4rcWjZXbShrAlhdWw6s5w5poSKhsKJvgEj8wpA+X9QAUuHEb5IMS1sSie9krfyvL7VaKNjBnVynTYAg6a85hIl7F/KAOoNMfdRahilSsm5pTkiqIhHgFy6dIvsYzr5cMb3qnXc4FCO2Jo7YGZ5u57nWCmyE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1588701764; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ZYrp2jBlDejlAVSrPy9xClnVzNt9qh2kDg2e/gHx8fM=; 
        b=ce7vnOtM+0C2lxCzaXu2iGotyvnBWjeMXjBMqDExfD+6nYxKaZ1jLeaCt8lciwfDozlTwr+jFawV5V9otlCvVCzP5xFGpxCpjsL7Is6rDQfBqMTxBogawFVy1XVzlJP1je0SiCqyd+qGG7jZ/BNK6U+0CAFK14Anjc/hFfzWWK4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.124.22] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 1588701762348740.4189002197907; Tue, 5 May 2020 20:02:42 +0200 (CEST)
Subject: Re: [PATCH] Assemble.c: respect force flag.
To:     Tkaczyk Mariusz <mariusz.tkaczyk@intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20200505101717.29553-1-mariusz.tkaczyk@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <2f0b5405-eacd-afc9-69ab-3ffa781045ba@trained-monkey.org>
Date:   Tue, 5 May 2020 14:02:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505101717.29553-1-mariusz.tkaczyk@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/5/20 6:17 AM, Tkaczyk Mariusz wrote:
> From: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
> 
> If the array is dirty handler will set resync_start to 0 to inform kernel
> that resync is needed. RWH affects only raid456 module, for other
> levels array will be started even array is degraded and resync cannot be
> performed.
> 
> Force is really meaningful for raid456. If array is degraded and resync
> is requested, kernel will reject an attempt to start the array. To
> respect force, it has to be marked as clean (this will be done for each
> array without PPL) and remove the resync request (only for raid 456).
> Data corruption may occur so proper warning is added.
> 
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
> ---
>  Assemble.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 38 insertions(+), 13 deletions(-)

Applied!

Thanks,
Jes

