Return-Path: <linux-raid+bounces-4230-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E0DABCC78
	for <lists+linux-raid@lfdr.de>; Tue, 20 May 2025 03:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834691B6230B
	for <lists+linux-raid@lfdr.de>; Tue, 20 May 2025 01:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C460255F2A;
	Tue, 20 May 2025 01:54:08 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C800A254AE4
	for <linux-raid@vger.kernel.org>; Tue, 20 May 2025 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747706047; cv=none; b=IIp/AksNv6oYvDOKAk/E2p2ErgK2SdoP5oi3hPU9vRAcbHSitDk3ubJc4ISuIi7BgVKC1Nk9YMcvDmEM740Rr200Z6prXFbJ8cQz7EqfVP6noNjLdLHTAuK5ytH0H3Ch2a0+/BlXNRDJR5/Jz8htr/hW1fg+eFkZ1zSIg4mLm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747706047; c=relaxed/simple;
	bh=4xMMe4Mrlqndxj9tbVChBh9qXtcq2/Tl6ZbZWJFW/U0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tipOsCqmibEaJnexfIp//t+aK89FwcitqNZZ3Wjm9b2YUbyhJptUnZyHGAXXQH1bj0vnbQreu6SW+wAXytk3CbjsFAYQ8ESuKRgBFIPNT0F31U5qxHF4+TGzGtnKqIdxRyh0J3S37bXb+2YW5Vwk9lTL+HGYcOkAa7sJD96GD9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4b1cz90CR2z4f3jqb
	for <linux-raid@vger.kernel.org>; Tue, 20 May 2025 09:53:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CE6F51A1513
	for <linux-raid@vger.kernel.org>; Tue, 20 May 2025 09:54:00 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgA3m1+44Ctoip+7Mw--.60273S3;
	Tue, 20 May 2025 09:54:00 +0800 (CST)
Subject: Re: LVM2 test breakage
To: Yu Kuai <yukuai1@huaweicloud.com>,
 Zdenek Kabelac <zdenek.kabelac@gmail.com>,
 Mikulas Patocka <mpatocka@redhat.com>
Cc: Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
 dm-devel@lists.linux.dev, "yukuai (C)" <yukuai3@huawei.com>
References: <34fa755d-62c8-4588-8ee1-33cb1249bdf2@redhat.com>
 <98ac5772-9931-17fd-1fc4-18d2c737b079@huaweicloud.com>
 <73ff7f5f-6f09-66d8-9061-7840bc72d0df@huaweicloud.com>
 <0be9be18-9488-1edc-00bb-5a1b0414fd15@redhat.com>
 <81c5847a-cfd8-4f9f-892c-62cca3d17e63@redhat.com>
 <2ec7a2fd-13bd-08d7-8e8d-71ef83c3aa45@huaweicloud.com>
 <28d561ba-a4d4-4a16-a6f9-5d39a344cd06@gmail.com>
 <db63fa48-b4bc-b5bc-c374-82422096a264@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <52577231-f4d3-84d1-ec5f-a197625a63c4@huaweicloud.com>
Date: Tue, 20 May 2025 09:53:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <db63fa48-b4bc-b5bc-c374-82422096a264@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3m1+44Ctoip+7Mw--.60273S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4ftr17uFW5Jr48XF1DZFb_yoW8XFWrpF
	s5Jw45Arn3GF1DG3yvgFWUJr18tw13CFyYkayfXFyxCFW7Z395ZFsxGr1jgFsrKFZ3KrW2
	va1kGrZrX3WYkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUG0PhUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/05/20 9:45, Yu Kuai 写道:
> dd if=/dev/zero of=/mnt/test/test.img bs=1048576 count=0 seek=5000000003
> dd: failed to truncate to 5242880003145728 bytes in output file 
> '/mnt/test/test.img': File too large
> 
> And this is because ext4 has hard limit of file size, 2^48:
> 
> fs/ext4/super.c:        sb->s_maxbytes = 
> ext4_max_size(sb->s_blocksize_bits, has_huge_files);
> 
> So, I can't use ext4 for this testcase. :(

Sadly, after switching to xfs, with 2^64 file size limit, I got a new
error:

[ 0:10.980] # 200 TiB raid1
[ 0:10.980] lvcreate --type raid1 -m 1 -L 200T -n $lv1 $vg1 --nosync
[ 0:10.980] #lvcreate-large-raid.sh:51+ lvcreate --type raid1 -m 1 -L 
200T -n LV1 LVMTEST1868vg1 --nosync
[ 0:10.980] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. 
Parent PID 1868: bash
[ 0:11.226]   WARNING: New raid1 won't be synchronized. Don't read what 
you didn't write!
[ 0:11.397]   Failed to deactivate LVMTEST1868vg1/LV1_rmeta_0.
[ 0:11.776]   Internal error: Removing still active LV 
LVMTEST1868vg1/LV1_rmeta_0.
[ 0:11.966] /root/lvm2/test/shell/lvcreate-large-raid.sh: line 51:  2071 
Aborted                 (core dumped) lvcreate --type raid1 -m 1 -L 200T 
-n $lv1 $vg1 --nosync
[ 0:14.059] set +vx; STACKTRACE; set -vx
[ 0:14.061] ##lvcreate-large-raid.sh:51+ set +vx
[ 0:14.061] ## - /root/lvm2/test/shell/lvcreate-large-raid.sh:51
[ 0:14.065] ## 1 STACKTRACE() called from 
/root/lvm2/test/shell/lvcreate-large-raid.sh:51

Looks like lvcreate crashed.

Thanks,
Kuai


