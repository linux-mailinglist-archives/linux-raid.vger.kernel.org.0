Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D94017C894
	for <lists+linux-raid@lfdr.de>; Fri,  6 Mar 2020 23:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCFWzL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 6 Mar 2020 17:55:11 -0500
Received: from omta02.suddenlink.net ([208.180.40.72]:63162 "EHLO
        omta02.suddenlink.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCFWzL (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 6 Mar 2020 17:55:11 -0500
Received: from [192.168.6.104] (really [66.76.46.195])
          by dalofep02.suddenlink.net
          (InterMail vM.8.04.03.22.02 201-2389-100-169-20190213) with ESMTP
          id <20200306225511.SOQD6906.dalofep02.suddenlink.net@[192.168.6.104]>
          for <linux-raid@vger.kernel.org>; Fri, 6 Mar 2020 16:55:11 -0600
Subject: Re: Need help with degraded raid 5
To:     mdraid <linux-raid@vger.kernel.org>
References: <CALc6PW74+m1tk4BGgyQRCcx1cU5W=DKWL1mq7EpriW6s=JajVg@mail.gmail.com>
 <CAD9gYJ+3gP+6aannsjzq=L0DsQ-dC2wj4SJfU3+n-t3pG0q3pg@mail.gmail.com>
 <5E61354C.2090901@youngman.org.uk>
 <CALc6PW6HYK_6UAtUVz4nmXF=BOwRrkt9HQFb0wpL5BM8tU9N4w@mail.gmail.com>
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
Message-ID: <1d46e4cd-ea71-37b4-9850-b4b9b5937891@suddenlinkmail.com>
Date:   Fri, 6 Mar 2020 16:55:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALc6PW6HYK_6UAtUVz4nmXF=BOwRrkt9HQFb0wpL5BM8tU9N4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at dalofep02.suddenlink.net from [66.76.46.195] using ID drankinatty@suddenlinkmail.com at Fri, 6 Mar 2020 16:55:10 -0600
X-CM-Analysis: v=2.3 cv=XMBOtjpE c=1 sm=1 tr=0 cx=a_idp_d a=/cos1G3ae6AqFCvJLv+j9g==:117 a=/cos1G3ae6AqFCvJLv+j9g==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=SS2py6AdgQ4A:10 a=A1jyNYAxBm8A:10 a=PXcLD-UJaTr8S1IEYkwA:9 a=QEXdDO2ut3YA:10
X-CM-Envelope: MS4wfB6Rh0G89+iYiMiFZKRcAhtJU43QvP5Nu7WPbU/jXdVQG+n4X1wi/HLQnTtwQw00Pjd3hhgSNRnaHmEiaGoHVsTCLpHPFAhvdMlfrKgbfKKjwtuJAoq1 K+EuDn1zwFDVDz0+utDK/Pd5/WhOWVQ8DwLoBgIFLF5eiAzziuTHZHF14r39o7zkL0kYfxeW6zQSBg==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 03/06/2020 03:33 PM, William Morgan wrote:
> I tried re-add and I get the following error:
> 
> bill@bill-desk:~$ sudo mdadm /dev/md0 --re-add /dev/sdl1
> mdadm: Cannot open /dev/sdl1: Device or resource busy
> 
> sdl is not mounted, and it doesn't seem to be a device mapper issue:

  cat /proc/mdstat  and/or cat /proc/partitions

  and see if the disk was brought up as an array of its own (something like
/dev/md127, etc..), If so, simply

  sudo mdadm --stop /dev/md127

  The try you re-add again. I recently had that occur when I put in a
replacement disk for a raid1 array. Even though I just cut the plastic
anti-static bag off the brand-new drive, when I booted the system, it came up
as an array (of what I don't know). I got the same device busy and simply used
--stop on the obviously not-an-array array, The --re-add worked just fine
afterwards.

-- 
David C. Rankin, J.D.,P.E.
