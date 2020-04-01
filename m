Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE8D719AEE8
	for <lists+linux-raid@lfdr.de>; Wed,  1 Apr 2020 17:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbgDAPjf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 1 Apr 2020 11:39:35 -0400
Received: from atl.turmel.org ([74.117.157.138]:47672 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732651AbgDAPjf (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 1 Apr 2020 11:39:35 -0400
Received: from [98.192.104.236] (helo=[192.168.19.61])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1jJfSo-0004EP-Ou; Wed, 01 Apr 2020 11:39:34 -0400
Subject: Re: Requesting assistance recovering RAID-5 array
From:   Phil Turmel <philip@turmel.org>
To:     Daniel Jones <dj@iowni.com>
Cc:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
References: <CAB00BMjPSg2wdq7pjt=AwmcDmr0ep2+Xr0EAy6CNnVhOsWk8pg@mail.gmail.com>
 <058b3f48-e69d-2783-8e08-693ad27693f6@youngman.org.uk>
 <CAB00BMgYmi+4XvdmJDWjQ8qGWa9m0mqj7yvrK3QSNH9SzYjypw@mail.gmail.com>
 <1d6b3e00-e7dd-1b19-1379-afe665169d44@turmel.org>
 <CAB00BMg50zcerSLHShSjoOcaJ0JQSi2aSqTFfU2eQQrT12-qEg@mail.gmail.com>
 <e77280ef-a5ac-f2d8-332c-dec032ddc842@turmel.org>
 <CAB00BMj5kihqwOY-FOXv-tqG1b2reMnUVkdmB9uyNAeE7ESasw@mail.gmail.com>
 <061b695a-2406-fc00-dd6d-9198b85f3b1b@turmel.org>
 <CAB00BMi3zhfVGpeE_AyyKiu1=MY2icYgfey0J3GeO8z9ZDAQbg@mail.gmail.com>
 <5E8485DA.2050803@youngman.org.uk>
 <9a303b9b-52b8-f0c6-4288-120338c6572f@turmel.org>
 <CAB00BMig177NjEbBQgfjQ5gZE3QPTR-B6FD9i8oczHqf7mMqcg@mail.gmail.com>
 <1f4b8c74-4c38-6ea4-6868-b28f9e5c4a10@turmel.org>
Message-ID: <e75f80f4-70d4-e283-b3bc-c78bd0d55a8a@turmel.org>
Date:   Wed, 1 Apr 2020 11:39:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1f4b8c74-4c38-6ea4-6868-b28f9e5c4a10@turmel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/1/20 11:38 AM, Phil Turmel wrote:
> On 4/1/20 11:21 AM, Daniel Jones wrote:
>> Hi Phil, Wols,

>> My question is how to get the kernel to recognize the
>> /dev/mapper/sd[bcde]1 partitions I have created?  Rebooting doesn't do
>> anything as the overlay loop files aren't something that gets
>> recognized during boot.
> 
> I would create the partition tables once on the live disks.  Then make 
> overlays for the partitions on each test.

And use partprobe if needed to tell the kernel to re-read the partition 
tables.

Phil
