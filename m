Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCE71CB247
	for <lists+linux-raid@lfdr.de>; Fri,  8 May 2020 16:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgEHOvI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 8 May 2020 10:51:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60459 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726913AbgEHOvI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 8 May 2020 10:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588949467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WYjIYtwEvR009TY4C66gnIr4LSCWjmzdKCXI/qM7eCI=;
        b=ZFLEugDaoulnpGGhCxtpoRkZG7nKchCAphFhRug7f/ovIP0V5Uqv6e+/T/ire1ZlnOsV4H
        eWsAaXalBDG6o6QfEwvTPBEhycwAK95MioZRBRZnd5V+B9m8FKeXQi2y+l5ShyvI3/lji5
        3ikto/8zhMVXSJnN5sCXHDz+c5OMQFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-C3A841nhMwCtrmUKAAn1OA-1; Fri, 08 May 2020 10:50:49 -0400
X-MC-Unique: C3A841nhMwCtrmUKAAn1OA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1696A1895A2C;
        Fri,  8 May 2020 14:50:48 +0000 (UTC)
Received: from [10.10.66.7] (ovpn-66-7.rdu2.redhat.com [10.10.66.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DA151002387;
        Fri,  8 May 2020 14:50:47 +0000 (UTC)
Subject: Re: [PATCH V2] allow RAID5 to grow to RAID6 with a backup_file
To:     Jes Sorensen <jes@trained-monkey.org>, linux-raid@vger.kernel.org
References: <20200505183545.26291-1-ncroxon@redhat.com>
 <8a30b584-753c-abff-634a-7dda8a2e3e27@trained-monkey.org>
From:   Nigel Croxon <ncroxon@redhat.com>
Message-ID: <2b7c4bbd-8bfd-e33b-ca52-0cb3385d46f1@redhat.com>
Date:   Fri, 8 May 2020 10:50:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <8a30b584-753c-abff-634a-7dda8a2e3e27@trained-monkey.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 5/8/20 10:01 AM, Jes Sorensen wrote:
> On 5/5/20 2:35 PM, Nigel Croxon wrote:
>> This problem came in, as the user did not specify a full path with
>> the backup_file option when growing an RAID5 array to RAID6.
>> When the full path is specified, the symbolic link is created
>> properly (/run/mdadm/backup_file-mdX). But the code did not support
>> the symbolic link when looking for the backup_file. Added two
>> checks for symlink.
>>
>> This addresses https://www.spinics.net/lists/raid/msg48910.html
>> and numerous customer reported problems.
>>
>> V2:
>> - Removed unneeded break; in both case-statements
>> - Returned the error checking on call to lstat
>>
>> Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
>> ---
>>   Grow.c | 21 +++++++++++++++++++--
>>   1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/Grow.c b/Grow.c
>> index 764374f..53245d7 100644
>> --- a/Grow.c
>> +++ b/Grow.c
>> @@ -1135,6 +1135,15 @@ int reshape_open_backup_file(char *backup_file,
>>   	unsigned int dev;
>>   	int i;
>>   
>> +	if (lstat(backup_file, &stb) != -1) {
>> +		switch (stb.st_mode & S_IFMT) {
>> +		case S_IFLNK:
>> +			return 1;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +
> Sorry for being a pita on this, but in this case you do the thing if the
> lstat completes correctly, but what if it fails? In that case we should
> error out rather than just continuing.
>
> Jes
>
There are two processes running in the reshape_array routine, the 
original, where the user entered the mdadm grow parameter. And the 
second, forked to call systemd mdadm-grow-continue@service.  It's in the 
original call we want the code to continue rather than fail. It needs to 
create the backup_file in the FS before the systemd thread runs.

-Nigel

