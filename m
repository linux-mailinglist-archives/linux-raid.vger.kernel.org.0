Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A960216A220
	for <lists+linux-raid@lfdr.de>; Mon, 24 Feb 2020 10:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgBXJZw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 24 Feb 2020 04:25:52 -0500
Received: from eva.aplu.fr ([91.224.149.41]:34220 "EHLO eva.aplu.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgBXJZv (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 24 Feb 2020 04:25:51 -0500
Received: from eva.aplu.fr (eva.aplu.fr [127.0.0.1])
        by eva.aplu.fr (Postfix) with ESMTP id 8351E14B9;
        Mon, 24 Feb 2020 10:25:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aplu.fr; s=s4096;
        t=1582536350; bh=n9L5couJuG2g0xphrAgfHyBg1j83EppXo0I9uZJBfXo=;
        h=Date:In-Reply-To:References:Subject:To:From:From;
        b=pMstgGTIqGQ4dgdaTXsmg01bZsQBeXkFpKtd3yMZS0NE504jLK9WXPQaClvkBlEYP
         8uG3s0s1BEmz7qqYg7xBhklJk5RV9LWAnqzL3Qvq5kncVq4rcBfxO8h9B8djvqm93l
         C7q4w9VTzRK9x6Br8tqSYB7YUJKyLONIkKmUH1O4zB31X27zoEsvon9s1EQ1pmYSwK
         1HAWGcPrnj42prkn1pmLOMVox9OzYfcmKkgxQCl2Xfn+scPuUJb4ubyQTEBSnOXefm
         FITUjte9F2QpewRvc+B5v4icghRs6E+YAxkvZAR1R1DLnFIzzzGlU+bee+dyAAMcZv
         MOY3m74IbFOP4h4ujZKYBAyN7oIbNprzIGy41TK+ThW0hj5Q5VemEwKPFBEKRx0sBQ
         ANQmJVK54oellMZ542ldTEyVtw++rHVDftutHSsH3kEOWxBmED61Nuj/RfuadRH+0A
         EHOtjkyf/jtRv/hPf3Bq/x6PgC46anjoI6EwGSGPJJNG00FwpCJtZfLyCg09cGieXy
         ZFkl4k/F6ee8rFlj7qRxA3uhBijMhzmG8FOJxOhav7dvq6PgwMNeYWS3qVN4vWs7+Q
         vS6zSqGZP5Q1p4RJ5RFVpRbD/DuEkDH0q3GjWi2au+AoforMe8BrQgE6NXixLQnn7i
         bE0iDXVgDV6GweDz+jgojApg=
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on eva.aplu.fr
X-Spam-Level: 
X-Spam-Status: No, score=-102.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        SHORTCIRCUIT shortcircuit=ham autolearn=disabled version=3.4.2
Received: from [IPv6:2a03:7220:8081:2901::1003] (unknown [IPv6:2a03:7220:8081:2901::1003])
        by eva.aplu.fr (Postfix) with ESMTPSA id 8A1551486;
        Mon, 24 Feb 2020 10:25:49 +0100 (CET)
Authentication-Results: eva.aplu.fr; dmarc=fail (p=none dis=none) header.from=aplu.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aplu.fr; s=s4096;
        t=1582536350; bh=n9L5couJuG2g0xphrAgfHyBg1j83EppXo0I9uZJBfXo=;
        h=Date:In-Reply-To:References:Subject:To:From:From;
        b=pMstgGTIqGQ4dgdaTXsmg01bZsQBeXkFpKtd3yMZS0NE504jLK9WXPQaClvkBlEYP
         8uG3s0s1BEmz7qqYg7xBhklJk5RV9LWAnqzL3Qvq5kncVq4rcBfxO8h9B8djvqm93l
         C7q4w9VTzRK9x6Br8tqSYB7YUJKyLONIkKmUH1O4zB31X27zoEsvon9s1EQ1pmYSwK
         1HAWGcPrnj42prkn1pmLOMVox9OzYfcmKkgxQCl2Xfn+scPuUJb4ubyQTEBSnOXefm
         FITUjte9F2QpewRvc+B5v4icghRs6E+YAxkvZAR1R1DLnFIzzzGlU+bee+dyAAMcZv
         MOY3m74IbFOP4h4ujZKYBAyN7oIbNprzIGy41TK+ThW0hj5Q5VemEwKPFBEKRx0sBQ
         ANQmJVK54oellMZ542ldTEyVtw++rHVDftutHSsH3kEOWxBmED61Nuj/RfuadRH+0A
         EHOtjkyf/jtRv/hPf3Bq/x6PgC46anjoI6EwGSGPJJNG00FwpCJtZfLyCg09cGieXy
         ZFkl4k/F6ee8rFlj7qRxA3uhBijMhzmG8FOJxOhav7dvq6PgwMNeYWS3qVN4vWs7+Q
         vS6zSqGZP5Q1p4RJ5RFVpRbD/DuEkDH0q3GjWi2au+AoforMe8BrQgE6NXixLQnn7i
         bE0iDXVgDV6GweDz+jgojApg=
Date:   Mon, 24 Feb 2020 10:25:49 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <1f5e671c-8d41-695b-2bc4-74df85361e75@youngman.org.uk>
References: <4cf4cbe7-989e-d7ec-cad9-cfde022bd4bf@aplu.fr> <1f5e671c-8d41-695b-2bc4-74df85361e75@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=mulx@aplu.fr; keydata=
 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
Subject: Re: mdadm RAID1 with 3 disks active on 2 disks configuration
To:     antlists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
From:   Aymeric <mulx@aplu.fr>
Message-ID: <DDF3C0A3-0963-4C33-95EC-96D594AA74D7@aplu.fr>
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
Aymeric
