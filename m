Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04EA1E183E
	for <lists+linux-raid@lfdr.de>; Tue, 26 May 2020 01:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388250AbgEYXbU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 19:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388226AbgEYXbS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 May 2020 19:31:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A2CC061A0E
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 16:31:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r7so1924927wro.1
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 16:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=QG0EJEVC8xnF2AVVLJFnfuRuY9zqy1M6/t+dfTym8ek=;
        b=TDcjr2FW3S0g3EFx7qdnjiHuWIRwjjUFLCt/MTTwiUqxBe0DOKvVVIUlHO/vxa+m8r
         ukFGU2uitnLvRwHjoPtNm3Sz7IQUBgy9bwC1RDsVciS7p0wt/Je+hqj8lhPAZJyBf0+M
         EvrTipFKjO1JXapjuWeZiveMqjGTA2KRVr/YiLn/th61FT+3X8f2R8IUyAU8l6HKHPIx
         WXK0Gxx+RECNE74r4SvdxwdZtiDT/tHjeZ7M4oTcyo0xC46psk49QslIxqZ6RmCaJQ8H
         pXbFwoC+FJhBiZEPbWYXWKPzh1Eo4cVrWrxlPTIGV5Assn5jMEfaXwSTg6ZkyMeGASs5
         CIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=QG0EJEVC8xnF2AVVLJFnfuRuY9zqy1M6/t+dfTym8ek=;
        b=dtOpol340m0Z03hN2f4oPH3JPwtuxB/7sLRkV3JyHRv10cv6l+265P51gHpee1xm/y
         jITlJo5J5T1OnSC+e0WBxb4Mt09BscJ9kOKZB3R0sy5Lw/jYC8a/02VN1j2B5M7QSock
         d1ACzy/w3Otr/c1h+5Hp4UGV+RICZEFlMT3hPmmCxxcll1bRckx3ie47cyPYwWODAXs0
         5r4FYhwfcBKlmUR9Zsx4jT1MZq0WodUaCW2hIoPPKZ0jclGpt5tTQI6UZ0kCR8O6HCj5
         Mww/ILcF2or52KNMO5sPATqLLCrYkwUQMO3GIAM5rV/LXqbMPKSJWTvpwXFf1RdhQ1Bu
         mAQg==
X-Gm-Message-State: AOAM530rD5veWwWkxzQJnpJb4Fbh3KJIOuSqKIC8D/A7+dfkNZGOGlQx
        /rS+FSsGJ2OgTfYLko1v4ew6dL3AzLk=
X-Google-Smtp-Source: ABdhPJyTZ7KZrYApoOtFwITi+BuJ7sMaPFl75Ms9HQVureH8scfRlkG3bJqey7pt7M5wSTMpvJ2sXQ==
X-Received: by 2002:adf:e84c:: with SMTP id d12mr2013312wrn.284.1590449476390;
        Mon, 25 May 2020 16:31:16 -0700 (PDT)
Received: from [192.168.188.88] ([46.28.163.233])
        by smtp.gmail.com with ESMTPSA id t185sm816961wmt.28.2020.05.25.16.31.15
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 16:31:16 -0700 (PDT)
Subject: Re: help requested for mdadm grow error
Cc:     linux-raid@vger.kernel.org
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
From:   Thomas Grawert <thomasgrawert0282@gmail.com>
Message-ID: <50c3b5ce-519b-57a6-6f11-f99d69c3fd23@gmail.com>
Date:   Tue, 26 May 2020 01:31:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <37636c91-9baf-4565-9849-f8aca54e392e@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

ok, maybe it´s getting out of scope now. If so, please let me know...

md0 is clean and running. no active resync.  I just tried to mount the 
filesystem to check if everything is fine and to proceed with growing... 
thanks god, I did it this way because:

root@nas:~# mount /dev/md0 /mnt
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/md0, 
missing codepage or helper program, or other error.

root@nas:~# df -h
Filesystem    Größe Benutzt Verf. Verw% Eingehängt auf
udev             16G       0   16G    0% /dev
tmpfs           3,1G     11M  3,1G    1% /run
/dev/sdg2       203G    7,2G  186G    4% /
tmpfs            16G       0   16G    0% /dev/shm
tmpfs           5,0M    4,0K  5,0M    1% /run/lock
tmpfs            16G       0   16G    0% /sys/fs/cgroup
/dev/sdg1       511M    5,2M  506M    1% /boot/efi
tmpfs           3,1G       0  3,1G    0% /run/user/0
root@nas:~# fsck /dev/md0
fsck from util-linux 2.33.1
e2fsck 1.44.5 (15-Dec-2018)
ext2fs_open2: Ungültige magische Zahl im Superblock
fsck.ext2: Superblock ungültig, Datensicherungs-Blöcke werden versucht ...
fsck.ext2: Ungültige magische Zahl im Superblock beim Versuch, /dev/md0 
zu öffnen

Der Superblock ist unlesbar bzw. beschreibt kein gültiges ext2/ext3/ext4-
Dateisystem. Wenn das Gerät gültig ist und ein ext2/ext3/ext4-
Dateisystem (kein swap oder ufs usw.) enthält, dann ist der Superblock
beschädigt, und Sie könnten versuchen, e2fsck mit einem anderen Superblock
zu starten:
     e2fsck -b 8193 <Gerät>
  oder
     e2fsck -b 32768 <Gerät>

In /dev/md0 wurde eine gpt-Partitionstabelle gefunden

=========================================

For those who not understand German:
ext2fs_open2: Invalid magical number in superblock
fsck.ext2: Superblock invalid. Backup-blocks are tried...
fsck.ext2:  Invalid magical number in superblock when trying to open 
/dev/md0

Found a gpt-partition-table at /dev/md0

=========================================

there should be a valid ext4 filesystem...

