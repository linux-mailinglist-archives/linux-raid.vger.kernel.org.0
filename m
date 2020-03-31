Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40C4C199547
	for <lists+linux-raid@lfdr.de>; Tue, 31 Mar 2020 13:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgCaLW7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 31 Mar 2020 07:22:59 -0400
Received: from azure.uno.uk.net ([95.172.254.11]:53942 "EHLO azure.uno.uk.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729925AbgCaLW7 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 31 Mar 2020 07:22:59 -0400
X-Greylist: delayed 1781 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Mar 2020 07:22:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sabi.unospace.net; s=default; h=From:References:In-Reply-To:Subject:To:Date
        :Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2GE4G7YlsgUlGprn0AMc42olRkqlOYovK9/HNsH2mHc=; b=NqBEAM0zPL5Ryf0aWl29XqrN5s
        a0gG3FvdQOBBxmieaYAa3yL4y+5/G823j2EZuXlb7CeJvNZO4aK83IF1lQ/RUQT/87zS2/2FywEEK
        b9xTiQ2tbAvUqypA5oFw0vmwVQdyaHhQgq5lCyLoysSpsaMz+3Ia9y7BW5DITRVXkrf4Vq2VSmV7J
        8D/l6k9Wr3AIcHT/ppTHSlyUQeQlmIg6dyG+iatmUwxU32fXIdOoh2igfvkK0x8Psx0mUOBYX4Hwz
        xdcFiCc6jZeNZqRnyMmy0hp0H/GaFACt/x3UJ60Nn0CEdLN/HYWN9nSv53edOT0Rok0ml0hX4Zri0
        hp9tX+gA==;
Received: from w-50.cust-u6066.ip.static.uno.uk.net ([95.172.224.50]:52840 helo=ty.sabi.co.UK)
        by azure.uno.uk.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <postmaster@mail.for.sabi.co.uk>)
        id 1jJEWB-0003TA-Qq
        for linux-raid@vger.kernel.org; Tue, 31 Mar 2020 11:53:15 +0100
Received: from from [127.0.0.1] (helo=base.ty.sabi.co.uk)
        by ty.sabi.co.UK with esmtps(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)(Exim 4.86_2 2)
        id 1jJEW3-00011z-T2
        for <linux-raid@vger.kernel.org>; Tue, 31 Mar 2020 11:53:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24195.8467.378436.7747@base.ty.sabi.co.uk>
Date:   Tue, 31 Mar 2020 11:53:07 +0100
X-Face: SMJE]JPYVBO-9UR%/8d'mG.F!@.,l@c[f'[%S8'BZIcbQc3/">GrXDwb#;fTRGNmHr^JFb
 SAptvwWc,0+z+~p~"Gdr4H$(|N(yF(wwCM2bW0~U?HPEE^fkPGx^u[*[yV.gyB!hDOli}EF[\cW*S
 H<GG"+i\3#fp@@EeWZWBv;]LA5n1pS2VO%Vv[yH?kY'lEWr30WfIU?%>&spRGFL}{`bj1TaD^l/"[
 msn( /TH#THs{Hpj>)]f><W}Ck9%2?H"AEM)+9<@D;3Kv=^?4$1/+#Qs:-aSsBTUS]iJ$6
To:     Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: mdcheck: slow system issues
In-Reply-To: <2933dddc-8728-51ac-1c60-8a47874966e4@molgen.mpg.de>
References: <2933dddc-8728-51ac-1c60-8a47874966e4@molgen.mpg.de>
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

> Dear Linux folks, When `mdcheck` runs on two 100 TB software
> RAIDs our users complain about being unable to open files in a
> reasonable time. [...]
>       109394518016 blocks super 1.2 level 6, 512k chunk,
> algorithm 2 [16/16] [UUUUUUUUUUUUUUUU]

Unsurprisingly it is a 16-wide RAID6 of 8TB HDDs.

> [...] The article *Software RAID check - slow system issues*
> [1] recommends to lower `dev.raid.speed_limit_max`, but the
> RAID should easily be able to do 200 MB/s as our tests show
> over 600 MB/s during some benchmarks.

Many people have to find out the hard way that on HDDs
sequential and random IO rates differ by "up to" two orders of
magnitude, and that RAID6 gives an "interesting" tradeoff
between read and write speed with random vs. sequential access.

> How do you run `mdcheck` in production without noticeably
> affecting the system?

Fortunately the only solution that works well is quite simple:
replace the storage system with one with much increased
IOPS-per-TB (that is SSDs or much smaller HDDs, 1TB or less)
*and* switch from RAID6 to RAID10.
