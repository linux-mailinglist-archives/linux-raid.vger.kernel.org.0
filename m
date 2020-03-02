Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7D51753F8
	for <lists+linux-raid@lfdr.de>; Mon,  2 Mar 2020 07:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCBGqk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Mar 2020 01:46:40 -0500
Received: from omta03.suddenlink.net ([208.180.40.73]:63358 "EHLO
        omta03.suddenlink.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgCBGqj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 Mar 2020 01:46:39 -0500
Received: from [192.168.6.104] (really [66.76.46.195])
          by dalofep03.suddenlink.net
          (InterMail vM.8.04.03.22.02 201-2389-100-169-20190213) with ESMTP
          id <20200302064638.VACQ12989.dalofep03.suddenlink.net@[192.168.6.104]>
          for <linux-raid@vger.kernel.org>; Mon, 2 Mar 2020 00:46:38 -0600
Subject: Re: Linux 5.5 Breaks Raid1 on Device instead of Partition, Unusable
 I/O
From:   "David C. Rankin" <drankinatty@suddenlinkmail.com>
To:     mdraid <linux-raid@vger.kernel.org>
References: <e46b2ae7-3b88-05f2-58d7-94ee3df449e4@suddenlinkmail.com>
 <20200302102542.309e2d19@natsu>
 <920df583-1d9e-6037-1d61-cbd5e1133d4d@suddenlinkmail.com>
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
Message-ID: <1691270c-0ead-08ba-27b0-3e672f584030@suddenlinkmail.com>
Date:   Mon, 2 Mar 2020 00:46:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <920df583-1d9e-6037-1d61-cbd5e1133d4d@suddenlinkmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at dalofep03.suddenlink.net from [66.76.46.195] using ID drankinatty@suddenlinkmail.com at Mon, 2 Mar 2020 00:46:38 -0600
X-CM-Analysis: v=2.3 cv=JvWPU/wC c=1 sm=1 tr=0 cx=a_idp_d a=/cos1G3ae6AqFCvJLv+j9g==:117 a=/cos1G3ae6AqFCvJLv+j9g==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=SS2py6AdgQ4A:10 a=A1jyNYAxBm8A:10 a=MS0co3RMW5KEwcELbhEA:9 a=QEXdDO2ut3YA:10
X-CM-Envelope: MS4wfGoNW21nnWoA7q2QC8tB/2IIvtO1yXGDn9YDjT9V6Tjk45c7UUs8/BB2OVs+0e18K1ieJxGuv+ddIk3AJKgB4puPx7rkIoY22HR4wY6pyDOw+tqQPH5m mGH/CML3Fa2CufQN43p7m8lDIqaC6ObSlwFkx3Gcl5yRCu1bhT7qjjt0ej5hcaoxfIHP1196BkxLlQ==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 03/02/2020 12:38 AM, David C. Rankin wrote:
> Thank you Roman, iostat and smartctl -a for sdc/sdd attached,
> 
>   sdc has a few errors from a power hit taken 3000 hours ago or so, but since
> that time it has been fine. I had rolled back to several earlier kernels from
> Jan 14, Jan 21, and Jan 27 with no change, I then updated to current which is
> Archlinux 5.5.6-arch1-1.
> 
>   I'm not sure what to make of the iostat output, but the r_await looks
> suspicious. Could this all be due to one flaky disk without it throwing any
> errors?

Actually,

  I think sdc looks like the flaky culprit... So what is recommended in the
interim, fail sdc and remove from array and run on sdd until the replacement
arrives to rebuild? (seems better than limping along with sdc if that is the
one causing all the slowdown)

-- 
David C. Rankin, J.D.,P.E.
