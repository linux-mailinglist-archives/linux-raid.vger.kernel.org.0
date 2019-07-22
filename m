Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC4276FA58
	for <lists+linux-raid@lfdr.de>; Mon, 22 Jul 2019 09:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfGVH1c (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 22 Jul 2019 03:27:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbfGVH1b (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 22 Jul 2019 03:27:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB8FF3082B1F;
        Mon, 22 Jul 2019 07:27:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1D8119D7B;
        Mon, 22 Jul 2019 07:27:27 +0000 (UTC)
Subject: Re: [PATCH 1/1] bad block is after superblock and bitmap
To:     Hou Tao <houtao1@huawei.com>, linux-raid@vger.kernel.org
Cc:     artur.paszkiewicz@intel.com, jes.sorensen@gmail.com,
        ncroxon@redhat.com, heinzm@redhat.com
References: <1563526156-17802-1-git-send-email-xni@redhat.com>
 <eacb8ed2-d947-cfdd-1920-3380b6aa0b96@huawei.com>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <e278e7df-f9ce-ebed-4776-f48f7adf2ef4@redhat.com>
Date:   Mon, 22 Jul 2019 15:27:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <eacb8ed2-d947-cfdd-1920-3380b6aa0b96@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 22 Jul 2019 07:27:31 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 07/19/2019 07:59 PM, Hou Tao wrote:
> Hi,
>
> On 2019/7/19 16:49, Xiao Ni wrote:
>> Now it calculate bad block offset by bm_offset + bm_space. It should add sb_offset.
>>
>> Fixes: 1b7eb672(super1: fix setting bad block log offset in write_init_super1())
>> Signed-off-by: Xiao Ni <xni@redhat.com>
>> ---
>>   super1.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/super1.c b/super1.c
>> index b85dc20..682655a 100644
>> --- a/super1.c
>> +++ b/super1.c
>> @@ -2012,7 +2012,7 @@ static int write_init_super1(struct supertype *st)
>>   			sb->data_size = __cpu_to_le64(dsize - data_offset);
>>   			if (data_offset >= sb_offset+bm_offset+bm_space+8) {
>>   				sb->bblog_size = __cpu_to_le16(8);
>> -				sb->bblog_offset = __cpu_to_le32(bm_offset +
>> +				sb->bblog_offset = __cpu_to_le32(sb_offset + bm_offset +
>>   								 bm_space);
> bblog_offset is used as the signed offset from the sb_offset not the offset from
> the start of the device, so I don't think the addition of sb_offset is correct.
Hi Tao

Thanks for pointing the error. You are right. Bitmap and bad block's 
offset are all
start from the superblock. I thought wrongly.

Regards
Xiao
