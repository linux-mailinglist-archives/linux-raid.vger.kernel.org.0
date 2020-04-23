Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C5D1B5B95
	for <lists+linux-raid@lfdr.de>; Thu, 23 Apr 2020 14:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgDWMiN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 23 Apr 2020 08:38:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57241 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728340AbgDWMiM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 23 Apr 2020 08:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587645491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gbrDbQRcnuT0cobTtqt+DJp5BtXQ5fZbLnGdiiqQk9E=;
        b=hR/uFIa5KcDCxS1E7mkgzrTfapFibgUTx8rK9ElLe1DPJ/IFpgCfcttyeVNR7OEQnfHMFB
        xwpdBpm19y5672I+xNJW7TF83AKGhGUISpzqq6h0ulTD15c9hb+dAc4bjCKZm3FtqWh27Y
        Cy+aBzVs05AtuANN/wh4UE8cLqWqNiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-y-fssP9qMV2zmntehdlozw-1; Thu, 23 Apr 2020 08:38:09 -0400
X-MC-Unique: y-fssP9qMV2zmntehdlozw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E03445C;
        Thu, 23 Apr 2020 12:38:08 +0000 (UTC)
Received: from [10.10.114.9] (ovpn-114-9.rdu2.redhat.com [10.10.114.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 48BF21C94C;
        Thu, 23 Apr 2020 12:38:07 +0000 (UTC)
Subject: Re: [PATCH] md/raid1: release pending accounting for an I/O only
 after write-behind is also finished
To:     Song Liu <song@kernel.org>, David Jeffery <djeffery@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20200127152619.GA3596@redhat>
 <CAPhsuW628WHm_Rifm9uMPeH+mwmeH121p85KbgvLt+SQTngW4A@mail.gmail.com>
 <CA+-xHTGJr5M9Ge1MCPPZWueM56Ap5=qcsG0KkddBMJOCAOWWpw@mail.gmail.com>
 <CAPhsuW7XJzdWxkLDbRG9VS3BJB6qaAoEC_sDOtMRaw1ZvMj1dw@mail.gmail.com>
From:   Nigel Croxon <ncroxon@redhat.com>
Message-ID: <bcc52c3e-0865-709b-fc4d-7ca59d10bf9d@redhat.com>
Date:   Thu, 23 Apr 2020 08:38:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7XJzdWxkLDbRG9VS3BJB6qaAoEC_sDOtMRaw1ZvMj1dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 1/28/20 2:08 PM, Song Liu wrote:
> On Mon, Jan 27, 2020 at 11:56 AM David Jeffery <djeffery@redhat.com> wrote:
>> On Mon, Jan 27, 2020 at 12:29 PM Song Liu <song@kernel.org> wrote:
>>> On Mon, Jan 27, 2020 at 7:26 AM David Jeffery <djeffery@redhat.com> wrote:
>>>> When using RAID1 and write-behind, md can deadlock when errors occur. With
>>>> write-behind, r1bio structs can be accounted by raid1 as queued but not
>>>> counted as pending. The pending count is dropped when the original bio is
>>>> returned complete but write-behind for the r1bio may still be active.
>>>>
>>>> This breaks the accounting used in some conditions to know when the raid1
>>>> md device has reached an idle state. It can result in calls to
>>>> freeze_array deadlocking. freeze_array will never complete from a negative
>>>> "unqueued" value being calculated due to a queued count larger than the
>>>> pending count.
>>>>
>>>> To properly account for write-behind, move the call to allow_barrier from
>>>> call_bio_endio to raid_end_bio_io. When using write-behind, md can call
>>>> call_bio_endio before all write-behind I/O is complete. Using
>>>> raid_end_bio_io for the point to call allow_barrier will release the
>>>> pending count at a point where all I/O for an r1bio, even write-behind, is
>>>> done.
>>>>
>>>> Signed-off-by: David Jeffery <djeffery@redhat.com>
>>>> ---
>>>>
>>>>   raid1.c |   13 +++++++------
>>>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>>>
>>>>
>>>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>>>> index 201fd8aec59a..0196a9d9f7e9 100644
>>>> --- a/drivers/md/raid1.c
>>>> +++ b/drivers/md/raid1.c
>>>> @@ -279,22 +279,17 @@ static void reschedule_retry(struct r1bio *r1_bio)
>>>>   static void call_bio_endio(struct r1bio *r1_bio)
>>>>   {
>>>>          struct bio *bio = r1_bio->master_bio;
>>>> -       struct r1conf *conf = r1_bio->mddev->private;
>>>>
>>>>          if (!test_bit(R1BIO_Uptodate, &r1_bio->state))
>>>>                  bio->bi_status = BLK_STS_IOERR;
>>>>
>>>>          bio_endio(bio);
>>>> -       /*
>>>> -        * Wake up any possible resync thread that waits for the device
>>>> -        * to go idle.
>>>> -        */
>>>> -       allow_barrier(conf, r1_bio->sector);
>>> raid1_end_write_request() also calls call_bio_endio(). Do we need to fix
>>> that?
>> This basically is the problem the patch is fixing.  We don't want
>> allow_barrier() being called when call_bio_endio() is called directly
>> from raid1_end_write_request().  Write-behind can still be active here
>> so it was dropping the pending accounting too early.  We only want it
>> called when all I/O for the r1bio is complete, which shifting the
>> allow_barrier() call to raid_end_bio_io() does.
> Thanks for the explanation. This looks good to me. I will process it
> after the merge window.
>
> I will also re-evaluate whether we need it for stable.
>
> Thanks again,
> Song
>
Hello Song,

Did you pull in this patch after the merge window?

I don't see it in your tree.

Thanks, Nigel





