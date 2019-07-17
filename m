Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55AAB6C243
	for <lists+linux-raid@lfdr.de>; Wed, 17 Jul 2019 22:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfGQUnr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 17 Jul 2019 16:43:47 -0400
Received: from azure.uno.uk.net ([95.172.254.11]:43728 "EHLO azure.uno.uk.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfGQUnr (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 17 Jul 2019 16:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sabi.unospace.net; s=default; h=From:References:In-Reply-To:Subject:To:Date
        :Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=grCy/q41VUHwYqCwqSI7yo7Iyo7CuCwIatmwjl9Qipc=; b=WQDLE/jYTb8fPXAffGvIY6Tc//
        zeqauci1psqRIsT3HWwjjeNRyjRcJmBOzG5y0CGVEDOGYHFhZjYWF6WhGFsxzc6/OqUVLaiNShrMK
        FNm4bjXxVA6X+e77DnuqHn6xl32DD8bOH0dbe2Tqm6HECGqaCBx2i9L3N5L5ygfBYqNgf+JH5lX5I
        V1o7yOsoSShxPfsEkFn0uSvWDK8BDZ6/r0uuJTTGd86x7LJ3P/BfrL8uHt4K0kTgqecR3qJ4/XHVA
        8kxgwrB6RG+mFP0M6PnSbHkv3vQA1OddAkdh0CB51g9XYcjQ/fD7AD04zlCw965Vhk/BypVvOGV/n
        vQZQf+QQ==;
Received: from w-50.cust-u6066.ip.static.uno.uk.net ([95.172.224.50]:54832 helo=ty.sabi.co.UK)
        by azure.uno.uk.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <postmaster@mail.for.sabi.co.uk>)
        id 1hnqmA-007l05-3W
        for linux-raid@vger.kernel.org; Wed, 17 Jul 2019 21:43:46 +0100
Received: from from [127.0.0.1] (helo=base.ty.sabi.co.uk)
        by ty.sabi.co.UK with esmtps(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)(Exim 4.86_2 2)
        id 1hnqm6-0003bG-6P
        for <linux-raid@vger.kernel.org>; Wed, 17 Jul 2019 21:43:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <23855.34940.723878.816848@base.ty.sabi.co.uk>
Date:   Wed, 17 Jul 2019 21:43:40 +0100
X-Face: SMJE]JPYVBO-9UR%/8d'mG.F!@.,l@c[f'[%S8'BZIcbQc3/">GrXDwb#;fTRGNmHr^JFb
 SAptvwWc,0+z+~p~"Gdr4H$(|N(yF(wwCM2bW0~U?HPEE^fkPGx^u[*[yV.gyB!hDOli}EF[\cW*S
 H<GG"+i\3#fp@@EeWZWBv;]LA5n1pS2VO%Vv[yH?kY'lEWr30WfIU?%>&spRGFL}{`bj1TaD^l/"[
 msn( /TH#THs{Hpj>)]f><W}Ck9%2?H"AEM)+9<@D;3Kv=^?4$1/+#Qs:-aSsBTUS]iJ$6
To:     Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: slow BLKDISCARD on RAID10 md block devices
In-Reply-To: <23855.33185.759034.421593@base.ty.sabi.co.uk>
References: <20190717090200.GD2080@wantstofly.org>
        <23855.33185.759034.421593@base.ty.sabi.co.uk>
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

>> Any ideas on what I can try to speed this up? [...]

> Develop a time machine and travel back in time to persuade the
> authors of the TRIM spec to make it non-blocking?

Alternatively, ask your storage system supplier to certify
that your storage systems supports queued TRIM (or similar
primitives) end-to-end and has been tested for related bugs.

It may be cheaper or easier to develop a time machine though
:-).

