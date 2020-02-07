Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 736FC155499
	for <lists+linux-raid@lfdr.de>; Fri,  7 Feb 2020 10:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgBGJ2A (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 7 Feb 2020 04:28:00 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:59413 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgBGJ2A (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 7 Feb 2020 04:28:00 -0500
Received: from [81.153.122.72] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1izzvZ-0004oU-Ck; Fri, 07 Feb 2020 09:27:58 +0000
Subject: Re: Is it possible to break one full RAID-1 to two degraded RAID-1?
To:     Ram Ramesh <rramesh2400@gmail.com>,
        Reindl Harald <h.reindl@thelounge.net>,
        Linux Raid <linux-raid@vger.kernel.org>
References: <1120831b-13e6-6a5d-8908-ee6a312e7302@gmail.com>
 <aa41492c-1ad7-070f-9bc6-646977364758@thelounge.net>
 <2c4fedff-a1c9-6ca3-5385-72b542a4a0b4@gmail.com>
 <551449ed-49f9-e567-09d3-981f4cf9eea9@thelounge.net>
 <5E32855D.3020906@youngman.org.uk>
 <0c70c04f-d8d0-0c44-e603-46c101b21cc1@gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5E3D2D9C.8020908@youngman.org.uk>
Date:   Fri, 7 Feb 2020 09:27:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <0c70c04f-d8d0-0c44-e603-46c101b21cc1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 07/02/20 07:02, Ram Ramesh wrote:
> I got no response on this and want to take a shot before going the
> backup way.
> 
> Assuming (hda1 and hdb1 in raid1 md0) Will the following work?
> 
> 1. Fail and remove hdb1
> 2. Create new RAID1 md1 with hdb1 and missing
> 3. dd md0 onto md1

I wouldn't bother with any of the above. Just shut down and physically
remove a LIVE disk. That now is your backup.

In fact, this might be a good excuse to get a 3rd disk and either go
raid 5 or use it for backups.

> 4. Make both bootable. (I suppose I need to change UUID of md1
>    partitions. I suppose that is easy)

Yes it's easy. Yes it should have been done a LOOONG time ago.

> 5. Boot both and double check

They'll be degraded, so you might have to do a forced assembly to make
them run ...

> 6. Now upgrade md0 without fear.
> 7. Boot and test the new system for a couple of days to make sure
>    everything is fine.
> 8. If that fails, delete md0, and add hda1 to md1. If not delete md1
>    and add hdb1 to md0

Yup.
> 
> Regards
> Ramesh
> 
Cheers,
Wol

