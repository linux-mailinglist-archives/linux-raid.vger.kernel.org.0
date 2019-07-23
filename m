Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFD5720CA
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jul 2019 22:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbfGWUaP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Jul 2019 16:30:15 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:40684 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729768AbfGWUaP (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 23 Jul 2019 16:30:15 -0400
Received: from [81.155.195.121] (helo=[192.168.1.78])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1hq1QL-0001YL-9p; Tue, 23 Jul 2019 21:30:13 +0100
Subject: Re: Raid 1 vs Raid 5 suggestion
To:     Luca Lazzarin <luca.lazzarin@gmail.com>,
        Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        Xiao Ni <xni@redhat.com>
Cc:     linux-raid@vger.kernel.org
References: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
 <5D25196A.9020606@youngman.org.uk>
 <da428a60-aa9a-1cd9-d766-237fd885d425@redhat.com>
 <5D25A4A4.2000609@youngman.org.uk>
 <6e20bc11-9afb-3183-102e-2305990d5c89@redhat.com>
 <20190710173354.GA5523@lazy.lzy>
 <08871cf8-8ae7-cde1-7b45-0d75fe42026e@gmail.com>
From:   Wol's lists <antlists@youngman.org.uk>
Message-ID: <1a8b3284-1338-9165-6359-5fdc71430b22@youngman.org.uk>
Date:   Tue, 23 Jul 2019 21:30:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <08871cf8-8ae7-cde1-7b45-0d75fe42026e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 23/07/2019 21:16, Luca Lazzarin wrote:
> Thank you all for your suggestiong.
> 
> I'll probably choose RAID6.

Any chance of putting it on top of dm-integrity? If you do can you post 
about it (seeing as it's new), but it sounds like it's something all 
raids should have.

Cheers,
Wol
