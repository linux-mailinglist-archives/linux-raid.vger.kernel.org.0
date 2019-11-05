Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE998F09D7
	for <lists+linux-raid@lfdr.de>; Tue,  5 Nov 2019 23:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbfKEWvT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 Nov 2019 17:51:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52142 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730054AbfKEWvS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 Nov 2019 17:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572994277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uLWlmSHEXu7JHUa6E1IxEkBrF4pT/h5kzhXKdI192eU=;
        b=Ev6GD66f5EeITRI3+OzpDj7GNt/gTbqzDE0hTta92Ej3Nt3ZROTltysfVVaEdGUPnNIGhd
        p9FnC0i2Wez6OqGgZ3CDWIE72tlIpigPR3dbN3mw7sUIJMPsJqc1p82tXJvygUKTdhpKSm
        oSEz9Jxcyq9SuWgXJVso/DIMWHLarXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-n_3e2PAwOGmtRipmnELFow-1; Tue, 05 Nov 2019 17:51:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D966B8017DE;
        Tue,  5 Nov 2019 22:51:12 +0000 (UTC)
Received: from [10.10.123.46] (ovpn-123-46.rdu2.redhat.com [10.10.123.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 60DE15D6D6;
        Tue,  5 Nov 2019 22:51:12 +0000 (UTC)
Subject: Re: [PATCH] raid456: avoid second retry of read-error
To:     Song Liu <liu.song.a23@gmail.com>,
        Wols Lists <antlists@youngman.org.uk>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20191104200157.31656-1-ncroxon@redhat.com>
 <CAPhsuW7J-3ewXRvB9H1m44L_sVnuKBGTLcuRiKKN4YLRNivxtQ@mail.gmail.com>
 <CAPhsuW7E6tHy6-1+NnQPhr82sZO9aRTSEyhNoh_+fS8HQi=+nQ@mail.gmail.com>
From:   Nigel Croxon <ncroxon@redhat.com>
Message-ID: <5d3275f7-e6dd-0313-6af9-98424a41b9ae@redhat.com>
Date:   Tue, 5 Nov 2019 17:51:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7E6tHy6-1+NnQPhr82sZO9aRTSEyhNoh_+fS8HQi=+nQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: n_3e2PAwOGmtRipmnELFow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 11/5/19 4:33 PM, Song Liu wrote:
> On Tue, Nov 5, 2019 at 1:14 PM Song Liu <liu.song.a23@gmail.com> wrote:
>> On Mon, Nov 4, 2019 at 12:02 PM Nigel Croxon <ncroxon@redhat.com> wrote:
>>> The MD driver for level-456 should prevent re-reading read errors.
>>>
>>> For redundant raid it makes no sense to retry the operation:
>>> When one of the disks in the array hits a read error, that will
>>> cause a stall for the reading process:
>>> - either the read succeeds (e.g. after 4 seconds the HDD error
>>> strategy could read the sector)
>>> - or it fails after HDD imposed timeout (w/TLER, e.g. after 7
>>> seconds (might be even longer)
>>>
>>> The user can enable/disable this functionality by the following
>>> commands:
>>> To Enable:
>>> echo 1 > /proc/sys/dev/raid/raid456_retry_read_error
>>>
>>> To Disable, type the following at anytime:
>>> echo 0 > /proc/sys/dev/raid/raid456_retry_read_error
>>>
>>> Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
>>> ---
>>>   drivers/md/md.c    | 43 +++++++++++++++++++++++++++++++++++++++++++
>>>   drivers/md/md.h    |  3 +++
>>>   drivers/md/raid5.c |  3 ++-
>>>   3 files changed, 48 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>> index 6f0ecfe8eab2..75b8b0615328 100644
>>> --- a/drivers/md/md.c
>>> +++ b/drivers/md/md.c
>>> @@ -125,6 +125,12 @@ static inline int speed_max(struct mddev *mddev)
>>>                  mddev->sync_speed_max : sysctl_speed_limit_max;
>>>   }
>>>
>>> +static int sysctl_raid456_retry_read_error =3D 0;
>>> +static inline void set_raid456_retry_re(struct mddev *mddev, int re)
>>> +{
>>> +       (re ? set_bit : clear_bit)(MD_RAID456_RETRY_RE, &mddev->flags);
>> Let's just keep this
>> if (re)
>>       set_bit(...);
>> else
>>       clear_bit(..);
>>
>>> +}
>>> +
>>>   static int rdev_init_wb(struct md_rdev *rdev)
>>>   {
>>>          if (rdev->bdev->bd_queue->nr_hw_queues =3D=3D 1)
>>> @@ -213,6 +219,13 @@ static struct ctl_table raid_table[] =3D {
>>>                  .mode           =3D S_IRUGO|S_IWUSR,
>>>                  .proc_handler   =3D proc_dointvec,
>>>          },
>>> +       {
>>> +               .procname       =3D "raid456_retry_read_error",
>>> +               .data           =3D &sysctl_raid456_retry_read_error,
>>> +               .maxlen         =3D sizeof(int),
>>> +               .mode           =3D S_IRUGO|S_IWUSR,
>>> +               .proc_handler   =3D proc_dointvec,
>>> +       },
>>>          { }
>>>   };
>> How about we add this to md_redundancy_attrs instead?
> Actually, I think raid5_attrs is better.
>
> Thanks,
> Song

I'll have to test that, raid5_attrs.

But the ev has to be available before the=C2=A0 array is created.

That way when the initial sync starts, a user can already enable/disable=20
the capability.

-Nigel

