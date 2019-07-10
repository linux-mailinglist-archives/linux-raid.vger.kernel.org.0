Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E33B643AE
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jul 2019 10:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfGJIlL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 10 Jul 2019 04:41:11 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:22421 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfGJIlL (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 10 Jul 2019 04:41:11 -0400
Received: from [81.155.195.121] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1hl8A1-0002Gm-7J; Wed, 10 Jul 2019 09:41:09 +0100
Subject: Re: Raid 1 vs Raid 5 suggestion
To:     Xiao Ni <xni@redhat.com>, Luca Lazzarin <luca.lazzarin@gmail.com>,
        linux-raid@vger.kernel.org
References: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
 <5D25196A.9020606@youngman.org.uk>
 <da428a60-aa9a-1cd9-d766-237fd885d425@redhat.com>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5D25A4A4.2000609@youngman.org.uk>
Date:   Wed, 10 Jul 2019 09:41:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <da428a60-aa9a-1cd9-d766-237fd885d425@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/07/19 09:35, Xiao Ni wrote:
> 
> It can create raid device on dm integrity device. So raid can fix the
> silent data corruption
> automatically itself. For example a raid1 with two members A and B. When
> there are some
> data corruption on A disk, the read from A will fail, because dm
> integrity return error to
> raid1. At this time, raid1 can fix this automatically.

Can you point me at some documentation on how to use this? This should
go in the raid wiki, as it sounds like it's something that users ought
to put in the stack, and I never knew about it.

Cheers,
Wol
