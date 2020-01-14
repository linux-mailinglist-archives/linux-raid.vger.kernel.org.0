Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C52D913B01C
	for <lists+linux-raid@lfdr.de>; Tue, 14 Jan 2020 17:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgANQ4q (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jan 2020 11:56:46 -0500
Received: from atl.turmel.org ([74.117.157.138]:53321 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgANQ4q (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 Jan 2020 11:56:46 -0500
X-Greylist: delayed 977 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jan 2020 11:56:46 EST
Received: from [98.192.104.236] (helo=[192.168.19.61])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1irPEw-0004Y9-9j; Tue, 14 Jan 2020 11:40:26 -0500
Subject: Re: Reassembling Raid5 in degraded state
To:     Christian Deufel <christian.deufel@inview.de>,
        linux-raid <linux-raid@vger.kernel.org>,
        Wols Lists <antlists@youngman.org.uk>
References: <13b11d17-a23a-3063-70cb-de63d9fa7d09@inview.de>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <a34d1a67-1d10-60fe-5922-42d27ce8dc6c@turmel.org>
Date:   Tue, 14 Jan 2020 11:40:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <13b11d17-a23a-3063-70cb-de63d9fa7d09@inview.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 1/14/20 6:28 AM, Christian Deufel wrote:
> Hey Wol
> 
>  > My plan now would be to run mdadm --assemble --force /dev/md3 with 3
>  > disk, to get the Raid going in a degraded state.
> 
>  >Yup, this would almost certainly work. I would recommend overlays and
>  >running a fsck just to check it's all okay before actually doing it on
>  >the actual disks. The event counts say to me that you'll probably lose
>  >little to nothing.
> 
> So as I was trying to reassemble my Raid it crashed again. But this time 
> sdc vanished.

I've experienced the problem of various disks disappearing when you 
attempt to use them.  It has always been some kind of power supply 
problem in my cases.

Consider relocating these drives to another box to continue your 
recovery efforts.

Phil
