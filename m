Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4071765D8
	for <lists+linux-raid@lfdr.de>; Mon,  2 Mar 2020 22:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCBVVW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Mar 2020 16:21:22 -0500
Received: from omta02.suddenlink.net ([208.180.40.72]:41011 "EHLO
        omta02.suddenlink.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgCBVVW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 Mar 2020 16:21:22 -0500
Received: from [192.168.6.104] (really [66.76.46.195])
          by dalofep02.suddenlink.net
          (InterMail vM.8.04.03.22.02 201-2389-100-169-20190213) with ESMTP
          id <20200302212120.PQRE6906.dalofep02.suddenlink.net@[192.168.6.104]>
          for <linux-raid@vger.kernel.org>; Mon, 2 Mar 2020 15:21:20 -0600
Subject: Re: Linux 5.5 Breaks Raid1 on Device instead of Partition, Unusable
 I/O
To:     mdraid <linux-raid@vger.kernel.org>
References: <e46b2ae7-3b88-05f2-58d7-94ee3df449e4@suddenlinkmail.com>
 <20200302102542.309e2d19@natsu>
 <920df583-1d9e-6037-1d61-cbd5e1133d4d@suddenlinkmail.com>
 <20200302115141.1e796b7c@natsu>
 <c5d8e6d2-a572-5602-6562-795ea52168ac@suddenlinkmail.com>
 <CAJCQCtTOJrvm7BnyqSSuCUa82ehZbtHgSGaQo1bzcepgdtazSw@mail.gmail.com>
 <9e31d56a-a35d-2413-b6c7-4a97445d487d@suddenlinkmail.com>
 <9b1ceff4-1299-8e8a-cbc9-da717c72bba3@turmel.org>
 <5E5D0AFA.1030701@youngman.org.uk>
From:   "David C. Rankin" <drankinatty@suddenlinkmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=drankinatty@suddenlinkmail.com; prefer-encrypt=mutual;
 keydata=
 xsBNBFkinL8BCADU5H9ZxEu+IIMb75pSmVXhW7ujTM7p2TzjZiyTT3Lfbxuoso1rWyAaAti6
 Jyfw2pk0SJYw+8afn1+Ag/BtmSGm7wiuGdpHlDL0e/2sbyCYoFExpFLecgd5+mU+M6GCNUaM
 vZ79BaM2wn+c4r1r0LcPmy7uweHhaVXGlocfMChd2fBweonL2jd4bX64XZbB5YErpkzxFN69
 kM+I4CmkzOaSSLfN6//EUgc2zBKGVJhM6fpZjVE4Wm8S+khvrJwFG0ZoaPC1Ol/b47iyqZcf
 jFZs75i2Tjd3AYyQ6Ai3ZNGrwv2PJSAawR+hfZLeNf5aMaIqoG099SsAN3j8wW97DDjbABEB
 AAHNRERhdmlkIEMuIFJhbmtpbiwgSi5ELixQLkUuICh3aXphcmQpIDxkcmFua2luYXR0eUBz
 dWRkZW5saW5rbWFpbC5jb20+wsCOBBMBCAA4FiEEUoo6wDEaJyRJMG0RyQVv1wIPCIcFAlki
 nL8CGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQyQVv1wIPCId/wgf/b+9BBzhRr2i+
 LDa5qHwlxmRbvQZp9yYzFbJV6s4Djyukir7CGYrzAvuFUWBIFiExBspGdHuQ3b/UA66/uupf
 6DlzRRTs62WMjK9DTZbQfFxqnx+EWCDKbBlXMsaIu/FjtBtc13uOzza967OdE8l2uxUH7+B4
 /S8ReppJ+FXm2pzo4qlq1YYNtX0cd7BymZdn0G2ogeHos2Ay5bYOfiYWFVwb7fnZ54DCsOfb
 H0M9RUIhA5ZKeChsCOAZvtiMMemIr/xihE8Ds7INbtEXxm00o4xgRiWSSJeuoOfeSilHbVjJ
 Ry26E/KhKvkZbcnGCJsQRo8DPq5P/O5UQn0HVvGyTs7ATQRZIpy/AQgAwX/4Z6vfnfWsr8WA
 qV6WYKK8FtIrWXBjEeztxiCAJydMwZkPQRbOJlZElLpZvWLHFp68mbMfrcv23dMJCH+jE5XB
 La/p7XZp10IHzBhedZbI2MBBsnfrqqCdrf0KNPfS9bD6+37ued+O8ONm4ELhzHfjlGojNddB
 vMEu7EQKY19u/X2sINiYvrAOX6ss21E4r4AoVojQqaL7fmrRCD2uI76z7O9zC3mQ0/JpkuEo
 0Yi97H+P3d3qSDb0IovPPyfioMAy7KIGSAYCHzxd47zvkYWlfSEWQ1aenAAvGgqKrZ3/KP9a
 V1ekGimYYIpnT/JJ67DPDx9gKlQD9f1YZVcQvwARAQABwsB2BBgBCAAgFiEEUoo6wDEaJyRJ
 MG0RyQVv1wIPCIcFAlkinL8CGwwACgkQyQVv1wIPCIffjwf/YXoinAWabuqugYxSNafvBcXA
 GEE5arTYSGSXhUWBER1Oz0U5BjeWAKKtan88pHkFrdHYW8su5A6Dn7jDxUWAVjXzRvA0LNbJ
 fKOrBw7knGJSqYQD7gdeBJZOSLf0Mt9g9evkxhR4cLFHG0mWH07H1yIreLNFTs+i0B3tKY44
 P5bsNcAzMwD2G1rJehiFTbxRlAiCc6v61rzu80XaDKLEJFHVYhCJRXrla04DoGZdZKfc6urF
 g/aUn+7z1pO70uumOnKvLViitsJ6IsxAsfhZp4KPBbbkTjixcTPfJAQGzQhcoZS22jGTPg1N
 7G4xtqMT/M34TbodTbaIO0HkA4n1Hw==
Organization: Rankin Law Firm, PLLC
Message-ID: <eb7083d2-4bd6-975c-07ea-d5a432606d32@suddenlinkmail.com>
Date:   Mon, 2 Mar 2020 15:21:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5E5D0AFA.1030701@youngman.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at dalofep02.suddenlink.net from [66.76.46.195] using ID drankinatty@suddenlinkmail.com at Mon, 2 Mar 2020 15:21:19 -0600
X-CM-Analysis: v=2.3 cv=L91jvNb8 c=1 sm=1 tr=0 cx=a_idp_d a=/cos1G3ae6AqFCvJLv+j9g==:117 a=/cos1G3ae6AqFCvJLv+j9g==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=SS2py6AdgQ4A:10 a=A1jyNYAxBm8A:10 a=4VFAfOaB5yQktmWFeVsA:9 a=QEXdDO2ut3YA:10
X-CM-Envelope: MS4wfBRsLz1r92DF0JvdZj0qBkoikrYihNf7++Lw39hTDt2sB9HK+p6WODOuxE2O2lZOlDqaQ2Qgp2DSWSZltgeaJNBMax0IDTgJh/JcuzkCtl2k4XTW8tBi UszJdJqRUxZVC3LOrGB/lj2luwpglFcopvDSILwKeW5vTzZDcIkydfWQvvsuNrYYH3uXxarkdQtNkA==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 03/02/2020 07:32 AM, Wols Lists wrote:
> It's a Seagate Barracuda ... nuff said
> 
> (For David, Barracudas don't support SCT/ERC - they are not recommended
> for raid. Okay for 1 but definitely not anything else. Get an Ironwolf
> to replace it.)

That's a good model!

  It's a shame that drive manufacturers have stripped functionality from most
of the drives over the past 20 years. 20+ years ago when you when you bought a
drive, it had all the drive features standard. Even back to the RLL/MFM days,
all features were supported. Now with the 4 flavors of drives from every
manufacturer it seems to be a race to put out the cheapest stripped down
drives they can make.

  Then don't make 'em like they used to. Just checking the collection of old
boxes still spinning, there is an ancient data drive hanging off one probably
from the mid 2005 timeframe:

 === START OF INFORMATION SECTION ===
Model Family:     Maxtor DiamondMax 10 (ATA/133 and SATA/150)
Device Model:     Maxtor 6L300R0
Serial Number:    L604P3MH
Firmware Version: BAH41E00
User Capacity:    300,090,728,448 bytes [300 GB]
Sector Size:      512 bytes logical/physical
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 0
Local Time is:    Mon Mar  2 15:14:20 2020 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

  It has probably been spinning continually for 12-15 years. So long the
power-on hours are reported only as "17h+26m",

  I'll update the thread when the new drives come in and the raid is rebuilt
and let you know how it goes.


-- 
David C. Rankin, J.D.,P.E.
