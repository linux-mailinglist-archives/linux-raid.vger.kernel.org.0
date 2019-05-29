Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B582D64E
	for <lists+linux-raid@lfdr.de>; Wed, 29 May 2019 09:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfE2H1e (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 29 May 2019 03:27:34 -0400
Received: from mifritscher.de ([188.40.170.105]:58446 "EHLO
        mail.mifritscher.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2H1e (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 29 May 2019 03:27:34 -0400
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 03:27:33 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mifritscher.de (Postfix) with ESMTP id 9BBE63A96E0;
        Wed, 29 May 2019 09:19:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mifritscher.vserverkompetenz.de
Received: from mail.mifritscher.de ([127.0.0.1])
        by localhost (mail.mifritscher.vserverkompetenz.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 62EqK5h_9W7f; Wed, 29 May 2019 09:19:20 +0200 (CEST)
Received: from mifritscher.de (localhost.localdomain [127.0.0.1])
        by mail.mifritscher.de (Postfix) with ESMTPA id 4B8793A91C6;
        Wed, 29 May 2019 09:19:20 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 May 2019 09:19:20 +0200
From:   michael@fritscher.net
To:     Xiao Ni <xni@redhat.com>
Cc:     Song Liu <liu.song.a23@gmail.com>,
        Matthew Moore <matthew@moore.sydney>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-raid-owner@vger.kernel.org
Subject: Re: Optimising raid on 4k devices
In-Reply-To: <263f25f0-e4e3-ace5-e8cc-96c8367549bf@redhat.com>
References: <3a28d64f-9f13-277a-a8f9-3cdf87034200@moore.sydney>
 <CAPhsuW5ngOxnddZp37nKe0KtsRTYxi-N1O2ARUqBbHbYJ=ASSg@mail.gmail.com>
 <263f25f0-e4e3-ace5-e8cc-96c8367549bf@redhat.com>
Message-ID: <d689cdb8feb428a15ceca4aac2769dec@fritscher.net>
X-Sender: michael@fritscher.net
User-Agent: Roundcube Webmail/1.2.3
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Am 2019-05-29 09:09, schrieb Xiao Ni:
> On 05/29/2019 12:21 AM, Song Liu wrote:
>> On Sun, May 26, 2019 at 2:27 AM Matthew Moore <matthew@moore.sydney> 
>> wrote:
>>> Hi all,
>>> 
>>> I'm setting up a RAID6 array on 8 * 8TB drives, which are obviously
>>> using 4k sectors.  The high-level view is XFS-on-LUKS-on-mdraid6.
>> Are these driver 4kB native or 512e?
> 
> Hi Song
> 
> What's the meaning of "4kB native" and "512e" here?
> The sector size is 4kB or 512 byte?
> 
>> 
>> For 4kB native, you don't need to do anything.
>> 
>> For 512e, just make sure NOT to create RAID on top of non-4kB-aligned
>> partitions.
> 
> Could you explain more about this?
> 
> Regards
> Xiao

Hello,

4kB = they expose their 4k sectors also at the interface.
512e = internally, they use (in far the most cases) 4kB sectors 
internally, but emulate 512 byte sectors at the interface. Which can 
make things slow if structures are not aligned at 4kB boundaries.

Best regards,
Michael Fritscher
