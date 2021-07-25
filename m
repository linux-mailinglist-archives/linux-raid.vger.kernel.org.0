Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4ED63D4C7F
	for <lists+linux-raid@lfdr.de>; Sun, 25 Jul 2021 09:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhGYGVh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 25 Jul 2021 02:21:37 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:61783 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhGYGVg (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 25 Jul 2021 02:21:36 -0400
Received: from host86-128-145-16.range86-128.btcentralplus.com ([86.128.145.16] helo=[192.168.1.64])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1m7Y9E-000BrH-CA; Sun, 25 Jul 2021 08:02:05 +0100
Subject: Re: SSD based sw RAID: is ERC/TLER really important?
To:     Phil Turmel <philip@turmel.org>,
        Peter Grandi <pg@list.for.sabi.co.UK>,
        list Linux RAID <linux-raid@vger.kernel.org>
References: <2232919.g0K5C1TF2C@chirone>
 <24828.30134.873619.942883@cyme.ty.sabi.co.uk>
 <e4ecfd01-cffc-f154-5f7c-5ca08a12fd33@turmel.org>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <60FD0BF9.6060507@youngman.org.uk>
Date:   Sun, 25 Jul 2021 08:00:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <e4ecfd01-cffc-f154-5f7c-5ca08a12fd33@turmel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 24/07/21 22:45, Phil Turmel wrote:
> I don't have data on SSD behavior without ERC.  If their retry cycle is
> exhausted within the kernel default 30 seconds, the timeout mismatch
> issue will *not* apply.

I've also seen stuff that implies (with spinning rust) that the retry
cycle can hang - a read times out, then the next attempt to read the
same data works fine.

It's *possible* the same applies to SSDs, in which case shortening the
timeout could be worthwhile.

And as Phil says, the critical fact is that the drive MUST come back
from la-la-land BEFORE the kernel times out.

Cheers,
Wol
