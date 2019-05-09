Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7945718591
	for <lists+linux-raid@lfdr.de>; Thu,  9 May 2019 08:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfEIGwt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 May 2019 02:52:49 -0400
Received: from zimbra.karlsbakk.net ([193.29.58.196]:38084 "EHLO
        zimbra.karlsbakk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfEIGwt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 9 May 2019 02:52:49 -0400
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 74B3C3C0246;
        Thu,  9 May 2019 08:52:47 +0200 (CEST)
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id b1wBrAXMF5Ip; Thu,  9 May 2019 08:52:46 +0200 (CEST)
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 295673C02B9;
        Thu,  9 May 2019 08:52:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.karlsbakk.net 295673C02B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlsbakk.net;
        s=1DC131FE-D37A-11E7-BD32-3AD4DFE620DF; t=1557384766;
        bh=XkdGim09iGQnzgiQncJopt9VvsGhVNpa4Fb6Va9/30Y=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=qRtpoZw3/WESKNTvMI8ze1aIhSJ2/+sHak8YXbEAllstD4Mba4gWlnV46T/Jn8i40
         YbA4GI0AJqlIpjY2gIClpRM/vU8Sod26e4cWl3n4vxG6KWBUkJXDp45Bz2nW9+/1fv
         wbIArmSewoMu10EoOdLLPtbyaAVy4AGBZ1F3W+oLOmMTCVO1wH7QYL1NGfz3KRPxSB
         dhMmGDayPKsrydu8VjfCTXnzLxAViKTIKMk5B3t/FnR5X/RBD4/4cic9fFGZPe98nP
         Wlg8Jdnoo304VCYsTUinVwsLB8hBTkQNf5s8qcrWDuhTaj/idgFlTF9b8KhmqA8kDQ
         RBB4QQvNbN3oA==
X-Virus-Scanned: amavisd-new at zimbra.karlsbakk.net
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Ds4QVotapANb; Thu,  9 May 2019 08:52:46 +0200 (CEST)
Received: from zimbra.karlsbakk.net (localhost.localdomain [127.0.0.1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 0C6AF3C0246;
        Thu,  9 May 2019 08:52:46 +0200 (CEST)
Date:   Thu, 9 May 2019 08:52:45 +0200 (CEST)
From:   Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     Linux Raid <linux-raid@vger.kernel.org>
Message-ID: <824237673.13103228.1557384765880.JavaMail.zimbra@karlsbakk.net>
In-Reply-To: <5CD37280.9080309@youngman.org.uk>
References: <1471924184.12974949.1557351707986.JavaMail.zimbra@karlsbakk.net> <2aff655d-0495-1f7d-a305-adf23f9800bb@eyal.emu.id.au> <1426313842.12996928.1557357572484.JavaMail.zimbra@karlsbakk.net> <5CD37280.9080309@youngman.org.uk>
Subject: Re: ID 5 Reallocated Sectors Count
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [::ffff:176.11.89.245]
X-Mailer: Zimbra 8.8.10_GA_3781 (ZimbraWebClient - FF66 (Mac)/8.8.10_GA_3786)
Thread-Topic: ID 5 Reallocated Sectors Count
Thread-Index: xmOyk5v4ZfhW+FT9kwWNnr91EoJ2Lg==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> On 09/05/19 00:19, Roy Sigurd Karlsbakk wrote:
>>> On 9/5/19 7:41 am, Roy Sigurd Karlsbakk wrote:
>>>> Hi
>>>>
>>>> I'm monitoring this box and it seems ID 5 Reallocated Sectors Count (f=
rom SMART)
>>>> is climbing frantically on one disk. It's a r6 so it shouldn't be much=
 of an
>>>> issue once the disk eventually fails, but does anyone out there know h=
ow many
>>>> reallocated sectors you can have on a drive? This is an older 1TB ST31=
000524NS
>>>
>>> My rule, and what is often suggested in raid documents, is that once th=
e number
>>> start to visibly climb (you say 'frantically') I replace the disk.
>>=20
>> That's more or less my understanding of it as well. The question was mor=
e of a
>> theoretical question: How many sectors can it reallocate before theey st=
art to
>> go "pending"?
>>=20
> I'm not sure of the exact meaning of "pending sectors", but I'm pretty
> certain your question doesn't make sense. Sectors go "pending" BEFORE
> they are re-allocated, not after.

197 Current_Pending_Sector  0x0032   200   200   000    Old_age   Always   =
    -       0

>=20
> I suspect that if a read fails, the sector goes pending. If a "write
> then verify" fails, the sector is re-allocated. And if the disk runs out
> of space to re-allocate, it commits suicide.
>=20
> So you can have thousands of "pendings", and it's independent of
> "reallocated". But if there's a real problem (like surface damage) any
> attempt to rewrite those pendings will result in a rapidly climbing
> reallocated count - like you've just seen - and as others have said, it
> looks like your drive is on the way out ...

AFAICS "pending" means "I know htese are bad, but I haven't reallocated the=
m (yet). Sometimes they never even get reallocated.
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
