Return-Path: <linux-raid+bounces-4231-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8589BABCDFB
	for <lists+linux-raid@lfdr.de>; Tue, 20 May 2025 05:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860B4189D7A6
	for <lists+linux-raid@lfdr.de>; Tue, 20 May 2025 03:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5582580F1;
	Tue, 20 May 2025 03:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b="ADsxTAR2"
X-Original-To: linux-raid@vger.kernel.org
Received: from mail-108-mta209.mxroute.com (mail-108-mta209.mxroute.com [136.175.108.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F8413B58B
	for <linux-raid@vger.kernel.org>; Tue, 20 May 2025 03:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747713163; cv=none; b=JLjTAYArRklpdrsutxIIRaJt2l7+lyrc8+7OYpTq1lQOtabz6Kgg+JdV1d7m3JFiiXuVaRr+64Ka19HTHBTpEpw9hch5OKzGVM6GKTtQ1IImIYLWeXPDnV43N/YuDpp1egGZ1O7nufhWHTs2zQKGerizYh8CULmaT+KuZvZwv5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747713163; c=relaxed/simple;
	bh=xR4RO7cAKj+dDyWDfREkss86cB5Q31usj/YD9flL9Mw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PbYgdyY7z7bv1lO2NRNntVVdAKHT8IkodAKoNmjfxLosdzpDHRohaGBPBbDDwBxRcf1eJE10hI12GQvc3pHqhT6CUkSmwTzN1ZUE25xv0qyQSGRob3a6EQOpJd7C9FNITw3kn2Jg0O1taGQEjGXc0Myy9eoCcjuLrulcNewg+JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org; spf=pass smtp.mailfrom=damenly.org; dkim=pass (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b=ADsxTAR2; arc=none smtp.client-ip=136.175.108.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damenly.org
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta209.mxroute.com (ZoneMTA) with ESMTPSA id 196ebcda5310008631.007
 for <linux-raid@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 20 May 2025 03:47:25 +0000
X-Zone-Loop: 7930db8d0b7ee9517cf22901be3fa3d5a22698b726e9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=damenly.org
	; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=Uio/We5CInJkkbCWP9SsY+Cgn/ZfxBWnr6bGZOqG5XQ=; b=ADsxTAR2OSlx
	EHI/DMnj858s7iBJ9WIr8OlC9JCKfQoIx3dbONLhTgYfh5l4SP1iN7RNFDI2oJ/Nugbtf1ZrULU40
	5CZbIc6OLTOib0ZD7oGPquEIOdUs/K9vqcU0CVm5GrNNE8j6ZliPRU1zMXmbFixZc4UzSE117pTPn
	W4T/gv/ILvhqRcwOtUS9+1sV5j+j7juAMuwhC+nqAluuQ3LTJa6SYDkB0pgBn8t+Iqe6iYt8BPCba
	zgZ4lrlvUFRTrfgz3R+hAgphGmAIGXeCXyrlloB6SGJUIeBUfcGzsz53mV+4T62PlL/w+loESf4Sx
	XBIKSII+qW7tkYgh9tJsPQ==;
From: Su Yue <l@damenly.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Zdenek Kabelac <zdenek.kabelac@gmail.com>,  Mikulas Patocka
 <mpatocka@redhat.com>,  Song Liu <song@kernel.org>,
  linux-raid@vger.kernel.org,  dm-devel@lists.linux.dev,  "yukuai (C)"
 <yukuai3@huawei.com>
Subject: Re: LVM2 test breakage
In-Reply-To: <52577231-f4d3-84d1-ec5f-a197625a63c4@huaweicloud.com> (Yu Kuai's
	message of "Tue, 20 May 2025 09:53:59 +0800")
References: <34fa755d-62c8-4588-8ee1-33cb1249bdf2@redhat.com>
	<98ac5772-9931-17fd-1fc4-18d2c737b079@huaweicloud.com>
	<73ff7f5f-6f09-66d8-9061-7840bc72d0df@huaweicloud.com>
	<0be9be18-9488-1edc-00bb-5a1b0414fd15@redhat.com>
	<81c5847a-cfd8-4f9f-892c-62cca3d17e63@redhat.com>
	<2ec7a2fd-13bd-08d7-8e8d-71ef83c3aa45@huaweicloud.com>
	<28d561ba-a4d4-4a16-a6f9-5d39a344cd06@gmail.com>
	<db63fa48-b4bc-b5bc-c374-82422096a264@huaweicloud.com>
	<52577231-f4d3-84d1-ec5f-a197625a63c4@huaweicloud.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Tue, 20 May 2025 11:47:02 +0800
Message-ID: <y0usaqq1.fsf@damenly.org>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Id: l@damenly.org

On Tue 20 May 2025 at 09:53, Yu Kuai <yukuai1@huaweicloud.com>=20
wrote:

> Hi,
>
> =E5=9C=A8 2025/05/20 9:45, Yu Kuai =E5=86=99=E9=81=93:
>> dd if=3D/dev/zero of=3D/mnt/test/test.img bs=3D1048576 count=3D0=20
>> seek=3D5000000003
>> dd: failed to truncate to 5242880003145728 bytes in output file
>> '/mnt/test/test.img': File too large
>> And this is because ext4 has hard limit of file size, 2^48:
>> fs/ext4/super.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sb->s_maxbyte=
s =3D=20
>> ext4_max_size(sb->s_blocksize_bits,
>> has_huge_files);
>> So, I can't use ext4 for this testcase. :(
>
> Sadly, after switching to xfs, with 2^64 file size limit, I got=20
> a new
> error:
>
> [ 0:10.980] # 200 TiB raid1
> [ 0:10.980] lvcreate --type raid1 -m 1 -L 200T -n $lv1 $vg1=20
> --nosync
> [ 0:10.980] #lvcreate-large-raid.sh:51+ lvcreate --type raid1 -m=20
> 1 -L 200T -n
> LV1 LVMTEST1868vg1 --nosync
> [ 0:10.980] File descriptor 6 (/dev/pts/0) leaked on lvm=20
> invocation. Parent PID
> 1868: bash
> [ 0:11.226]   WARNING: New raid1 won't be synchronized. Don't=20
> read what you
> didn't write!
> [ 0:11.397]   Failed to deactivate LVMTEST1868vg1/LV1_rmeta_0.
> [ 0:11.776]   Internal error: Removing still active LV
> LVMTEST1868vg1/LV1_rmeta_0.
> [ 0:11.966] /root/lvm2/test/shell/lvcreate-large-raid.sh: line=20
> 51:  2071 Aborted
> (core dumped) lvcreate --type raid1 -m 1 -L 200T -n $lv1 $vg1=20
> --nosync
> [ 0:14.059] set +vx; STACKTRACE; set -vx
> [ 0:14.061] ##lvcreate-large-raid.sh:51+ set +vx
> [ 0:14.061] ## - /root/lvm2/test/shell/lvcreate-large-raid.sh:51
> [ 0:14.065] ## 1 STACKTRACE() called from
> /root/lvm2/test/shell/lvcreate-large-raid.sh:51
>
> Looks like lvcreate crashed.
>
Can't reproduce it on v6.15-rc7 and lvm2 HEAD=20
37b28216fd029ffe2fac815b16645aeb9d352235:

/dev/vdc on /mnt type xfs=20
(rw,relatime,attr2,inode64,logbufs=3D8,logbsize=3D32k,noquota)
make check_local T=3Dshell/lvcreate-large-raid.sh=20
LVM_TEST_AUX_TRACE=3D1  VERBOSE=3D1 LVM_TEST_DIR=3D/mnt

What's your kernel and lvm versions?

--
Su
> Thanks,
> Kuai

