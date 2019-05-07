Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B053E1619A
	for <lists+linux-raid@lfdr.de>; Tue,  7 May 2019 11:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfEGJ7Z (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 May 2019 05:59:25 -0400
Received: from zimbra.karlsbakk.net ([193.29.58.196]:39374 "EHLO
        zimbra.karlsbakk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfEGJ7Y (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 7 May 2019 05:59:24 -0400
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 22FBA3C0220;
        Tue,  7 May 2019 11:59:22 +0200 (CEST)
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id aOj_DTcV62OI; Tue,  7 May 2019 11:59:20 +0200 (CEST)
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 95CD33C02B4;
        Tue,  7 May 2019 11:59:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.karlsbakk.net 95CD33C02B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlsbakk.net;
        s=1DC131FE-D37A-11E7-BD32-3AD4DFE620DF; t=1557223160;
        bh=DURiaxhCHenbRv3LbRYpO7epc1PNz0sUQUHTfXzP/Xg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=h47mfQQM7IZ56Qpc9o1+D0atRuo+REVK8VthG7ev3LSWch+QlrLWXeqQwmFgaGM2t
         xwd9yRsmSiuIBaverSeJZAIgGfr63o+xE+fQu/hkMqhKVKX45zGuRJAX+z6z0Y20xl
         KMLERQkr6VIHFMTTRweAPLq0KpxkeonnLrThcOmawobk/Ib+y3EAfwEHOwk+hmqajR
         NiiWgsJzbj8veSBnQLGPjv0iBzEhsDYcwcUBccbQLOwLNFV+nvpeupydE2OawyKaZE
         n6tMjRNEVYHY3d3jHRMri5mAswxxZAzmafg7admKdeBPE2khElLeI0TggTV2Mqy94y
         dHfZkzEXuuRKg==
X-Virus-Scanned: amavisd-new at zimbra.karlsbakk.net
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id byDLoWbK6YCv; Tue,  7 May 2019 11:59:20 +0200 (CEST)
Received: from zimbra.karlsbakk.net (localhost.localdomain [127.0.0.1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 729993C0220;
        Tue,  7 May 2019 11:59:20 +0200 (CEST)
Date:   Tue, 7 May 2019 11:59:19 +0200 (CEST)
From:   Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Message-ID: <1984380790.12464378.1557223159700.JavaMail.zimbra@karlsbakk.net>
In-Reply-To: <20190507095831.30f9cdf6@natsu>
References: <892824910.12274529.1557192807487.JavaMail.zimbra@karlsbakk.net> <20190507095831.30f9cdf6@natsu>
Subject: Re: Locating slow drives
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [::ffff:91.186.71.4]
X-Mailer: Zimbra 8.8.10_GA_3781 (ZimbraWebClient - FF66 (Mac)/8.8.10_GA_3786)
Thread-Topic: Locating slow drives
Thread-Index: uMdVy1j7zZFz9PFDLKV7kgN7bqjALw==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>> I have sometimes vitnessed a RAID set slowing down tremendously and afte=
r some
>> research, finding a single drive performing very badly (often down to 1-=
2% of
>> what it should do). In zfs, I found this with zpool iostat (IIRC, that w=
as some
>> time back), but I'm not using zfs at home, just md. A friend just had a =
similar
>> issue, so I tried nosing around looking for some counters to tell me wha=
t was
>> lagging, but found none. Luckily, the raid only had six drives, so we tr=
ied
>> hdparm -t on each of them, and one of them stood out with a speed of wel=
l below
>> 1MB/s (the others were around 100MB/s, these being a diversity of old 1T=
B
>> drives). Then I checked a drive that was kicked out of my home raid the =
other
>> day, apparently for no reason (smart data looking ok etc, same thing wit=
h my
>> friend's disk) and same thing there - perhaps 2MB/s on a Western Digital=
 RE4 (6
>> years spinning time in one hour at this moment), which should be somethi=
ng like
>> 150MB/s or thereabout.
>=20
> If you catch this slowdown event while it is occuring, you can run
>=20
>  iostat -x /dev/sd? 2
>=20
> to get a summary of disk I/O stats, including "utilization" percentage. T=
he
> slow disks will display 100% in the rightmost column, while others will b=
e
> mostly idle.

Well, the bad drives are replaced on both machines, so I can't do it realti=
me, but sar -d -f /var/log/sysstat/sa06 tells me how things looked during t=
he monthly check

12:00:01 AM       DEV       tps  rd_sec/s  wr_sec/s  avgrq-sz  avgqu-sz    =
 await     svctm     %util
12:05:01 AM    dev7-0      0.00      0.00      0.00      0.00      0.00    =
  0.00      0.00      0.00
12:05:01 AM    dev8-0      9.63     14.92    114.92     13.49      0.09    =
  9.46      8.53      8.21
12:05:01 AM    dev9-0      0.36      0.00     53.35    146.94      0.00    =
  0.00      0.00      0.00
12:05:01 AM    dev9-1      7.89     16.60    108.30     15.83      0.00    =
  0.00      0.00      0.00
12:05:01 AM   dev8-16      4.16   4873.93     21.27   1175.59      0.39    =
 92.81      5.15      2.15
12:05:01 AM   dev8-32      4.17   4877.82     20.84   1175.48      0.36    =
 86.09      4.92      2.05
12:05:01 AM   dev8-48     13.51   4876.09    139.18    371.28      0.49    =
 36.26      5.43      7.33
12:05:01 AM   dev8-64      6.25   4873.02     27.95    784.65      0.73    =
116.28      8.19      5.11
12:05:01 AM   dev8-96      4.00   4813.88     19.48   1207.10     24.77   6=
305.24    249.40     99.86
12:05:01 AM   dev8-80      2.04      0.59     11.88      6.11      0.02    =
  7.46      6.57      1.34
12:05:01 AM  dev8-112      4.15   4876.01     12.37   1176.78      0.38    =
 92.59      5.13      2.13
12:05:01 AM    dev9-2      1.45      1.31      9.99      7.78      0.00    =
  0.00      0.00      0.00
12:05:01 AM  dev252-0      1.30      1.31      9.99      8.70      0.02    =
 16.26      9.76      1.27
12:05:01 AM  dev252-1      0.00      0.00      0.00      0.00      0.00    =
  0.00      0.00      0.00
12:05:01 AM  dev252-2      0.29      0.00     53.35    182.00      0.95   3=
246.68    698.91     20.49
12:05:01 AM  dev252-3      7.76     16.60    108.30     16.09      0.12    =
 15.02      9.21      7.15

and dev8-96 matches sdg, which was the troublesome drive. I guess I'll have=
 to write a zabbix plugin for this (after having checked that noone else ha=
s done so already)

thanks

roy
--
Roy Sigurd Karlsbakk
(+47) 98013356
http://blogg.karlsbakk.net/
GPG Public key: http://karlsbakk.net/roysigurdkarlsbakk.pubkey.txt
--
Hi=C3=B0 g=C3=B3=C3=B0a skaltu =C3=AD stein h=C3=B6ggva, hi=C3=B0 illa =C3=
=AD snj=C3=B3 rita.
