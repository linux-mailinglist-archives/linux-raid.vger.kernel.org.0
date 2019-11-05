Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E47CEF1FF
	for <lists+linux-raid@lfdr.de>; Tue,  5 Nov 2019 01:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfKEAdV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 Nov 2019 19:33:21 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:59822 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729795AbfKEAdS (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 4 Nov 2019 19:33:18 -0500
Received: from [86.155.171.62] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iRmma-00030C-B4; Tue, 05 Nov 2019 00:33:16 +0000
Subject: Re: [PATCH] raid456: avoid second retry of read-error
To:     Nigel Croxon <ncroxon@redhat.com>, linux-raid@vger.kernel.org,
        liu.song.a23@gmail.com
References: <20191104200157.31656-1-ncroxon@redhat.com>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5DC0C34B.1040102@youngman.org.uk>
Date:   Tue, 5 Nov 2019 00:33:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20191104200157.31656-1-ncroxon@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 04/11/19 20:01, Nigel Croxon wrote:
> The MD driver for level-456 should prevent re-reading read errors.
> 
> For redundant raid it makes no sense to retry the operation:
> When one of the disks in the array hits a read error, that will
> cause a stall for the reading process:
> - either the read succeeds (e.g. after 4 seconds the HDD error
> strategy could read the sector)
> - or it fails after HDD imposed timeout (w/TLER, e.g. after 7
> seconds (might be even longer)

Okay, I'm being completely naive here, but what is going on? Are you
saying that if we hit a read error, we just carry on, ignore it, and
calculate the missing block from parity?

If so, what happens if we hit two errors on a raid-5, or 3 on a raid-6,
or whatever ... :-)

Cheers,
Wol
