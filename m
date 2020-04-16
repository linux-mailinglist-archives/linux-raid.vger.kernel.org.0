Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870DE1AB5AD
	for <lists+linux-raid@lfdr.de>; Thu, 16 Apr 2020 03:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388951AbgDPB4f (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Apr 2020 21:56:35 -0400
Received: from omta03.suddenlink.net ([208.180.40.73]:42878 "EHLO
        omta03.suddenlink.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388434AbgDPB4a (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 15 Apr 2020 21:56:30 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2020 21:56:29 EDT
Received: from [192.168.6.104] (really [66.76.46.195])
          by dalofep01.suddenlink.net
          (InterMail vM.8.04.03.22.02 201-2389-100-169-20190213) with ESMTP
          id <20200416015035.CVXI27429.dalofep01.suddenlink.net@[192.168.6.104]>
          for <linux-raid@vger.kernel.org>; Wed, 15 Apr 2020 20:50:35 -0500
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
To:     mdraid <linux-raid@vger.kernel.org>
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
 <5E95C698.1030307@youngman.org.uk>
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
Message-ID: <461be4bb-a86b-dca0-605f-cda13bc1602d@suddenlinkmail.com>
Date:   Wed, 15 Apr 2020 20:50:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5E95C698.1030307@youngman.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at dalofep01.suddenlink.net from [66.76.46.195] using ID drankinatty@suddenlinkmail.com at Wed, 15 Apr 2020 20:50:35 -0500
X-CM-Analysis: v=2.3 cv=L91jvNb8 c=1 sm=1 tr=0 cx=a_idp_d a=/cos1G3ae6AqFCvJLv+j9g==:117 a=/cos1G3ae6AqFCvJLv+j9g==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=cl8xLZFz6L8A:10 a=A1jyNYAxBm8A:10 a=85ssfZEmyD7xuK1np94A:9 a=QEXdDO2ut3YA:10
X-CM-Envelope: MS4wfO7uRWY7YcUqJDCa2prqY6nXiRqUjyeJoXbq5VP7GmY3VTV4KNGGsMNeK/7p9+JrfXUxteprdMuS22dd1uxGxIeTXcsPN01HRqAoy/qznpwVO5pgL32i pSSvN/NN/8V0u3Sdc2oT64PGZJQzjgYER7D5JloSJ0EV15XM+0twVLd2W8/rh+ytEqsYpD0ingTrGw==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 04/14/2020 09:20 AM, Wols Lists wrote:
> That's true, but is it worth it? RAM is cheap, max out your motherboard,
> and try and avoid falling into swap at all. I have one swap partition
> per disk, but simply set them up as equal priority so the kernel does
> its own raid-0 stripe across them. Yes a disk failure would kill any
> apps swapped on to that disk, but my system rarely swaps...

That's a neat approach, I do it just the opposite and care RAID1 partitions
for swap (though I rarely swap as well). I've never had an issue restarting
after a failure (or me doing something dumb like hitting the wrong button on
the UPS)

So that I'm understanding, you simply create a swap partition on each disk not
part of an array, swapon both and let the kernel decide?


-- 
David C. Rankin, J.D.,P.E.
