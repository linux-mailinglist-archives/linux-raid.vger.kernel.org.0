Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60FEC16A257
	for <lists+linux-raid@lfdr.de>; Mon, 24 Feb 2020 10:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgBXJcB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 24 Feb 2020 04:32:01 -0500
Received: from eva.aplu.fr ([91.224.149.41]:34676 "EHLO eva.aplu.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgBXJcB (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 24 Feb 2020 04:32:01 -0500
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 04:32:00 EST
Received: from eva.aplu.fr (eva.aplu.fr [127.0.0.1])
        by eva.aplu.fr (Postfix) with ESMTP id 6ECCF1479;
        Mon, 24 Feb 2020 10:23:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aplu.fr; s=s4096;
        t=1582536200; bh=quBzZ2v2ctF52ufgp/iLt5HkW7+LSaNHNV03EFB/I9Q=;
        h=Date:In-Reply-To:References:Subject:To:From:From;
        b=dBiRZwcERBlra2U3p6svWC2a8U4vDxyyz5pOkBjdl3zFQ2Hrn0eCI4dwFFtY+Ub0B
         d7I2jrKGiEvtZ8pvCk+8LNVsG6/ArlFhAb/x8/LyNiwYt+V8D7lffjmfTAAQ7pZ5n/
         IiF3p/NTVMLE++m92+ZJRN+5ujPrUW3Z072LaMuX9IOCWdpEClg3Q0XpwVT4C8StmF
         TsiRWwtTxTsCB4UjIww5ePzeV5CGulnlPqoUYE+x1fVdmwIu/nAJ3ggFGYKGbgKz66
         oS0U4rzinWTSpkFKuLr3dy9/OLD1hIdEZjYIDVaZQPSAjeldrjA/apVASSJZYrcLwq
         841lERFRJGVw97nA9H1B6BLOX8UXsA9I69tkabGHEq8agmaG2ivhetRQPd9jdw7LFk
         l0MNxbGdkvwCxFEgvfRRYx+4YXlFHwCfTYrzLJtABakgqXE1NyvnZV/+gaPFZzvQbb
         bj/IjOJa48vyQVobV9ModaynXiIl11PpPOCj1azOzzPjFDVB/BX0KTJvF6YXFd10K7
         LrW+0AGiCZFt/wzp14hReZFNlFROu2Q80j4dAyj2GGE1O7+rCqJdN9n3b4KTSXBXq7
         ygz9c/DtuD1Ojed8vGoppxuRC8p2UmIZIu5iNVPK/FOPbNAPAJU27mDi2lvA3cm9sX
         +IRJpwUNygxZV7W9/xHo7BE4=
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on eva.aplu.fr
X-Spam-Level: 
X-Spam-Status: No, score=-102.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        SHORTCIRCUIT shortcircuit=ham autolearn=disabled version=3.4.2
Received: from [IPv6:2a03:7220:8081:2901::1003] (unknown [IPv6:2a03:7220:8081:2901::1003])
        by eva.aplu.fr (Postfix) with ESMTPSA id D1DAA4C2;
        Mon, 24 Feb 2020 10:23:19 +0100 (CET)
Authentication-Results: eva.aplu.fr; dmarc=fail (p=none dis=none) header.from=aplu.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aplu.fr; s=s4096;
        t=1582536200; bh=quBzZ2v2ctF52ufgp/iLt5HkW7+LSaNHNV03EFB/I9Q=;
        h=Date:In-Reply-To:References:Subject:To:From:From;
        b=dBiRZwcERBlra2U3p6svWC2a8U4vDxyyz5pOkBjdl3zFQ2Hrn0eCI4dwFFtY+Ub0B
         d7I2jrKGiEvtZ8pvCk+8LNVsG6/ArlFhAb/x8/LyNiwYt+V8D7lffjmfTAAQ7pZ5n/
         IiF3p/NTVMLE++m92+ZJRN+5ujPrUW3Z072LaMuX9IOCWdpEClg3Q0XpwVT4C8StmF
         TsiRWwtTxTsCB4UjIww5ePzeV5CGulnlPqoUYE+x1fVdmwIu/nAJ3ggFGYKGbgKz66
         oS0U4rzinWTSpkFKuLr3dy9/OLD1hIdEZjYIDVaZQPSAjeldrjA/apVASSJZYrcLwq
         841lERFRJGVw97nA9H1B6BLOX8UXsA9I69tkabGHEq8agmaG2ivhetRQPd9jdw7LFk
         l0MNxbGdkvwCxFEgvfRRYx+4YXlFHwCfTYrzLJtABakgqXE1NyvnZV/+gaPFZzvQbb
         bj/IjOJa48vyQVobV9ModaynXiIl11PpPOCj1azOzzPjFDVB/BX0KTJvF6YXFd10K7
         LrW+0AGiCZFt/wzp14hReZFNlFROu2Q80j4dAyj2GGE1O7+rCqJdN9n3b4KTSXBXq7
         ygz9c/DtuD1Ojed8vGoppxuRC8p2UmIZIu5iNVPK/FOPbNAPAJU27mDi2lvA3cm9sX
         +IRJpwUNygxZV7W9/xHo7BE4=
Date:   Mon, 24 Feb 2020 10:23:18 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <1f5e671c-8d41-695b-2bc4-74df85361e75@youngman.org.uk>
References: <4cf4cbe7-989e-d7ec-cad9-cfde022bd4bf@aplu.fr> <1f5e671c-8d41-695b-2bc4-74df85361e75@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=aymeric@aplu.fr; keydata=
 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
Subject: Re: mdadm RAID1 with 3 disks active on 2 disks configuration
To:     antlists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
From:   "Aymeric P." <aymeric@aplu.fr>
Message-ID: <CC9E4848-12C7-4DA3-9626-F083F20EF676@aplu.fr>
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Le 23 f=C3=A9vrier 2020 21:40:44 GMT+01:00, antlists <antlists@youngman=2E=
org=2Euk> a =C3=A9crit :
>On 23/02/2020 17:38, Aymeric wrote:
>
>Because rebuilding sda is a lot of work=2E The sensible option would have
>
>been to leave sdb and sdc active, and left sda as spare=2E

Well, for some reason that didn't happen that way=2E=2E

>> I used the following command to add sda to the RAID1:
>> # mdadm=C2=A0 /dev/md0 --add /dev/sda3
>>
>>
>> What did I do wrong here? And how to fix it? Do I have to set sdc to
>> faulty and add it back?
>
>I'd just leave it as a 3-disk raid=2E But no, if you do want to set it=20
>back to a 2-disk raid don't do a "faulty and re-add" - that'll just
>make=20
>re-sync it again=2E

I would prefer to revert to sdc as a spare, it's a really a slow disk (540=
0rpm with a sata1 while others are 7200 at sata3)=2E For a spare disk it's =
good enough to give me time to get a new disk in case of failure but not fo=
r daily=2E

> Somehow you've got active devices set to 3, so just=20
>set that back to two=2E If you look on the wiki it covers the scenario of
>
>converting a three-disk raid to two=2E
>
>The only thing I will add about a 3-disk raid is that if you want to=20
>change it to anything else, you'll have to revert to 2 first, but do=20
>that when you want to change things, leave it at 3 for the moment=2E
>

So I tried with the --grow option to change the number disk in the array b=
ut it doesn't want to change=2E=2E=2E

# mdadm --grow /dev/md0 --raid-devices=3D2
mdadm: /dev/md0: no change requested
# mdadm --grow /dev/md0 --raid-devices=3D3
mdadm: Need 1 spare to avoid degraded array, and only have 0=2E
       Use --force to over-ride this check=2E

When looking with --examine, sdc3 is marked a replacement device=2E

# mdadm --examine /dev/sda3 /dev/sdb3 /dev/sdc3|grep 'dev\|Role\|State'
/dev/sda3:
          State : clean
   Device Role : Active device 1
   Array State : AR ('A' =3D=3D active, '=2E' =3D=3D missing, 'R' =3D=3D r=
eplacing)
/dev/sdb3:
          State : clean
   Device Role : Active device 0
   Array State : AR ('A' =3D=3D active, '=2E' =3D=3D missing, 'R' =3D=3D r=
eplacing)
/dev/sdc3:
          State : clean
   Device Role : Replacement device 1
   Array State : AR ('A' =3D=3D active, '=2E' =3D=3D missing, 'R' =3D=3D r=
eplacing)

Thanks,
Aymeric
--=20
Aymeric P=2E
Phone: +33 685 674 843
