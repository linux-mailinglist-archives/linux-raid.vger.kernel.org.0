Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 087AD2A92A
	for <lists+linux-raid@lfdr.de>; Sun, 26 May 2019 11:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfEZJZl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 26 May 2019 05:25:41 -0400
Received: from nsstlmta36p.bpe.bigpond.com ([203.38.21.36]:59922 "EHLO
        nsstlmta36p.bpe.bigpond.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726837AbfEZJZk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Sun, 26 May 2019 05:25:40 -0400
X-Greylist: delayed 638 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 May 2019 05:25:39 EDT
Received: from smtp.telstra.com ([10.10.24.4])
          by nsstlfep35p-svc.bpe.nexus.telstra.com.au with ESMTP
          id <20190526091459.KBJB22935.nsstlfep35p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>
          for <linux-raid@vger.kernel.org>; Sun, 26 May 2019 19:14:59 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddruddvtddgudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuffpveftpgfvgffnuffvtfetnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffuvffkffgfgggtgfesthekredttdefjeenucfhrhhomhepofgrthhthhgvficuofhoohhrvgcuoehmrghtthhhvgifsehmohhorhgvrdhshigunhgvhieqnecukfhppeduvddurddvuddtrdegkedrleeknecurfgrrhgrmhephhgvlhhopegrphhpshhvrhdquddrmhgrthhtqdhsrghmrdgtohhmpdhinhgvthepuddvuddrvddutddrgeekrdelkedpmhgrihhlfhhrohhmpeeomhgrthhthhgvfiesmhhoohhrvgdrshihughnvgihqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeolhhinhhugidqrhgrihgusehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RG-VS-CLASS: clean
Received: from appsvr-1.matt-sam.com (121.210.48.98) by smtp.telstra.com (9.0.019.26-1)
        id 5C1AEA6040D4325C for linux-raid@vger.kernel.org; Sun, 26 May 2019 19:14:59 +1000
Received: from holly.matt-sam.com (unknown [192.168.1.11])
        by appsvr-1.matt-sam.com (Postfix) with ESMTP id 957DE197896
        for <linux-raid@vger.kernel.org>; Sun, 26 May 2019 19:14:58 +1000 (AEST)
From:   Matthew Moore <matthew@moore.sydney>
Subject: Optimising raid on 4k devices
To:     linux-raid@vger.kernel.org
Message-ID: <3a28d64f-9f13-277a-a8f9-3cdf87034200@moore.sydney>
Date:   Sun, 26 May 2019 19:14:58 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi all,

I'm setting up a RAID6 array on 8 * 8TB drives, which are obviously 
using 4k sectors.  The high-level view is XFS-on-LUKS-on-mdraid6.

I've traditionally used partitions appropriately aligned to 4k sectors, 
however my understanding is that modern utilities properly recognise and 
align to the underlying disk structure.

Can I simply create the array on top of the physical disks, do I need to 
tell mdadm to offset/align, or do I need to continue to use partitions 
on the physical disks to get the best performance from this setup?

Many thanks in advance.

