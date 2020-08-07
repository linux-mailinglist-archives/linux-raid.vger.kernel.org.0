Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F29223EE70
	for <lists+linux-raid@lfdr.de>; Fri,  7 Aug 2020 15:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgHGNoU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 7 Aug 2020 09:44:20 -0400
Received: from sender11-op-o12.zoho.eu ([31.186.226.226]:17481 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHGNoR (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 7 Aug 2020 09:44:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1596807847; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=O/C417ggubo2IvHrRMDFXvGB5Zi7skgZBWUb7fy6KD4sQFJb999A9Q1z7xMtGGSPhYUoXPdvzrl7cWvK53Ek3J1RImkdl3itJYx/gMK2FfQ8ooTjGJ4tOiZyg13nPwp5A6t+55bFIJGbyXUGOvTx1rz1v5hEUE80/v2WV87C1fY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1596807847; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=LpwnvngxRbV6lX8QdG4FGOTfqPzMY9j+luVuNIFlSRI=; 
        b=VSXzCDUCzMNw2K/oTGq4+KJ14F7BUEX7WecGfK3tP8frT7ngJmM32QkU8GG5Q7fT6wmPWpTXsSZ3SsRWA+j+xlwb6WCvu1DlVWCVrTIfigAUV2d3JujKIWm5uFz05eHM3e9QqaYhX4p8wMj8FJ0IDvCdgvq/Ue4UgnZZsiUtDBE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [192.168.99.29] (pool-108-46-250-244.nycmny.fios.verizon.net [108.46.250.244]) by mx.zoho.eu
        with SMTPS id 1596807846600180.900077331288; Fri, 7 Aug 2020 15:44:06 +0200 (CEST)
Subject: Re: [PATCH v2] mdadm/md.4: update path to in-kernel-tree
 documentation
To:     Winston Weinert <winston@ml1.net>, linux-raid@vger.kernel.org
References: <20200718103314.14549-1-winstonml1.net>
 <20200722133321.8512-1-winston@ml1.net>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <567445a4-49b1-003c-61c9-9a9e113ee184@trained-monkey.org>
Date:   Fri, 7 Aug 2020 09:44:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200722133321.8512-1-winston@ml1.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/22/20 9:33 AM, Winston Weinert wrote:
> Documentation/md.txt was renamed to Documentation/admin-guide/md.rst
> in linux commit 9d85025b0418163fae079c9ba8f8445212de8568 (Oct 26,
> 2016).
> 
> Signed-off-by: Winston Weinert <winston@ml1.net>
> ---
> I am sending this updated patch which includes a sign-off, fixes a
> commit message typo, and CC's Jes Sorensen. I hope it is up to
> standards.

Applied!

Thanks,
Jes

