Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D8D15381F
	for <lists+linux-raid@lfdr.de>; Wed,  5 Feb 2020 19:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgBESaA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 5 Feb 2020 13:30:00 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:35234 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbgBESaA (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 5 Feb 2020 13:30:00 -0500
Received: from [81.153.122.72] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1izPR0-0001Bt-42; Wed, 05 Feb 2020 18:29:58 +0000
Subject: Re: mdadm RAID1 -> 5 conversion safety
To:     Paul Dann <pdgiddie@gmail.com>, linux-raid@vger.kernel.org
References: <CALZj-VqNACF+Dn5rBrLaVmvVE2weOAjqtvWpwKU7sE=72nyvXg@mail.gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5E3B09A5.8010209@youngman.org.uk>
Date:   Wed, 5 Feb 2020 18:29:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CALZj-VqNACF+Dn5rBrLaVmvVE2weOAjqtvWpwKU7sE=72nyvXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 05/02/20 11:51, Paul Dann wrote:
> Hi there,
> 
> I've got a load of data on an md RAID 1 array assembled from 2x4TB
> disks. I'm looking to expand this by adding a third 4TB disk and
> converting the array to RAID 5. Now the required procedure is
> documented on the wiki, but my question is:
> 
> When I convert the RAID 1 array to RAID 5, the array will be in a
> degraded state as it rebuilds onto the new disk. However, if one of
> the original two disks were to fail during this procedure, is mdadm
> smart enough to convert the array back to degraded RAID 1, or will my
> array now be a broken RAID 5 with no path to recovery?

There is a "revert reshape" option which will take you back to a raid 1.
This assumes, however, that it's the new disk that has failed.

I'm pretty certain, however, that should one of the old disks fail
during the conversion you will end up with a degraded raid 5.

If you're worried, I would make sure you've done a SMART health check on
your two original drives, although that's no guarantee everything's okay.

If you really are that worried, get two new disks with the intention of
ending up at raid 6. Add a 3rd drive to the mirror, fail and remove one
of the originals, add the 4th to go raid 5, then add back the first to
go raid 6.

One thing I will say - MAKE SURE you have the latest mdadm, and if
possible make sure you're running a recent kernel. There have been
issues converting from 1 to 5. None of them serious, and all fixed by
upgrading mdadm/kernel, hence the advice to be running the latest/greatest.
> 
> Many thanks,
> Paul
> 
Cheers,
Wol
