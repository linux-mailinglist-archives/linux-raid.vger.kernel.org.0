Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818A6220164
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 02:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGOAj2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jul 2020 20:39:28 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:21456 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgGOAj2 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 Jul 2020 20:39:28 -0400
Received: from host86-157-102-29.range86-157.btcentralplus.com ([86.157.102.29] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jvVDT-000BYC-FW; Wed, 15 Jul 2020 01:24:08 +0100
Subject: Re: Reshape using drives not partitions, RAID gone after reboot
To:     Roger Heflin <rogerheflin@gmail.com>
Cc:     Adam Barnett <adamtravisbarnett@gmail.com>,
        Linux RAID <linux-raid@vger.kernel.org>
References: <b551920e-ddad-c627-d75a-e99d32247b6d@gmail.com>
 <0b857b5f-20aa-871d-a22d-43d26ad64764@youngman.org.uk>
 <CAAMCDec22wshoG8eb9aM4su-EBdJRbh_LyVtaskR9FbYc4f=gw@mail.gmail.com>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <730bb16a-235d-9186-a486-7ed0018121ab@youngman.org.uk>
Date:   Wed, 15 Jul 2020 01:24:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAMCDec22wshoG8eb9aM4su-EBdJRbh_LyVtaskR9FbYc4f=gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 15/07/2020 00:27, Roger Heflin wrote:
> Did you create the partition before you added the disk to mdadm or
> after?  If after was it a dos or a gpt?  Dos should have only cleared
> the first 512byte block.  If gpt it will have written to the first
> block and to at least 1 more location on the disk, possibly causing
> data loss.
> 
> If before then you at least need to get rid of the partition table
> completely.   Having a partition on a device will often cause a number
> of things to ignore the whole disk.  I have debugged "lost" pv's where
> the partition effectively "blocked" lvm from even looking at the
> entire device that the pv was one.

If an explicit assemble works, then if you can get hold of a temporary 
spare/loan disk, I'd slowly move the new disks across to partitions by 
doing a --replace, not a --remove / --add. A replace will both keep the 
array protected against failure, and also not stress the array because 
it will just copy the old disk to the new, rather than rebuilding the 
new disk from all the others.

I'm not sure about the commands, but iirc mdadm has a --wipe-superblock 
command or something, as does fdisk have something to wipe a gpt, so 
make sure you clear that stuff out before re-initialising a disk.

Cheers,
Wol
