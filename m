Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2612C99BC
	for <lists+linux-raid@lfdr.de>; Tue,  1 Dec 2020 09:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgLAImq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 1 Dec 2020 03:42:46 -0500
Received: from mout01.posteo.de ([185.67.36.65]:59065 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbgLAImp (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 1 Dec 2020 03:42:45 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id B14A316005C
        for <linux-raid@vger.kernel.org>; Tue,  1 Dec 2020 09:41:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1606812108; bh=TrsJOpVR7Ju7Oqw/22Li4RbPb1G0O33b+KBW4RfgBnU=;
        h=Date:From:To:Cc:Subject:From;
        b=PqmW7Cb+ZTjBsaKWIgFUCnSd9jl4KPjnFvfgPKXvwxjtwZ/dcGsQVbQEMJifk2HhN
         wJzVFbuEJn0jX7c8JF2xi7S3E58pKQiwSmt9eeYjDtPJM+vefn7Fr7tEkiC2ug4Ic4
         YI2PySrFAFbTDMi+j7SACmHl+4ifCKrlif03mfZJGCjJc/O0wSWjdn/23f+EbqeLjA
         kpkwlAhTiJUgpF2j/FcRI2/yMtpaqMu9hdckGA/OIyqQFU94lLj7/hoTNwTDWXm5la
         RPrhR3f6ofLgEJU6BNW25BiczcT6jB3+G2DtCaCOsTBW2idm5vs0c5/rIHhm9QmpUT
         v04gCzZzvaW1Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4ClbDr1BN0z9rxP;
        Tue,  1 Dec 2020 09:41:47 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Dec 2020 09:41:47 +0100
From:   buhtz@posteo.de
To:     David T-G <davidtg-robot@justpickone.org>
Cc:     linux-raid@vger.kernel.org
Subject: re: partitions & filesystems (was "Re: =?UTF-8?Q?=3F=3F=3Froot=20?=
 =?UTF-8?Q?account=20locked=3F=3F=3F=20after=20removing=20one=20RAID=31=20?=
 =?UTF-8?Q?hard=20disc=22=29?=
In-Reply-To: <20201130200503.GV1415@justpickone.org>
References: <e6b7a61d16a25c433438c670fa4c0b4f@posteo.de>
 <20201130200503.GV1415@justpickone.org>
Message-ID: <8fa1ae68716e406423039419f10ec219@posteo.de>
X-Sender: buhtz@posteo.de
User-Agent: Posteo Webmail
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear David and others,

thanks a lot for so much discussion and details. I learn a lot.
Following your discussions I see there still is some basic knowledge 
missing on my side.

Am 30.11.2020 21:05 schrieb David T-G:
> You don't see any "filesystem" or, more correctly, partition in your
> 
>   fdisk -l

I do not see the partition in the output of "fdisk -l".

But I can (when both discs are present) mount /dev/md127 (manualy via 
mount and via fstab) to /Daten and create files on it.

> So the display isn't interesting, although the logic behind that 
> approach
> certainly is to me.

I plugged in the nacked hard discs and they appear as /dev/sdb and 
/dev/sdc. After that
   mdadm --create /dev/md/md0 --level=1 --raid-devices=2 /dev/sdb 
/dev/sdc
Then I did
  ls -l /dev/md/md0 and found out this is just a link to /dev/md127.
I formated the raid with
  mkdfs.ext4 /dev/md127
Then I mounted (first manually via mount and after sucess via fstab) 
/dev/md127 to /Daten

Is this unusual?
