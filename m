Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76B05B6C64
	for <lists+linux-raid@lfdr.de>; Tue, 13 Sep 2022 13:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiIMLag (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 13 Sep 2022 07:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiIMLad (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 13 Sep 2022 07:30:33 -0400
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C110564E3
        for <linux-raid@vger.kernel.org>; Tue, 13 Sep 2022 04:30:32 -0700 (PDT)
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4MRh924yLlzXLW;
        Tue, 13 Sep 2022 13:30:30 +0200 (CEST)
Message-ID: <9e537739-2fbd-2c99-8191-54faf0a69a8b@thelounge.net>
Date:   Tue, 13 Sep 2022 13:30:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: change UUID of RAID devcies
Content-Language: en-US
To:     Pascal Hambourg <pascal@plouf.fr.eu.org>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
References: <2341a2a9-b86e-f0e5-784a-05dbd474dec5@thelounge.net>
 <729bdc01-b0ae-887a-6d2a-5135d287636c@youngman.org.uk>
 <05a1161b-d798-c68f-d37c-a9fc373c6e73@thelounge.net>
 <0023fefe-aad1-e692-48dd-e354497f6e41@plouf.fr.eu.org>
 <1fb05e0f-34b7-3ec4-bc00-ec540e592f19@thelounge.net>
 <3fc0b889-3ef9-652e-6452-2eeede918683@plouf.fr.eu.org>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
In-Reply-To: <3fc0b889-3ef9-652e-6452-2eeede918683@plouf.fr.eu.org>
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



Am 13.09.22 um 13:17 schrieb Pascal Hambourg:
> On 13/09/2022 at 13:12, Reindl Harald wrote:
>>
>> Am 13.09.22 um 12:39 schrieb Pascal Hambourg:
>>> On 13/09/2022 at 12:28, Reindl Harald wrote:
>>>>
>>>> BTW: currently the machines are BIOS-boot - am i right that the 2 TB 
>>>> limitation only requires that the parts which are needed for booting 
>>>> are on the first 2 TB and i can use 4 TB SSD's on the two bigger 
>>>> machines?
>>>
>>> Which 2 TB limitation ? EDD BIOS calls use 64-bit LBA and should not 
>>> have any practical limitation unless the BIOS implementation is flawed.
> (...)
>> "For example, you cannot create 3TB or 4TB partition size (RAID based) 
>> using the fdisk command. It will not allow you to create a partition 
>> that is greater than 2TB" makes me nervous
> 
> This is a DOS/MBR partition scheme limitation, not a BIOS limitation, 
> and irrelevant with GPT partition scheme.
> 
>> how to get a > 3 TB partition for /dev/md2
> 
> Use GPT

yeah but the goal is to convert a existing RAID1/RAID10/RAID10 setup 
with 4x2 TB drives to RAID1/RAID1/RAID1 with 2x4 Tb drives and so my 
/boot won't work with GPT :-)

the two smaller machines are easier because of finally 2 TB drives - i 
really think loudly about a USB stick for /boot with regular dd-images 
and leave the existing RAID1 /boot ignored

[root@srv-rhsoft:~]$ df
Filesystem     Type  Size  Used Avail Use% Mounted on
/dev/md0       ext4  482M   77M  401M  17% /boot
/dev/md1       ext4   29G  8.9G   20G  31% /
/dev/md2       ext4  3.6T  2.0T  1.7T  55% /data
