Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C214F2F13
	for <lists+linux-raid@lfdr.de>; Thu,  7 Nov 2019 14:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388470AbfKGNWR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 Nov 2019 08:22:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24739 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388368AbfKGNWQ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 7 Nov 2019 08:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573132935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8BMRXqrthM23RRM/lBbqxC7S7AmzN+yO32EU+EP+AA=;
        b=RAj4GvvcUbgsG9J3g49+RGTCbo5VVh7J51u/a72sISuCIl46aqEe8x9VnbcOGiOceZx9nF
        a40z078Gb4BNRxhGcjh6lvRnASdpb6WJmblTsEhy8gTN0ZEKg5Lk9D/TMlzZIcMnUBOZnz
        UdZrwUnyyCl6nnHVY7aDRcL8fX038Fk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-5Yl6r0eONu2O1GOxMaS3Kw-1; Thu, 07 Nov 2019 08:22:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 772D3800C61;
        Thu,  7 Nov 2019 13:22:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1CD15DA2C;
        Thu,  7 Nov 2019 13:22:08 +0000 (UTC)
Subject: Re: [PATCH] raid456: avoid second retry of read-error
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <liu.song.a23@gmail.com>,
        Wols Lists <antlists@youngman.org.uk>
Cc:     Nigel Croxon <ncroxon@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>
References: <20191104200157.31656-1-ncroxon@redhat.com>
 <5DC0C34B.1040102@youngman.org.uk>
 <CAPhsuW5bkFEk+t06JQufyYbzr-ckUfpQtgctoe6jy4wxzesBhw@mail.gmail.com>
 <7f512319-d7e3-edd1-3540-44581918d3cf@cloud.ionos.com>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <e6ff9bf8-46ea-f953-02a4-1fad697a89a0@redhat.com>
Date:   Thu, 7 Nov 2019 21:22:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <7f512319-d7e3-edd1-3540-44581918d3cf@cloud.ionos.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 5Yl6r0eONu2O1GOxMaS3Kw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 11/07/2019 12:02 AM, Guoqing Jiang wrote:
>
>
> On 11/5/19 10:11 PM, Song Liu wrote:
>> On Mon, Nov 4, 2019 at 4:33 PM Wols Lists <antlists@youngman.org.uk>=20
>> wrote:
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
>> Based on my understanding (no data on this), the drive will retry read
>> internally before return error. Therefore, host level retry doesn't=20
>> really
>> help. But I could be wrong.
>
> The read which bypasses the cache could retry too, should it be
> changed as well?
>
Do you mean the align read part? If so, yes, we should handle it too.=20
Now it calls retry_aligned_read when
there is a read failure for align read. We can set R5_ReadError before=20
handling the stripe.

Regards
Xiao

