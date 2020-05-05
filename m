Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC1F1C5F5C
	for <lists+linux-raid@lfdr.de>; Tue,  5 May 2020 19:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbgEERwd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 May 2020 13:52:33 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17016 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729729AbgEERwd (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 May 2020 13:52:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588701146; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=dN+KZWIEgc+kNklz2iKBxJc6vY66OIwmm70hGlHgwY+M5ciGrjj2JedDjYPIrnreGv2Ww+XUiZYyhcxNE30132Zro/XfXoF6w7jgVK0INMVeIt1966W59rTPjXtJd3Vxp1mxOV2q/Qg4GVsoWN4vFsDcdPQkhCm/uEN4fadDuvw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1588701146; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=/W7txdXLDVjjhlorU+TuAts4m8+L4I6aN6mUubj2IK8=; 
        b=IL4sjz82t1mbLaOdtb06/rRJOh+RK64LXR6Gv8pJXC2rIeSFDjHu+VQlAJxKvng/GlWs9V8Hjt9lPOOzZihrCpjPGCnBqOOTz32pcID8i7h0xNFBtcKyWkOS6LzCB34WzSvbhsS4gnYX93jmNbPBrkS+UDR54xRgZHJ+S1nZR7s=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.124.22] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 15887011459421004.4233131775117; Tue, 5 May 2020 19:52:25 +0200 (CEST)
Subject: Re: [PATCH] clean up meaning of small typo
To:     Nigel Croxon <ncroxon@redhat.com>, linux-raid@vger.kernel.org
References: <20200504162745.22665-1-ncroxon@redhat.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <7d2c26a8-f7b0-af52-048b-5eded971cfb8@trained-monkey.org>
Date:   Tue, 5 May 2020 13:52:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504162745.22665-1-ncroxon@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/4/20 12:27 PM, Nigel Croxon wrote:
> Clean up the typo which leads to wrong understanding.
> 
> Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
> ---
>  mdadm.8.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied thanks!

Jes

