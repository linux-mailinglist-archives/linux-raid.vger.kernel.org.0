Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634C11C38E0
	for <lists+linux-raid@lfdr.de>; Mon,  4 May 2020 14:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgEDMHS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 May 2020 08:07:18 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:58947 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbgEDMHS (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 4 May 2020 08:07:18 -0400
Received: from [81.153.126.158] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jVZsS-0003ch-6u; Mon, 04 May 2020 13:07:16 +0100
Subject: Re: RAID 1 | Restore based on Image of /dev/sda
To:     Stefanie Leisestreichler 
        <stefanie.leisestreichler@peter-speer.de>,
        linux-raid@vger.kernel.org
References: <5e29b897-b2df-c6b9-019a-e037101bfeec@peter-speer.de>
 <5EAFF763.2000906@youngman.org.uk>
 <58659d1e-bcce-553c-fe68-52d075422252@peter-speer.de>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5EB00573.9040503@youngman.org.uk>
Date:   Mon, 4 May 2020 13:07:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <58659d1e-bcce-553c-fe68-52d075422252@peter-speer.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 04/05/20 12:26, Stefanie Leisestreichler wrote:
> 

> 
> Thanks, Wol, especially for the hint with the GUIDs, will keep this in
> mind. If ever using it again - maybe in case of a quick temporary
> replacement in the original computer - I will wipe it with zeros before.

And what Johannes said ... oh and I believe gdisk has an option that
will change guids for you without affecting anything else.

Wiping it with zeroes will take a long time - it might well be mdadm I
think it has an option to wipe the raid superblock.

Note that both the partitions and the raid will have guids, so moving
drives around can be fraught ...
> 
> The partition layout will be cloned using sfdisk.
> 
> Thanks for the wiki links. I read the wiki before asking but it was not
> clear to me how to do it...
> 
> Btw, I will stay with mdadm/lvm/ext4 and not switch to btrfs.
> 
That's good - my feelings entirely as btrfs may be a decent file system,
but I gather parity raid is experimental as in it will probably eat your
data at some point and may be unfixable. I gather it also does NOT
mirror your data by default (typical computer scientists - they consider
the filesystem structure valuable and assume the user can retrieve the
data from backup ... :-(

lvm gives you snapshotting and stuff ...

And my current (and planned new) systems both have the root filesystem
on a separate partition from /home, so if I wanted I could have root on
a 1.0 mirror - not especially recommended but there are good reasons for
it ...

> Thanks again,
> Steffi

Cheers,
Wol
