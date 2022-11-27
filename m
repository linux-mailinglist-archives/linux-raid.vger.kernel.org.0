Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BFE639A47
	for <lists+linux-raid@lfdr.de>; Sun, 27 Nov 2022 12:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiK0Lwg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 27 Nov 2022 06:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiK0Lwg (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 27 Nov 2022 06:52:36 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD42AB2D
        for <linux-raid@vger.kernel.org>; Sun, 27 Nov 2022 03:52:32 -0800 (PST)
Received: from host86-138-24-20.range86-138.btcentralplus.com ([86.138.24.20] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1ozGD1-0006qH-9i;
        Sun, 27 Nov 2022 11:52:31 +0000
Message-ID: <62b72b4e-8461-e616-1227-4dcef8853143@youngman.org.uk>
Date:   Sun, 27 Nov 2022 11:52:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: how do i fix these RAID5 arrays?
Content-Language: en-GB
To:     Reindl Harald <h.reindl@thelounge.net>,
        John Stoffel <john@stoffel.org>
Cc:     David T-G <davidtg-robot@justpickone.org>,
        Linux RAID list <linux-raid@vger.kernel.org>
References: <20221123220736.GD19721@jpo> <20221124032821.628cd042@nvm>
 <20221124211019.GE19721@jpo>
 <f58964da-4ded-61a8-bd6a-e2391557b38a@youngman.org.uk>
 <25474.28874.952381.412636@quad.stoffel.home>
 <fd543697-14a6-0868-82a1-be61790e07f3@thelounge.net>
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <fd543697-14a6-0868-82a1-be61790e07f3@thelounge.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 27/11/2022 11:46, Reindl Harald wrote:
> 
> 
> Am 26.11.22 um 21:02 schrieb John Stoffel:
>> I call it a failure of the layering model.  If you want RAID, use MD.
>> If you want logical volumes, then put LVM on top.  Then put
>> filesystems into logical volumes.
>>
>> So much simpler...
> 
> have you ever replaced a 6 TB drive and waited for the resync of mdadm 
> in the hope in all that hours no other drive goes down?
> 
> when your array is 10% used it's braindead
> when your array is new and empty it's braindead
> 
> ZFS/BTRFS don't neeed to mirror/restore 90% nulls

This is why you have trim. Although I don't know if raid supports that - 
I hope it does I suspect it doesn't.

Cheers,
Wol
