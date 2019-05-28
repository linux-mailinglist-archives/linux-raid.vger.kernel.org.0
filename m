Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83F102CFDC
	for <lists+linux-raid@lfdr.de>; Tue, 28 May 2019 21:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfE1T6r (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 May 2019 15:58:47 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:28058 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfE1T6r (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 28 May 2019 15:58:47 -0400
Received: from [86.177.149.27] (helo=[192.168.1.78])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1hViFB-0001Fi-8E; Tue, 28 May 2019 20:58:45 +0100
Subject: Re: Optimising raid on 4k devices
To:     Matthew Moore <matthew@moore.sydney>, linux-raid@vger.kernel.org
References: <3a28d64f-9f13-277a-a8f9-3cdf87034200@moore.sydney>
From:   Wol's lists <antlists@youngman.org.uk>
Message-ID: <b5219c22-7439-26ad-9994-6007aa459467@youngman.org.uk>
Date:   Tue, 28 May 2019 20:58:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3a28d64f-9f13-277a-a8f9-3cdf87034200@moore.sydney>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 26/05/2019 10:14, Matthew Moore wrote:
> Can I simply create the array on top of the physical disks, do I need to 
> tell mdadm to offset/align, or do I need to continue to use partitions 
> on the physical disks to get the best performance from this setup?

There *should* be no difference between raw devices and partitions.

General advice though, is to use partitions, not because of any 
advantage, but because there are utilities out there that assume an 
unpartitioned disk is an empty disk, and will scribble all over your 
data WITHOUT ASKING.

You pays your money and you takes your choice.

Cheers,
Wol
