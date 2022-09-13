Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555CB5B6B9C
	for <lists+linux-raid@lfdr.de>; Tue, 13 Sep 2022 12:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiIMK2c (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 13 Sep 2022 06:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiIMK2W (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 13 Sep 2022 06:28:22 -0400
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2A45A15C
        for <linux-raid@vger.kernel.org>; Tue, 13 Sep 2022 03:28:21 -0700 (PDT)
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4MRfnH1dqzzXLW;
        Tue, 13 Sep 2022 12:28:19 +0200 (CEST)
Message-ID: <05a1161b-d798-c68f-d37c-a9fc373c6e73@thelounge.net>
Date:   Tue, 13 Sep 2022 12:28:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: change UUID of RAID devcies
Content-Language: en-US
To:     Wol <antlists@youngman.org.uk>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
References: <2341a2a9-b86e-f0e5-784a-05dbd474dec5@thelounge.net>
 <729bdc01-b0ae-887a-6d2a-5135d287636c@youngman.org.uk>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
In-Reply-To: <729bdc01-b0ae-887a-6d2a-5135d287636c@youngman.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 12.09.22 um 23:37 schrieb Wol:
> On 12/09/2022 16:04, Reindl Harald wrote:
>> the reason for that game is that the machines are running for 10 years 
>> now and all the new desktop hardware can't hold 4x3.5" disks and so 
>> just put them in a new one isn't possible
> 
> How many SATA ports does the mobo have? Can you --replace onto the new 
> drives (especially if it's raid-10!), then just fail the remaining two 
> drives?
> 
> Iirc raid-10 doesn't require the drives to be the same size, so provided 
> the two new drives are big enough, that should just work.
> 
> Then with just two drives you change the raid to raid-1

i had this idea also and the drives have 3 partitions in that order, two 
machines 4x1TB and two machines 4x2TB

/boot is a RAID1, the other two RAIDS are RAID10

/dev/md0       ext4  482M     77M  401M   17% /boot
/dev/md1       ext4   29G    8,9G   20G   31% /
/dev/md2       ext4  3,6T    2,0T  1,7T   55% /data

/dev/md0       ext4  474M     45M  426M   10% /boot
/dev/md1       ext4   39G     22G   17G   58% /
/dev/md2       ext4  1,8T    1,1T  699G   61% /data

when i understand you correctly:

* replace two disks with double sized SSD's
* partition / and /data double sized
* "mdadm /dev/md1 --add /dev/sdcX" the double sized
* wait resync
* finally remove the two old half sized
* reshape md1 and md2 to RAID1

how would the command look for "Then with just two drives you change the 
raid to raid-1"?

----------

BTW: currently the machines are BIOS-boot - am i right that the 2 TB 
limitation only requires that the parts which are needed for booting are 
on the first 2 TB and i can use 4 TB SSD's on the two bigger machines?

in that case i think i would need GPT partitioning and does GRUB2 
support booting from GPT-partitioned disks in BIOS-mode?





