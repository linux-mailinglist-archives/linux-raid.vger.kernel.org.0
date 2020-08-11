Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBF1241CFF
	for <lists+linux-raid@lfdr.de>; Tue, 11 Aug 2020 17:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgHKPOT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Aug 2020 11:14:19 -0400
Received: from zimbra.karlsbakk.net ([193.29.58.196]:52522 "EHLO
        zimbra.karlsbakk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgHKPOP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Aug 2020 11:14:15 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Aug 2020 11:14:15 EDT
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 958B63C26B1;
        Tue, 11 Aug 2020 17:06:31 +0200 (CEST)
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id MhTGkSYSuCBx; Tue, 11 Aug 2020 17:06:30 +0200 (CEST)
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 1E0823C278E;
        Tue, 11 Aug 2020 17:06:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.karlsbakk.net 1E0823C278E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlsbakk.net;
        s=1DC131FE-D37A-11E7-BD32-3AD4DFE620DF; t=1597158390;
        bh=8KnhfaCn1wC/SkH4IWCvr8yw6aVCxFk40N18CrBrkjs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=tnqagBNFEezWX7+13yMhZ2ez2ABltyULz/XgYPSvKPPAnv+KedfsCpbEx3ciKmRat
         i/XaIwb5iPhx7UcY+rSmM27k4xe/j+T2j+0gflGcykYnuYEG5huE3Wvzz9PLOd7uTl
         a6fGphmdfYR8h43t+OaiHle3s4+TZ5VPJns17Yk5NTbRL7aBOdX2f3yWvneVOcr3px
         I786SM316eEeWOUV3SAau5/r9iZjB1nA22kUV1BtFAcnTe9jn68lW8ucoXTmqi9d5T
         A5MXcWOMNUZUtrVsPt1+IkW4A3TYz4mJnoJotWOSuGaHwwTnQxLp+4fG0QphuHk6W0
         /W2BbwID6Dxcw==
X-Virus-Scanned: amavisd-new at zimbra.karlsbakk.net
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id PIqjfKoEHl6K; Tue, 11 Aug 2020 17:06:30 +0200 (CEST)
Received: from zimbra.karlsbakk.net (localhost.localdomain [127.0.0.1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id F156B3C26B1;
        Tue, 11 Aug 2020 17:06:29 +0200 (CEST)
Date:   Tue, 11 Aug 2020 17:06:29 +0200 (CEST)
From:   Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To:     George Rapp <george.rapp@gmail.com>
Cc:     Linux Raid <linux-raid@vger.kernel.org>
Message-ID: <1381759926.21710099.1597158389614.JavaMail.zimbra@karlsbakk.net>
In-Reply-To: <CAF-KpgYcEF5juR9nFPifZunPPGW73kWVG9fjR3=WpufxXJcewg@mail.gmail.com>
References: <CAF-KpgYcEF5juR9nFPifZunPPGW73kWVG9fjR3=WpufxXJcewg@mail.gmail.com>
Subject: Re: Recommended filesystem for RAID 6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [::ffff:51.175.216.121]
X-Mailer: Zimbra 8.8.10_GA_3801 (ZimbraWebClient - FF79 (Mac)/8.8.10_GA_3786)
Thread-Topic: Recommended filesystem for RAID 6
Thread-Index: afwYIUSxjLthqxrQhCRsG0ez/RoCCg==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> Hello Linux RAID community -

Hi

> I've been running an assortment of software RAID arrays for a while
> now (my oldest Creation Time according to 'mdadm --detail' is April
> 2011) but have been meaning to consolidate my five active arrays into
> something easier to manage. This weekend, I finally found enough cheap
> 2TB disks to get started. I'm planning on creating a RAID 6 array due
> to the age and consumer-grade quality of my 16 2TB disks.

I'd recommend first checking each drive's SMART data if they're old and rus=
ty. You can start off with smartctl -H /dev/sdX and if that's ok, check 'sm=
artctl -a' and look for errors, and in particular current pending sectors. =
A smartct -t short or even -t long won't hurt either. If you find peending =
sectors or other bad stuff, either choose not to include the drive or at le=
ast make sure you have sufficient redundancy. 16 drives in a single RAID-6 =
may be a bit high, but it should work. Any more than that (or even less), m=
ake more RAIDs and use lvm or md to stripe the data across them.

> Use case is long-term storage of many small files and a few large ones
> (family photos and videos, backups of other systems, working copies of
> photo, audio, and video edits, etc.)? Current usable space is about
> 10TB but my end state vision is probably upwards of 20TB. I'll
> probably consign the slowest working disks in the server to an archive
> filesystem, either RAID 1 or RAID 5, for stuff I care less about and
> backups; the archive part can be ignored for the purposes of this
> exercise.

RAID-6 is nice for achival stuff. RAID-1 (or RAID-10) gives you better IOPS=
 and so on, but for mass storage, RAID-10 isn't really much safer than RAID=
-6. RAID-5 also works, but suddenly, one day, a disk dies and you swap it w=
ith a new one and another shows bad sectors. Then you have data corruption.=
 I rarely use RAID-5 anymore, since RAID-6 isn't much heavier on the CPU an=
d the cost of another drive is low compared to the time I'll use to rebuild=
 a broken array in case of the above or even a double disk failure (yes, th=
at happens too).

> My question is: what filesystem type would be best practice for my use
> case and size requirements on the big array? (I have reviewed
> https://raid.wiki.kernel.org/index.php/RAID_and_filesystems, but am
> looking for practitioners' recommendations.)  I've run ext4
> exclusively on my arrays to date, but have been reading up on xfs; is
> there another filesystem type I should consider? Finally, are there
> any pitfalls I should know about in my high-level design?

I've mostly ditched ext4 on large filesystems, since AFAIK it still makes a=
 32bit fs if created on something <16TiB and then you're unable to grow it =
past 16TiB without recreating it (backup/create/restore). Also, when someth=
ing goes bad (it might be a power spike, a sudden power failure, a bug, som=
ething) you'll need to run a check the filesystem. With fsck.ext4, this may=
 take hours, many hours, with such a large filesystem. With xfs_check/xfs_r=
epair, it doesn't take so long. This is the main reason that RHEL/CentOS sw=
itched to XFS from RHEL/CentOS v7 and forward. The only thing that comes to=
 mind as a good excuse for using ext4, is that it can be shrunk, something =
xfs doesn't support (yet).

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
