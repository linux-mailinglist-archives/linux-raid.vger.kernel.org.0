Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0F31DC84A
	for <lists+linux-raid@lfdr.de>; Thu, 21 May 2020 10:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgEUINQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 May 2020 04:13:16 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:63289 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgEUINP (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 21 May 2020 04:13:15 -0400
Received: from [81.154.111.47] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jbgKI-00039l-Ag; Thu, 21 May 2020 09:13:14 +0100
Subject: Re: failed disks, mapper, and "Invalid argument"
To:     David T-G <davidtg-robot@justpickone.org>,
        Linux RAID list <linux-raid@vger.kernel.org>
References: <20200520200514.GE1415@justpickone.org>
 <5EC5BBEF.7070002@youngman.org.uk> <20200520235347.GF1415@justpickone.org>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5EC63819.5010508@youngman.org.uk>
Date:   Thu, 21 May 2020 09:13:13 +0100
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
>   diskfarm:root:13:/mnt/scratch/disks> mdadm --assemble --force /dev/md0 --verbose /dev/sda1 /dev/sdb1 /dev/sdc1
>   mdadm: looking for devices for /dev/md0
>   mdadm: /dev/sda1 is busy - skipping
>   mdadm: /dev/sdb1 is busy - skipping
>   mdadm: /dev/sdc1 is busy - skipping
> 
> like the overlay is keeping me from the raw devices, so I'd have to tear
> down all of that to try the real thing.  I'll h old off on that...

Did you do an mdadm --stop before trying the force assemble? That
implies to me you've got the remnants of a previous attempt lying around...

Not sure which command it is - "cat /proc/mdstat" maybe, but make sure
ALL your arrays are stopped (unless you know they are running okay)
before you try stuff.

Cheers,
Wol
