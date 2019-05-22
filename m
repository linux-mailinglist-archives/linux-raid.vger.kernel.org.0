Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C879E263BE
	for <lists+linux-raid@lfdr.de>; Wed, 22 May 2019 14:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfEVMY3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 May 2019 08:24:29 -0400
Received: from mail.thorsten-knabe.de ([212.60.139.226]:55424 "EHLO
        mail.thorsten-knabe.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfEVMY2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 22 May 2019 08:24:28 -0400
X-Greylist: delayed 1042 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 May 2019 08:24:28 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=thorsten-knabe.de; s=dkim1; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O/2u/+3rOm4UAK3SMQ8TbZ2T9tceAxMqjJFQapTP1Q0=; b=N1iBrxRiOYJe2ZIhpsD+ZDUvIV
        PUHg7D7pQxqfLm+NH7iUTzdsayT/CMP/FeyMsplaR4oVvcz9sKZTeeRvlAzUWcMfv4M+ThWobUAiL
        n+N/kZpBusSm273TI+9rnA2+m7eaInF0+6/Rq48lJ4rzkj2xZfIXlEtM4+r5S7A6cbm6f16cqWDWs
        pzTNiya3Au42lOa0kj9GwmJYSFT7zNUYJQnsQJqX9QqKxAqkfyhsrb/IKbDw03xeAHqic3lDYjUfK
        BEO4TM3j5Uh21fUv55AW1N6hIusOyIxPPQN/GSC2VzajlgwuyesFJnRDAMmZgBntokETQDDX5fYWQ
        JdpZ31NA==;
Received: from tek01.intern.thorsten-knabe.de ([2a01:170:101e:1::a00:101])
        by mail.thorsten-knabe.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <linux@thorsten-knabe.de>)
        id 1hTQ1O-0008Hl-28; Wed, 22 May 2019 14:07:03 +0200
From:   Thorsten Knabe <linux@thorsten-knabe.de>
Subject: BUG: RAID6 recovery broken by commit
 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef (Linux 5.1.3)
Openpgp: preference=signencrypt
To:     shli@kernel.org, ncroxon@redhat.com
Cc:     linux-raid@vger.kernel.org
Message-ID: <69b2ca6b-2ccb-db3b-1fde-62e5b7483293@thorsten-knabe.de>
Date:   Wed, 22 May 2019 14:06:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Report: Content analysis details:   (-1.1 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0018]
  0.8 DKIM_ADSP_ALL          No valid author signature, domain signs all mail
  0.0 SPF_NONE               SPF: sender does not publish an SPF Record
  0.0 SPF_HELO_NONE          SPF: HELO does not publish an SPF Record
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello.

BUG: RAID6 recovery broken by commit
4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef (Linux 5.1.3+)

Replacing a failed disk of a MD RAID6 array causes file system
corruption and data loss on kernels containing commit
4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef.

Affected kernels: 5.1.3, 5.1.4 possibly others.
Unaffected kernels: 5.1.2

OS: Debian stretch amd64

Steps to reproduce the BUG:

1. Create a new 4-disk RAID6 array, create a file system and mount it:
   mdadm /dev/md0 --create -l 6 -n 4 /dev/sd[bcde]
   mkfs.ext4 /dev/md0
   mount /dev/md0 /mnt
2. Store some data (a few GB should be fine) on the RAID6 arrays file
system:
   cp -r whatever /mnt
3. Fail a disk of the RAID6 array and remove it from the array:
   mdadm /dev/md0 --fail /dev/sdd
   mdadm /dev/md0 --remove /dev/sdd
4. Drop caches:
   echo "3" > /proc/sys/vm/drop_caches
5. Compare data copied to the RAID6 array in step 2 with its source:
   diff -r whatever /mnt/whatever
   There should be no differences and no file system errors.
6. Add a new empty disk to the RAID6 array:
   mdadm /dev/md0 --add /dev/sdf
7. RAID6 recovery should start now, wait for the RAID6 recovery to finish.
8. Drop caches again:
   echo "3" > /proc/sys/vm/drop_caches
9. Compare data copied to the RAID6 array in step 2 with its source again:
   diff -r whatever /mnt/whatever
   diff now reports a lot of differences and the kernel log gets filled
with file system errors. For example:
   EXT4-fs warning (device md0): ext4_dirent_csum_verify:355: inode
#918549: comm diff: No space for directory leaf checksum. Please run
e2fsck -D.

Reverting commit 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef from kernel
5.1.4 resolves the issues described above.

Kind regards
Thorsten


-- 
___              
 |        | /                 E-Mail: linux@thorsten-knabe.de 
 |horsten |/\nabe                WWW: http://linux.thorsten-knabe.de 

