Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BCC1BC134
	for <lists+linux-raid@lfdr.de>; Tue, 28 Apr 2020 16:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgD1O2n (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Apr 2020 10:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726900AbgD1O2m (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 28 Apr 2020 10:28:42 -0400
Received: from resqmta-po-04v.sys.comcast.net (resqmta-po-04v.sys.comcast.net [IPv6:2001:558:fe16:19:96:114:154:163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96B8C03C1AB
        for <linux-raid@vger.kernel.org>; Tue, 28 Apr 2020 07:28:42 -0700 (PDT)
Received: from resomta-po-04v.sys.comcast.net ([96.114.154.228])
        by resqmta-po-04v.sys.comcast.net with ESMTP
        id TQy4jxIo9YN1DTRE0jHg1w; Tue, 28 Apr 2020 14:28:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1588084120;
        bh=Geoyv0JBm2YzaE6LIxfkPzey65mAtVvvcQ7NJW4z+kQ=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=kXq/RSiUxbP6W3ugzBG1IeFXo0BYPqWVJ/OnPB6mdcKjbTgiSIeRySU50TkO/Jm9G
         1bwx530plEUI+61BVltAXKNWBdj7InmrCAm8KRu+F7rK5Ftx4ZQJi6fafF1+eZAaRp
         hcb+cvN+cuRwoTF3/mF6s/GEaUYq/qiSYA5LloCBIHbEYE9BUaYVW8xl1ydy+cAu9g
         giYb5psnf0Bdkon7nPFi7bVV3jHPooSsfjNUUWGLAeuDBEuRCsi5jmSmmHY1f+K55w
         KI9qkVo+pdBAe574LgAj2PPgjQKS1ayNYGzX8W3y56OJZOYEGuchCkdTlLx0Spgruw
         M9NN9tTIKSYvQ==
Received: from [192.168.2.24] ([67.166.240.34])
        by resomta-po-04v.sys.comcast.net with ESMTPSA
        id TRDyjqQHqE7DsTRDzjOQON; Tue, 28 Apr 2020 14:28:40 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgeduhedriedugdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucevohhmtggrshhtqdftvghsihdpqfgfvfdppffquffrtefokffrnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeftohgsvghrthcuufhtvghinhhmvghtiicuoehrohgssehsthgvihhnmhgvthiinhgvthdrtghomheqnecukfhppeeijedrudeiiedrvdegtddrfeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddvrddvgegnpdhinhgvthepieejrdduieeirddvgedtrdefgedpmhgrihhlfhhrohhmpehrohgssehsthgvihhnmhgvthiinhgvthdrtghomhdprhgtphhtthhopehrohgssehsthgvihhnmhgvthiinhgvthdrtghomhdprhgtphhtthhopehlihhnuhigqdhrrghiugesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhtlhhishhtsheshihouhhnghhmrghnrdhorhhgrdhukhdprhgtphhtthhopehphhhilhhiphesthhurhhmvghlrdhorhhg
X-Xfinity-VMeta: sc=-100.00;st=legit
Subject: Re: Hard Drive Partition Table shows partition larger than drive
To:     Phil Turmel <philip@turmel.org>,
        Wols Lists <antlists@youngman.org.uk>,
        linux-raid@vger.kernel.org
References: <6ee9392d-8867-f0b5-193e-17a516bb7e0e@steinmetznet.com>
 <5EA5ED5D.8060006@youngman.org.uk>
 <c3b5d1be-3ee6-303e-63f5-51faf2053f63@steinmetznet.com>
 <991449ea-82e8-8f80-d73c-ad9701cf2d88@turmel.org>
From:   Robert Steinmetz <rob@steinmetznet.com>
Message-ID: <c2c0bdf0-ebff-d52f-8f76-9fe3af3d58bb@steinmetznet.com>
Date:   Tue, 28 Apr 2020 10:28:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <991449ea-82e8-8f80-d73c-ad9701cf2d88@turmel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/27/20 1:54 PM, Phil Turmel wrote:
> here is the output of lsdrv for the drive.
>>
>> USB [usb-storage] Bus 001 Device 002: ID 152d:2338 JMicron Technology 
>> Corp. / JMicron USA Technology Corp. JM20337 Hi-Speed USB to SATA & 
>> PATA Combo Bridge {000000000005}
>> └scsi 4:0:0:0 TOSHIBA  HDWD110          {585T7P6NS}
>>   └sdb 931.51g [8:16] Partitioned (dos)
>                                     ^^^^^
> There's your answer.  This drive is using a dos partition table, not 
> GPT.  But there's some info where the GPT would be that is confusing 
> parted.
>
>>    └sdb1 931.51g [8:17] Empty/Unknown
>
> As you can see, this partition entry is rational.
>
> Try displaying the partition table with fdisk instead of parted.

Here is what fdisk says:

Disk /dev/sdb: 931.5 GiB, 1000204886016 bytes, 244190646 sectors
Units: sectors of 1 * 4096 = 4096 bytes
Sector size (logical/physical): 4096 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: dos
Disk identifier: 0x19e6cd02

Device     Boot Start        End    Sectors  Size Id Type
/dev/sdb1  *     2048 1953523711 1953521664  7.3T fd Linux raid autodetect

Note the discrepancy between the disk size and the partition size.

It seems the end sector for partition /dev/sdb1 is incorrect and should 
be 244190646 or 244190645 depending on how sectors are numberd that is 
if there is a sector 0 or it starts at 1.

-- 

Rob

