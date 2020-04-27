Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B461BABB9
	for <lists+linux-raid@lfdr.de>; Mon, 27 Apr 2020 19:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgD0Rya (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 Apr 2020 13:54:30 -0400
Received: from atl.turmel.org ([74.117.157.138]:54594 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgD0Ry3 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 27 Apr 2020 13:54:29 -0400
Received: from [98.192.104.236] (helo=[192.168.19.61])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1jT7xc-0007Bs-Du; Mon, 27 Apr 2020 13:54:28 -0400
Subject: Re: Hard Drive Partition Table shows partition larger than drive
To:     Robert Steinmetz <rob@steinmetznet.com>,
        Wols Lists <antlists@youngman.org.uk>,
        linux-raid@vger.kernel.org
References: <6ee9392d-8867-f0b5-193e-17a516bb7e0e@steinmetznet.com>
 <5EA5ED5D.8060006@youngman.org.uk>
 <c3b5d1be-3ee6-303e-63f5-51faf2053f63@steinmetznet.com>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <991449ea-82e8-8f80-d73c-ad9701cf2d88@turmel.org>
Date:   Mon, 27 Apr 2020 13:54:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c3b5d1be-3ee6-303e-63f5-51faf2053f63@steinmetznet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/27/20 10:40 AM, Robert Steinmetz wrote:
> On 4/26/20 4:21 PM, Wols Lists wrote:
>> Run lsdrv over the drive and see what that reports.
>> https://raid.wiki.kernel.org/index.php/Asking_for_help
>>
>> If you post that here, hopefully somebody can help you reconstruct
>> whatever was there.
>>
>> Cheers,
>> Wol
> 
> here is the output of lsdrv for the drive.
> 
> USB [usb-storage] Bus 001 Device 002: ID 152d:2338 JMicron Technology 
> Corp. / JMicron USA Technology Corp. JM20337 Hi-Speed USB to SATA & PATA 
> Combo Bridge {000000000005}
> └scsi 4:0:0:0 TOSHIBA  HDWD110          {585T7P6NS}
>   └sdb 931.51g [8:16] Partitioned (dos)
                                     ^^^^^
There's your answer.  This drive is using a dos partition table, not 
GPT.  But there's some info where the GPT would be that is confusing parted.

>    └sdb1 931.51g [8:17] Empty/Unknown

As you can see, this partition entry is rational.

Try displaying the partition table with fdisk instead of parted.

Phil
