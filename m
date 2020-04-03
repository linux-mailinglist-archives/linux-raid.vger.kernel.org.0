Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C8519DF08
	for <lists+linux-raid@lfdr.de>; Fri,  3 Apr 2020 22:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgDCUN6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 3 Apr 2020 16:13:58 -0400
Received: from hammer.websitemanagers.com.au ([59.100.172.130]:57169 "EHLO
        hammer.websitemanagers.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbgDCUN6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 3 Apr 2020 16:13:58 -0400
Received: (qmail 6599 invoked by uid 1011); 3 Apr 2020 20:13:57 -0000
Received: from 192.168.5.178 by hammer (envelope-from <mailinglists@websitemanagers.com.au>, uid 1008) with qmail-scanner-1.24 
 (clamdscan: 0.102.1/25738. spamassassin: 3.4.2.  
 Clear:RC:1(192.168.5.178):. 
 Processed in 0.045602 secs); 03 Apr 2020 20:13:57 -0000
Received: from unknown (HELO ADAM-MBP.local) (adamg+websitemanagers.com.au@192.168.5.178)
  by 0 with ESMTPA; 3 Apr 2020 20:13:57 -0000
Subject: Re: Requesting assistance recovering RAID-5 array
To:     Phil Turmel <philip@turmel.org>, Daniel Jones <dj@iowni.com>
Cc:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
References: <CAB00BMjPSg2wdq7pjt=AwmcDmr0ep2+Xr0EAy6CNnVhOsWk8pg@mail.gmail.com>
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
 <bb554b86-3dc0-8cb2-c279-f8841742195c@turmel.org>
 <CAB00BMgwCbtGYJ_hX3_rZv3uaOd7vrHuEebqsPLHp3S96tJaRw@mail.gmail.com>
 <5985cc5b-a332-eb69-2d84-cb54f8f5b0fc@turmel.org>
 <CAB00BMjxywFn_K_D=Xn7ySHp404nvULTXarA7EwjxtuTJSOqQg@mail.gmail.com>
 <346301ce-505f-a2df-5cda-536f3ebb9b34@turmel.org>
From:   Adam Goryachev <mailinglists@websitemanagers.com.au>
Organization: Website Managers
Message-ID: <3f771f84-1c0d-8617-faa7-22657d9de95e@websitemanagers.com.au>
Date:   Sat, 4 Apr 2020 07:13:56 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <346301ce-505f-a2df-5cda-536f3ebb9b34@turmel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 4/4/20 05:43, Phil Turmel wrote:
>
> On 4/3/20 2:42 PM, Daniel Jones wrote:
>> After the "--create missing /dev/sdc1 /dev/sdd1 /dev/sde1"  and the
>> fsck, is "mdadm --manage /dev/md0 --add /dev/sdb" the correct syntax
>> for attempting to add?
>
> You can leave out "--manage".  But yes.

I was mostly following this, but might have missed something here so 
this is just a suggestion to double check....

If you are trying to use partitions instead of whole devices (to prevent 
this happening again in future), then shouldn't you use:

mdadm --manage /dev/md0 --add /dev/sdb1

ie, sdb1 not sdb....

Regards,
Adam

