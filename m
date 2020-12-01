Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F6A2CA17D
	for <lists+linux-raid@lfdr.de>; Tue,  1 Dec 2020 12:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbgLALfW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 1 Dec 2020 06:35:22 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:26706 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbgLALfW (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 1 Dec 2020 06:35:22 -0500
Received: from host86-149-69-253.range86-149.btcentralplus.com ([86.149.69.253] helo=[192.168.1.64])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1kk3vc-000Cfy-4i; Tue, 01 Dec 2020 11:34:40 +0000
Subject: Re: Fwd: [OT][X-POST] RAID-6 hw rebuild speed
To:     Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>,
        General discussion - ask "questions," receive answers
         and advice from other ZFS users 
        <zfs-discuss@list.zfsonlinux.org>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
References: <CAJH6TXjsg+OE5rUpK+RqeFJRxBiZJ94ToOdUD5ajjwXzYft9Vw@mail.gmail.com>
 <CAJH6TXgED_UGRcLNVU+-1p8BVMapJkRmvZMndLYAKjX_j6f7iw@mail.gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5FC62A4F.9000100@youngman.org.uk>
Date:   Tue, 1 Dec 2020 11:34:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CAJH6TXgED_UGRcLNVU+-1p8BVMapJkRmvZMndLYAKjX_j6f7iw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 01/12/20 09:57, Gandalf Corvotempesta wrote:
> Sorry for the OT and X-POST but these 2 lists are full of skilled
> storage engineer.
> For a very,very,very,very long time I used 15k SAS 3.5'' disks. A
> RAID-6 hardware (8 disks) took about 20 hours to rebuild.
> 
> Now I've replaced a 3.5 disks with a 15k SAS 2.5'' disk. raid is
> rebuilding properly, but the ETA is less then 1 hours.
> 
> I've moved from a 20 hours rebuild to about 50 minutes rebuild, by
> just changing one 3.5' disks with a 2.5'
> 
> Is this normal ? I'm thinking something strange is happening
> 
Your rebuild time is effectively the time it takes to write to the new
disk. So I'm guessing if you had to wipe and rebuild one of the old
disks it would again be 20 hours. So what's different about the new disk?

Yes I know it's a 2.5". But could it be it's SATA-3 as opposed to the
old ones being SATA-2? There's a whole bunch of things it could be.

But my money's on it having a bigger cache. The ETA is based on how fast
it can read from the existing array and the rebuild hasn't yet filled
the cache. Once that fills up and the disk write speed kicks in, the ETA
will start climbing fast as the write speed starts dominating the ETA.
That said, it'll probably be faster than the old 20hrs, but I don't know
by how much.

Cheers,
Wol
