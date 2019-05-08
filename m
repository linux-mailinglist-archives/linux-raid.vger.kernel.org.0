Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4A7B182BB
	for <lists+linux-raid@lfdr.de>; Thu,  9 May 2019 01:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfEHXg2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 May 2019 19:36:28 -0400
Received: from zimbra.karlsbakk.net ([193.29.58.196]:57662 "EHLO
        zimbra.karlsbakk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfEHXg1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 8 May 2019 19:36:27 -0400
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 8F9D73C023D;
        Thu,  9 May 2019 01:36:25 +0200 (CEST)
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id KCU7cEfyatIp; Thu,  9 May 2019 01:36:24 +0200 (CEST)
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 506AE3C02B8;
        Thu,  9 May 2019 01:36:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.karlsbakk.net 506AE3C02B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlsbakk.net;
        s=1DC131FE-D37A-11E7-BD32-3AD4DFE620DF; t=1557358584;
        bh=i7RR9LYfD/pxv31ltxI1/5my1MkB/h4nM+S5+Nchrd8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=cqpfQB/KsZUER09TKKp7ziaLGvXcB+8S9vwjiVu0f/LzpWxF7zRVgpHT3ZrwtKSC3
         LjLmeAzv9s8vaCVfzcekopqndep6dvSDx/wxV6LowvD3RqYWlELsWoCg4O7Q5mOVmK
         zMs64WcmbvjUSAckjyUrmZS9y9ObgfL6xCqr7ofciJeetYuVNfJjQUqI9cG1mYt2Ah
         rvTwg918exrFYhvftww8aGDvbf+unBCVtvaELDA6jAaVDAd02cGaPgPHxpnn0lat33
         1E3N+qOGttXYMFJJVvcUb2tbOB/N2oTO++U/06xTSZnCmDCFfiLjlSYbaNwcs1WqaG
         ep9jZwW4tUZpQ==
X-Virus-Scanned: amavisd-new at zimbra.karlsbakk.net
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Q-sKw-f60HdF; Thu,  9 May 2019 01:36:24 +0200 (CEST)
Received: from zimbra.karlsbakk.net (localhost.localdomain [127.0.0.1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 245233C023D;
        Thu,  9 May 2019 01:36:24 +0200 (CEST)
Date:   Thu, 9 May 2019 01:36:23 +0200 (CEST)
From:   Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To:     Julien ROBIN <julien.robin28@free.fr>
Cc:     Linux Raid <linux-raid@vger.kernel.org>
Message-ID: <1638761679.13000592.1557358583866.JavaMail.zimbra@karlsbakk.net>
In-Reply-To: <458766bc-bd91-88b3-6075-8fde270c7222@free.fr>
References: <1471924184.12974949.1557351707986.JavaMail.zimbra@karlsbakk.net> <458766bc-bd91-88b3-6075-8fde270c7222@free.fr>
Subject: Re: ID 5 Reallocated Sectors Count
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [::ffff:51.175.163.250]
X-Mailer: Zimbra 8.8.10_GA_3781 (ZimbraWebClient - FF66 (Mac)/8.8.10_GA_3786)
Thread-Topic: ID 5 Reallocated Sectors Count
Thread-Index: qMCjzXTZmG1x2WsspkybxzQItZZGfQ==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> As you are on RAID 6 it's less dangerous to wait and see. But what you
> are likely to see is a very quickly coming failure ;)

Well, it's not my box and the owner was a bit fed up today, so we'll see. I=
t'll be interesting to see the graphs and when (if ever) pending sectors st=
arts rising during the night or the week. He has a few more disks around, a=
nd an offsite backup, so it should be safe(ish)

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
