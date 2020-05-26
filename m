Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564D31E1F75
	for <lists+linux-raid@lfdr.de>; Tue, 26 May 2020 12:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbgEZKOq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 26 May 2020 06:14:46 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:12689 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgEZKOp (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 26 May 2020 06:14:45 -0400
Received: from [81.154.111.47] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jdWba-000AMe-FL; Tue, 26 May 2020 11:14:43 +0100
Subject: Re: mdadm failed to create internal bitmap
To:     Jonas Fisher <fisherthepooh@protonmail.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
References: <46XMI93tZHsxcOEfRj7cEIl272c4YrZUfsGBCr904ogr3xj8zPNdBaJdDWZBnahFIVVpLhDKWE0zc4_6JsBXWMu2mkiK63MUzuM6_ND7CpE=@protonmail.com>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <4313d92c-8657-d2d7-0ddc-f91e211cf1bf@youngman.org.uk>
Date:   Tue, 26 May 2020 11:14:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <46XMI93tZHsxcOEfRj7cEIl272c4YrZUfsGBCr904ogr3xj8zPNdBaJdDWZBnahFIVVpLhDKWE0zc4_6JsBXWMu2mkiK63MUzuM6_ND7CpE=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 26/05/2020 04:40, Jonas Fisher wrote:
> Hi all,
> 
> I got a raid1 composed with 2 disks
> /dev/sda -- 2T
> /dev/sdb -- 4T
> 
> mdadm version is 3.3 and md metadata version is 1.0

That's a well ancient mdadm, you need to upgrade ...
> 
> At first, I was only using 1T of the each disk,
> 
> then I grew the array recently with the command
> 
> mdadm --grow /dev/md1 --size=1951944704K
> 
> I also tried to add the internal bitmap after expansion finished
> 
> mdadm --grow /dev/md1 --bitmap=internal
> 
> But I got the following message
> 
> mdadm: failed to create internal bitmap - chunksize problem.
> 
> I found that Avail Dev Size in superblock examine of two disks
> 
> are the same, same as the value I set when I expanded the array (1951944704K).

Makes sense, it's a mirror ...
> 
> Then I found that in mdadm bitmap chunksize calculation,
> 
> in function add_internal_bitmap1 (super1.c)
> 
> variable "room" and and "max_bits" seems to be overflowed under this situation

Could well be fault of the old mdadm ...
> 
> 
> I was wondering is this because mdadm set the size of the rdevs in the array
> 
> before doing expansion (in function Grow_reshape)
> 
> that caused the sb->data_size not equals to actual raw device size
> 
> and consequently led to bitmap chunksize calculation error
> 
> or it is simply a data type issue.
> 
> Thanks,
> 
Download and run a new mdadm. If the problem still persists, then I 
guess the mdadm guys will take a look.

https://raid.wiki.kernel.org/index.php/Linux_Raid

https://raid.wiki.kernel.org/index.php/A_guide_to_mdadm#Getting_mdadm

It seems odd to be mirroring a 2TB and 4TB, but never mind. It's not 
(that much) a problem if you're using desktop drives for a mirror, but 
if you do get a new 4TB drive, read the advice on the website and make 
sure you get a proper raid drive.

Cheers,
Wol
