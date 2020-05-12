Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CDE1CFDC7
	for <lists+linux-raid@lfdr.de>; Tue, 12 May 2020 20:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgELSuu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Tue, 12 May 2020 14:50:50 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17081 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgELSut (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 12 May 2020 14:50:49 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589309442; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=MoINdDSYhls07Mu9t6GUm5Tf+0/cnE8iepQLnaxeBDrl9J11EIGmzK6U7XytmBc1lFSx5fZ953T5aVxGIzf34BraJ7Fz9U2MhcRyqFlZa8ApsbWmiubZO4ZIcMUv4J/WroJn0AT9qmjs96o7bSJcx1ffTJrWnKOb/vbtfBaNtj4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1589309442; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0NUqgkrv/tcFw3aVzdhn89tH+lpGsSPhJvM3lg0kmv0=; 
        b=H63wmTMM0bTeV7EzYHwfmNu5+lzznE7r+i8N8va9m9wIZsn/3sggrr5LDykZtrTrf/ULN2b7OaSM4M9BgBu2YX2KqF0YmA91QQSNQtpoRxFSa9wEyzJru852Nv3ZRyXNkdVDDEi8pdjE8EHqCNqmTKhg2SDU4q7oUEAcotgg7LQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.128.78] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 1589309440049514.9070274735291; Tue, 12 May 2020 20:50:40 +0200 (CEST)
Subject: Re: [PATCH V2] allow RAID5 to grow to RAID6 with a backup_file
To:     Nigel Croxon <ncroxon@redhat.com>, linux-raid@vger.kernel.org
References: <20200505183545.26291-1-ncroxon@redhat.com>
 <8a30b584-753c-abff-634a-7dda8a2e3e27@trained-monkey.org>
 <2b7c4bbd-8bfd-e33b-ca52-0cb3385d46f1@redhat.com>
 <7a37b29a-4d6c-b371-df26-aa67a32e57e8@redhat.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <c0acda80-38a0-59d9-016e-8c59b12d317b@trained-monkey.org>
Date:   Tue, 12 May 2020 14:50:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7a37b29a-4d6c-b371-df26-aa67a32e57e8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/12/20 12:26 PM, Nigel Croxon wrote:
> On 5/8/20 10:50 AM, Nigel Croxon wrote:
>>
>> On 5/8/20 10:01 AM, Jes Sorensen wrote:
>>> On 5/5/20 2:35 PM, Nigel Croxon wrote:
>>>> This problem came in, as the user did not specify a full path with
>>>> the backup_file option when growing an RAID5 array to RAID6.
>>>> When the full path is specified, the symbolic link is created
>>>> properly (/run/mdadm/backup_file-mdX). But the code did not support
>>>> the symbolic link when looking for the backup_file. Added two
>>>> checks for symlink.
>>>>
>>>> This addresses https://www.spinics.net/lists/raid/msg48910.html
>>>> and numerous customer reported problems.
>>>>
>>>> V2:
>>>> - Removed unneeded break; in both case-statements
>>>> - Returned the error checking on call to lstat
>>>>
>>>> Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
>>>> ---
>>>>   Grow.c | 21 +++++++++++++++++++--
>>>>   1 file changed, 19 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Grow.c b/Grow.c
>>>> index 764374f..53245d7 100644
>>>> --- a/Grow.c
>>>> +++ b/Grow.c
>>>> @@ -1135,6 +1135,15 @@ int reshape_open_backup_file(char *backup_file,
>>>>       unsigned int dev;
>>>>       int i;
>>>>   +    if (lstat(backup_file, &stb) != -1) {
>>>> +        switch (stb.st_mode & S_IFMT) {
>>>> +        case S_IFLNK:
>>>> +            return 1;
>>>> +        default:
>>>> +            break;
>>>> +        }
>>>> +    }
>>>> +
>>> Sorry for being a pita on this, but in this case you do the thing if the
>>> lstat completes correctly, but what if it fails? In that case we should
>>> error out rather than just continuing.
>>>
>>> Jes
>>>
>> There are two processes running in the reshape_array routine, the
>> original, where the user entered the mdadm grow parameter. And the
>> second, forked to call systemd mdadm-grow-continue@service.  It's in
>> the original call we want the code to continue rather than fail. It
>> needs to create the backup_file in the FS before the systemd thread runs.
>>
>> -Nigel
>>
> Jes,
> 
> Do you have more questions?  an alternate solution?

I don't like ignoring error codes like this. As a bare minimum it should
be documented, or we should call in with an argument to decide whether
or not to stat the file in the first place.

Cheers,
Jes


