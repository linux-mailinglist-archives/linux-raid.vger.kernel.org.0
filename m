Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434001A7FB9
	for <lists+linux-raid@lfdr.de>; Tue, 14 Apr 2020 16:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390735AbgDNO1Z (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Apr 2020 10:27:25 -0400
Received: from mail.thelounge.net ([91.118.73.15]:32923 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390719AbgDNO1U (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Apr 2020 10:27:20 -0400
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 491nr36ZghzXP1;
        Tue, 14 Apr 2020 16:27:15 +0200 (CEST)
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
To:     Wols Lists <antlists@youngman.org.uk>,
        Stefanie Leisestreichler 
        <stefanie.leisestreichler@peter-speer.de>,
        linux-raid@vger.kernel.org
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
 <5E95C698.1030307@youngman.org.uk>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <e23e36e5-7cb0-4e9c-5929-adce833c45f9@thelounge.net>
Date:   Tue, 14 Apr 2020 16:27:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5E95C698.1030307@youngman.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 14.04.20 um 16:20 schrieb Wols Lists:
> On 14/04/20 14:02, Stefanie Leisestreichler wrote:
>> Hi List.
>> I want to set up a new server. Data should be redundant that is why I
>> want to use RAID level 1 using 2 HDs, each having 1TB. Like suggested in
>> the wiki, I want to have the RAID running on a partition which has
>> TOTAL_SIZE - 100M allocated for smoother replacement of an array-disk in
>> case of failure.
>>
>> The firmware is UEFI, Partitioning will be made using GPT/gdisk.
>>
>> Boot manager should be GRUB (not legacy).
> 
> Why? Why not EFI? That can boot linux just as easily as it can boot grub

because people prefer to boot the old kernel when something goes wrong
which is somehow difficult by just using uefi-stub
