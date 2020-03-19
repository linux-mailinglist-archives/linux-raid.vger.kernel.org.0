Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE89D18C0E0
	for <lists+linux-raid@lfdr.de>; Thu, 19 Mar 2020 20:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgCSTzk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 19 Mar 2020 15:55:40 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:36790 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgCSTzk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 19 Mar 2020 15:55:40 -0400
Received: by mail-lj1-f179.google.com with SMTP id g12so3969484ljj.3
        for <linux-raid@vger.kernel.org>; Thu, 19 Mar 2020 12:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qAs41D/YOBXqgsCPZjmVfEp9c7sDlgROa0MNlTXIQpk=;
        b=Ksr15cqkaWLM0ovqDPEEYXAdpW9zdL9DbccAVrO4w/C55rj8Rlg9NKzwTftA1Gqi1o
         7KDUE+IrnZto0OnDAmrEEbhfSZgD/Zr7XlbgSZrwPrJWJ36VOkFOMr+QL90ZtgM4hyG5
         wCHAR0/+gE5y5WwiPydMgPGOE40rtlRdd1dBup632Xl4vPIKYnUPQI/l21YorSS0IuIF
         LxsNpFrFNuGXQsINUrZExb+Q09YtHJ7Pp8ZW31oTkyJO1fmjSDRkctGzaj/Rpn2Za/y0
         2aUomkkNQe4LPa55tJt0mpJRo2ifOkEaavypJ55cB6sTjxS4OZrSu+t2ZEbc92tLWKU4
         PkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qAs41D/YOBXqgsCPZjmVfEp9c7sDlgROa0MNlTXIQpk=;
        b=rytG+yzRCr8qL6VF1dExYatNRAVhlOA+S3Xb7aYbDK7x01vvYjjnQ9LLwQoU+DWQ+u
         5IlAfw9PhmtObXpIrOahREieQiYUQ/Ttixwod6pN/BJGyQoaOWhTembAGoHqHI6QpkXC
         RuafIXqFB+l8qJFh5MF5g245GAVfKWSPj4GyS9N5vdSu92xp9+6irbhuuYIl9FYALY0k
         fIdtdSuYS+qMtmgfQxgr1e0r15IjkHxHB1NlVerSXYRW8948oAKSsCIuUDpWWdqH7KzS
         1pKzsHIecx/0Ph+MAdpWZcAP8vv5T2Ce8DCFHyFmQ0S38oWpaNVhWSFmcPkbdSvwqO5c
         N23g==
X-Gm-Message-State: ANhLgQ3MSG8udAoFyWJrZ6oIbrRXNBIQO+Y8yxEyAMk60WlqonbIECfR
        gGvFD4O9YCinPsmLSmTE5vApYocQSwaLmtx814v5IrDGTgQ=
X-Google-Smtp-Source: ADFU+vvdm6lSNqrMuiEKSbUzpAeBBw+iE+pwdKY8s1TzWqF7kzOuWR/RcNZXcJ31jzi6TvjT9WcDV5A8rGg43B0zsvg=
X-Received: by 2002:a2e:92d6:: with SMTP id k22mr3201008ljh.18.1584647736361;
 Thu, 19 Mar 2020 12:55:36 -0700 (PDT)
MIME-Version: 1.0
From:   Glenn Greibesland <glenngreibesland@gmail.com>
Date:   Thu, 19 Mar 2020 20:55:25 +0100
Message-ID: <CA+9eyijuUEJ7Y8BuxkKaZ=v8zbPpwixOezngPjtJzaLsBd+A4Q@mail.gmail.com>
Subject: Raid6 recovery
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi. I need some help with recovering from multiple disk failure on a
RAID6 array.
I had two failed disks and therefore shut down the server and
connected new disks.
After I powered on the server, another disk got booted out of the
array leaving it with only 15 out of 18 working devices, so it won=E2=80=99=
t
start.
I ran an offline test with smartctl and the disk that got thrown out
of the array seems totally fine.

Here is where I think I made a mistake. I use the =E2=80=93re-add command o=
n
the disk. Now it is regarded as spare and the array still won=E2=80=99t sta=
rt.

I=E2=80=99ve been reading on
https://raid.wiki.kernel.org/index.php/RAID_Recovery and I have tried
`=E2=80=93assemble =E2=80=93scan =E2=80=93force =E2=80=93verbose` and manua=
l `=E2=80=93assemble =E2=80=93force` with
specifying each drive. Neither of them works (reporting that 15 out of
18 devices is not enough).

All drives has the same event count and used dev size, but two of the
devices has a lower Avail Dev Size, and a different Data Offset.

After a bit of digging in the manual and on different forums I have
concluded that the next step for me is to recreate the array using
=E2=80=93assume-clean and =E2=80=93data-offset=3Dvariable.
I have tried a dry run of the command (answering no to =E2=80=9CContinue
creating array=E2=80=9D), and mdadm accepts the parameters without any erro=
rs:


mdadm --create --assume-clean --level=3D6 --raid-devices=3D18
--size=3D3906763776s --chunk=3D512K --data-offset=3Dvariable /dev/md0
/dev/sdj1:262144s /dev/sdk1:262144s /dev/sdi1:262144s
/dev/sdh1:262144s /dev/sdo1:262144s /dev/sdp1:262144s
/dev/sdr1:262144s /dev/sdq1:262144s /dev/sdf1:262144s
/dev/sdb1:262144ss /dev/sdg1:262144s /dev/sdd1:262144s
/dev/sdm1:262144s /dev/sdf2:241664s missing missing /dev/sdc2:241664s
/dev/sdc1:262144s
mdadm: /dev/sdj1 appears to be part of a raid array:
       level=3Draid6 devices=3D18 ctime=3DWed Nov 14 22:53:28 2012
mdadm: /dev/sdk1 appears to be part of a raid array:
       level=3Draid6 devices=3D18 ctime=3DWed Nov 14 22:53:28 2012
mdadm: /dev/sdi1 appears to be part of a raid array:
       level=3Draid6 devices=3D18 ctime=3DWed Nov 14 22:53:28 2012
mdadm: /dev/sdh1 appears to be part of a raid array:
       level=3Draid6 devices=3D18 ctime=3DWed Nov 14 22:53:28 2012
mdadm: /dev/sdo1 appears to be part of a raid array:
       level=3Draid6 devices=3D18 ctime=3DWed Nov 14 22:53:28 2012
mdadm: /dev/sdp1 appears to be part of a raid array:
       level=3Draid6 devices=3D18 ctime=3DWed Nov 14 22:53:28 2012
mdadm: /dev/sdr1 appears to be part of a raid array:
       level=3Draid6 devices=3D18 ctime=3DWed Nov 14 22:53:28 2012
mdadm: /dev/sdq1 appears to be part of a raid array:
       level=3Draid6 devices=3D18 ctime=3DWed Nov 14 22:53:28 2012
mdadm: /dev/sdf1 appears to be part of a raid array:
       level=3Draid6 devices=3D18 ctime=3DWed Nov 14 22:53:28 2012
mdadm: /dev/sdb1 appears to be part of a raid array:
       level=3Draid6 devices=3D18 ctime=3DWed Nov 14 22:53:28 2012
mdadm: partition table exists on /dev/sdb1 but will be lost or
       meaningless after creating array
mdadm: /dev/sdg1 appears to be part of a raid array:
       level=3Draid6 devices=3D18 ctime=3DWed Nov 14 22:53:28 2012
mdadm: /dev/sdd1 appears to be part of a raid array:
       level=3Draid6 devices=3D18 ctime=3DWed Nov 14 22:53:28 2012
mdadm: /dev/sdm1 appears to be part of a raid array:
       level=3Draid6 devices=3D18 ctime=3DWed Nov 14 22:53:28 2012
mdadm: /dev/sdf2 appears to be part of a raid array:
       level=3Draid6 devices=3D18 ctime=3DWed Nov 14 22:53:28 2012
mdadm: /dev/sdc2 appears to be part of a raid array:
       level=3Draid6 devices=3D18 ctime=3DWed Nov 14 22:53:28 2012
mdadm: /dev/sdc1 appears to be part of a raid array:
       level=3Draid6 devices=3D18 ctime=3DWed Nov 14 22:53:28 2012
Continue creating array? N

My only worries now are the size and data-offset parameters. According
to the man page, the size should be specified in KiloBytes. It was
KibiBytes previously.
The Used Device Size of all array members is 3906763776 sectors
(1862.89 GiB 2000.26 GB).

Should I convert the sectors into KiloBytes or does mdadm support
using sectors as unit for =E2=80=93size and data-offset? It is not mentione=
d
in the manual, but I=E2=80=99ve seen it being used on different forum threa=
ds
and mdadm does not blow up if I try using it.

Any other suggestions?
