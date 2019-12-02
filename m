Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD3710F1E5
	for <lists+linux-raid@lfdr.de>; Mon,  2 Dec 2019 22:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfLBVHB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Dec 2019 16:07:01 -0500
Received: from sender11-op-o12.zoho.eu ([185.20.211.226]:17421 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfLBVHA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 Dec 2019 16:07:00 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575320818; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=dQebj40VNmcBOTMTiGZ7drYReDcsc6s/2d3Z/mZT4aHROBu8BcK2pbT5jZ1SSykDdekm4wKSCkZMV/d93QAHuOZZmYYnaLXNlrCe1NH9qWSTGNII8Ps8u4hBl6Uhe0lKAA6TRzIJeYPhGgd0KrQZjMkcxYC+s+ZqL5GVxKgaI+A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1575320818; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=fMNJcf/A+YeJMRsGyS13vyGkjjQgcP6VpMZxfYgiCM8=; 
        b=K29468T33VenafHxDYGndR+npxEQXNFnMTvka1Z4sqk/iXX9qkBUOI8iPRg7kxmA+Kg8jDIGsNvfSunLeUuXJDUMrShQ9/b8x7PuHj1Fngliu15gxSQgLitBSY00O5j8X2JpYtqatxW9aoM6nFyymBSLBfUR1EVD4nIhXXaJGt4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=trained-monkey.org;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [172.30.221.108] (163.114.130.128 [163.114.130.128]) by mx.zoho.eu
        with SMTPS id 157532081758931.518690986800152; Mon, 2 Dec 2019 22:06:57 +0100 (CET)
Subject: Re: [PATCH] imsm: Change the way of printing nvme drives in
 detail-platform.
To:     Blazej Kucman <blazej.kucman@intel.com>, linux-raid@vger.kernel.org
References: <20191202095205.16308-1-blazej.kucman@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <ee096918-52c3-d3c3-ef95-2ef969abb1a2@trained-monkey.org>
Date:   Mon, 2 Dec 2019 16:06:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191202095205.16308-1-blazej.kucman@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 12/2/19 4:52 AM, Blazej Kucman wrote:
> Change NVMe controller path to device node path
> in mdadm --detail-platform and print serial number.
> The method imsm_read_serial always trimes serial to
> MAX_RAID_SERIAL_LEN, added parameter 'serial_buf_len'
> will be used to check the serial fit
> to passed buffor, if not, will be trimed.
> 
> Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
> ---
>   super-intel.c | 97 ++++++++++++++++++++++++++++-------------------------------
>   1 file changed, 46 insertions(+), 51 deletions(-)

Applied!

Thanks,
Jes



