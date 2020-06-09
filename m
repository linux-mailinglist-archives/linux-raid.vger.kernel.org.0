Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0801F4872
	for <lists+linux-raid@lfdr.de>; Tue,  9 Jun 2020 22:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgFIU6o (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 9 Jun 2020 16:58:44 -0400
Received: from mx0a-0019cd01.pphosted.com ([67.231.149.227]:4404 "EHLO
        mx0b-0019cd01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727113AbgFIU6j (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 9 Jun 2020 16:58:39 -0400
Received: from pps.filterd (m0073873.ppops.net [127.0.0.1])
        by mx0a-0019cd01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 059KmlbX019729
        for <linux-raid@vger.kernel.org>; Tue, 9 Jun 2020 16:58:38 -0400
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        by mx0a-0019cd01.pphosted.com with ESMTP id 31g7d90ftu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-raid@vger.kernel.org>; Tue, 09 Jun 2020 16:58:38 -0400
Received: by mail-qv1-f71.google.com with SMTP id j4so60544qvt.20
        for <linux-raid@vger.kernel.org>; Tue, 09 Jun 2020 13:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fordham-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=KtDersxh/nH2j1uixRPqZ04XHGmOZQ9jBWuISXV4vrU=;
        b=uMrYAmXeHApE2XP5IpAlZlMcxRcLAR08H2ztMluvhOtH8g2FCxV7fiyHozvLaZNqbm
         ++3cuzYDd7P0QUmMe440oYJwz0wM+yzXNtHRvhEx6t8zE4XNGYHo5TLog89PkmSrCXjU
         o5b5cwh/gjWWW4G2vz85oY7ut+zR7Kn2LB9xotv4PfuhNsTE+B5DbmhbsvHahNz+MPoi
         R8FlLk/4QDa/4Y+SlTatEIQH9L1nomzXKLLQpckJ6xYlVfa5zVZjnN79A64v8tjXtXh4
         i6VEi4zLYTQZP+IIf/ZY+2ZW006A55/IppzGYbbrRB0Yw1yPXepQGdhpeu1ha3rMRLEG
         tDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KtDersxh/nH2j1uixRPqZ04XHGmOZQ9jBWuISXV4vrU=;
        b=b8ohl0e8NebVRHXgCXEdIqnZY2w83vZ1ocfHLZQT0XwxAAznk0Af5w5+4Y/tG97JyC
         GC9OBUbyNPnwVCD+D6/+IiicXUl9pw9Qxjl1Ji1fmIq0wbHbUStCelbWMp0JM9poqVkz
         XxLb8xswSdWpT2z3EkMB0l9aNvciXsQZFiF+Hwi2Ko4FmDtverLmQ/XOiog7EEgAuZnb
         SbpIoMhUy7tqsxwHbwpuWMUuqEtn6HW2pZNjgKkHIWDn+NWrZubCLaqcew8Q2NCCruyJ
         rAiQ/t1/KMdpjOarUsM5kb/nb3U7XLC8TNBaQXbUtVxk0royC26zygSKxi8A7YmzMnc4
         TKGw==
X-Gm-Message-State: AOAM531EhHAziumherFo/T0o3Rl+j7idb7l7j9QvT2/nmuPv/aKKheCN
        6zzzRjPSLIfOoEoBHalBcOKTPbKerlIa1Ugv77EYm0FK07RsybjqfRtVuEdV4XrPbUmvs7gi85p
        v3uOtiKKFRNQaLCGeRZdJB8WH1c4jmRRmuME=
X-Received: by 2002:ae9:e904:: with SMTP id x4mr30244146qkf.398.1591736316562;
        Tue, 09 Jun 2020 13:58:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+zvZqYoSZMtgdJm2CToc9DA2aaE/Zh+oZ+8wimiVzDgP1QfW6N3QtQ4F+HcWfuLWkKmp1Hl9B0zB7irFZ3I8=
X-Received: by 2002:ae9:e904:: with SMTP id x4mr30244107qkf.398.1591736315979;
 Tue, 09 Jun 2020 13:58:35 -0700 (PDT)
MIME-Version: 1.0
From:   Robert Kudyba <rkudyba@fordham.edu>
Date:   Tue, 9 Jun 2020 16:58:23 -0400
Message-ID: <CAFHi+KRt9TZmu6GWer0wEQug-ZJGBm7kGSkCWs2==8V_Ge_31g@mail.gmail.com>
Subject: Re: rsync input/output errors during resyncing of RAID10 e-sata,
 share changed to read-only
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_14:2020-06-09,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 cotscore=-2147483648 impostorscore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=3 mlxlogscore=952 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090159
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> Is this a Barracuda? ummmm :-(

> Are you running that script that fixes timeouts?

I am now:
/dev/sda  is  bad Device Model:     ST2000DM001-1ER164
/dev/sdb  is  bad
/dev/sdc  is good Device Model:     ST31500341AS
/dev/sdd  is  bad
/dev/sde  is  bad
/dev/sdf  is good Device Model:     ST31500341AS

> When you get things sorted, you need to check all the SMARTs.

Now I'm seeing this in the logs:
Jun  9 15:51:31 ourserver kernel: md: recovery of RAID array md0
Jun  9 15:51:31 ourserver kernel: md/raid10:md0: insufficient working
devices for recovery.
Jun  9 15:51:31 ourserver kernel: md: md0: recovery interrupted.
Jun  9 15:51:31 ourserver kernel: md: super_written gets error=10
Jun  9 15:53:23 ourserver kernel: program smartctl is using a
deprecated SCSI ioctl, please convert it to SG_IO

And trying to fail /dev/sdb results in:
mdadm --manage /dev/md0 --fail /dev/sdb1
mdadm: set device faulty failed for /dev/sdb1:  Device or resource busy

Resync is now showing 0%:
mdadm --detail /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Fri Mar 13 16:46:35 2020
        Raid Level : raid10
        Array Size : 2930010928 (2794.28 GiB 3000.33 GB)
     Used Dev Size : 1465005464 (1397.14 GiB 1500.17 GB)
      Raid Devices : 4
     Total Devices : 4
       Persistence : Superblock is persistent

       Update Time : Tue Jun  9 15:49:41 2020
             State : clean, degraded, recovering
    Active Devices : 3
   Working Devices : 4
    Failed Devices : 0
     Spare Devices : 1

            Layout : near=2
        Chunk Size : 8K

Consistency Policy : resync

    Rebuild Status : 0% complete

              Name : ourserver:0  (local to host ourserver)
              UUID : 88b9fcb6:52d0f235:849bd9d6:c079cfc8
            Events : 1081374

    Number   Major   Minor   RaidDevice State
       0       8       81        0      active sync set-A   /dev/sdf1
       4       8       33        1      active sync set-B   /dev/sdc1
       3       8       17        2      active sync set-A   /dev/sdb1
       5       8        1        2      spare rebuilding   /dev/sda1
       -       0        0        3      removed

cat /proc/mdstat
Personalities : [raid10]
md0 : active raid10 sda1[5](S)(R) sdf1[0] sdb1[3] sdc1[4]
      2930010928 blocks super 1.2 8K chunks 2 near-copies [4/3] [UUU_]

How do I promote the spare drive and fail /dev/sdb?
