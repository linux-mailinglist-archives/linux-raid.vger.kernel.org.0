Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2971C3807
	for <lists+linux-raid@lfdr.de>; Mon,  4 May 2020 13:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgEDL0j (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 May 2020 07:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDL0j (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 4 May 2020 07:26:39 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19786C061A0E
        for <linux-raid@vger.kernel.org>; Mon,  4 May 2020 04:26:39 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jVZF7-0008Fs-PH; Mon, 04 May 2020 13:26:37 +0200
Subject: Re: RAID 1 | Restore based on Image of /dev/sda
To:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
References: <5e29b897-b2df-c6b9-019a-e037101bfeec@peter-speer.de>
 <5EAFF763.2000906@youngman.org.uk>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Message-ID: <58659d1e-bcce-553c-fe68-52d075422252@peter-speer.de>
Date:   Mon, 4 May 2020 13:26:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5EAFF763.2000906@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1588591599;f962d6a8;
X-HE-SMSGID: 1jVZF7-0008Fs-PH
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 04.05.20 13:07, Wols Lists wrote:
> https://raid.wiki.kernel.org/index.php/Linux_Raid
> 
> Is the drive formatted with one big partition? I guess it is. What it
> really cares about is that the new partition you are adding is identical
> in size to the partition the raid is on.
> 
> There are tools that will copy a partition table for you - BEWARE - a
> lot of things rely on GUIDs and at least the tools I know of don't reset
> them by default - duplicate unique ids are not a good idea :-) So as you
> copied this drive using dd DO NOT put it back in the original computer ...
> 
> https://raid.wiki.kernel.org/index.php/A_guide_to_mdadm#Adding_a_drive_to_a_mirror
> 
> Cheers,
> Wol

Thanks, Wol, especially for the hint with the GUIDs, will keep this in 
mind. If ever using it again - maybe in case of a quick temporary 
replacement in the original computer - I will wipe it with zeros before.

The partition layout will be cloned using sfdisk.

Thanks for the wiki links. I read the wiki before asking but it was not 
clear to me how to do it...

Btw, I will stay with mdadm/lvm/ext4 and not switch to btrfs.

Thanks again,
Steffi
