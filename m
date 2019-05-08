Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3138C181B7
	for <lists+linux-raid@lfdr.de>; Wed,  8 May 2019 23:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfEHVlv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 May 2019 17:41:51 -0400
Received: from zimbra.karlsbakk.net ([193.29.58.196]:55250 "EHLO
        zimbra.karlsbakk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfEHVlv (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 8 May 2019 17:41:51 -0400
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 8EFEB3C023D
        for <linux-raid@vger.kernel.org>; Wed,  8 May 2019 23:41:49 +0200 (CEST)
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id HASbJeBScIKQ for <linux-raid@vger.kernel.org>;
        Wed,  8 May 2019 23:41:48 +0200 (CEST)
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 33A5F3C02B8
        for <linux-raid@vger.kernel.org>; Wed,  8 May 2019 23:41:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.karlsbakk.net 33A5F3C02B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlsbakk.net;
        s=1DC131FE-D37A-11E7-BD32-3AD4DFE620DF; t=1557351708;
        bh=sIvucU7h5DtMbMklc7XLpc67u2DVAosPr5/dOwxlnYM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=qZG388TflpVQr/kQf83gwQAp3fnijy4z0baMtrQ6Za7mRrN+N1idbIyoAa4W0WhdL
         NzVneHW5VodqSgRv1FwKdRelNrHj20FGbW62shO8pAa6gP/xOMLCqHo7/xS8QxEgql
         jTOl63+YXJE3Zt4MFPm3ATL61XW6/rgttbUB6PJjKalFJ5H0wokax/BsPbrImEc8RE
         NUf2+SiN6DkxmhJfnv0DD+2z3jXb80+llGnBwoEC65hcUPOqv16PEcmWJ9MCKBcrLN
         RMPitnRIYZuNiHRgKrvSPSBhTbMNJeZ75AdfMJsXhG64klxPmiKhaqsd4z5R+njgGC
         U/00rFwpotbtw==
X-Virus-Scanned: amavisd-new at zimbra.karlsbakk.net
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Lg9PLCK2dMEp for <linux-raid@vger.kernel.org>;
        Wed,  8 May 2019 23:41:48 +0200 (CEST)
Received: from zimbra.karlsbakk.net (localhost.localdomain [127.0.0.1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 18EF53C023D
        for <linux-raid@vger.kernel.org>; Wed,  8 May 2019 23:41:48 +0200 (CEST)
Date:   Wed, 8 May 2019 23:41:47 +0200 (CEST)
From:   Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Message-ID: <1471924184.12974949.1557351707986.JavaMail.zimbra@karlsbakk.net>
Subject: ID 5 Reallocated Sectors Count
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [::ffff:51.175.163.250]
X-Mailer: Zimbra 8.8.10_GA_3781 (ZimbraWebClient - FF66 (Mac)/8.8.10_GA_3786)
Thread-Index: RPYl4K/l9xIEPV7/bI1qkbFEGycyvw==
Thread-Topic: ID 5 Reallocated Sectors Count
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi

I'm monitoring this box and it seems ID 5 Reallocated Sectors Count (from S=
MART) is climbing frantically on one disk. It's a r6 so it shouldn't be muc=
h of an issue once the disk eventually fails, but does anyone out there kno=
w how many reallocated sectors you can have on a drive? This is an older 1T=
B ST31000524NS

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
