Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28674230A71
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jul 2020 14:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgG1Mlc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 08:41:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44293 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729379AbgG1Mlb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 Jul 2020 08:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595940090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TjGWqrEGz+cd8zKRgBH3PixiN/tM1F2S/cmxMuQ+WSs=;
        b=cZJM7WYUrVSo/cmM52+sRsbaAsV1G9tT+/SPHuodfxLc4K3gers5n8IycdNNRWTE8dD1Dr
        pm8Aner9U0TfcJV8uBPmBSVeP7YgN021pyMLIznmRoDai7wZ9FUzr5w9F3hCbUtYuXWvQq
        GLJtpG3lWOQX10zZ2O943CC93sXLqms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-yLXPehLiOg-PKVpkdgy0dQ-1; Tue, 28 Jul 2020 08:41:26 -0400
X-MC-Unique: yLXPehLiOg-PKVpkdgy0dQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F6A5100AA21;
        Tue, 28 Jul 2020 12:41:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77BFA171F9;
        Tue, 28 Jul 2020 12:41:22 +0000 (UTC)
Subject: Re: [PATCH V2 1/3] Move codes related with submitting discard bio
 into one function
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, song@kernel.org,
        linux-raid@vger.kernel.org
Cc:     colyli@suse.de, ncroxon@redhat.com, heinzm@redhat.com
References: <1595920703-6125-1-git-send-email-xni@redhat.com>
 <1595920703-6125-2-git-send-email-xni@redhat.com>
 <407c8e78-93d0-5347-1056-192613fff708@cloud.ionos.com>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <d4a66f24-08ae-29ec-356c-bd290ecf0aea@redhat.com>
Date:   Tue, 28 Jul 2020 20:41:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <407c8e78-93d0-5347-1056-192613fff708@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Guoqing

Thanks for reviewing this patch set.


On 07/28/2020 04:21 PM, Guoqing Jiang wrote:
> Hi Xiao,
>
> Better to add a prefix before subject like "md" ...", the same to 
> other patches.
Sure.
>
> On 7/28/20 9:18 AM, Xiao Ni wrote:
>> These codes can be used in raid10. So we can move these codes into
>> md.c. raid0 and raid10 can share these codes.
>>
>> Reviewed-by: Coly Li <colyli@suse.de>
>> Signed-off-by: Xiao Ni <xni@redhat.com>
>> ---
>>   drivers/md/md.c    | 22 ++++++++++++++++++++++
>>   drivers/md/md.h    |  3 +++
>>   drivers/md/raid0.c | 15 ++-------------
>>   3 files changed, 27 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 07e5b67..2b8f654 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -8559,6 +8559,28 @@ void md_write_end(struct mddev *mddev)
>>     EXPORT_SYMBOL(md_write_end);
>
> Could you add comment before the function to inform it is used by 
> raid0 and raid10?
I'll add comments in next version.

Regards
Xiao
>
>> +void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
>> +                struct bio *bio,
>> +                sector_t dev_start, sector_t dev_end)
>
> Thanks,
> Guoqing
>

