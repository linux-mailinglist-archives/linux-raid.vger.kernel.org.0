Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB24235A15
	for <lists+linux-raid@lfdr.de>; Sun,  2 Aug 2020 21:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgHBTBo (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 2 Aug 2020 15:01:44 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:54855 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbgHBTBo (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 2 Aug 2020 15:01:44 -0400
Received: from host86-157-100-178.range86-157.btcentralplus.com ([86.157.100.178] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1k2JEs-0001rd-BN; Sun, 02 Aug 2020 20:01:42 +0100
Subject: Re: Restoring a raid0 for data rescue
To:     tyranastrasz@gmx.de, linux-raid@vger.kernel.org
References: <S1726630AbgHBR6v/20200802175851Z+2001@vger.kernel.org>
 <68c39e83-1155-0c8d-96a9-0418bdaf850d@gmx.de>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <7437ab4d-9cd1-fe53-a17a-fc9e966ccd92@youngman.org.uk>
Date:   Sun, 2 Aug 2020 20:01:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <68c39e83-1155-0c8d-96a9-0418bdaf850d@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 02/08/2020 19:09, tyranastrasz@gmx.de wrote:
> Hello
> 
> I've a problem with my raid0.
> The probelmatic disks (2x 1TB wdred) were in usage in my server, now
> they got replaced with 3x 4TB seagate in a raid5.
> 
> Before I turned them off, I made a backup on an external drive (normal
> hdd via USB) via rsync -avx /source /mnt/external/
> 
> Whatever happens in the night, the backup isn't complete and I miss files.
> So I put the old raid again into the server and wanted to start, but the
> Intel Raid Controller said that one of the disks are no member of a raid.
> 
> My server mainboard is from Gigabyte a MX11-PC0.
> 
> Well I made some mdadm examines, smartctl, mdstat, lsdrv logfiles and
> attached them to the mail.
> 
Ow...

This is still the same linux on the server? Because mdstat says no raid 
personalities are installed. Either linux has changed or you've got 
hardware raid. in which case you'll need to read up on the motherboard 
manual.

I'm not sure what they're called, but try "insmod raid1x" I think it is. 
Could be raid0x. If that loads the raid0 driver, cat /proc/mdstat should 
list raid0 as a personality. Once that's there, mdadm may be able to 
start the array.

Until you've got a working raid driver in the kernel, I certainly can't 
help any further. But hopefully reading the mobo manual might help. The 
other thing to try is an up-to-date rescue disk and see if that can read 
the array.

Cheers,
Wol
