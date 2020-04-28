Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCB61BC172
	for <lists+linux-raid@lfdr.de>; Tue, 28 Apr 2020 16:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgD1Ogo (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Apr 2020 10:36:44 -0400
Received: from atl.turmel.org ([74.117.157.138]:35244 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgD1Ogm (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 28 Apr 2020 10:36:42 -0400
Received: from [98.192.104.236] (helo=[192.168.19.61])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1jTRLl-0001KY-Ew; Tue, 28 Apr 2020 10:36:41 -0400
Subject: Re: Hard Drive Partition Table shows partition larger than drive
To:     Robert Steinmetz <rob@steinmetznet.com>,
        Wols Lists <antlists@youngman.org.uk>,
        linux-raid@vger.kernel.org
References: <6ee9392d-8867-f0b5-193e-17a516bb7e0e@steinmetznet.com>
 <5EA5ED5D.8060006@youngman.org.uk>
 <c3b5d1be-3ee6-303e-63f5-51faf2053f63@steinmetznet.com>
 <991449ea-82e8-8f80-d73c-ad9701cf2d88@turmel.org>
 <c2c0bdf0-ebff-d52f-8f76-9fe3af3d58bb@steinmetznet.com>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <407df0cc-e18c-4ba4-ed37-04282d20c93f@turmel.org>
Date:   Tue, 28 Apr 2020 10:36:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c2c0bdf0-ebff-d52f-8f76-9fe3af3d58bb@steinmetznet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Robert,

On 4/28/20 10:28 AM, Robert Steinmetz wrote:
> On 4/27/20 1:54 PM, Phil Turmel wrote:
>> here is the output of lsdrv for the drive.
>>>
>>> USB [usb-storage] Bus 001 Device 002: ID 152d:2338 JMicron Technology 
>>> Corp. / JMicron USA Technology Corp. JM20337 Hi-Speed USB to SATA & 
>>> PATA Combo Bridge {000000000005}
>>> └scsi 4:0:0:0 TOSHIBA  HDWD110          {585T7P6NS}
>>>   └sdb 931.51g [8:16] Partitioned (dos)
>>                                     ^^^^^
>> There's your answer.  This drive is using a dos partition table, not 
>> GPT.  But there's some info where the GPT would be that is confusing 
>> parted.
>>
>>>    └sdb1 931.51g [8:17] Empty/Unknown
>>
>> As you can see, this partition entry is rational.
>>
>> Try displaying the partition table with fdisk instead of parted.
> 
> Here is what fdisk says:
> 
> Disk /dev/sdb: 931.5 GiB, 1000204886016 bytes, 244190646 sectors
> Units: sectors of 1 * 4096 = 4096 bytes
> Sector size (logical/physical): 4096 bytes / 4096 bytes
> I/O size (minimum/optimal): 4096 bytes / 4096 bytes
> Disklabel type: dos
> Disk identifier: 0x19e6cd02
> 
> Device     Boot Start        End    Sectors  Size Id Type
> /dev/sdb1  *     2048 1953523711 1953521664  7.3T fd Linux raid autodetect
> 
> Note the discrepancy between the disk size and the partition size.

fdisk is multiplying the sectors in the dos partition table by 4096 
instead of 512.  DOS partition tables always presume 512-byte sectors. 
Looks like a bug in fdisk.

> It seems the end sector for partition /dev/sdb1 is incorrect and should 
> be 244190646 or 244190645 depending on how sectors are numberd that is 
> if there is a sector 0 or it starts at 1.

The "end" sector of a partition is the last address within the 
partition.  One less than what would be the start of the next partition.

Phil
