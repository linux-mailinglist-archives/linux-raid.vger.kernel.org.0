Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1ED6C232
	for <lists+linux-raid@lfdr.de>; Wed, 17 Jul 2019 22:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfGQUfM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 17 Jul 2019 16:35:12 -0400
Received: from azure.uno.uk.net ([95.172.254.11]:43576 "EHLO azure.uno.uk.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbfGQUfM (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 17 Jul 2019 16:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sabi.unospace.net; s=default; h=From:References:In-Reply-To:Subject:To:Date
        :Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5czBecMTxL4+emNfx/F9FtBClHp/+dZCBWDlhX6YXfs=; b=ogdAm3xF1cMnOSgXfdnN9HogK7
        bY7NyZPR8I9Iw76D+5QZ9iUg6oiodWWqt/ncPU19rn9qYrJiBXZnk8Qz0+gtBaS6ms7rePmdMZFJi
        Z4e5wZ9eIRI8DKmXaTYpc43Qeah8INM9YwPg1Ga8dg9nozNLsTpg5MwfGhnnVUZyjD8rVstW53z1b
        JDkzOlWteXBpvBaqH2JWNC0MkNk1B7elDIdcvmGXKBM5K0a2SeR54f3bBSyrkytmaIuZsThxDYVSj
        +6WlAB9g00ilsoaLbs6hv+sXfadS2YKnXjVYROCuvZGVb63FDNIB8cZJkHcpMVdm0Lp8Kf2PIp7j+
        OSj/ZldA==;
Received: from w-50.cust-u6066.ip.static.uno.uk.net ([95.172.224.50]:54196 helo=ty.sabi.co.UK)
        by azure.uno.uk.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <postmaster@mail.for.sabi.co.uk>)
        id 1hnqJu-007jqE-So
        for linux-raid@vger.kernel.org; Wed, 17 Jul 2019 21:14:34 +0100
Received: from from [127.0.0.1] (helo=base.ty.sabi.co.uk)
        by ty.sabi.co.UK with esmtps(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)(Exim 4.86_2 2)
        id 1hnqJm-0003Q0-Fp
        for <linux-raid@vger.kernel.org>; Wed, 17 Jul 2019 21:14:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <23855.33185.759034.421593@base.ty.sabi.co.uk>
Date:   Wed, 17 Jul 2019 21:14:25 +0100
X-Face: SMJE]JPYVBO-9UR%/8d'mG.F!@.,l@c[f'[%S8'BZIcbQc3/">GrXDwb#;fTRGNmHr^JFb
 SAptvwWc,0+z+~p~"Gdr4H$(|N(yF(wwCM2bW0~U?HPEE^fkPGx^u[*[yV.gyB!hDOli}EF[\cW*S
 H<GG"+i\3#fp@@EeWZWBv;]LA5n1pS2VO%Vv[yH?kY'lEWr30WfIU?%>&spRGFL}{`bj1TaD^l/"[
 msn( /TH#THs{Hpj>)]f><W}Ck9%2?H"AEM)+9<@D;3Kv=^?4$1/+#Qs:-aSsBTUS]iJ$6
To:     Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: slow BLKDISCARD on RAID10 md block devices
In-Reply-To: <20190717090200.GD2080@wantstofly.org>
References: <20190717090200.GD2080@wantstofly.org>
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

> I've been running into an issue with background fstrim on
> large xfs filesystems on RAID10d SSDs taking a lot of time to
> complete and starving out other I/O to the filesystem. There
> seem to be a few different issues involved here, [...] Doing
> this on actual 4x7.68TB or 6x7.68TB SSD arrays instead of with
> loop devices takes many many hours.

Amazingly unexpected news :-). Stop the presses! "Complex and
expensive operation based on a misdesigned primitive takes a
long time when scaled to huge volumes!!!!!!!!!!!!!!!!!!!!!!!".
In other news ursinids have been see relieving themselves in
areas with many trees.

> Any ideas on what I can try to speed this up? [...]

Develop a time machine and travel back in time to persuade the
authors of the TRIM spec to make it non-blocking?
Send patches to improve most host adapter and disk firmware?

> but the main one appears to be that BLKDISCARD on a RAID10 md
> block device sends many small discard requests down to the
> underlying component devices (while this doesn't seem to be an
> issue for RAID0 or for RAID1).

If you think that can be improved (and it can be improved, at a
very high cost), send patches :-).

> [...] the completion time is somewhat inversely proportional
> to the RAID chunk size. [...]

How strange is that! :-)

> It's quite easy to reproduce this with just using in-memory
> loop devices [...]

For pretty small values of "reproduce"...
