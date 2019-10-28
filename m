Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D606E7B69
	for <lists+linux-raid@lfdr.de>; Mon, 28 Oct 2019 22:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfJ1Ver (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 28 Oct 2019 17:34:47 -0400
Received: from rin.romanrm.net ([91.121.75.85]:50410 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbfJ1Ver (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 28 Oct 2019 17:34:47 -0400
Received: from natsu (natsu.2.romanrm.net [IPv6:fd39:aa:7359:7f90:e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 761A720276;
        Mon, 28 Oct 2019 21:34:45 +0000 (UTC)
Date:   Tue, 29 Oct 2019 02:34:45 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-raid@vger.kernel.org
Subject: Re: Cannot fix Current_Pending_Sector even after check and repair
Message-ID: <20191029023445.15022961@natsu>
In-Reply-To: <20191028202732.GV15771@merlins.org>
References: <20191028202732.GV15771@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, 28 Oct 2019 13:27:32 -0700
Marc MERLIN <marc@merlins.org> wrote:

> Out of desperation, I ran hdrecover /dev/sdx on all my drives. It reads the
> whole drive block by block, allowing to re-read a block many times to try
> and rescue data from it, or just re-write it with 0's.
> That one again, ran fine, no error.

It is weird that this succeeds, usually a "pending sector" means it's
unreadable until overwritten.

One possibility is that your RAID card either sets up a HPA at the end of each
drive to store metadata there, or just presents them as somewhat smaller than
their actual size to the OS. If the pending sectors happen to be in that
walled off area, then no wonder that no OS tools can get to them.

See `hdparm -N`, or if possible compare `blockdev --getsize64` with the same
model drives which are not connected via a RAID controller.

-- 
With respect,
Roman
