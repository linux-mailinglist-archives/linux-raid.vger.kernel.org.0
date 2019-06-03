Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA403331D2
	for <lists+linux-raid@lfdr.de>; Mon,  3 Jun 2019 16:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfFCOOY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 3 Jun 2019 10:14:24 -0400
Received: from imail01.uvensys.de ([37.208.110.138]:48875 "EHLO
        imail01.uvensys.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfFCOOY (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 3 Jun 2019 10:14:24 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jun 2019 10:14:22 EDT
Received: from [192.168.2.102] (p2E5162B8.dip0.t-ipconnect.de [46.81.98.184])
        by imail01.uvensys.de (Postfix) with ESMTPSA id E34BA19F25;
        Mon,  3 Jun 2019 16:04:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uvensys.de; s=201903;
        t=1559570697; bh=9OF/lR0snQx2nLi277vmOwF2KBCxfsYI84culLUXwsI=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=TX5TMNyP/ymBN5CmZV4AZrqirmbszlCGKtm0vOG2RmYCzI6jHTaFM0b2S327/pmn1
         QOn0D0Hp/kZtoxy14jdsihY3bvRMK9r1UXudcu8CrdL0LbJ5DPxOHTWqkLjWOkB2QT
         a56k+tX4rAWB1SmLsLE4XIXW5inOtpsLzthsrqpY=
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: lost software raid information
From:   Volker Lieder <v.lieder@uvensys.de>
In-Reply-To: <DD75AF0E-C953-4419-BFD8-F78120339DA9@uvensys.de>
Date:   Mon, 3 Jun 2019 16:04:57 +0200
Cc:     linux-raid@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B1A9F6E-775B-49D9-A8A5-C90CBAC3B941@uvensys.de>
References: <CF3197CC-8CA8-471E-8190-9C06637567C3@uvensys.de>
 <20190423114117.GA11431@metamorpher.de>
 <1150C8E6-39E4-47D1-AF6C-EAD6D3FC51D0@uvensys.de>
 <20190423145806.GA13542@metamorpher.de>
 <20190423152917.GA22049@metamorpher.de>
 <DD75AF0E-C953-4419-BFD8-F78120339DA9@uvensys.de>
To:     Andreas Klauer <Andreas.Klauer@metamorpher.de>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi all,

after we made a backup to other hdds we recovered the raid with =
following command:

mdadm --create --assume-clean /dev/md2 --level=3D6 --raid-devices=3D24 =
/dev/sda /dev/sd[d-z]

xfs made a journal check and then the files were back again.

Best regards,
Volker

> Am 24.04.2019 um 11:34 schrieb Volker Lieder <v.lieder@uvensys.de>:
>=20
> Hi Andreas,
>=20
> first setup was try with zfs, perhaps partition scheme was not deleted =
perfect.
>=20
> The customer ordered a server like this one. We will backup all disk =
via dd first and then try different other things.
>=20
> Thank you
>=20
>> Am 23.04.2019 um 17:29 schrieb Andreas Klauer =
<Andreas.Klauer@metamorpher.de>:
>>=20
>> On Tue, Apr 23, 2019 at 04:58:06PM +0200, Andreas Klauer wrote:
>>>> /dev/sda:
>>>>  MBR Magic : aa55
>>>> Partition[0] :   4294967295 sectors at            1 (type ee)
>>>> mdadm: No md superblock detected on /dev/sda1.
>>>> mdadm: No md superblock detected on /dev/sda9.
>>>> [    6.044546]  sda: sda1 sda9
>>>=20
>>> The partition numbering is weird too - partition 1, partition 9,=20
>>> nothing in between for all of them.
>>>=20
>>> Is there anything on these partitions? (file -s /dev/sd*)
>>> Any data written to partitions likely damaged data on the RAID.
>>=20
>> Apparently this partition 1 partition 9 scheme is common=20
>> for Solaris ZFS / ZFS on Linux?
>>=20
>> https://www.slackwiki.com/ZFS_root
>>=20
>>> Currently, when ZFSonLinux is given a whole disk device=20
>>> like /dev/sdb to use, it will automatically GPT partition it=20
>>> with a bf01 partition #1 that is the whole disk except=20
>>> a small 8MiB type bf07 partition #9 at the end of the disk
>>> (/dev/sdb1 and /dev/sdb9).
>>=20
>> I don't use ZFS myself, so... no idea, sorry.=20
>> I thought you were asking about mdadm RAID.
>>=20
>> Regards
>> Andreas Klauer
>=20

