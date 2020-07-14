Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2012200CE
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 00:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGNWya (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jul 2020 18:54:30 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:16244 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbgGNWy3 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 Jul 2020 18:54:29 -0400
Received: from host86-157-102-29.range86-157.btcentralplus.com ([86.157.102.29] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jvToh-0007Kz-52; Tue, 14 Jul 2020 23:54:27 +0100
Subject: Re: Reshape using drives not partitions, RAID gone after reboot
To:     Adam Barnett <adamtravisbarnett@gmail.com>,
        linux-raid@vger.kernel.org
References: <b551920e-ddad-c627-d75a-e99d32247b6d@gmail.com>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <0b857b5f-20aa-871d-a22d-43d26ad64764@youngman.org.uk>
Date:   Tue, 14 Jul 2020 23:54:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b551920e-ddad-c627-d75a-e99d32247b6d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14/07/2020 20:50, Adam Barnett wrote:
> Forcing the assembly does not work:
> 
> $ sudo mdadm /dev/md1 --assemble --force /dev/sd[ijmop]1 /dev/sd[kln]
> mdadm: /dev/sdi1 is busy - skipping
> mdadm: /dev/sdj1 is busy - skipping
> mdadm: /dev/sdm1 is busy - skipping
> mdadm: /dev/sdo1 is busy - skipping
> mdadm: /dev/sdp1 is busy - skipping
> mdadm: Cannot assemble mbr metadata on /dev/sdk
> mdadm: /dev/sdk has no superblock - assembly aborted

Did you do an "mdadm --stop /dev/md1" before trying that? That's a 
classic error from an array that's previously been partially assembled 
and failed ...

The other thing I'd do is make sure there aren't any other unepected 
partially assembled arrays. I doubt it applies here, but I have come 
across mirrors that get broken in half and you get two failed arrays 
instead of one working one ...

Cheers,
Wol
