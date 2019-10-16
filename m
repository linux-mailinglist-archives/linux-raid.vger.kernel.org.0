Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24452DA17F
	for <lists+linux-raid@lfdr.de>; Thu, 17 Oct 2019 00:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbfJPW0N (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 16 Oct 2019 18:26:13 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:51990 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730142AbfJPW0N (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 16 Oct 2019 18:26:13 -0400
Received: from [86.132.37.73] (helo=[192.168.1.162])
        by smtp.hosts.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iKqut-0003m1-8G; Wed, 16 Oct 2019 22:33:11 +0100
Subject: Re: Degraded RAID1
To:     curtis@npc-usa.com, linux-raid@vger.kernel.org
References: <qo31v1$31rr$2@blaine.gmane.org>
 <5DA5165E.8070609@youngman.org.uk>
 <9bfd62ed-a41c-8093-b522-db0ccbe32b89@npc-usa.com>
 <4e25fa78-846f-42b9-e50a-c4876377a08d@npc-usa.com>
 <be94147a-a244-6f71-5f6a-7c6da8515cf9@youngman.org.uk>
 <1a20554d-1a40-f226-28bc-c3d38f8c7014@npc-usa.com>
 <5DA648B9.7030506@youngman.org.uk>
 <006efea0-ec71-3eaf-a456-7fcc2efe4916@npc-usa.com>
 <5212dd1b-b67d-f7fd-a96b-6281f0501740@youngman.org.uk>
 <ac4a6b63-b886-1c0c-3aad-f77b54246226@npc-usa.com>
From:   Wol <antlists@youngman.org.uk>
Message-ID: <9864d7bd-f2f7-b25e-fa6d-9ca06a9e6b87@youngman.org.uk>
Date:   Wed, 16 Oct 2019 22:33:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ac4a6b63-b886-1c0c-3aad-f77b54246226@npc-usa.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 16/10/2019 22:15, Curtis Vaughan wrote:
> Think I got it working, just want to make sure I did this right. Using
> fdisk I recreated the exact same partitions on sda as on sdb.
>
> Then I ran the mdadm --re-add for each partition to each raid volume. So
> now here are some outputs to various commands. Does everything look right?

Yup. Looks fine.

Because we have two raids on one disk, the rebuild is throttled such 
that only one rebuild is proceeding at a time.

md1 is rebuilding, as it says. Once that completes then all the status 
stuff will look normal, and md0 will start rebuilding.

Don't know how long it will take, but because the raid doesn't know what 
bits of the disk are used and what are not, the complete rebuild will 
take however long it takes to read a 1gig drive from end to end, and 
that is quite a long time ...

Cheers,
Wol

