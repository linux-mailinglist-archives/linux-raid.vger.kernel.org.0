Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F05F1133ED0
	for <lists+linux-raid@lfdr.de>; Wed,  8 Jan 2020 11:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgAHKDa (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 Jan 2020 05:03:30 -0500
Received: from arcturus.uberspace.de ([185.26.156.30]:60704 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAHKD3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 8 Jan 2020 05:03:29 -0500
Received: (qmail 24374 invoked from network); 8 Jan 2020 10:03:28 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 8 Jan 2020 10:03:28 -0000
Date:   Wed, 8 Jan 2020 11:03:27 +0100
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     Marco Heiming <myx00r@gmail.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: Raid 5 cannot be re-assembled after disk was removed
Message-ID: <20200108100327.GA15483@metamorpher.de>
References: <CAEWf3EDf-CwMz660RjRAtL==fa-Xc2XVpbrJL_Xqw24ZTZ18Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEWf3EDf-CwMz660RjRAtL==fa-Xc2XVpbrJL_Xqw24ZTZ18Zg@mail.gmail.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jan 08, 2020 at 10:31:28AM +0100, Marco Heiming wrote:
> So here is what what it looked like at the time it was working:
> 
> mdadm -D /dev/md0
> /dev/md0:
>   Creation Time : Wed Jan  7 18:14:37 2015
>      Raid Level : raid5
>      Array Size : 5860270080 (5588.79 GiB 6000.92 GB)
>   Used Dev Size : 2930135040 (2794.39 GiB 3000.46 GB)
>    Raid Devices : 3
>   Total Devices : 4

A three disk raid5 with spare (odd, why not raid6 then?)

> Somehow the spare was not activated and so the array degraded was inactive.
> 
> I activated the spare and the array was syncing.

Then something went wrong in this step.
It seems like you did something else.

> mdadm --examine /dev/sd[b-z]
> /dev/sdb:
>   Creation Time : Wed Jan  7 18:14:37 2015
>      Raid Level : raid5
>    Raid Devices : 4
> 
>  Avail Dev Size : 5860274096 (2794.40 GiB 3000.46 GB)
>      Array Size : 8790405120 (8383.18 GiB 9001.37 GB)
>   Used Dev Size : 5860270080 (2794.39 GiB 3000.46 GB)

For whatever reason, it's a 4 disk raid5 now.

Array size went up from 6000GB to 9000GB accordingly.

>    Device Role : Active device 1
>    Array State : AAA. ('A' == active, '.' == missing, 'R' == replacing)

And one disk is missing so no redundancy here.

> When i try to assemble the array with the two (hopefully) fine drives it fails:

You can't assemble a 4 disk raid5 with only 2 drives.

Your examine also only gave two disks out of 4.

You need 3 drives with good data on them, and a 4th drive to restore redundancy.
Whether you have those 3 drives, only you yourself know...

Regards
Andreas Klauer
