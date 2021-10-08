Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13E64272CD
	for <lists+linux-raid@lfdr.de>; Fri,  8 Oct 2021 23:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243404AbhJHVGj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 8 Oct 2021 17:06:39 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:9377 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243385AbhJHVGj (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 8 Oct 2021 17:06:39 -0400
Received: from host86-155-223-151.range86-155.btcentralplus.com ([86.155.223.151] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1mYx2n-0007Me-9U; Fri, 08 Oct 2021 22:04:42 +0100
Subject: Re: "md/raid:mdX: cannot start dirty degraded array."
To:     Andreas Trottmann <andreas.trottmann@werft22.com>,
        linux-raid@vger.kernel.org
References: <8b0a13e1-0972-be41-d234-2202abe1a54c@werft22.com>
From:   Wol <antlists@youngman.org.uk>
Message-ID: <2f1a309d-cb7d-4f93-10f4-5af96690c935@youngman.org.uk>
Date:   Fri, 8 Oct 2021 22:04:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8b0a13e1-0972-be41-d234-2202abe1a54c@werft22.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 08/10/2021 20:57, Andreas Trottmann wrote:
> Hello linux-raid
> 
> I am running a server that runs a number of virtual machines and manages 
> their virtual disks as logical volumes using lvmraid (so: indivdual SSDs 
> are used as PVs for LVM; the LVs are using RAID to create redundancy and 
> are created with commands such as "lvcreate --type raid5 --stripes 4 
> --stripesize 128 ...")
> 
> The server is running Debian 10 "buster" with latest updates and its 
> stock kernel: Linux (hostname) 4.19.0-17-amd64 #1 SMP Debian 4.19.194-3 
> (2021-07-18) x86_64 GNU/Linux

Ummm is there an lvm mailing list? I've not seen a question like this 
before - this list is really for md-raid. There may be people who can 
help but I've got a feeling you're in the wrong place, sorry.

In md terms, volumes have an "event count", and that error sounds like 
one drive has been lost, and the others do not have a matching event 
count. Hopefully that's given you a clue. With mdadm you'd do a forced 
assembly, but it carries the risk of data loss.

Cheers,
Wol
