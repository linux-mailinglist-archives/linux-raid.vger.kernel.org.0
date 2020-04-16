Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71E01AB5AF
	for <lists+linux-raid@lfdr.de>; Thu, 16 Apr 2020 03:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgDPB6O (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Apr 2020 21:58:14 -0400
Received: from omta02.suddenlink.net ([208.180.40.72]:47830 "EHLO
        omta02.suddenlink.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgDPB6M (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 15 Apr 2020 21:58:12 -0400
Received: from [192.168.6.104] (really [66.76.46.195])
          by dalofep02.suddenlink.net
          (InterMail vM.8.04.03.22.02 201-2389-100-169-20190213) with ESMTP
          id <20200416015808.XHLX11819.dalofep02.suddenlink.net@[192.168.6.104]>
          for <linux-raid@vger.kernel.org>; Wed, 15 Apr 2020 20:58:08 -0500
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
Message-ID: <c457c321-b250-c145-b72c-7e599562ac66@suddenlinkmail.com>
Date:   Wed, 15 Apr 2020 20:58:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5E95C698.1030307@youngman.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at dalofep02.suddenlink.net from [66.76.46.195] using ID drankinatty@suddenlinkmail.com at Wed, 15 Apr 2020 20:58:04 -0500
X-CM-Analysis: v=2.3 cv=L91jvNb8 c=1 sm=1 tr=0 cx=a_idp_d a=/cos1G3ae6AqFCvJLv+j9g==:117 a=/cos1G3ae6AqFCvJLv+j9g==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=cl8xLZFz6L8A:10 a=A1jyNYAxBm8A:10 a=ioB_H9AeCsTv1GCEJtIA:9 a=QEXdDO2ut3YA:10
X-CM-Envelope: MS4wfCYmtaozElw7NkRzfj+zEx2HAJz2xVoXk4UegjUhMbxRRiVkq5RPtqdNXU4nwXp1BoIFUS5GILrWHOa9wCNmN1uJz4lAczSoSGg951x9pafwPk7Xntxs C/2shQ9dWSLBugxwzDrWaIOvC9XGR3tj1k6bja39NSpMV6nLZwCHUMULbGW0u0pRrRUa16irKO2PbA==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 04/14/2020 09:20 AM, Wols Lists wrote:
> Again, personally, I'd make /tmp a tmpfs rather than a partition of its
> own, the spec says that the system should *expect* /tmp to disappear at
> any time and especially on reboot... while tmpfs defaults to half ram,
> you can specify what size you want, and it'll make use of your swap space.

Agreed, but keep in mind that what is written to /tmp on tmpfs will be stored
in RAM (reducing your available RAM by that amount).

This only becomes an issue if you are running something that makes heavy use
of /tmp (some databases can use huge amounts of temporary storage for queries,
joins, etc...) Or if you are a budding programmer that routinely (or may
accidentally) write very large files to /tmp. If you fall into this category,
you may want to specify that large temporary files are created elsewhere.

I put /tmp on tmpfs for all normal installations and haven't had an issue.

-- 
David C. Rankin, J.D.,P.E.
