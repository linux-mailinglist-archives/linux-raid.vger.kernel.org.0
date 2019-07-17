Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5596C25A
	for <lists+linux-raid@lfdr.de>; Wed, 17 Jul 2019 22:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfGQUyM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 17 Jul 2019 16:54:12 -0400
Received: from azure.uno.uk.net ([95.172.254.11]:43770 "EHLO azure.uno.uk.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfGQUyM (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 17 Jul 2019 16:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sabi.unospace.net; s=default; h=From:References:In-Reply-To:Subject:To:Date
        :Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HrSmTRtMjxO6LQH9OUROyPS/jyI+Qrvq/g8QzzPx+dM=; b=bApjxgk8bFgMYaAh3bwAfbi5d6
        6miitl3oizAnA261aHDY4RGnDETuPuYQ/SL3szWDB19fK2UGPgX2G4KQdV/tDPpeffvsAdOj9nELh
        1B1J5ZHho5CTHgFoIEEqIkj/DyKeB9sw8htd37Dno28cMJj6T98k1LJ6xXdlIZVTjd8j+2lnf9uwr
        S7s0zV5lJeNQUBe/MAsgrs9oxCDgtE1Aayjdi4liA5a9mJusjGKox8Y454aakhFREotS524lSPHRM
        6o5XTRoJt1BD/W/Yil6i/0EIXwTHBP78oK8vR5PNeVAAzGQY0tv/q12YYTyvnRy34DbeAJdRD5/AC
        3BCts2Zg==;
Received: from w-50.cust-u6066.ip.static.uno.uk.net ([95.172.224.50]:55012 helo=ty.sabi.co.UK)
        by azure.uno.uk.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <postmaster@mail.for.sabi.co.uk>)
        id 1hnqwE-007lO3-IB
        for linux-raid@vger.kernel.org; Wed, 17 Jul 2019 21:54:10 +0100
Received: from from [127.0.0.1] (helo=base.ty.sabi.co.uk)
        by ty.sabi.co.UK with esmtps(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)(Exim 4.86_2 2)
        id 1hnqwA-0003dL-9Z
        for <linux-raid@vger.kernel.org>; Wed, 17 Jul 2019 21:54:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <23855.35565.981137.953275@base.ty.sabi.co.uk>
Date:   Wed, 17 Jul 2019 21:54:05 +0100
X-Face: SMJE]JPYVBO-9UR%/8d'mG.F!@.,l@c[f'[%S8'BZIcbQc3/">GrXDwb#;fTRGNmHr^JFb
 SAptvwWc,0+z+~p~"Gdr4H$(|N(yF(wwCM2bW0~U?HPEE^fkPGx^u[*[yV.gyB!hDOli}EF[\cW*S
 H<GG"+i\3#fp@@EeWZWBv;]LA5n1pS2VO%Vv[yH?kY'lEWr30WfIU?%>&spRGFL}{`bj1TaD^l/"[
 msn( /TH#THs{Hpj>)]f><W}Ck9%2?H"AEM)+9<@D;3Kv=^?4$1/+#Qs:-aSsBTUS]iJ$6
To:     Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: slow BLKDISCARD on RAID10 md block devices
In-Reply-To: <26ef3b9b-54d0-e660-8614-a45ddd2a4b1e@thelounge.net>
References: <20190717090200.GD2080@wantstofly.org>
        <20190717113352.GA13079@metamorpher.de>
        <23855.33990.595530.291667@base.ty.sabi.co.uk>
        <26ef3b9b-54d0-e660-8614-a45ddd2a4b1e@thelounge.net>
X-Mailer: VM 8.2.0b under 24.5.1 (x86_64-pc-linux-gnu)
From:   pg@mdraid.list.sabi.co.UK (Peter Grandi)
X-Disclaimer: This message contains only personal opinions
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - azure.uno.uk.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mail.for.sabi.co.uk
X-Get-Message-Sender-Via: azure.uno.uk.net: authenticated_id: sabity@sabi.unospace.net
X-Authenticated-Sender: azure.uno.uk.net: sabity@sabi.unospace.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>> [...] Many filesystems have a "free list" optimized for the
>> forward mapping fast "find a free block", not the reverse
>> mapping "check whether a block is free". A good option would
>> have been to not do 'fstrim'/'blkdiscard' and put TRIM in
>> 'fsck' (apparently that happens under MacOS X and 'e2fsck'
>> also allows that).

> how often do you reboot at all and then check your filesystems
> versus blocks freed /data deleted?

System design is all about tradeoffs: in this case between
having complicated and subtle code to list unused block segments
in the kernel or have it in 'fsck' (which can take weeks to
complete...), which must be regularly used to audit the
filesystem structure anyhow.

I am aware that the opinion that "reboot at all and then check
your filesystems" (and presumably other maintenance operations)
should be or can be performed rarely is very popular among many
sysadmins, being very low cost; to an extreme example I have
seen systems in semi production use for which hardware and
software went EOL in 2007 and untouched since then, and still
"work". But some people get away with it, some don't.
