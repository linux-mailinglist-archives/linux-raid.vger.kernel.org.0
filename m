Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A867F10F1D1
	for <lists+linux-raid@lfdr.de>; Mon,  2 Dec 2019 21:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbfLBU7u (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Dec 2019 15:59:50 -0500
Received: from sender11-op-o12.zoho.eu ([185.20.211.226]:17458 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfLBU7t (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 Dec 2019 15:59:49 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575320383; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=BD73pr5K0kvQllDwYrflNXsycaqhvJmN7iORH1e7I95BECCNRbeDp8Vzi9fdOUYcAO/MOiDE+caVUFHnA9qezZJuXdwq+7OgC7XQxionvKNBw/eMP5z8Nj98kjupikc6yJXRG32wx2JFG+YocVe94HjUXjyU2CCvt79WllJ94hM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1575320383; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=KZcSHbGPJLaDRMK2grcX/S2/vValpclzCW3YHOGl7ag=; 
        b=L0IvdLcsKr/h+fiP5BI9hoDgloxxViJ6xWpwSddJ/BQNlvMKSi6cyoI5QxssHQQZIgL0xQQmNFneQQ7bHlJ2fsk6YXeGoBUgANeevSwqNjW+f54m60lLgrpCf250cP71IIVPrrYu1xHWatDdJsb4W0C2Lh0+Ycv1q01WeFXxP7w=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=trained-monkey.org;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [172.30.221.108] (163.114.130.128 [163.114.130.128]) by mx.zoho.eu
        with SMTPS id 1575320383157318.604030980915; Mon, 2 Dec 2019 21:59:43 +0100 (CET)
Subject: Re: [PATCH 1/1] Remove unused code
To:     Xiao Ni <xni@redhat.com>, jes.sorensen@gmail.com
Cc:     artur.paszkiewicz@intel.com, linux-raid@vger.kernel.org
References: <1575018887-5138-1-git-send-email-xni@redhat.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <7f6ef8bd-c096-7a3d-cb5b-9e191392c4a9@trained-monkey.org>
Date:   Mon, 2 Dec 2019 15:59:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575018887-5138-1-git-send-email-xni@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/29/19 4:14 AM, Xiao Ni wrote:
> Signed-off-by: Xiao Ni <xni@redhat.com>
> ---
>   platform-intel.h | 1 -
>   1 file changed, 1 deletion(-)

Applied!

Thanks,
Jes


