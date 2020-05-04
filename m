Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29231C37FE
	for <lists+linux-raid@lfdr.de>; Mon,  4 May 2020 13:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgEDLXz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 May 2020 07:23:55 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:27663 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgEDLXz (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 4 May 2020 07:23:55 -0400
Received: from [81.153.126.158] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jVYwO-000BKv-9o; Mon, 04 May 2020 12:07:16 +0100
Subject: Re: RAID 1 | Restore based on Image of /dev/sda
To:     Stefanie Leisestreichler 
        <stefanie.leisestreichler@peter-speer.de>,
        linux-raid@vger.kernel.org
References: <5e29b897-b2df-c6b9-019a-e037101bfeec@peter-speer.de>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5EAFF763.2000906@youngman.org.uk>
Date:   Mon, 4 May 2020 12:07:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <5e29b897-b2df-c6b9-019a-e037101bfeec@peter-speer.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 04/05/20 11:48, Stefanie Leisestreichler wrote:
> Hi.
> I have a running RAID 1 based on /dev/sda1 and /dev/sda2 with
> metadata=1.2 with mdadm version 3.2.5.
> 
> I took an image of /dev/sda using dd.
> There is a computer with identical hardware (test-env) where I put in
> this image. When I start this computer, it is booting and recognizing
> the raid active as md0 with state [2/1] [U_] like expected.
> 
> My target is to restore the raid using another new and blank hard disk
> in the test-env computer. I know I have to format the new disk
> identically to the format the image is providing, but I am unsure about
> how to add the new disk to the raid array.
> 
> Could you please guide me?
> 
https://raid.wiki.kernel.org/index.php/Linux_Raid

Is the drive formatted with one big partition? I guess it is. What it
really cares about is that the new partition you are adding is identical
in size to the partition the raid is on.

There are tools that will copy a partition table for you - BEWARE - a
lot of things rely on GUIDs and at least the tools I know of don't reset
them by default - duplicate unique ids are not a good idea :-) So as you
copied this drive using dd DO NOT put it back in the original computer ...

https://raid.wiki.kernel.org/index.php/A_guide_to_mdadm#Adding_a_drive_to_a_mirror

Cheers,
Wol
