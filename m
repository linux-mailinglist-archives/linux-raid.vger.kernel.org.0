Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D01CF31C6
	for <lists+linux-raid@lfdr.de>; Thu,  7 Nov 2019 15:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfKGOvy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 Nov 2019 09:51:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50401 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726033AbfKGOvx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 7 Nov 2019 09:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573138312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9PxMsdI4TG3QAS80nWU9cjEB/GBxXWBCSw49JHo8ZQ0=;
        b=ERgc9Z3FAWIfg6H5Y6Y6wdhiq+F0UwWPyvKPdbdzK3e8Ip2BMy39mxFAqfdWvuvLPOd1I0
        Pe8AfPdjtO23dPtq6WVy3j9AC3XOPiSgS5Z1x5SRWStlKhmzIL5gYjFaugXP6yVAKG1eTS
        QxTROTt3Di3/ydB9hFUQVTYQmLecgGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-xiaXLym9MWaDjo3N65NbKA-1; Thu, 07 Nov 2019 09:51:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3884D107ACC3;
        Thu,  7 Nov 2019 14:51:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11F765DA70;
        Thu,  7 Nov 2019 14:51:45 +0000 (UTC)
Subject: Re: [PATCH] raid456: avoid second retry of read-error
To:     Wols Lists <antlists@youngman.org.uk>,
        Nigel Croxon <ncroxon@redhat.com>, linux-raid@vger.kernel.org,
        liu.song.a23@gmail.com
References: <20191104200157.31656-1-ncroxon@redhat.com>
 <5DC0C34B.1040102@youngman.org.uk>
 <a91541f0-f38f-6b9f-b02c-b6b803e9673c@redhat.com>
 <5DC41DAB.6020405@youngman.org.uk>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <3d433e66-d9c5-d30c-2a12-cc145cfb8c17@redhat.com>
Date:   Thu, 7 Nov 2019 22:51:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <5DC41DAB.6020405@youngman.org.uk>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: xiaXLym9MWaDjo3N65NbKA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 11/07/2019 09:35 PM, Wols Lists wrote:
> On 07/11/19 13:17, Xiao Ni wrote:
>>
>> On 11/05/2019 08:33 AM, Wols Lists wrote:
>>> On 04/11/19 20:01, Nigel Croxon wrote:
>>>> The MD driver for level-456 should prevent re-reading read errors.
>>>>
>>>> For redundant raid it makes no sense to retry the operation:
>>>> When one of the disks in the array hits a read error, that will
>>>> cause a stall for the reading process:
>>>> - either the read succeeds (e.g. after 4 seconds the HDD error
>>>> strategy could read the sector)
>>>> - or it fails after HDD imposed timeout (w/TLER, e.g. after 7
>>>> seconds (might be even longer)
>>> Okay, I'm being completely naive here, but what is going on? Are you
>>> saying that if we hit a read error, we just carry on, ignore it, and
>>> calculate the missing block from parity?
>>>
>>> If so, what happens if we hit two errors on a raid-5, or 3 on a raid-6,
>>> or whatever ... :-)
>>>
>> Hi Wol
>>
>> What's the meaning of "two errors on a raid-5"? Two read errors happen
>> on one disk?
>> Or there are two read errors on two disks?
>>
> Two read errors on two disks, so that you can't recalculate from parity.
>
> Basically, what I was thinking was "does this patch mean that if we get
> a read error, we read the parity instead and recalculate the block that
> failed?". If that is the case, what happens if we get a second read
> error and can't recalculate?
>
> Because, aiu real-world behaviour, it's quite normal for the first read
> to fail and the retry to succeed. So if this patch does what I think
> (feel free to tell me I'm wrong :-) a double read error would make raid
> return a read error, when actually the old code would have resulted in
> the read being successful, if a bit slower.
>

Now it's a little hard to choose. For me, I'd like to get right data when
there is a double read error if it can read successfully in retry-read.

Thanks
Xiao

