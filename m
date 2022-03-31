Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652614EDF5B
	for <lists+linux-raid@lfdr.de>; Thu, 31 Mar 2022 19:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiCaRIp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 31 Mar 2022 13:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbiCaRIo (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 31 Mar 2022 13:08:44 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DB61EC9A2
        for <linux-raid@vger.kernel.org>; Thu, 31 Mar 2022 10:06:56 -0700 (PDT)
Received: from host86-155-180-61.range86-155.btcentralplus.com ([86.155.180.61] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1nZyG6-00031L-4Y;
        Thu, 31 Mar 2022 18:06:54 +0100
Message-ID: <e3573002-05f3-3110-62a6-e704385f877f@youngman.org.uk>
Date:   Thu, 31 Mar 2022 18:06:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Trying to rescue a RAID-1 array
Content-Language: en-GB
To:     bruce.korb+reply@gmail.com, linux-raid@vger.kernel.org
References: <CAKRnqN+_=U58dT5bvgWJ1DgyEuhjsbmCuDL+xOLxmcuG1ML4qg@mail.gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <CAKRnqN+_=U58dT5bvgWJ1DgyEuhjsbmCuDL+xOLxmcuG1ML4qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 31/03/2022 17:44, Bruce Korb wrote:
> I moved the two disks from a cleanly shut down system that could not
> reboot and could not
> be upgraded to a new OS release. So, I put them in.a new box and did an install.
> The installation recognized them as a RAID and decided that the
> partitions needed a
> new superblock of type RAID-0.

That's worrying, did it really write a superblock?

> Since these data have never been
> remounted since the
> shutdown on the original machine, I am hoping I can change the RAID
> type and mount it
> so as to recover my. .ssh and .thunderbird (email) directories. The
> bulk of the data are
> backed up (assuming no issues with the full backup of my critical
> data), but rebuilding
> and redistributing the .ssh directory would be a particular nuisance.
> 
> SO: what are my options? I can't find any advice on how to tell mdadm
> that the RAID-0 partitions
> really are RAID-1 partitions. Last gasp might be to "mdadm --create"
> the RAID-1 again, but there's
> a lot of advice out there saying that it really is the last gasp
> before giving up. :)
> 

https://raid.wiki.kernel.org/index.php/Asking_for_help

Especially lsdrv. That tells us a LOT about your system.

What was the filesystem on your raid? Hopefully it's as simple as moving 
the "start of partition", breaking the raid completely, and you can just 
mount the filesystem.

What really worries me is how and why it both recognised it as a raid, 
then thought it needed to be converted to raid-0. That just sounds wrong 
on so many levels. Did you let it mess with your superblocks? I hope you 
said "don't touch those drives"?

Cheers,
Wol
