Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 006EEDDBF3
	for <lists+linux-raid@lfdr.de>; Sun, 20 Oct 2019 04:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfJTCgG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 19 Oct 2019 22:36:06 -0400
Received: from MAIL.NPC-USA.COM ([173.160.187.9]:51230 "EHLO
        nautilus.npc-usa.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726125AbfJTCgG (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 19 Oct 2019 22:36:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by nautilus.npc-usa.com (Postfix) with ESMTP id 8C5D11DC01B9
        for <linux-raid@vger.kernel.org>; Sat, 19 Oct 2019 19:36:05 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at npc-usa.com
Received: from nautilus.npc-usa.com ([127.0.0.1])
        by localhost (mail.npc-usa.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tExTs9z8lgok for <linux-raid@vger.kernel.org>;
        Sat, 19 Oct 2019 19:36:04 -0700 (PDT)
Received: from [192.168.88.34] (c-73-254-66-50.hsd1.wa.comcast.net [73.254.66.50])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: curtis)
        by nautilus.npc-usa.com (Postfix) with ESMTPSA id 462441DC008F
        for <linux-raid@vger.kernel.org>; Sat, 19 Oct 2019 19:36:04 -0700 (PDT)
Reply-To: curtis@npc-usa.com
Subject: Re: Degraded RAID1
To:     linux-raid@vger.kernel.org
References: <qo31v1$31rr$2@blaine.gmane.org>
 <5DA5165E.8070609@youngman.org.uk>
 <9bfd62ed-a41c-8093-b522-db0ccbe32b89@npc-usa.com>
 <4e25fa78-846f-42b9-e50a-c4876377a08d@npc-usa.com>
 <be94147a-a244-6f71-5f6a-7c6da8515cf9@youngman.org.uk>
 <1a20554d-1a40-f226-28bc-c3d38f8c7014@npc-usa.com>
 <5DA648B9.7030506@youngman.org.uk>
 <006efea0-ec71-3eaf-a456-7fcc2efe4916@npc-usa.com>
 <5212dd1b-b67d-f7fd-a96b-6281f0501740@youngman.org.uk>
 <ac4a6b63-b886-1c0c-3aad-f77b54246226@npc-usa.com>
 <9864d7bd-f2f7-b25e-fa6d-9ca06a9e6b87@youngman.org.uk>
 <5a153cf6-e53d-35d9-6775-e09028799721@npc-usa.com>
 <1b33414d-dd79-6cb1-0f24-d7eed407e490@thelounge.net>
From:   Curtis Vaughan <curtis@npc-usa.com>
Organization: North Pacific Corporation
Message-ID: <afbdeb22-4000-dcc3-26bd-70307b8e530d@npc-usa.com>
Date:   Sat, 19 Oct 2019 19:36:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1b33414d-dd79-6cb1-0f24-d7eed407e490@thelounge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/19/19 6:54 PM, Reindl Harald wrote:
>
> Am 20.10.19 um 02:06 schrieb Curtis Vaughan:
>> After updates I decided to reboot, but it would never reboot until I
>> removed the new drive. I'm wondering if it has something to do with
>> needing to installl grub on the new drive?
> surely, a workaround would have been switch the cables so that the first
> disk is the one which still has grub
>
> grub is at the begin of the drive outisde the array itself and so for
> real working redundacy and i posted you days ago my script for drive
> replacemnets which clearly installs grub on the new one
>
> [root@srv-rhsoft:~]$ cat /scripts/raid-recovery.sh
> #!/usr/bin/bash
>
> GOOD_DISK="/dev/sda"
> BAD_DISK="/dev/sdd"
>
> # --------------------------------------------------------------------------
>
> echo "NOT NOW"
> exit
>
> # --------------------------------------------------------------------------
>
> # clone MBR
> dd if=$GOOD_DISK of=$BAD_DISK bs=512 count=1
>
> # force OS to read partition tables
> partprobe $BAD_DISK
>
> # start RAID recovery
> mdadm /dev/md0 --add ${BAD_DISK}1
> mdadm /dev/md1 --add ${BAD_DISK}2
> mdadm /dev/md2 --add ${BAD_DISK}3
>
> # print RAID status on screen
> sleep 5
> cat /proc/mdstat
>
> # install bootloader on replacement disk
> grub2-install "$BAD_DISK"


OMG. The funny thing is that I was looking for this information, but I 
was sure it was on a website and never searched my emails....

Thanks for reminding me!

