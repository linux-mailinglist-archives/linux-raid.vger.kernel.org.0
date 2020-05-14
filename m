Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DBE1D348E
	for <lists+linux-raid@lfdr.de>; Thu, 14 May 2020 17:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgENPJe (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 14 May 2020 11:09:34 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17103 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgENPJe (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 14 May 2020 11:09:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589468960; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=BIEks24YA9ni4tKLpQV7DQ2VQZZzHEDDQwkDUI9V1eNSoOYZ5rY+ENmkcN6R/P7JWjsBP9iQSRAPcfBxkUdWC42zr2vMmqSjv21cPN56EoP4eQnB/zRR9th9iyQn0e9hUwVchO7G/SsVQDUV7uPks10oDaB5A8EKSTCPkr4K+O0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1589468960; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Wo8QJBJwO9woS99UZv+KhC0h6/Bb5fM4v2eohmFyGGw=; 
        b=VH+L4panexoqdRZO6Tyzx1R5doW8DoJp2E29B7AEp2DiYPOK+gD5/aim4f1mVGXGHDEt+Q0M1U33mqC2EveAzV4xHIKmvWUE9ynD0jr4MLeP0n+Vs7KMBJvjcSaxi6YjOYQ60nbe34AJB0iGkTg30IVeUyGeOCPkybVPBWu1RyA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.129.242] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 1589468958519718.69341397183; Thu, 14 May 2020 17:09:18 +0200 (CEST)
Subject: Re: [PATCH] mdcheck: Log when done
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Jes Sorensen <Jes.Sorensen@gmail.com>
Cc:     Donald Buczek <buczek@molgen.mpg.de>, linux-raid@vger.kernel.org
References: <20200513131646.16357-1-pmenzel@molgen.mpg.de>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <bbb4c492-4fa3-ae68-d045-976c102ab2b3@trained-monkey.org>
Date:   Thu, 14 May 2020 11:09:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513131646.16357-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/13/20 9:16 AM, Paul Menzel wrote:
> From: Donald Buczek <buczek@molgen.mpg.de>
> 
> Currently mdcheck (when called with `--duration`) logs only the
> beginning of the check, the pausing and the continuation but not the
> completion.
> 
> So, log the completion, too, so that it can be determined how long the
> raid check took.
> 
>     2020-05-08T18:00:02+02:00 deadpool root: mdcheck start checking /dev/md0
>     2020-05-08T18:00:02+02:00 deadpool root: mdcheck start checking /dev/md1
>     2020-05-09T15:32:04+02:00 deadpool root: mdcheck finished checking /dev/md1
>     2020-05-09T17:38:04+02:00 deadpool root: mdcheck finished checking /dev/md0
> 
> Cc: linux-raid@vger.kernel.org
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Applied!

Thanks,
Jes

