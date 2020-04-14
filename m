Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6949E1A8AFD
	for <lists+linux-raid@lfdr.de>; Tue, 14 Apr 2020 21:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504921AbgDNTgS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Apr 2020 15:36:18 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:47210 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504919AbgDNTgR (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 Apr 2020 15:36:17 -0400
Received: from [81.157.200.200] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jORLz-0007Zd-6i; Tue, 14 Apr 2020 20:36:15 +0100
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
To:     Stefanie Leisestreichler 
        <stefanie.leisestreichler@peter-speer.de>,
        linux-raid@vger.kernel.org
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
 <5E95C698.1030307@youngman.org.uk>
 <13a3bc12-67f7-46d5-7e6a-c6880ace4b1c@peter-speer.de>
 <5E95F461.50209@youngman.org.uk>
 <fe996f6f-3b0a-4638-d74d-ae6dc99599df@peter-speer.de>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5E9610AE.3000507@youngman.org.uk>
Date:   Tue, 14 Apr 2020 20:36:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <fe996f6f-3b0a-4638-d74d-ae6dc99599df@peter-speer.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14/04/20 20:13, Stefanie Leisestreichler wrote:
>> I'd just use type linux ...

> Could you please be a little more concrete on this one?

The old scheme linux disks were 83. That makes it 8300 on gpt. Like 82
is swap.

At the end of the day, linux doesn't care much. So why should you? In
the old days you needed disk-type raid to tell the kernel to
auto-assemble it, but you shouldn't be using that nowadays.

Cheers,
Wol
