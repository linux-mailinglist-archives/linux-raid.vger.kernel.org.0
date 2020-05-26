Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 154E719B59C
	for <lists+linux-raid@lfdr.de>; Wed,  1 Apr 2020 20:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbgDAScU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 1 Apr 2020 14:32:20 -0400
Received: from atl.turmel.org ([74.117.157.138]:37803 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732979AbgDAScU (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 1 Apr 2020 14:32:20 -0400
Received: from [98.192.104.236] (helo=[192.168.19.61])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1jJi9z-0005D3-2q; Wed, 01 Apr 2020 14:32:19 -0400
Subject: Re: Requesting assistance recovering RAID-5 array
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
 <e75f80f4-70d4-e283-b3bc-c78bd0d55a8a@turmel.org>
 <CAB00BMhU76rjvQv9v-HxM8Harc9ssLBANWfPsW9abbSRNgwoUQ@mail.gmail.com>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <bb554b86-3dc0-8cb2-c279-f8841742195c@turmel.org>
Date:   Wed, 1 Apr 2020 14:32:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAB00BMhU76rjvQv9v-HxM8Harc9ssLBANWfPsW9abbSRNgwoUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Daniel,

On 4/1/20 2:07 PM, Daniel Jones wrote:
> Hi Phil,
> 
> So far so good.

Yes.

> # mdadm --manage /dev/md0 --add /dev/mapper/sdb1
> mdadm: added /dev/mapper/sdb1

Don't do this.  Overlays can't really handle the amount of data that 
would be involved, and you definitely don't want to rebuild yet.

> 4: Summary
> 
> The drives have had physical partitions written.
> I think I've found the correct offset and device order to use --create
> to restore the array to the degraded state it was in before the
> superblocks were overwritten.

Yes.

> I'm not sure why the --add doesn't work.

Don't do the --add operation until you've copied anything critical in 
the array to external backups (while running with 3 of 4).  The reason 
is that any not-yet-discovered URE on those three will certainly crash 
the array during rebuild.  It could still crash copying critical stuff, 
but you can repeatedly --assemble --force to keep going with the next 
items to backup.

Only when you've backed up everything possible do you --add the fourth 
drive back into the array.

> Thanks so much for your help this far.

You're welcome.

> Regards,
> DJ

Phil

