Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB2C19B693
	for <lists+linux-raid@lfdr.de>; Wed,  1 Apr 2020 21:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbgDATuN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 1 Apr 2020 15:50:13 -0400
Received: from azure.uno.uk.net ([95.172.254.11]:47614 "EHLO azure.uno.uk.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732314AbgDATuN (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 1 Apr 2020 15:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sabi.unospace.net; s=default; h=From:References:In-Reply-To:Subject:To:Date
        :Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0bkyOq55kt/2IqGoZN4BtlepKGd4u3frJHANtLEIhMw=; b=uIbZfMMS9LeHaESS+Zj7jelP84
        i9rE2Wj6XGo3hft7/XFwU0DHW2bqeCUlQjcUNto0o1ogKpRcfTb3UwZMWD98geB8OuXA1EvkPuMf8
        e4uICnSyYk6vQk5gKDlgSpMCfGOPspmum7Tpoxu0i/uwckyDa4qUDYGlSSD+m/XlpQ1tEKzae9syK
        VbFI2SB6SWWIqu/eyhiqh10uwnw1nv9RneefCZgmwL/gSZ4mN/eU5OhIO6S2bgr3H3q+qP2TFddZm
        vItmFKszIRh7EOZxvybmgzWhqqbxSRX3U2P/aIhxdVQNjZNjdxkrG+r1/DZEJCV6Sful7C9NXB50w
        E+oSjeBw==;
Received: from w-50.cust-u6066.ip.static.uno.uk.net ([95.172.224.50]:40144 helo=ty.sabi.co.UK)
        by azure.uno.uk.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <postmaster@mail.for.sabi.co.uk>)
        id 1jJjNL-00085N-8Q
        for linux-raid@vger.kernel.org; Wed, 01 Apr 2020 20:50:11 +0100
Received: from from [127.0.0.1] (helo=base.ty.sabi.co.uk)
        by ty.sabi.co.UK with esmtps(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)(Exim 4.86_2 2)
        id 1jJjNE-00059m-6B
        for <linux-raid@vger.kernel.org>; Wed, 01 Apr 2020 20:50:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24196.61547.646152.522241@base.ty.sabi.co.uk>
Date:   Wed, 1 Apr 2020 20:50:03 +0100
To:     Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: mdcheck: slow system issues
In-Reply-To: <dbbd010e-3648-c72c-ce44-ed570f6eb8be@turmel.org>
References: <2933dddc-8728-51ac-1c60-8a47874966e4@molgen.mpg.de>
        <24195.8467.378436.7747@base.ty.sabi.co.uk>
        <dbbd010e-3648-c72c-ce44-ed570f6eb8be@turmel.org>
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

>> Unsurprisingly it is a 16-wide RAID6 of 8TB HDDs.

> With a 512k chunk.  Definitely not suitable for anything but
> large media file streaming. [...] The random/streaming
> threshold is proportional to the address stride on one
> device--the raid sector number gap between one chunk and the
> next chunk on that (approximately). [...] I configure any
> raid6 that might have some random loads with a 16k or 32k
> chunk size.

That is actually rather controversial: I have read both
arguments like this and the opposite argument that sequential
performance is much better with small chunk sizes because then
sequential access is striped:

* Consider a 512KiB chunk size with 64KiB reads: 8 successive
  reads will be sequentially from the same disk, so top speed
  will be that of a single disk.

* Consider a 16KiB chunk size with 4 data disks with 64KiB
  reads: each read will be spread in parallel over all 4 disks.

The rationale for large chunk sizes is that it minimizes time
wasted on rotational latency: if reading 64KiB from 4 drives
with a 16KiB chunk size, the 64KiB block will only become
available when all four chunks have finished reading, and
because in most RAID types the drives are not synchronized, on
average each chunk will be at a different rotational position,
potentially one full rotation apart, but often half a rotation
apart, that is each read will have an overhead of 8ms of extra
rotational latency, and that's pretty huge. Some more detailed
discussion here:

  http://www.sabi.co.uk/blog/12-thr.html?120310#120310

Multihreading, block device read-ahead, various types of
alternative RAID layouts etc.  complicate things, and in some
small experiments I have done over the years results were
inconclusive, except that really large chunk sizes seemed worse
than smaller ones.

> Finally, the stripe cache size should be optimized on the
> system in question.  More is generally better, unless it
> starves the OS of buffers.

Indeed the stripe cache size matters a great deal to a 16-wide
RAID6, and that's a good point, but it is secondary to the
storage system having designed for high latency during mixed
read-write workloads with even a minimal degree of "random"
access or multithreading.

As to other secondary palliatives, the "unable to open files in
a reasonable time" case often can be made less bad in two other
ways:

* Often the (terrible) Linux block layer has default settings
  that result in enormous amounts of unsynced data in memory,
  and when that eventually is synced to disk, it can create huge
  congestion. This can also happen with hw RAID host adapters
  with onboard caches (in many cases very badly managed by their
  firmware).

* The default disk schedulers (in particular 'cfq') tend to
  prefer reads to writes, and this can result in large delays
  especially if 'atime' if set impacting 'open's, or 'mtime' on
  directories when 'creat'ing files. Using 'deadline' with
  tighter settings for "write_expire" and/or "writes_starved"
  might help.

But nothing other than a simple, quick replacement of the
storage system can work around a storage system designed to
minimize the IOPS-per-TB rate below the combined requirements of
the workload of 'mdcheck' (or backup) and the live workloads.
