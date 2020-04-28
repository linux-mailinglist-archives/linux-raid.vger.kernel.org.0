Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B327B1BC014
	for <lists+linux-raid@lfdr.de>; Tue, 28 Apr 2020 15:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgD1NrY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Apr 2020 09:47:24 -0400
Received: from atl.turmel.org ([74.117.157.138]:40466 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgD1NrY (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 28 Apr 2020 09:47:24 -0400
Received: from [98.192.104.236] (helo=[192.168.19.61])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1jTQa2-0000xp-Qh; Tue, 28 Apr 2020 09:47:22 -0400
Subject: Re: Does a "check" of a RAID6 actually read all disks in a stripe?
To:     Brad Campbell <lists2009@fnarfbargle.com>,
        linux-raid@vger.kernel.org
References: <18271293-9866-1381-d73e-e351bf9278fd@fnarfbargle.com>
 <1ccd57ba-9d9a-d10e-4efd-dc0e8a5cf162@fnarfbargle.com>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <e02412eb-d7f3-cea8-7398-4e5c0d749f43@turmel.org>
Date:   Tue, 28 Apr 2020 09:47:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1ccd57ba-9d9a-d10e-4efd-dc0e8a5cf162@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/28/20 7:02 AM, Brad Campbell wrote:
> 
> 
> On 28/4/20 2:47 pm, Brad Campbell wrote:
>> G'day all,
>>
>> I have a test server with some old disks I use for beating up on. Bear 
>> in mind the disks are old and dicey which is *why* they live in a test 
>> server. I'm not after reliability, I'm more interested in finding 
>> corner cases.
>>
>> One disk has a persistent read error (pending sector). This can be 
>> identified easily with dd on a specific or whole disk basis.

[trim /]

>> Examine on the suspect disk :
>>
>> test:/home/brad# mdadm --examine /dev/sdj
>> /dev/sdj:
>>            Magic : a92b4efc
>>          Version : 1.2
>>      Feature Map : 0x1
>>       Array UUID : dbbca7b5:327751b1:895f8f11:443f6ecb
>>             Name : test:3  (local to host test)
>>    Creation Time : Wed Nov 29 10:46:21 2017
>>       Raid Level : raid6
>>     Raid Devices : 9
>>
>>   Avail Dev Size : 3906767024 (1862.89 GiB 2000.26 GB)
>>       Array Size : 13673684416 (13040.24 GiB 14001.85 GB)
>>    Used Dev Size : 3906766976 (1862.89 GiB 2000.26 GB)
>>      Data Offset : 262144 sectors
>>     Super Offset : 8 sectors
>>     Unused Space : before=262056 sectors, after=48 sectors
>>            State : clean
>>      Device UUID : f1a39d9b:fe217c62:26b065e3:0f859afd
>>
>> Internal Bitmap : 8 sectors from superblock
>>      Update Time : Tue Apr 28 09:39:23 2020
>>    Bad Block Log : 512 entries available at offset 72 sectors

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

>>         Checksum : cb44256b - correct
>>           Events : 177156
>>
>>           Layout : left-symmetric
>>       Chunk Size : 64K
>>
>>     Device Role : Active device 5
>>     Array State : AA.AAAAAA ('A' == active, '.' == missing, 'R' == 
>> replacing)

The bad block log misfeature is turned on.  Any blocks recorded in it 
will never be read again by MD, last I looked.  This might explain what 
you are seeing.

> This would imply that a RAID "check" scrub does not actually read every 
> block on every stripe of a RAID6, and thus has the potential to miss a 
> dodgy sector under the wrong circumstances. When I get a minute, I'll 
> try and put some test scenarios together with hdparm to create bad 
> blocks and try to characterize the issue further.
> 
> Regards,
> Brad

Regards,

Phil
