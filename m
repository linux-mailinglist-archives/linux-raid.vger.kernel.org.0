Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 938751659A
	for <lists+linux-raid@lfdr.de>; Tue,  7 May 2019 16:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfEGO0H (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 May 2019 10:26:07 -0400
Received: from zimbra.karlsbakk.net ([193.29.58.196]:45136 "EHLO
        zimbra.karlsbakk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfEGO0G (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 7 May 2019 10:26:06 -0400
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 812DD3C0220
        for <linux-raid@vger.kernel.org>; Tue,  7 May 2019 16:26:05 +0200 (CEST)
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id GB2QdVEbmmmY for <linux-raid@vger.kernel.org>;
        Tue,  7 May 2019 16:26:04 +0200 (CEST)
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id DC6593C02B4
        for <linux-raid@vger.kernel.org>; Tue,  7 May 2019 16:26:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.karlsbakk.net DC6593C02B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlsbakk.net;
        s=1DC131FE-D37A-11E7-BD32-3AD4DFE620DF; t=1557239163;
        bh=3rATxNxK2gitjGLLqlmEx1mA6KuCaYwKNIlJUl1SMZE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=dRvEWKwvWTYfTUQ8APkP04sq1EUf8xeq9lCb1iDPQde5NdYGzYrToSqaxzkA/FY0/
         5YbdEp0KartI0/Xq4kLOqhXML93IXHHlCmcj1NVHckmDW8mCQaDy9Fh2qK5Mj7tMKQ
         PljL0aktLBwQGCogx5GbrI2IMN4uq5a5qhSgc+J13u90br7O45EAqcZFo5lGE2t7Xc
         ZK62B56U2IwR21l/U5rJAJ0vV4wmqAwnA8pb/aGhgPAtroPUO3y3nZbKmitC1OeE2Z
         qyFzZ1AjU9aDDGfv5etGmn7FTLOxwaDXMWZ5TYZm4pI5xtrMqBcs9PtWFqn/ZtMbU/
         PPD+mgkllMDmg==
X-Virus-Scanned: amavisd-new at zimbra.karlsbakk.net
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 5HvBGQeY0RYk for <linux-raid@vger.kernel.org>;
        Tue,  7 May 2019 16:26:03 +0200 (CEST)
Received: from zimbra.karlsbakk.net (localhost.localdomain [127.0.0.1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id B8AF43C0220
        for <linux-raid@vger.kernel.org>; Tue,  7 May 2019 16:26:03 +0200 (CEST)
Date:   Tue, 7 May 2019 16:26:03 +0200 (CEST)
From:   Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Message-ID: <1059881755.12544793.1557239163561.JavaMail.zimbra@karlsbakk.net>
Subject: Spare pool documentation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [::ffff:91.186.71.4]
X-Mailer: Zimbra 8.8.10_GA_3781 (ZimbraWebClient - FF66 (Mac)/8.8.10_GA_3786)
Thread-Index: vZgptUfofUglm4aFOdjLI06Cz9G5og==
Thread-Topic: Spare pool documentation
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi

I came across the phenomonen of 'spare pools', merely mentioned in the manu=
al pages I've found, but just, so I did some testing in my raidtest vm to s=
ee if I could make it work. It seems fine by me, but so far I don't have mo=
re than one raidset (plus the small one for the root). Are there any offici=
al documentation on this except for the few lines in the manual pages?

I wrote about my tests here: https://wiki.malinux.no/index.php/Roy's_notes#=
Spare_pools

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
