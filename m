Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB14205B22
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jun 2020 20:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733188AbgFWSu2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Jun 2020 14:50:28 -0400
Received: from li1843-175.members.linode.com ([172.104.24.175]:37508 "EHLO
        mail.stoffel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733075AbgFWSu1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 23 Jun 2020 14:50:27 -0400
Received: from quad.stoffel.org (066-189-075-104.res.spectrum.com [66.189.75.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id DF9E924904;
        Tue, 23 Jun 2020 14:50:26 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 52595A64AE; Tue, 23 Jun 2020 14:50:26 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24306.20210.265626.431196@quad.stoffel.home>
Date:   Tue, 23 Jun 2020 14:50:26 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Nix <nix@esperi.org.uk>
Cc:     "John Stoffel" <john@stoffel.org>,
        Ian Pilcher <arequipeno@gmail.com>, linux-raid@vger.kernel.org
Subject: Re: RAID types & chunks sizes for new NAS drives
In-Reply-To: <875zbi3r46.fsf@esperi.org.uk>
References: <rco1i8$1l34$1@ciao.gmane.io>
        <24305.24232.459249.386799@quad.stoffel.home>
        <875zbi3r46.fsf@esperi.org.uk>
X-Mailer: VM 8.2.0b under 26.1 (x86_64-pc-linux-gnu)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>>>>> "Nix" == Nix  <nix@esperi.org.uk> writes:

Nix> On 23 Jun 2020, John Stoffel told this:
>> You also don't say how *big* your disks will be, and if your 5 bay NAS
>> box can even split like that, and if it has the CPU to handle that.
>> Is it an NFS connection to the rest of your systems?

Nix> Side note: NFSv4 really is much much better at this stuff than v3
Nix> ever was. With a fast enough network connection, I find NFSv4 as
Nix> fast for more or less all workloads as NFSv3 was, mostly because
Nix> of the lease support in v4 allowing client-side caching of the
Nix> vast majority of files and directories that are either not
Nix> written to or only written to by one client in a given short time
Nix> window. (Obviously it also helps if your network is fast enough:
Nix> 1GbE is going to be saturated many times over by a RAID array of
Nix> any but the slowest modern HDDs. 10GbE and small 10GbE-capable
Nix> switches are not very costly these days and is definitely worth
Nix> investing in on the NFS server and any clients you care about.)

I've been thinking about moving to NFSv4 at home, since my main file
server has my main desktop as an NFS and LDAP client for
authentication.  Works quite well, and I don't care if my dekstop
reboots on my, since the homedir is elsewhere.

John
