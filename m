Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9801205358
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jun 2020 15:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbgFWNZE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Jun 2020 09:25:04 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:60076 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732594AbgFWNZD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 23 Jun 2020 09:25:03 -0400
X-Greylist: delayed 3499 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jun 2020 09:25:03 EDT
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.15.2/8.15.2) with ESMTP id 05NCQXrs000905;
        Tue, 23 Jun 2020 13:26:33 +0100
From:   Nix <nix@esperi.org.uk>
To:     "John Stoffel" <john@stoffel.org>
Cc:     Ian Pilcher <arequipeno@gmail.com>, linux-raid@vger.kernel.org
Subject: Re: RAID types & chunks sizes for new NAS drives
References: <rco1i8$1l34$1@ciao.gmane.io>
        <24305.24232.459249.386799@quad.stoffel.home>
Emacs:  an inspiring example of form following function... to Hell.
Date:   Tue, 23 Jun 2020 13:26:33 +0100
In-Reply-To: <24305.24232.459249.386799@quad.stoffel.home> (John Stoffel's
        message of "Mon, 22 Jun 2020 21:45:12 -0400")
Message-ID: <875zbi3r46.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC-wuwien-Metrics: loom 1290; Body=3 Fuz1=3 Fuz2=3
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 23 Jun 2020, John Stoffel told this:

> You also don't say how *big* your disks will be, and if your 5 bay NAS
> box can even split like that, and if it has the CPU to handle that.
> Is it an NFS connection to the rest of your systems?

Side note: NFSv4 really is much much better at this stuff than v3 ever
was. With a fast enough network connection, I find NFSv4 as fast for
more or less all workloads as NFSv3 was, mostly because of the lease
support in v4 allowing client-side caching of the vast majority of files
and directories that are either not written to or only written to by one
client in a given short time window. (Obviously it also helps if your
network is fast enough: 1GbE is going to be saturated many times over by
a RAID array of any but the slowest modern HDDs. 10GbE and small
10GbE-capable switches are not very costly these days and is definitely
worth investing in on the NFS server and any clients you care about.)
