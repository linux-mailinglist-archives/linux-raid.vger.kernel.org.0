Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764F415753
	for <lists+linux-raid@lfdr.de>; Tue,  7 May 2019 03:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEGBdb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 May 2019 21:33:31 -0400
Received: from zimbra.karlsbakk.net ([193.29.58.196]:57314 "EHLO
        zimbra.karlsbakk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfEGBdb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 May 2019 21:33:31 -0400
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 3C5C93C0220
        for <linux-raid@vger.kernel.org>; Tue,  7 May 2019 03:33:29 +0200 (CEST)
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id KQt_lyjErXLp for <linux-raid@vger.kernel.org>;
        Tue,  7 May 2019 03:33:27 +0200 (CEST)
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id C9F053C02B3
        for <linux-raid@vger.kernel.org>; Tue,  7 May 2019 03:33:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.karlsbakk.net C9F053C02B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlsbakk.net;
        s=1DC131FE-D37A-11E7-BD32-3AD4DFE620DF; t=1557192807;
        bh=psUS1qHjVPZkN1oFFBoq4v91t51rMxMdcQ1s825+nnQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=w2eBfF9DRqWa4O/U/Kx66vzF5qY90nfi2lQuP+uIsZiyuBk5n5HvCJZVvSA2OQt0+
         F9e3xYKvPyQUTyszKlTIY0LUiKF5kCVYzlJlOVBxtanWifXMBm08qj74xwEkxheWJY
         NiP8RzQEGlNfC9wGiDuER03XUrY98Rt8bkT7Q2g3Rh1fTMEfGRmhMWzBgdQfCYI0P/
         YMcnUv0WMWyl92u91ANjVQ7P+mWcncCxbwzIOcM0rpuLiKqep8HQvOn4E7sktJ4L3o
         b9MNPPf5gdUWSBel+rtY7dDP9cArxl+2mxDC6Sm5hHsykUrBDO0T0w0Od767WRoHGK
         8gargtJpGSa5w==
X-Virus-Scanned: amavisd-new at zimbra.karlsbakk.net
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Ku3b-ZEPWEWz for <linux-raid@vger.kernel.org>;
        Tue,  7 May 2019 03:33:27 +0200 (CEST)
Received: from zimbra.karlsbakk.net (localhost.localdomain [127.0.0.1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id A252F3C0220
        for <linux-raid@vger.kernel.org>; Tue,  7 May 2019 03:33:27 +0200 (CEST)
Date:   Tue, 7 May 2019 03:33:27 +0200 (CEST)
From:   Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Message-ID: <892824910.12274529.1557192807487.JavaMail.zimbra@karlsbakk.net>
Subject: Locating slow drives
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [::ffff:91.186.71.4]
X-Mailer: Zimbra 8.8.10_GA_3781 (ZimbraWebClient - FF66 (Mac)/8.8.10_GA_3786)
Thread-Index: 1Y1HCUA3v9PwKT3soZkNsC7GuFjanQ==
Thread-Topic: Locating slow drives
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi all

I have sometimes vitnessed a RAID set slowing down tremendously and after s=
ome research, finding a single drive performing very badly (often down to 1=
-2% of what it should do). In zfs, I found this with zpool iostat (IIRC, th=
at was some time back), but I'm not using zfs at home, just md. A friend ju=
st had a similar issue, so I tried nosing around looking for some counters =
to tell me what was lagging, but found none. Luckily, the raid only had six=
 drives, so we tried hdparm -t on each of them, and one of them stood out w=
ith a speed of well below 1MB/s (the others were around 100MB/s, these bein=
g a diversity of old 1TB drives). Then I checked a drive that was kicked ou=
t of my home raid the other day, apparently for no reason (smart data looki=
ng ok etc, same thing with my friend's disk) and same thing there - perhaps=
 2MB/s on a Western Digital RE4 (6 years spinning time in one hour at this =
moment), which should be something like 150MB/s or thereabout.

So again - anyone that knows any counters to monitor to find these anomalie=
s? I could of course cron up a job running hdparm -t, but I'd hope for some=
thing a bit more sexy=E2=80=A6

Vennlig hilsen

roy
--
Roy Sigurd Karlsbakk
(+47) 98013356
http://blogg.karlsbakk.net/
GPG Public key: http://karlsbakk.net/roysigurdkarlsbakk.pubkey.txt
--
Hi=C3=B0 g=C3=B3=C3=B0a skaltu =C3=AD stein h=C3=B6ggva, hi=C3=B0 illa =C3=
=AD snj=C3=B3 rita.
