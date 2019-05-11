Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8EFF1A866
	for <lists+linux-raid@lfdr.de>; Sat, 11 May 2019 18:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfEKQVQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 11 May 2019 12:21:16 -0400
Received: from zimbra.karlsbakk.net ([193.29.58.196]:57756 "EHLO
        zimbra.karlsbakk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfEKQVQ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 11 May 2019 12:21:16 -0400
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 71D753C0222;
        Sat, 11 May 2019 18:21:14 +0200 (CEST)
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id AAgvH8esOsww; Sat, 11 May 2019 18:21:13 +0200 (CEST)
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 1BA5B3C023D;
        Sat, 11 May 2019 18:21:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.karlsbakk.net 1BA5B3C023D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlsbakk.net;
        s=1DC131FE-D37A-11E7-BD32-3AD4DFE620DF; t=1557591673;
        bh=EOibyRBOrh25MTUaggaserw1uT/u+ndK2nI3BXP20HA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=tlAc3IMbjOLhSb9yo20zGkMabQDmzF+bPWHKqCcvOZLZPtr9lMTUhfMU7T12QGhfq
         aB9J5fI/GaukP8xmrgYaVPdNoGqyNV1xhKXJqgwGX3DUzXvNbe6FBmwegPXhZ+JSKt
         Mi6XQ99spEW5MB+Rf39BwHN0EF0HXmBBNs2BtsOtxCm1FcJMQktTH5LtedCchWTR4Q
         sg2svMBk49uBrOhJxTj5Y3ekZqFl355ZH+dCBCQNUOhU5dG2xLXgdsUDjcfh3PO//6
         qnZlgwYc0jinMTcNOyPZe886MbL3UpgTJVvLQxvtaWMH+3pHSyOO5jk056WAjWbizD
         oXR7mljiH3W4g==
X-Virus-Scanned: amavisd-new at zimbra.karlsbakk.net
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id yFFRvQuQvZE4; Sat, 11 May 2019 18:21:12 +0200 (CEST)
Received: from zimbra.karlsbakk.net (localhost.localdomain [127.0.0.1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id DD11E3C0222;
        Sat, 11 May 2019 18:21:12 +0200 (CEST)
Date:   Sat, 11 May 2019 18:21:12 +0200 (CEST)
From:   Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To:     Roger Heflin <rogerheflin@gmail.com>
Cc:     Linux Raid <linux-raid@vger.kernel.org>
Message-ID: <1120688127.13902394.1557591672640.JavaMail.zimbra@karlsbakk.net>
In-Reply-To: <CAAMCDecuOER88FMdvpoBpGTy8wHBSXVtaf5u7xJzyGHC4qoK6Q@mail.gmail.com>
References: <1471924184.12974949.1557351707986.JavaMail.zimbra@karlsbakk.net> <1486566915.13433540.1557468499945.JavaMail.zimbra@karlsbakk.net> <CAAMCDecuOER88FMdvpoBpGTy8wHBSXVtaf5u7xJzyGHC4qoK6Q@mail.gmail.com>
Subject: Re: ID 5 Reallocated Sectors Count
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [::ffff:51.175.163.250]
X-Mailer: Zimbra 8.8.10_GA_3781 (ZimbraWebClient - FF66 (Mac)/8.8.10_GA_3786)
Thread-Topic: ID 5 Reallocated Sectors Count
Thread-Index: 76SZm/i6GJ/ryObvuRrcue6JTD0SLw==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> I have found the max number it can get to depends on the disk/mfg.
> Older seagates only did 512, newer 1.5's could get to 4096 if I am
> remembering correctly.  I do know for sure that the newer disk I had
> went much higher before the disk itself officially failed.
>=20
> I have found disks that aren't reporting re-allocates, but respond
> poorly, and seem to be hitting close to the 7 second timeout and cause
> large IO pauses, and it is just best to replace the disk when it
> starts acting up like that.

I'd recommend getting drives that support SCTERC and adjust that to somethi=
ng more sane than 7s. Typically 1.0s is ok, but some run down to 0.1s

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
