Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5616C215
	for <lists+linux-raid@lfdr.de>; Wed, 17 Jul 2019 22:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfGQU17 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 17 Jul 2019 16:27:59 -0400
Received: from azure.uno.uk.net ([95.172.254.11]:43518 "EHLO azure.uno.uk.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbfGQU16 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 17 Jul 2019 16:27:58 -0400
X-Greylist: delayed 800 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jul 2019 16:27:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sabi.unospace.net; s=default; h=From:References:In-Reply-To:Subject:To:Date
        :Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y9S3uGmo8qjxAuO14PyxNjHWadOmTl1176434kmvfM4=; b=uSGqxN8F103CWzG2ku0uQ6z/na
        ExxljBWi7RspmI2bEQv9SIND6TAYmm9rCSc1kh7tjp2wfKwjog0qnZZuaYhOr4mWPHFBmaHWYYTuy
        76emJXNRQYifw5xNF4qwN+TnU1pQx2oQxuV15hJuH/4j+Jsk/ww99c4l6lQK0yvuYDia29+iWFX8Y
        WUB/hpPLEHYKBt8pXZvSNR5jLIHz3UcjErUB4KERJ3jruE7MnyofQWiJNll882CwyV0nv1+CjEP/O
        tDPQfyYhxe0USKCnVmTy6vIEK0Gv4BrDeT/RtoP83BbydUtL/ztRv3x94/4PRqHeOhj+ysw8fafYT
        xRZSuKRA==;
Received: from w-50.cust-u6066.ip.static.uno.uk.net ([95.172.224.50]:54504 helo=ty.sabi.co.UK)
        by azure.uno.uk.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <postmaster@mail.for.sabi.co.uk>)
        id 1hnqWr-007kNo-JK
        for linux-raid@vger.kernel.org; Wed, 17 Jul 2019 21:27:57 +0100
Received: from from [127.0.0.1] (helo=base.ty.sabi.co.uk)
        by ty.sabi.co.UK with esmtps(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)(Exim 4.86_2 2)
        id 1hnqWm-0003Vf-4d
        for <linux-raid@vger.kernel.org>; Wed, 17 Jul 2019 21:27:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <23855.33990.595530.291667@base.ty.sabi.co.uk>
Date:   Wed, 17 Jul 2019 21:27:50 +0100
To:     Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: slow BLKDISCARD on RAID10 md block devices
In-Reply-To: <20190717113352.GA13079@metamorpher.de>
References: <20190717090200.GD2080@wantstofly.org>
        <20190717113352.GA13079@metamorpher.de>
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

[...]
> Total time (this is tmpfs-backed, no real I/O)

That's not even remotely realistic.

> (Why XFS trims 900G when I said 500G is a bit of a mystery...

>> # time fstrim -v --minimum 64M --offset 0G --length 500G /mnt/tmp/

My guess is that those limiting options are advisory: they rely
on the ability of the filesystem code to easily and cheaply
check whether a given range of physical addresses is free or
used. Many filesystems have a "free list" optimized for the
forward mapping fast "find a free block", not the reverse
mapping "check whether a block is free".

A good option would have been to not do 'fstrim'/'blkdiscard'
and put TRIM in 'fsck' (apparently that happens under MacOS X
and 'e2fsck' also allows that).
