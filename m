Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D7E1E18F4
	for <lists+linux-raid@lfdr.de>; Tue, 26 May 2020 03:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbgEZBQ1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 21:16:27 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:64256 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387888AbgEZBQ1 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 25 May 2020 21:16:27 -0400
Received: from [81.154.111.47] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jdOCb-00083e-G6; Tue, 26 May 2020 02:16:23 +0100
Subject: Re: help requested for mdadm grow error
To:     Thomas Grawert <thomasgrawert0282@gmail.com>
Cc:     Phil Turmel <philip@turmel.org>, linux-raid@vger.kernel.org
References: <7d95da49-33d8-cd4d-fa3f-0f3d3074cb30@gmail.com>
 <5ECC09D6.1010300@youngman.org.uk>
 <ff4ea9cd-ab35-0990-5946-4a72d4021658@gmail.com>
 <5ECC1488.3010804@youngman.org.uk>
 <4891e1e8-aaee-b36b-4131-ca7deb34defd@gmail.com>
 <alpine.DEB.2.20.2005252132080.7596@uplift.swm.pp.se>
 <103b80fa-029f-ecdc-d470-5cc591dc8dd0@gmail.com>
 <e1a4a609-2068-b084-59a6-214c88798966@youngman.org.uk>
 <e1ad56b2-df70-bc6a-9a81-333230d558c2@gmail.com>
 <358e9f6b-a989-0e4a-04c4-6efe2666159f@youngman.org.uk>
 <b5e5c7af-9d1b-3eca-f3a1-f03f8d308015@gmail.com>
 <37636c91-9baf-4565-9849-f8aca54e392e@youngman.org.uk>
 <50c3b5ce-519b-57a6-6f11-f99d69c3fd23@gmail.com>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <dab8f436-ab65-880e-dc4a-b19d6a2659dc@youngman.org.uk>
Date:   Tue, 26 May 2020 02:16:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <50c3b5ce-519b-57a6-6f11-f99d69c3fd23@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 26/05/2020 00:31, Thomas Grawert wrote:
> ok, maybe it´s getting out of scope now. If so, please let me know...
> 
> md0 is clean and running. no active resync.  I just tried to mount the 
> filesystem to check if everything is fine and to proceed with growing... 
> thanks god, I did it this way because:
> 
> root@nas:~# mount /dev/md0 /mnt
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/md0, 
> missing codepage or helper program, or other error.
> 
> root@nas:~# df -h
> Filesystem    Größe Benutzt Verf. Verw% Eingehängt auf
> udev             16G       0   16G    0% /dev
> tmpfs           3,1G     11M  3,1G    1% /run
> /dev/sdg2       203G    7,2G  186G    4% /
> tmpfs            16G       0   16G    0% /dev/shm
> tmpfs           5,0M    4,0K  5,0M    1% /run/lock
> tmpfs            16G       0   16G    0% /sys/fs/cgroup
> /dev/sdg1       511M    5,2M  506M    1% /boot/efi
> tmpfs           3,1G       0  3,1G    0% /run/user/0
> root@nas:~# fsck /dev/md0
> fsck from util-linux 2.33.1
> e2fsck 1.44.5 (15-Dec-2018)
> ext2fs_open2: Ungültige magische Zahl im Superblock
> fsck.ext2: Superblock ungültig, Datensicherungs-Blöcke werden versucht ...
> fsck.ext2: Ungültige magische Zahl im Superblock beim Versuch, /dev/md0 
> zu öffnen
> 
> Der Superblock ist unlesbar bzw. beschreibt kein gültiges ext2/ext3/ext4-
> Dateisystem. Wenn das Gerät gültig ist und ein ext2/ext3/ext4-
> Dateisystem (kein swap oder ufs usw.) enthält, dann ist der Superblock
> beschädigt, und Sie könnten versuchen, e2fsck mit einem anderen Superblock
> zu starten:
>      e2fsck -b 8193 <Gerät>
>   oder
>      e2fsck -b 32768 <Gerät>
> 
> In /dev/md0 wurde eine gpt-Partitionstabelle gefunden
> 
> =========================================
> 
> For those who not understand German:
> ext2fs_open2: Invalid magical number in superblock
> fsck.ext2: Superblock invalid. Backup-blocks are tried...
> fsck.ext2:  Invalid magical number in superblock when trying to open 
> /dev/md0
> 
> Found a gpt-partition-table at /dev/md0
> 
> =========================================
> 
> there should be a valid ext4 filesystem...
> 
Oh help ...

Hopefully all that's happened is that something has written a GPT and 
that's it. Unfortunately, that seems painfully common - rogue tools 
format disks when they shouldn't ... I just hope it's not the Debian 
upgrade that did it.

So we should hopefully just be able to recover the filesystem, except I 
don't know how.

Did you actually try the e2fsck with the alternate superblocks? That's 
the limit of what I can suggest. I don't think e2fsck will try them for 
you - you have to explicitly tell it.

Just test it by using the "don't write anything" option, whatever that 
is? If that then doesn't report many errors, it looks like we may have 
our filesystem back - cross fingers ...

Cheers,
Wol
