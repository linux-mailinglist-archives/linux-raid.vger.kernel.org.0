Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 171D86C239
	for <lists+linux-raid@lfdr.de>; Wed, 17 Jul 2019 22:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfGQUhX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 17 Jul 2019 16:37:23 -0400
Received: from azure.uno.uk.net ([95.172.254.11]:43606 "EHLO azure.uno.uk.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfGQUhX (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 17 Jul 2019 16:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sabi.unospace.net; s=default; h=From:References:In-Reply-To:Subject:To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H73yW80jBBTxWkKzgHZCKLqoh4tlcNlg7qQkSLNuw4M=; b=fod+pqWSWkfKVmy7HXzf/0zqDl
        7Mv2wSa2v3VhE0vA2AkdZfOPkgp2HKSBo7HsHqE8SSfYUbVcqeXQlZvi0TsugJvP5KmEbBLMyxrVt
        ouNv3HCmw53dNyI5NFuZeLeAfMpwb78MJkCPh3i8TnlWUpXeOVAwzffoWPyL9QHP1gH+fEIu0zSwb
        UqJ6JKhWuUYwTHoEM4tN89DgnwmIh7RDRWgcBzNciBaKK7OH5DSuMyq7VUx/DVMiVDZsvjihAp73E
        L9BSyC3D/ab8rlFWZYOJd4rb84f6iB0ysCSAGO6nNSOeicjrwAol260pQJ6Iz5PWVjl0l49E4YqJS
        VE/OYbDw==;
Received: from w-50.cust-u6066.ip.static.uno.uk.net ([95.172.224.50]:54704 helo=ty.sabi.co.UK)
        by azure.uno.uk.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <postmaster@mail.for.sabi.co.uk>)
        id 1hnqfy-007kky-KS
        for linux-raid@vger.kernel.org; Wed, 17 Jul 2019 21:37:22 +0100
Received: from from [127.0.0.1] (helo=base.ty.sabi.co.uk)
        by ty.sabi.co.UK with esmtps(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)(Exim 4.86_2 2)
        id 1hnqfu-0003Yd-2m
        for <linux-raid@vger.kernel.org>; Wed, 17 Jul 2019 21:37:18 +0100
Message-ID: <23855.34557.987347.284655@base.ty.sabi.co.uk>
Date:   Wed, 17 Jul 2019 21:37:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Face: SMJE]JPYVBO-9UR%/8d'mG.F!@.,l@c[f'[%S8'BZIcbQc3/">GrXDwb#;fTRGNmHr^JFb
 SAptvwWc,0+z+~p~"Gdr4H$(|N(yF(wwCM2bW0~U?HPEE^fkPGx^u[*[yV.gyB!hDOli}EF[\cW*S
 H<GG"+i\3#fp@@EeWZWBv;]LA5n1pS2VO%Vv[yH?kY'lEWr30WfIU?%>&spRGFL}{`bj1TaD^l/"[
 msn( /TH#THs{Hpj>)]f><W}Ck9%2?H"AEM)+9<@D;3Kv=^?4$1/+#Qs:-aSsBTUS]iJ$6
To:     Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: slow BLKDISCARD on RAID10 md block devices
In-Reply-To: <23855.33990.595530.291667@base.ty.sabi.co.uk>
References: <20190717090200.GD2080@wantstofly.org>
        <20190717113352.GA13079@metamorpher.de>
        <23855.33990.595530.291667@base.ty.sabi.co.uk>
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

>> (Why XFS trims 900G when I said 500G is a bit of a mystery...
>>> # time fstrim -v --minimum 64M --offset 0G --length 500G /mnt/tmp/
> My guess is that those limiting options are advisory:

BTW there is a terse explanation of TRIM by a guy who knows
what's about here:

https://forums.freebsd.org/threads/ssd-trim-maintenance.56951/#post-328912

and one of the points he makes is that TRIM itself is only a
hint, so I guess that related commands behave similarly.
