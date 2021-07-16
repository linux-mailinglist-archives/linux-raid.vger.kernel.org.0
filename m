Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98F13CB8CB
	for <lists+linux-raid@lfdr.de>; Fri, 16 Jul 2021 16:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbhGPOkJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 16 Jul 2021 10:40:09 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17013 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbhGPOkJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 16 Jul 2021 10:40:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1626445325; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Bdm/dMiRaTjmtt3y7JZw/2dGT2WVnx1cH7Sb972oia7VUYkN0ZKX0Pn9gBi6AHqzwiqa3siiWq351yZhCXv086PNE7zx3Sb3puNlUIQPoyhtG00KRPQAu4Xs5dZG8e6ihf1e6/Yr2xclER5kZGLnpUQ0oY2tB8l5uWriNvncwfw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1626445325; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=m7PTygUYR5SxuUswvjOrZs6lDGAGFUS/ilhv2aS1w/M=; 
        b=MBXrSZMj3KncIt+3/xftAxlHZzsUoEFgUHuowbCqDxC8YlZxB0xUkCnJH5qucT8GqBMyEdA6kDFNW6EHcs1qA98iqhqRnLqPD8gZndrLk5uz+uHzlZ/VdDgZbD87X+39ajdX2Nv6g+DeCkppEsYAP5gEuYPPlLYUvwHfB5RFZQc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.29] (pool-72-69-75-15.nycmny.fios.verizon.net [72.69.75.15]) by mx.zoho.eu
        with SMTPS id 1626445324587852.1619408046502; Fri, 16 Jul 2021 16:22:04 +0200 (CEST)
Subject: Re: [PATCH 1/1] mdadm/super1: It needs to specify int32 for
 bitmap_offset
To:     Xiao Ni <xni@redhat.com>
Cc:     ncroxon@redhat.com, linux-raid@vger.kernel.org
References: <1622596639-3767-1-git-send-email-xni@redhat.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <59388bc8-9dc0-f98c-f0ed-1804c9766c6b@trained-monkey.org>
Date:   Fri, 16 Jul 2021 10:22:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1622596639-3767-1-git-send-email-xni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/1/21 9:17 PM, Xiao Ni wrote:
> For super1.0 bitmap offset is -16. So it needs to use int type for bitmap offset.
> 
> Fixes: 1fe2e1007310 (mdadm/bitmap: locate bitmap calcuate bitmap position wrongly)
> Signed-off-by: Xiao Ni <xni@redhat.com>
> ---
>  super1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks!

Jes
