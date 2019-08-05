Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8B4381884
	for <lists+linux-raid@lfdr.de>; Mon,  5 Aug 2019 13:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfHELzw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 5 Aug 2019 07:55:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53791 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHELzw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 5 Aug 2019 07:55:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so74464841wmj.3
        for <linux-raid@vger.kernel.org>; Mon, 05 Aug 2019 04:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6DV7NULWXTKmxPUlxIbIaTZ+WwHek3RCbS21JjmkqM=;
        b=AXZ1JXWHpa1/9l8Lat/iA00eJxyxK8rXNxsFRf/7VHn9iXxxioTT9hAEItPx1Dh9th
         jIM5rzqJgCf61lqf+HxveUC7mM9UoG43KxWZJtKfJQIfA7mSISGGBVYPGNg4SM/uHuMW
         MsM0dJarujeWc8LH+h9WrR5deoIUFo5EqJ6Gycxe5R2g7z89x5phAAx+TtmEKWw05q1/
         02LO0EfCJQg4I2QJfTtHNNeFe+vwPomtwR9mhV5QhBqmhXgV1PW2F//7iIeOcc2+vsRG
         1uU98BwxupRiCrZN9Pcr+PnI5uFlPlwTIWEKuDhEZ/269L8+hRgIbvKbrLZh41PgPFT7
         oviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6DV7NULWXTKmxPUlxIbIaTZ+WwHek3RCbS21JjmkqM=;
        b=PWuCqQMkRzo/Bv1ZFGUp0T8mPS3DPaFOvLVMI++ZLsQjdttkfE8LzyQECFAGO04oiZ
         0Ks+g06F7q/XBsKIdNBMBzJptZCwlpOOlMmBiElfo+FIoPDRBln5Pa9nswtUI1TjOCDP
         XuKjXcRmww4kzBCdJq6AEvEiIz5csNKwALZF7i9Pzn3TV9URT9eAVpFgRA3gG1iUeLKG
         IsR0vK82u0q4SMnpIpaV7iFod7cRZ45oE880/HUIGVSFE6+L8S2JGUSDYCNl8ktcxhO1
         tHPxCEl6JfZEBNd68543Fe1QldUS6JJSYH5C9Z9uzQTxx87I1WMu5iF62e75ne/Hki3U
         NOtg==
X-Gm-Message-State: APjAAAVMW/uppdEmmlxzbdxaktFMLQKPdATZpo/6BUYDfMSx2z22UlU7
        c1j3CkSSgkMcYEnMFmgs3onyFTFSHHRzlkKI4/AuYw==
X-Google-Smtp-Source: APXvYqxRocYlZtsmySV21CtvrpzgqkTjPiyGA/IX/Ff4cR/YijjeB8VqhHjlHMmanlC3IKQDUZI/c4pVnbBHk6t8P44=
X-Received: by 2002:a1c:c005:: with SMTP id q5mr17605109wmf.59.1565006149655;
 Mon, 05 Aug 2019 04:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffEkotpvVz8FA78vNFh0qZv3kEMNrXXfVPEUC=MhH0pMCZA@mail.gmail.com>
 <0a83fde3-1a74-684c-0d70-fb44b9021f96@molgen.mpg.de> <CAMGffE=_kPoBmSwbxvrqdqbhpR5Cu2Vbe4ArGqm9ns9+iVEH_g@mail.gmail.com>
In-Reply-To: <CAMGffE=_kPoBmSwbxvrqdqbhpR5Cu2Vbe4ArGqm9ns9+iVEH_g@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 5 Aug 2019 13:55:38 +0200
Message-ID: <CAMGffEkcXcQC+kjwdH0iVSrFDk-o+dp+b3Q1qz4z=R=6D+QqLQ@mail.gmail.com>
Subject: Bisected: Kernel 4.14 + has 3 times higher write IO latency than
 Kernel 4.4 with raid1
To:     NeilBrown <neilb@suse.com>, linux-raid <linux-raid@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandr Iarygin <alexandr.iarygin@cloud.ionos.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Neil,

For the md higher write IO latency problem, I bisected it to these commits:

4ad23a97 MD: use per-cpu counter for writes_pending
210f7cd percpu-refcount: support synchronous switch to atomic mode.

Do you maybe have an idea? How can we fix it?

Regards,
Jack Wang

git bisect log:
git bisect start
# good: [d9560919689d588beccf719452086b5cdf6d6c22] Linux 4.4.157
git bisect good d9560919689d588beccf719452086b5cdf6d6c22
# good: [d9560919689d588beccf719452086b5cdf6d6c22] Linux 4.4.157
git bisect good d9560919689d588beccf719452086b5cdf6d6c22
# good: [b562e44f507e863c6792946e4e1b1449fbbac85d] Linux 4.5
git bisect good b562e44f507e863c6792946e4e1b1449fbbac85d
# bad: [7d80e1218adf6d1aa5270587192789e218fef706] Linux 4.14.136
git bisect bad 7d80e1218adf6d1aa5270587192789e218fef706
# good: [309c675e62d140d46806ca3e6b29f4549076d0d6] hwmon: (pcf8591)
use permission-specific DEVICE_ATTR variants
git bisect good 309c675e62d140d46806ca3e6b29f4549076d0d6
# bad: [8ad06e56dcbc1984ef0ff8f6e3c19982c5809f73] Merge branch 'linus'
of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect bad 8ad06e56dcbc1984ef0ff8f6e3c19982c5809f73
# good: [47d272f0f9887343f4e4d31bb22910b141b96654] Merge tag
'iwlwifi-next-for-kalle-2017-04-26' of
git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
git bisect good 47d272f0f9887343f4e4d31bb22910b141b96654
# bad: [81be3dee96346fbe08c31be5ef74f03f6b63cf68] fs/xattr.c: zero out
memory copied to userspace in getxattr
git bisect bad 81be3dee96346fbe08c31be5ef74f03f6b63cf68
# bad: [2f34c1231bfc9f2550f934acb268ac7315fb3837] Merge tag
'drm-for-v4.12' of git://people.freedesktop.org/~airlied/linux
git bisect bad 2f34c1231bfc9f2550f934acb268ac7315fb3837
# good: [be580e7522eecfcf31c70abdf6fa0ae77b2e293b] Merge tag
'mmc-v4.12' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect good be580e7522eecfcf31c70abdf6fa0ae77b2e293b
# good: [f7effef8d6e38d7d3120c604ad7d0b299b349e14] drm/amdgpu: limit
block size to one page
git bisect good f7effef8d6e38d7d3120c604ad7d0b299b349e14
# good: [1676a2b35cd5a548da17d1106fb0d4d238c0d191] drm/i915: Park the
signaler before sleeping
git bisect good 1676a2b35cd5a548da17d1106fb0d4d238c0d191
# good: [0302e28dee643932ee7b3c112ebccdbb9f8ec32c] Merge branch 'next'
of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
git bisect good 0302e28dee643932ee7b3c112ebccdbb9f8ec32c
# bad: [d35a878ae1c50977b55e352fd46e36e35add72a0] Merge tag
'for-4.12/dm-changes' of
git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm
git bisect bad d35a878ae1c50977b55e352fd46e36e35add72a0
# bad: [78b6350dcaadb03b4a2970b16387227ba6744876] md: support
disabling of create-on-open semantics.
git bisect bad 78b6350dcaadb03b4a2970b16387227ba6744876
# bad: [513e2faa0138462ce014e1b0e226ca45c83bc6c1] md: prepare for
managing resync I/O pages in clean way
git bisect bad 513e2faa0138462ce014e1b0e226ca45c83bc6c1
# good: [497280509f32340d90feac030bce18006a3e3605] md/raid5: use
md_write_start to count stripes, not bios
git bisect good 497280509f32340d90feac030bce18006a3e3605
# good: [84dd97a69092cef858483b775f1900d743d796a4] md/raid5: don't
test ->writes_pending in raid5_remove_disk
git bisect good 84dd97a69092cef858483b775f1900d743d796a4
# bad: [0b408baf7f4f3ea94239d021a1f19e60cd8694de] raid5-ppl: silence a
misleading warning message
git bisect bad 0b408baf7f4f3ea94239d021a1f19e60cd8694de
# good: [55cc39f345256af241deb6152ff5c06bedd10f11] md: close a race
with setting mddev->in_sync
git bisect good 55cc39f345256af241deb6152ff5c06bedd10f11
# bad: [4ad23a976413aa57fe5ba7a25953dc35ccca5b71] MD: use per-cpu
counter for writes_pending
git bisect bad 4ad23a976413aa57fe5ba7a25953dc35ccca5b71

diff between bad latency and good latency:
root@ib2:/home/jwang/pb-linux-4.14# diff
md_lat_ib2_4.11.0-rc2-1-storage+_2019_0805_125846.log
md_lat_ib2_4.11.0-rc2-1-storage+_2019_0805_132042.log
5c5
< write-test: (groupid=0, jobs=1): err= 0: pid=3265: Mon Aug  5 12:59:27 2019
---
> write-test: (groupid=0, jobs=1): err= 0: pid=3192: Mon Aug  5 13:21:23 2019
7,9c7,9
<     slat (usec): min=2, max=29, avg= 2.36, stdev= 0.49
<     clat (usec): min=0, max=94, avg= 0.37, stdev= 1.13
<      lat (usec): min=2, max=113, avg= 2.74, stdev= 1.16
---
>     slat (usec): min=2, max=59973, avg= 5.25, stdev=375.04
>     clat (usec): min=0, max=127, avg= 1.74, stdev=13.00
>      lat (usec): min=2, max=60095, avg= 7.00, stdev=376.12
13,20c13,20
<      | 70.00th=[    1], 80.00th=[    1], 90.00th=[    1], 95.00th=[    1],
<      | 99.00th=[    1], 99.50th=[    1], 99.90th=[    1], 99.95th=[    1],
<      | 99.99th=[   67]
<     bw (KB  /s): min=20000, max=20008, per=100.00%, avg=20004.35, stdev= 4.01
<     lat (usec) : 2=99.96%, 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%
<     lat (usec) : 100=0.02%
<   cpu          : usr=2.44%, sys=1.49%, ctx=199942, majf=0, minf=11
<   IO depths    : 1=100.0%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=0.0%
---
>      | 70.00th=[    0], 80.00th=[    1], 90.00th=[    1], 95.00th=[    1],
>      | 99.00th=[   93], 99.50th=[  120], 99.90th=[  123], 99.95th=[  124],
>      | 99.99th=[  125]
>     bw (KB  /s): min=18042, max=22072, per=100.00%, avg=20007.54, stdev=409.26
>     lat (usec) : 2=98.52%, 4=0.01%, 10=0.01%, 20=0.02%, 50=0.06%
>     lat (usec) : 100=0.41%, 250=0.98%
>   cpu          : usr=1.06%, sys=2.81%, ctx=197106, majf=0, minf=11
>   IO depths    : 1=98.5%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=1.3%, >=64=0.0%
30c30
<     md0: ios=60/199469, merge=0/0, ticks=0/0, in_queue=0,
util=0.00%, aggrios=0/0, aggrmerge=0/0, aggrticks=0/0, aggrin_queue=0,
aggrutil=0.00%
---
>     md0: ios=60/199443, merge=0/0, ticks=0/0, in_queue=0, util=0.00%, aggrios=0/0, aggrmerge=0/0, aggrticks=0/0, aggrin_queue=0, aggrutil=0.00%
