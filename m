Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE1631383A9
	for <lists+linux-raid@lfdr.de>; Sat, 11 Jan 2020 22:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbgAKVZi (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 11 Jan 2020 16:25:38 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:31036 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731382AbgAKVZi (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 11 Jan 2020 16:25:38 -0500
Received: from [81.157.2.11] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iqOGF-0001KJ-5D; Sat, 11 Jan 2020 21:25:35 +0000
Subject: Re: RAID10, 3 copies, 3 disks
To:     Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
References: <CAJH6TXhWd-AGi0_KnbnepxZXsOvpMQGwkisFuuX14dMe157jWw@mail.gmail.com>
 <82a7d9ec-f991-ad25-bf1f-eee74be90b1b@youngman.org.uk>
 <CAJH6TXji3e1Tp8xDDiqfqy36fpMC4kZTLaYj0Le9A6Cyg8EnGg@mail.gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5E1A3D4F.30205@youngman.org.uk>
Date:   Sat, 11 Jan 2020 21:25:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CAJH6TXji3e1Tp8xDDiqfqy36fpMC4kZTLaYj0Le9A6Cyg8EnGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/01/20 20:55, Gandalf Corvotempesta wrote:
> Il giorno sab 11 gen 2020 alle ore 20:11 Wol
> <antlists@youngman.org.uk> ha scritto:
>> The "standard" as you call it is actually RAID1+0. This is *not* "linux
>> raid10", which is as you describe it - the number of disks can be any
>> number greater than the number of mirrors.
> 
> Actually, what I need to do is simple: a scalable array with at least
> 3way-mirrors.
> 
> I've thought in using multiple 3way mirrors (RAID1) merged together with LVM or
> just a single RAID10 (with 3 disks mirrors) and LVM on top of it as
> volume manager.
> 
> Don't know which one is better, the result is similar.
> 
Multiple 3-way mirrors (1+0) requires disks in multiples of 3. Raid10
simply requires "4 or more" disks. If you expect/want to expand your
storage in small increments, then 10 is clearly better. BUT.

Depending on your filesystem - for example XFS - changing the disk
layout underneath it can severely impact performance - when the
filesystem is created it queries the layout and optimises for it. When I
discussed it with one of the XFS guys he said "use 1+0 and add a fresh
*set* of disks (or completely recreate the filesystem), because XFS
optimises layout based on what disks it thinks its got."

Cheers,
Wol
