Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6860024E6B8
	for <lists+linux-raid@lfdr.de>; Sat, 22 Aug 2020 11:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgHVJio (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 22 Aug 2020 05:38:44 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:60122 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgHVJio (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 22 Aug 2020 05:38:44 -0400
Received: from host86-157-102-164.range86-157.btcentralplus.com ([86.157.102.164] helo=[192.168.1.64])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1k9Pyz-0001Ek-59; Sat, 22 Aug 2020 10:38:41 +0100
Subject: Re: Recommended filesystem for RAID 6
To:     Peter Grandi <pg@mdraid.list.sabi.co.UK>,
        list Linux RAID <linux-raid@vger.kernel.org>
References: <CAF-KpgYcEF5juR9nFPifZunPPGW73kWVG9fjR3=WpufxXJcewg@mail.gmail.com>
 <1381759926.21710099.1597158389614.JavaMail.zimbra@karlsbakk.net>
 <4a7bfca8-af6e-cbd1-0dc4-feaf1a0288be@fritscher.net>
 <5F32F56C.7040603@youngman.org.uk>
 <05661c44-8193-6bba-67c9-4e0d220eb348@suddenlinkmail.com>
 <24384.51317.30569.169686@cyme.ty.sabi.co.uk>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5F40E7A0.8040802@youngman.org.uk>
Date:   Sat, 22 Aug 2020 10:38:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <24384.51317.30569.169686@cyme.ty.sabi.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 22/08/20 08:25, Peter Grandi wrote:
>>> [...] Note that it IS a shingled drive, so fine for backup,
>>> >> much less so for anything else.
> It is fine for backup especially if used as a tape that is say
> divided into partitions and backup is done using 'dd' (but
> careful if using Btrfs) or 'tar' or similar. If using 'rsync' or
> similar those still write a lot of inodes and often small files
> if they are present in the source.
> 
The idea is an "in place" rsync, with lvm or btrfs or something
providing snapshots.

That way, I have full backups each of which only takes up the marginal
space required by an incremental :-)

Cheers,
Wol
