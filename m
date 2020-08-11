Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF7E24225F
	for <lists+linux-raid@lfdr.de>; Wed, 12 Aug 2020 00:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgHKWOV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Aug 2020 18:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgHKWOU (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Aug 2020 18:14:20 -0400
X-Greylist: delayed 25665 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Aug 2020 15:14:20 PDT
Received: from zimbra.karlsbakk.net (zimbra.karlsbakk.net [IPv6:2a0a:51c0:0:1f:4ca5::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FE4C06174A
        for <linux-raid@vger.kernel.org>; Tue, 11 Aug 2020 15:14:19 -0700 (PDT)
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id D05243C278C;
        Wed, 12 Aug 2020 00:14:17 +0200 (CEST)
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id bcP-EzABtVOy; Wed, 12 Aug 2020 00:14:15 +0200 (CEST)
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id ACF8E3C278E;
        Wed, 12 Aug 2020 00:14:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.karlsbakk.net ACF8E3C278E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlsbakk.net;
        s=1DC131FE-D37A-11E7-BD32-3AD4DFE620DF; t=1597184055;
        bh=gwCFIybXHyoz9Ep7UPaU81ZheY/ijWFTLqU6ovn2sz4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=kH+GpQuRcF9k4ab83v2UV72s62zWbn51omRI0uOxm//r3KHCRz7hkQa1cGvS2sWVy
         qQE6WVpUTpdthl9baeea1517NpUJAoYsKqOv0LD6Y6+EhFCoieJQXY9EjHFSosqqUl
         uG1Al5TuDKNk456FAoCbNkpyFHIQrWtDDsIrIXpBrY9DssbV0lHt9rH/lRuL5vMQIu
         M3PT7/udHf09e0LLoTDEvYjoqpYuVgggQpACO4mDgVyAVWJcEVpgv3zYgTWS4IYI1X
         EelsOwyh+SMrqqAHbrb94PiOi0CBrjXd2LA+ARxyY9mDGio35UnVIKZTYVsidiB7Rb
         fH351afTkUtIg==
X-Virus-Scanned: amavisd-new at zimbra.karlsbakk.net
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 8AwvXp9Eyd2Q; Wed, 12 Aug 2020 00:14:15 +0200 (CEST)
Received: from zimbra.karlsbakk.net (localhost.localdomain [127.0.0.1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 8BE843C278C;
        Wed, 12 Aug 2020 00:14:15 +0200 (CEST)
Date:   Wed, 12 Aug 2020 00:14:14 +0200 (CEST)
From:   Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     George Rapp <george.rapp@gmail.com>,
        Linux Raid <linux-raid@vger.kernel.org>
Message-ID: <619625137.21825049.1597184054230.JavaMail.zimbra@karlsbakk.net>
In-Reply-To: <20200811212305.02fec65a@natsu>
References: <CAF-KpgYcEF5juR9nFPifZunPPGW73kWVG9fjR3=WpufxXJcewg@mail.gmail.com> <20200811212305.02fec65a@natsu>
Subject: Re: Recommended filesystem for RAID 6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [::ffff:51.175.216.121]
X-Mailer: Zimbra 8.8.10_GA_3801 (ZimbraWebClient - FF79 (Mac)/8.8.10_GA_3786)
Thread-Topic: Recommended filesystem for RAID 6
Thread-Index: B0zrpe1s12rGMpfJMlrFQIL9kYnuIQ==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>> Use case is long-term storage of many small files and a few large ones
>> (family photos and videos, backups of other systems, working copies of
>> photo, audio, and video edits, etc.)? Current usable space is about
>> 10TB but my end state vision is probably upwards of 20TB. I'll
>> probably consign the slowest working disks in the server to an archive
>> filesystem, either RAID 1 or RAID 5, for stuff I care less about and
>> backups; the archive part can be ignored for the purposes of this
>> exercise.
>>=20
>> My question is: what filesystem type would be best practice for my use
>> case and size requirements on the big array? (I have reviewed
>> https://raid.wiki.kernel.org/index.php/RAID_and_filesystems, but am
>> looking for practitioners' recommendations.)  I've run ext4
>> exclusively on my arrays to date, but have been reading up on xfs; is
>> there another filesystem type I should consider? Finally, are there
>> any pitfalls I should know about in my high-level design?
>=20
> Whichever filesystem you choose, you will end up with a huge single point=
 of
> failure, and any trouble with that FS or the underlying array put all you=
r
> data instantly at risk. "But RAID6" -- what about a SATA controller failu=
re,
> or a flaky cabling/PSU/backplane, which disconnects, say, 4 disks at once=
 "on
> the fly". What about a sudden power loss amidst heavy write load. And so =
on.

If that happens, you just connect the drives to another controller and reas=
semble. If you are really, really unlucky and lose more than two of the dri=
ves in a RAID-6, you restore from backup.

> First of all, ask yourself -- is all of this backed up? If no, then go an=
d buy
> more drives until the answer is yes. With current drive prices, or as you=
 say,
> with having lots of spare old drives lying around, there's no excuse to l=
eave
> anything non-trivial not backed up.
>=20
> Secondly -- if all of this... is BACKED UP ANYWAY, why even run RAID? And=
 with
> RAID6, even waste 2 more drives for redundancy. Do you need 24x7 uptime o=
f your
> home NAS, do you have hotswap cages, do you require that the server absol=
utely
> stays online while a disk is being replaced.

Simply because if you lose 10-20TiB of data on a disk failure, you also los=
e a week or two with troubleshooting instead of just replacing that disk.


> (blablbla)
>
> For the FS considerations, the dealbreaker of XFS for me is its inability=
 to
> be shrunk.=20

And how many times have you had the need to shrink a large filesystem used =
for the mentioned purposes? To me that's zero. It's practical, yes, but the=
 adverse effect of ext4 and large filesystems are worse.

But hey - go on with your "good" advice. I just stick to my own so far.

- Remember that RAID is not backup, it's redundancy. It may fail any day at=
 any time, but normally just one drive fails, sometimes two. With sufficien=
t redundancy, you just swap those drives out.
- Redundancy has a cost, but time also has a cost, even at home. If you nee=
d to spend hours or days to restore a system, the time you spent could be u=
sed for family or friends.

And so on=E2=80=A6

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

