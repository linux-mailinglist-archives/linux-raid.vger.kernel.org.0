Return-Path: <linux-raid+bounces-1507-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 580F98CA702
	for <lists+linux-raid@lfdr.de>; Tue, 21 May 2024 05:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D496C2819C0
	for <lists+linux-raid@lfdr.de>; Tue, 21 May 2024 03:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED003B784;
	Tue, 21 May 2024 03:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVqi/zQQ"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A2C2D045
	for <linux-raid@vger.kernel.org>; Tue, 21 May 2024 03:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261684; cv=none; b=HgWF8sxJfOO4pc5tf2awW6n9SVK8cfnpSNYj3lRm3cFhyk6yuQdk1QEwDJwOfHQCEtcaW9Ry7bAtjFyRjvAWSspEPyg/xjmC/qwvX93cjFOiHbqn81NXJ015juHhSWzNWekyDhT2dsQHAOkoZMEgdcc9IjC81MWU/yV29PLq3Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261684; c=relaxed/simple;
	bh=hgEBfrL12u/YZi3Nt98pRvCzPUAIyh72dAb/bdXL2+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlM/5Z6sIqzgvV9dmIHHeVjhky6ExDjgtitiWyOZgkAPwj6i/uCg4xqlfGGGmiqDRSIZESkdE4bPppmwFbEcoBVbA5fJpLMsrl7cLqubff+S8ZwBuOgmRCIW5ZW/YBHt0WqbhM8AKMyA6gZLf4VrR/m/HW1O8St3fsfK28v6c60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVqi/zQQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716261682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5SZaJj7rxUpjvnvkp63OuLLEZc78yuhpeFtPw7UM1Yg=;
	b=bVqi/zQQ9ui2NAKM+AcSWJw7BlCAN5EuEQ0F91RRQBFkJUTByxnnFYTnV9LLcmnSPN+SX6
	F1//v2bqRRZqbYATLxcmracPqUILByBRzlSyS6u01n8964IOagYSbBI1dbsXHW2QwzUiwD
	lIMDUThgbSa+tqigzAwR2bqkFwCUQ30=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-R8ltCkvLNQ2X22QxKpXUsQ-1; Mon, 20 May 2024 23:21:17 -0400
X-MC-Unique: R8ltCkvLNQ2X22QxKpXUsQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2b9e0939124so5812791a91.0
        for <linux-raid@vger.kernel.org>; Mon, 20 May 2024 20:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261676; x=1716866476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SZaJj7rxUpjvnvkp63OuLLEZc78yuhpeFtPw7UM1Yg=;
        b=bOL73WqSQ4L2P7C5YXvCL7JaiLJ87RqASdJ38t0i0MMeh0VYxBLtYmVpJTrVuAyIi+
         rWYrsLfNKurYXnp/lezJQHuhrvLLxcGAWYO/Tu8nli7XXdUZMxzx6ygAe4rd8f1Qn2yE
         yXHtTa785f7RvAPop4KAaGbcmgom+UXWa1fexaqrva5Mza3k/TiDtjni115reXq97YBA
         wY0toKpFh7p6+CP7/H9aU8VdIhovExVpCabPC1nN9Io/uegoX4mNHdOnatbeYfpKZ8qp
         nQnaqdlbaQ4m7kO+fnKWKzgtjJy+f31c5I2CA+tnBh4BN36cPg+nYOT8VYX1cBkddGw9
         Xagw==
X-Forwarded-Encrypted: i=1; AJvYcCVN9xMdmp5bLDj1E9DuFUxJ/2/bgZ7DHBlaS/oQd9vY8x9e4tDzI1Lu+8CTUh54A9qY3iGjJ7EmuIEIFJDRpbqvnmJAnNIBPQYuaA==
X-Gm-Message-State: AOJu0Yy0MwhXg/dLM7JjRObngXNz3ZJn6/v1VQ+OWHISrHdEDGnRk52a
	gazE3oeu2My82iNrMTzTvG5+J48VuaVhWy5gDA4J6peZqlZ/AREFnf3CTg9/6g713h1I4kATmLV
	IfuMFPpxFBH6kQM3XpExwVjRlQvY4YT17aiNiJiRte8jY0tpKBzY1Mo28qaqY/o/cA7r1h3Tcas
	k6iOwegZGZaOlMA8gh+c96xJu0z1k+Ty2r9g==
X-Received: by 2002:a17:90a:db54:b0:2ae:346d:47cc with SMTP id 98e67ed59e1d1-2b6ccd6c244mr27746058a91.38.1716261676286;
        Mon, 20 May 2024 20:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHBPaM7b2VvRPBTjRV2BTjE7ps3LO+3uHh6mWFSlu0ed7RwBfwN7s5iq6aoNmLG/mDSkgLoeKXlbY43INnzrw=
X-Received: by 2002:a17:90a:db54:b0:2ae:346d:47cc with SMTP id
 98e67ed59e1d1-2b6ccd6c244mr27746041a91.38.1716261675915; Mon, 20 May 2024
 20:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405202204.4e3dc662-oliver.sang@intel.com> <c9406496-7b97-a3c5-b48c-32f8248cee39@huaweicloud.com>
 <ZkwOpD8rjYeb+4eT@xsang-OptiPlex-9020>
In-Reply-To: <ZkwOpD8rjYeb+4eT@xsang-OptiPlex-9020>
From: Xiao Ni <xni@redhat.com>
Date: Tue, 21 May 2024 11:21:03 +0800
Message-ID: <CALTww29kyA71WVRxh32W0NkOwZbHkFcs=fTCL5in=e5OhtJ-HA@mail.gmail.com>
Subject: Re: [PATCH md-6.10 5/9] md: replace sysfs api sync_action with new helpers
To: Oliver Sang <oliver.sang@intel.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-raid@vger.kernel.org, agk@redhat.com, snitzer@kernel.org, 
	mpatocka@redhat.com, song@kernel.org, dm-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuai

I've tested 07reshape5intr with the latest upstream kernel 15 times
without failure. So it's better to have a try with 07reshape5intr with
your patch set.

Regards
Xiao




On Tue, May 21, 2024 at 11:02=E2=80=AFAM Oliver Sang <oliver.sang@intel.com=
> wrote:
>
> hi, Yu Kuai,
>
> On Tue, May 21, 2024 at 10:20:54AM +0800, Yu Kuai wrote:
> > Hi,
> >
> > =E5=9C=A8 2024/05/20 23:01, kernel test robot =E5=86=99=E9=81=93:
> > >
> > >
> > > Hello,
> > >
> > > kernel test robot noticed "mdadm-selftests.07reshape5intr.fail" on:
> > >
> > > commit: 18effaab5f57ef44763e537c782f905e06f6c4f5 ("[PATCH md-6.10 5/9=
] md: replace sysfs api sync_action with new helpers")
> > > url: https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/md-rearra=
nge-recovery_flage/20240509-093248
> > > base: https://git.kernel.org/cgit/linux/kernel/git/device-mapper/linu=
x-dm.git for-next
> > > patch link: https://lore.kernel.org/all/20240509011900.2694291-6-yuku=
ai1@huaweicloud.com/
> > > patch subject: [PATCH md-6.10 5/9] md: replace sysfs api sync_action =
with new helpers
> > >
> > > in testcase: mdadm-selftests
> > > version: mdadm-selftests-x86_64-5f41845-1_20240412
> > > with following parameters:
> > >
> > >     disk: 1HDD
> > >     test_prefix: 07reshape5intr
> > >
> > >
> > >
> > > compiler: gcc-13
> > > test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790T CPU @ 2.=
70GHz (Haswell) with 16G memory
> > >
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > >
> > >
> > >
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202405202204.4e3dc662-oliver=
.sang@intel.com
> > >
> > > 2024-05-14 21:36:26 mkdir -p /var/tmp
> > > 2024-05-14 21:36:26 mke2fs -t ext3 -b 4096 -J size=3D4 -q /dev/sda1
> > > 2024-05-14 21:36:57 mount -t ext3 /dev/sda1 /var/tmp
> > > sed -e 's/{DEFAULT_METADATA}/1.2/g' \
> > > -e 's,{MAP_PATH},/run/mdadm/map,g'  mdadm.8.in > mdadm.8
> > > /usr/bin/install -D -m 644 mdadm.8 /usr/share/man/man8/mdadm.8
> > > /usr/bin/install -D -m 644 mdmon.8 /usr/share/man/man8/mdmon.8
> > > /usr/bin/install -D -m 644 md.4 /usr/share/man/man4/md.4
> > > /usr/bin/install -D -m 644 mdadm.conf.5 /usr/share/man/man5/mdadm.con=
f.5
> > > /usr/bin/install -D -m 644 udev-md-raid-creating.rules /lib/udev/rule=
s.d/01-md-raid-creating.rules
> > > /usr/bin/install -D -m 644 udev-md-raid-arrays.rules /lib/udev/rules.=
d/63-md-raid-arrays.rules
> > > /usr/bin/install -D -m 644 udev-md-raid-assembly.rules /lib/udev/rule=
s.d/64-md-raid-assembly.rules
> > > /usr/bin/install -D -m 644 udev-md-clustered-confirm-device.rules /li=
b/udev/rules.d/69-md-clustered-confirm-device.rules
> > > /usr/bin/install -D  -m 755 mdadm /sbin/mdadm
> > > /usr/bin/install -D  -m 755 mdmon /sbin/mdmon
> > > Testing on linux-6.9.0-rc2-00012-g18effaab5f57 kernel
> > > /lkp/benchmarks/mdadm-selftests/tests/07reshape5intr... FAILED - see =
/var/tmp/07reshape5intr.log and /var/tmp/fail07reshape5intr.log for detail
> > [root@fedora mdadm]# ./test --dev=3Dloop --tests=3D07reshape5intr
> > test: skipping tests for multipath, which is removed in upstream 6.8+
> > kernels
> > test: skipping tests for linear, which is removed in upstream 6.8+ kern=
els
> > Testing on linux-6.9.0-rc2-00023-gf092583596a2 kernel
> > /root/mdadm/tests/07reshape5intr... FAILED - see /var/tmp/07reshape5int=
r.log
> > and /var/tmp/fail07reshape5intr.log for details
> >   (KNOWN BROKEN TEST: always fails)
> >
> > So, since this test is marked BROKEN.
> >
> > Please share the whole log, and is it possible to share the two logs?
>
>
> we only captured one log as attached log-18effaab5f.
> also attached parent log FYI.
>
>
> >
> > Thanks,
> > Kuai
> >
> > >
> > >
> > >
> > > The kernel config and materials to reproduce are available at:
> > > https://download.01.org/0day-ci/archive/20240520/202405202204.4e3dc66=
2-oliver.sang@intel.com
> > >
> > >
> > >
> >


