Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7D01C9C82
	for <lists+linux-raid@lfdr.de>; Thu,  7 May 2020 22:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgEGUgk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 May 2020 16:36:40 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:43951 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgEGUgk (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 7 May 2020 16:36:40 -0400
Received: from [81.153.126.158] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jWnG3-000BjH-8l; Thu, 07 May 2020 21:36:39 +0100
Subject: Re: "mdadm -n": component device selection when delta_disks<0
To:     David F <raid@meta-dynamic.com>, linux-raid@vger.kernel.org
References: <20200507193636.5B4FE53E95@mail.meta-dynamic.com>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5EB47156.9050902@youngman.org.uk>
Date:   Thu, 7 May 2020 21:36:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20200507193636.5B4FE53E95@mail.meta-dynamic.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 07/05/20 20:36, David F wrote:
> I'm planning to use use three mdadm commands to accomplish the
> reshape, as follows:
> 
> mdadm --grow --size=6000G --assume-clean /dev/md0
> mdadm --grow --array-size=12000G /dev/md0
> mdadm --grow --raid-devices=3 --backup-file=/root/md-backup /dev/md0
> 
> 
> Ideally, I'd prefer a single command,
> mdadm --grow --size=6000G --raid-devices=3 /dev/md0
> ... but that seems not possible [1].
> 
> 
> In either case, my question still applies: when reshaping to
> reduce the number of devices in the array (--raid-devices), is
> there any way to specify exactly which device(s) are to be
> removed from active sync (I suppose they become spares) and which
> ones kept? 

You should be able to stick --remove /dev/sdX on the command line ...

BUT. Before you start, what version of mdadm are you running? The
latest? What version of linux? An old LTS with a heavily patched
frankenkernel? You really want to be running both a recent kernel and
recent mdadm.

The other point, if you don't need --backup, DON'T USE IT. It doesn't do
any real harm provided you use it right, but it shouldn't be necessary
and it causes needless confusion and trouble.

Cheers,
Wol
