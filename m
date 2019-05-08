Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC3E182A4
	for <lists+linux-raid@lfdr.de>; Thu,  9 May 2019 01:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfEHXTg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 May 2019 19:19:36 -0400
Received: from zimbra.karlsbakk.net ([193.29.58.196]:57300 "EHLO
        zimbra.karlsbakk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfEHXTg (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 8 May 2019 19:19:36 -0400
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 438DF3C023D;
        Thu,  9 May 2019 01:19:34 +0200 (CEST)
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id hY6Pe_b22MKP; Thu,  9 May 2019 01:19:33 +0200 (CEST)
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id D8A173C02B8;
        Thu,  9 May 2019 01:19:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.karlsbakk.net D8A173C02B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlsbakk.net;
        s=1DC131FE-D37A-11E7-BD32-3AD4DFE620DF; t=1557357572;
        bh=KTnLVmpxkbwLHqbpNq0OCV1xR/YxoBGRjl6NxAgBwBg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=zOqU5RTRlwDYOsKiQQUrUfbBjnCoyyec/OJjfFekhyXRPJ4D0F3SCJBXciD0QCwoH
         K4wytuuwt7XmrkWqse3RUQiNkzI3mL1/v3AhvPwwrgp3ZRof8BFIna40yY0w6EM2h6
         hESN0ET9KZUctXvhtq8dCIwKzUofemwrOz24hfo2KfeM1cqTB0maEqgrZp6wpGCj03
         4HJP4QBCkqDYh6KEEeFGurrb8axQBPH8U0qkQl2C9+WmPsAn/vg8xQQIYn6+HH1UKj
         zcXuDv+zvJA2QMLogvVKhS3xv0I/6lM0IJzJPvRLaU6zhc/iw19vcrVH7TsdlLA+Kg
         35WdjBvvnroCg==
X-Virus-Scanned: amavisd-new at zimbra.karlsbakk.net
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id CgEhC-u-GWeK; Thu,  9 May 2019 01:19:32 +0200 (CEST)
Received: from zimbra.karlsbakk.net (localhost.localdomain [127.0.0.1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id AA94C3C023D;
        Thu,  9 May 2019 01:19:32 +0200 (CEST)
Date:   Thu, 9 May 2019 01:19:32 +0200 (CEST)
From:   Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To:     Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc:     Linux Raid <linux-raid@vger.kernel.org>
Message-ID: <1426313842.12996928.1557357572484.JavaMail.zimbra@karlsbakk.net>
In-Reply-To: <2aff655d-0495-1f7d-a305-adf23f9800bb@eyal.emu.id.au>
References: <1471924184.12974949.1557351707986.JavaMail.zimbra@karlsbakk.net> <2aff655d-0495-1f7d-a305-adf23f9800bb@eyal.emu.id.au>
Subject: Re: ID 5 Reallocated Sectors Count
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [::ffff:51.175.163.250]
X-Mailer: Zimbra 8.8.10_GA_3781 (ZimbraWebClient - FF66 (Mac)/8.8.10_GA_3786)
Thread-Topic: ID 5 Reallocated Sectors Count
Thread-Index: jbHfYhjGqXyRoTWeFz5QVIpRqn1Jeg==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> On 9/5/19 7:41 am, Roy Sigurd Karlsbakk wrote:
>> Hi
>>=20
>> I'm monitoring this box and it seems ID 5 Reallocated Sectors Count (fro=
m SMART)
>> is climbing frantically on one disk. It's a r6 so it shouldn't be much o=
f an
>> issue once the disk eventually fails, but does anyone out there know how=
 many
>> reallocated sectors you can have on a drive? This is an older 1TB ST3100=
0524NS
>=20
> My rule, and what is often suggested in raid documents, is that once the =
number
> start to visibly climb (you say 'frantically') I replace the disk.

That's more or less my understanding of it as well. The question was more o=
f a theoretical question: How many sectors can it reallocate before theey s=
tart to go "pending"?

As for the growth, at May 7 19:42 CEST, reallocated sectors were 53. When t=
his email was posted, it was 1812. Currently it's at 1883, so it's still cl=
imbing rapidly. Pending is till zero. This shows the numbers over the day f=
or reallocated sectors (the dots in front was before I turned up the check =
frequency and zabbix 3.4 apparently isn't smart enough to draw the graph fo=
r them there) https://karlsbakk.net/tmp/reallocated-sectors-hba-skrothaug.p=
ng=20

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
