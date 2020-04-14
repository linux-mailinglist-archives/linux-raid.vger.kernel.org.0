Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF87E1A8451
	for <lists+linux-raid@lfdr.de>; Tue, 14 Apr 2020 18:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389768AbgDNQOK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Apr 2020 12:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389581AbgDNQOD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 Apr 2020 12:14:03 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57333C061A0C
        for <linux-raid@vger.kernel.org>; Tue, 14 Apr 2020 09:14:03 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jOOCG-0007Vj-9y; Tue, 14 Apr 2020 18:14:00 +0200
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
To:     G <garboge@shaw.ca>, linux-raid@vger.kernel.org
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
 <f9f2f479-2899-6774-eb20-bf81ed24bc7b@shaw.ca>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Message-ID: <c6be03e8-7726-f184-7752-b41732a9e015@peter-speer.de>
Date:   Tue, 14 Apr 2020 18:14:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f9f2f479-2899-6774-eb20-bf81ed24bc7b@shaw.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1586880843;c1ba7605;
X-HE-SMSGID: 1jOOCG-0007Vj-9y
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 14.04.20 18:00, G wrote:
> Since you are running disks less than 2TB I would suggest a more 
> rudimentary setup using legacy bios booting. This setup will not allow 
> disks greater than 2TB because they would not be partitioned GPT. There 
> would still be an ability to increase total storage using more disks. 
> There would be raid redundancy with the ability for grub to boot off 
> either disk.
> 
> Two identical partitions on each disk using mbr partition tables.

Thank you for your thoughts and input.
I would prefer using uefi/gpt in favor of legacy setup even you are 
totally right about the 2TB border.
