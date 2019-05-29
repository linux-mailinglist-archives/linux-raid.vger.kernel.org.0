Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 281DE2D5EE
	for <lists+linux-raid@lfdr.de>; Wed, 29 May 2019 09:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfE2HJV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 29 May 2019 03:09:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfE2HJU (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 29 May 2019 03:09:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AD6A8112C;
        Wed, 29 May 2019 07:09:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 298C46148C;
        Wed, 29 May 2019 07:09:16 +0000 (UTC)
Subject: Re: Optimising raid on 4k devices
To:     Song Liu <liu.song.a23@gmail.com>,
        Matthew Moore <matthew@moore.sydney>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <3a28d64f-9f13-277a-a8f9-3cdf87034200@moore.sydney>
 <CAPhsuW5ngOxnddZp37nKe0KtsRTYxi-N1O2ARUqBbHbYJ=ASSg@mail.gmail.com>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <263f25f0-e4e3-ace5-e8cc-96c8367549bf@redhat.com>
Date:   Wed, 29 May 2019 15:09:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5ngOxnddZp37nKe0KtsRTYxi-N1O2ARUqBbHbYJ=ASSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 29 May 2019 07:09:20 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 05/29/2019 12:21 AM, Song Liu wrote:
> On Sun, May 26, 2019 at 2:27 AM Matthew Moore <matthew@moore.sydney> wrote:
>> Hi all,
>>
>> I'm setting up a RAID6 array on 8 * 8TB drives, which are obviously
>> using 4k sectors.  The high-level view is XFS-on-LUKS-on-mdraid6.
> Are these driver 4kB native or 512e?

Hi Song

What's the meaning of "4kB native" and "512e" here?
The sector size is 4kB or 512 byte?

>
> For 4kB native, you don't need to do anything.
>
> For 512e, just make sure NOT to create RAID on top of non-4kB-aligned
> partitions.

Could you explain more about this?

Regards
Xiao
