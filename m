Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3972F527164
	for <lists+linux-raid@lfdr.de>; Sat, 14 May 2022 15:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiENNqn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 14 May 2022 09:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiENNqn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 14 May 2022 09:46:43 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD75C28E15
        for <linux-raid@vger.kernel.org>; Sat, 14 May 2022 06:46:40 -0700 (PDT)
Received: from host86-155-180-61.range86-155.btcentralplus.com ([86.155.180.61] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1nps6Q-000BBf-75;
        Sat, 14 May 2022 14:46:38 +0100
Message-ID: <994cb384-3782-dac2-898b-ea02816a904f@youngman.org.uk>
Date:   Sat, 14 May 2022 14:46:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: failed sector detected but disk still active ?
Content-Language: en-GB
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
References: <CAJH6TXh7cVHa+G1DaJwWSvgDaCOrYLP_Ppau8q6pk1V4dS3D_Q@mail.gmail.com>
 <Yn6BEym8s0kVLhD0@lazy.lzy>
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <Yn6BEym8s0kVLhD0@lazy.lzy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 13/05/2022 17:02, Piergiorgio Sartor wrote:
>> [Mon May  2 03:36:25 2022] Add. Sense: Unrecovered read error
>> [Mon May  2 03:36:25 2022] sd 0:0:2:0: [sdc] CDB:
>> [Mon May  2 03:36:25 2022] Read(10): 28 00 10 56 55 80 00 04 00 00
>> [Mon May  2 03:36:25 2022] end_request: critical medium error, dev
>> sdc, sector 274093444
>> [Mon May  2 04:06:32 2022] md: md0: data-check done.
> The error is reported from the device.
> 
> As far as I know, and please someone correct
> me if I'm wrong, when a device has an error,
> "md" tries to re-write the data, using the
> redundancy, and, if no error occurs, it just
> continues, no reason to kick the device our
> of the array.

Correct. If the underlying disk returns an error, raid recovery kicks 
in. The missing block is calculated, returned to the caller and written 
back to the disk.

There's a whole bunch of reasons how/why this can occur. If it's a 
transient failure and the re-write succeeds perfectly, everything is 
normally hunky-dory.

There could be a problem with the drive, the drive re-locates the dodgy 
sector, and everything APPEARS hunky-dory.

Or the rewrite fails, raid assumes the drive is faulty and kicks it out. 
That's why you should never use desktop drives unless you know EXACTLY 
what you are doing!

The error message is "critical medium error" - we have a real problem 
with the disk I suspect.

FIRST run SMART on the disk and see what that reports. If that's not 
happy, REPLACE THE DRIVE PRONTO.

If SMART is happy, run a raid scrub.

And whatever, if you haven't replaced the drive, start monitoring SMART. 
If disk errors start climbing, that's a cause for concern and replacing 
the drive.

Cheers,
Wol
