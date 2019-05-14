Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD80A1CCEF
	for <lists+linux-raid@lfdr.de>; Tue, 14 May 2019 18:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbfENQ3C (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 May 2019 12:29:02 -0400
Received: from mail-it1-f169.google.com ([209.85.166.169]:50536 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENQ3C (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 May 2019 12:29:02 -0400
Received: by mail-it1-f169.google.com with SMTP id i10so6040186ite.0
        for <linux-raid@vger.kernel.org>; Tue, 14 May 2019 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1Vki/m9Mmlc/RNmjopy8ZqGP6tH4IxxF14q+E/UCgw=;
        b=r+j3RB81VL0a2c5zpxWaiIVfor2Oh80GhtDXv+jZvCQ7sEyA8dl/+UnYZ38x8VxCm3
         q10rFqyJwYJkb+YkkeRgvFCVaERZWgCYFI5CbVn04sSfraCpmo/I9tDVu3/n/uMf1jAk
         9GkyTw7AXtmQ66M1UL8JoVH4tRJnYdNTp8Hy9BV0S2c8gQk0P8ItBKNOPyQ6OScr0MYQ
         gtYKyqMBT2p3vZnKNlMcfTKISzTrkqwVVvhYlZFgQEtW9ihbMD+vWC4Q7pHB+TuTZ3U/
         jqxu8TB0S1mmy3HGLCTiz+ZjN+hnJgBORZz00noUYOgoX25Ew/COGd00dyUnHlwwSvDs
         6pYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1Vki/m9Mmlc/RNmjopy8ZqGP6tH4IxxF14q+E/UCgw=;
        b=IL15X1vLEDRbDDVUsLjR4IWgLsy7Qswm68BiGp7+5kaubPjYwcoVKSCp/qJ8LSVOGD
         1lm7UUDtTj56dz9dy01o8LPIxOlQOts0QUEYaoYahrTV7Nn1cIwv8G+/8oRLh8WiXRh7
         1gjz/XcJ6ed4bJbOEM6ejQfSAyJnEBZoFc7MZnrbWqL0pz+OpEnQUow3HC2gXxu5Ltfm
         tAvBbgwKTmzxpZBpL2rc/338lHfUxo4uOAWt9xpX9XcPVTsoJWPhNFoL6ERsAKeHcTLs
         o1A5HelpW+zkRYAn7fsrkYu53dGiu77Ss7Nq+T+/Uiwe74NfWRq5Usv5ySZ+iP0GFSUS
         cHeQ==
X-Gm-Message-State: APjAAAUMmIVDs1tw8s9aQ+2g2I4qz373iqc6f283hOQpg1Bi8qPCrb+u
        6Q4rErHEmHn5WGpJwczNaDlOQnkIbqbctq9Ynw==
X-Google-Smtp-Source: APXvYqwrF/WJOjBIllcgBQ2SVUh8Aj6roKMp6Foq8D/ozCIjevmrxEZLnZD9pWdPspuKflCFXe9RNqLXRP6kitkDaGE=
X-Received: by 2002:a24:cec3:: with SMTP id v186mr4386636itg.173.1557851341134;
 Tue, 14 May 2019 09:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <87d22dc0-4b45-e13f-86e1-d3e9fbd7f55d@free.fr>
In-Reply-To: <87d22dc0-4b45-e13f-86e1-d3e9fbd7f55d@free.fr>
From:   Feng Zhang <prod.feng@gmail.com>
Date:   Tue, 14 May 2019 12:28:47 -0400
Message-ID: <CA+hhoHkuVw+JvLMeeJV_2eqY3tUd7k3qo4DEYwokRfnstoGtDw@mail.gmail.com>
Subject: Re: Help restoring a raid10 Array (4 disk + one spare) after a hard
 disk failure at power on
To:     eric.valette@free.fr
Cc:     Linux Raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

after the sdd failure, you rebooted your server?

Do you have /etc/mdadm.conf(or in other location) that explicitly list
the sdb1 , sdd1 etc as the md0? If so, maybe you can comment it and
then rescan the devices. If the spare disk is defined at the
beginning, or added afterward as "spare", it should start rebuilding
right away after a disk failure.

The comands to rescan  may look like:
mdadm --stop /dev/md0
mdadm --assemble --scan

You can use UUID instead of sdb, or sdc, etc.

Other experts on the list may give you more helpful info.

Best,

Feng

On Tue, May 14, 2019 at 11:49 AM Eric Valette <eric.valette@free.fr> wrote:
>
> I have a dedicated hardware nas that runs a self maintained debian 10.
>
> before the hardware disk problem (before/after)
>
> sda : system disk OK/OK no raid
> sdb : first disk of the raid10 array OK/OK
> sdc : second disk of the raid10 array OK/OK
> sdd : third disk of the raid10 array OK/KO
> sde : fourth disk of the raid10 array OK/OK but is now sdd
> sdf : spare disk for the array is now sde
>
> After the failure the BIOS does not detect the original third disk. Disk
> are renamed and I think sde has become sdd and sdf -> sde
>
> Below are more detailed info. Feel free to ask for other things as I can
> log into the machine via ssh
>
> So I have several questions :
>
>         1) How to I repair the raid10 array using the spare disk without
> replacing the faulty one immediately?
>         2) What should I do once I receive the new disk (hopefully soon)
>         3) Is there a way to use persistent naming for disk array?
>
> Sorry to annoy you but my kid wants to see a film on the nas and annoys
> me badly. And I prefer to ask rather than doing mistakes.
>
> Thanks for any
>
>
>
> mdadm --examine /dev/sdb
> /dev/sdb:
>     MBR Magic : aa55
> Partition[0] :   4294967295 sectors at            1 (type ee)
> root@nas2:~# mdadm --examine /dev/sdb
> /dev/sdb:
>     MBR Magic : aa55
> Partition[0] :   4294967295 sectors at            1 (type ee)
> root@nas2:~# mdadm --examine /dev/sdb1
> /dev/sdb1:
>            Magic : a92b4efc
>          Version : 1.2
>      Feature Map : 0x0
>       Array UUID : 6abe1f20:90c629de:fadd8dc0:ca14c928
>             Name : nas2:0  (local to host nas2)
>    Creation Time : Wed Jun 20 23:56:59 2012
>       Raid Level : raid10
>     Raid Devices : 4
>
>   Avail Dev Size : 5860268943 (2794.39 GiB 3000.46 GB)
>       Array Size : 5860268032 (5588.79 GiB 6000.91 GB)
>    Used Dev Size : 5860268032 (2794.39 GiB 3000.46 GB)
>      Data Offset : 262144 sectors
>     Super Offset : 8 sectors
>     Unused Space : before=262064 sectors, after=911 sectors
>            State : clean
>      Device UUID : ce9d878a:37a4f3a3:936bd905:c4ed9970
>
>      Update Time : Wed May  8 11:39:40 2019
>         Checksum : cf841c9f - correct
>           Events : 1193
>
>           Layout : near=2
>       Chunk Size : 512K
>
>     Device Role : Active device 0
>     Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
> root@nas2:~# mdadm --examine /dev/sdc
> /dev/sdc:
>     MBR Magic : aa55
> Partition[0] :   4294967295 sectors at            1 (type ee)
> root@nas2:~# mdadm --examine /dev/sdc1
> /dev/sdc1:
>            Magic : a92b4efc
>          Version : 1.2
>      Feature Map : 0x0
>       Array UUID : 6abe1f20:90c629de:fadd8dc0:ca14c928
>             Name : nas2:0  (local to host nas2)
>    Creation Time : Wed Jun 20 23:56:59 2012
>       Raid Level : raid10
>     Raid Devices : 4
>
>   Avail Dev Size : 5860268943 (2794.39 GiB 3000.46 GB)
>       Array Size : 5860268032 (5588.79 GiB 6000.91 GB)
>    Used Dev Size : 5860268032 (2794.39 GiB 3000.46 GB)
>      Data Offset : 262144 sectors
>     Super Offset : 8 sectors
>     Unused Space : before=262064 sectors, after=911 sectors
>            State : clean
>      Device UUID : 8c89bdf8:4f3f8ace:c15b5634:7a874071
>
>      Update Time : Wed May  8 11:39:40 2019
>         Checksum : 97744edb - correct
>           Events : 1193
>
>           Layout : near=2
>       Chunk Size : 512K
>
>     Device Role : Active device 1
>     Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
> root@nas2:~# mdadm --examine /dev/sdd
> /dev/sdd:
>     MBR Magic : aa55
> Partition[0] :   4294967295 sectors at            1 (type ee)
> root@nas2:~# mdadm --examine /dev/sdd1
> /dev/sdd1:
>            Magic : a92b4efc
>          Version : 1.2
>      Feature Map : 0x0
>       Array UUID : 6abe1f20:90c629de:fadd8dc0:ca14c928
>             Name : nas2:0  (local to host nas2)
>    Creation Time : Wed Jun 20 23:56:59 2012
>       Raid Level : raid10
>     Raid Devices : 4
>
>   Avail Dev Size : 5860268943 (2794.39 GiB 3000.46 GB)
>       Array Size : 5860268032 (5588.79 GiB 6000.91 GB)
>    Used Dev Size : 5860268032 (2794.39 GiB 3000.46 GB)
>      Data Offset : 262144 sectors
>     Super Offset : 8 sectors
>     Unused Space : before=262064 sectors, after=911 sectors
>            State : clean
>      Device UUID : c97b767a:84d2e7e2:52557d30:51c39784
>
>      Update Time : Wed May  8 11:39:40 2019
>         Checksum : 3d08e837 - correct
>           Events : 1193
>
>           Layout : near=2
>       Chunk Size : 512K
>
>     Device Role : Active device 3
>     Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
> root@nas2:~# mdadm --examine /dev/sde
> /dev/sde:
>     MBR Magic : aa55
> Partition[0] :   4294967295 sectors at            1 (type ee)
> root@nas2:~# mdadm --examine /dev/sde1
> /dev/sde1:
>            Magic : a92b4efc
>          Version : 1.2
>      Feature Map : 0x0
>       Array UUID : 6abe1f20:90c629de:fadd8dc0:ca14c928
>             Name : nas2:0  (local to host nas2)
>    Creation Time : Wed Jun 20 23:56:59 2012
>       Raid Level : raid10
>     Raid Devices : 4
>
>   Avail Dev Size : 5860268943 (2794.39 GiB 3000.46 GB)
>       Array Size : 5860268032 (5588.79 GiB 6000.91 GB)
>    Used Dev Size : 5860268032 (2794.39 GiB 3000.46 GB)
>      Data Offset : 262144 sectors
>     Super Offset : 8 sectors
>     Unused Space : before=262064 sectors, after=911 sectors
>            State : clean
>      Device UUID : 82667e81:a6158319:85e0282e:845eec1c
>
>      Update Time : Wed May  8 11:00:29 2019
>         Checksum : 10ac3349 - correct
>           Events : 1193
>
>           Layout : near=2
>       Chunk Size : 512K
>
>     Device Role : spare
>     Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
> root@nas2:~#
>
> mdadm --detail /dev/md0
> /dev/md0:
>             Version : 1.2
>          Raid Level : raid0
>       Total Devices : 4
>         Persistence : Superblock is persistent
>
>               State : inactive
>     Working Devices : 4
>
>                Name : nas2:0  (local to host nas2)
>                UUID : 6abe1f20:90c629de:fadd8dc0:ca14c928
>              Events : 1193
>
>      Number   Major   Minor   RaidDevice
>
>         -       8       65        -        /dev/sde1
>         -       8       49        -        /dev/sdd1
>         -       8       33        -        /dev/sdc1
>         -       8       17        -        /dev/sdb1
>
> cat /proc/mdstat
> Personalities : [raid10]
> md0 : inactive sdc1[1](S) sdb1[0](S) sde1[4](S) sdd1[3](S)
>        11720537886 blocks super 1.2
>
> unused devices: <none>
>
> --
>     __
>    /  `                         Eric Valette
>   /--   __  o _.                6 rue Paul Le Flem
> (___, / (_(_(__                 35740 Pace
>
> Tel: +33 (0)2 99 85 26 76       Fax: +33 (0)2 99 85 26 76
> E-mail: eric.valette@free.fr
>
>
>
