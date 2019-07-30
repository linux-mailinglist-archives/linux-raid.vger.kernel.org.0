Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B41137B608
	for <lists+linux-raid@lfdr.de>; Wed, 31 Jul 2019 01:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfG3XEz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Jul 2019 19:04:55 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:17352 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfG3XEz (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 30 Jul 2019 19:04:55 -0400
Received: from [86.154.25.20] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1hsbAq-00016H-9D; Wed, 31 Jul 2019 00:04:53 +0100
Subject: Re: RAID-1 from SAS to SSD
To:     Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
References: <CAJH6TXjer-gs4bwOCLkdi4xXm-g17ZLMZT1zCHig2Cip5Xokmw@mail.gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5D40CD14.1080100@youngman.org.uk>
Date:   Wed, 31 Jul 2019 00:04:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CAJH6TXjer-gs4bwOCLkdi4xXm-g17ZLMZT1zCHig2Cip5Xokmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 30/07/19 12:07, Gandalf Corvotempesta wrote:
> # Sync disk partitions
> sfdisk --dump /dev/sda | sfdisk /dev/sdc
> sfdisk --dump /dev/sdb | sfdisk /dev/sdd
> 
> # Rebuild array
> mdadm /dev/md0 --add /dev/sdc1
> mdadm /dev/md0 --replace /dev/sda1 --with /dev/sdc1
> mdadm /dev/md0 --add /dev/sdd1
> mdadm /dev/md0 --replace /dev/sdb1 --with /dev/sdd1
> 
> This should replace, with no loss of redundancy, sda with sdc and sdb with sdd.
> Then I have to re-install the bootloaded on new disks and reboot to
> run from the SSDs
> 
> Any thoughts ? What about LVM ?  By syncing the disk partitions and
> the undelying array, LVM should be up & running on next reboot
> automatically, even if moved from SAS to SSD, right ?

Something has come up on the list recently, called dm-integrity. It's
worth thinking about.

Once you've created your sdc1 and sdd1, consider creating a dm-integrity
device on them, and then adding that dm-integrity device into your mirror.

It's another layer in the stack, but it check-sums and ensures read
integrity. So should something *corrupt* one of your mirrors, the
dm-integrity layer will fail with a read error, and the raid will
correct the mirror for you. The alternative is a raid that returns
correct and corrupt data at random, until you do an integrity check,
which will toss a dice whether it overwrites the corrupt data with the
correct data, or vice versa.

Please note that dm-integrity is NEW, so use it at your own risk ...

Cheers,
Wol
