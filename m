Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7401DC83D
	for <lists+linux-raid@lfdr.de>; Thu, 21 May 2020 10:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgEUIJq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 May 2020 04:09:46 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:38745 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbgEUIJq (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 21 May 2020 04:09:46 -0400
Received: from [81.154.111.47] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jbgGu-0001YR-As; Thu, 21 May 2020 09:09:44 +0100
Subject: Re: failed disks, mapper, and "Invalid argument"
To:     David T-G <davidtg-robot@justpickone.org>,
        Linux RAID list <linux-raid@vger.kernel.org>
References: <20200520200514.GE1415@justpickone.org>
 <5EC5BBEF.7070002@youngman.org.uk> <20200520235347.GF1415@justpickone.org>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Cc:     Phil Turmel <philip@turmel.org>
Message-ID: <5EC63745.1080602@youngman.org.uk>
Date:   Thu, 21 May 2020 09:09:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20200520235347.GF1415@justpickone.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 21/05/20 00:53, David T-G wrote:
>   ## parted
>   Model: ATA ST4000DM000-1F21 (scsi)
>   Disk /dev/sdd: 4001GB
>   ## Version
>   Firmware Version: CC54
>   ATA Version is:   ACS-2, ACS-3 T13/2161-D revision 3b
>   SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 3.0 Gb/s)
>   SCT capabilities:              (0x1085) SCT Status supported.
>   SMART Error Log Version: 1
>   ## scterc
>   SCT Error Recovery Control command not supported
> 
> Curiously, note that querying just scterc as the wiki instructs says "not
> supported", but a general smartctl query says yes.  I'm not sure how to
> interpret this...

Seagate Barracudas :-(

As for smartctl, you're asking two different things. Firstly is SCT
supported (yes). Secondly, is the ERC feature supported (no).

And that second question is the killer. Your drives do not support error
recovery. Plan to replace them with ones that do ASAP!

I'm currently running on two 3TB Barracudas mirrored. I've finally got
around to building a system with two 4TB Ironwolves to replace them. You
need to think about the same.

In the meantime, make sure you're running Brad's script, and watch out
for any hint of lengthening read/write times. That's unlikely to be why
your overlay drives won't mount - I suspect a problem with loopback, but
I don't know.

What I don't want to advise, but I strongly suspect will work, is to
force-assemble the two good drives and the nearly-good drive. Because it
has no redundancy it won't scramble your data because it can't do a
rebuild, but I would VERY STRONGLY suggest you download lsdrv and get
the output. The whole point of this script is to get the information you
need so that if everything does go pear shaped, you can rebuild the
metadata from first principles. It's easy - git clone, run.

Cheers,
Wol
