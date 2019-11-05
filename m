Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2DB3EFD74
	for <lists+linux-raid@lfdr.de>; Tue,  5 Nov 2019 13:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbfKEMo2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 Nov 2019 07:44:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:35288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388222AbfKEMo2 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 5 Nov 2019 07:44:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE1A6AC5F;
        Tue,  5 Nov 2019 12:44:26 +0000 (UTC)
Subject: Re: [PATCH] mdadm.8: add note information for raid0 growing operation
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-raid@vger.kernel.org, NeilBrown <neilb@suse.de>,
        jes.sorensen@gmail.com
References: <20191105075540.56013-1-colyli@suse.de>
 <605de72e-0771-adc8-d39c-fc9e634e9b9b@molgen.mpg.de>
From:   Coly Li <colyli@suse.de>
Organization: SUSE Labs
Message-ID: <29133ed2-98d0-94c0-8787-711ec7d5cb1a@suse.de>
Date:   Tue, 5 Nov 2019 20:44:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <605de72e-0771-adc8-d39c-fc9e634e9b9b@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2019/11/5 5:52 下午, Paul Menzel wrote:
> Dear Coly,
> 
> 
> Thank you for improving the documentation.
> 
> On 2019-11-05 08:55, Coly Li wrote:
>> When growing a raid0 device, if the new component disk size is not
>> big enough, the grow operation may fail due to lack of backup space.
>>
>> The minimum backup space should be larger than
>> 	LCM(old, new) * chunk-size * 2
>> Here LCM stands for Least Common Multiple calculation, old and new
>> are devices number before and  after  the grow operation, "* 2" comes
> 
> device numbers

Copied. I am not sure whether it should be "device numbers" or maybe
"devices numbers", this confuses me *^_^*

> 
>> from the fact that mdadm refuses to use more than half of a spare
>> device for backup space.
>>
>> There are users reported such failure when they grew a raid0 array
> 
> There are users reporting …
> 
>> with small component disk. Neil Brown points out this is not a bug
>> and how the failure comes. This patch adds note information into
>> mdadm(8) man page in the Notes part of GROW MODE section, to explain
> 
> Comma can be removed.

Without the comma, I feel the sentence is too long to have a breath for
readers LOL..

> 
>> a minimum size requirement of new component disk size or external
> 
> s/a/the/

Copied, I will update this in next version.

> 
>> backup size.
>>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> Cc: NeilBrown <neilb@suse.de>
>> ---
>>  mdadm.8.in | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/mdadm.8.in b/mdadm.8.in
>> index 9aec9f4..dfb55e3 100644
>> --- a/mdadm.8.in
>> +++ b/mdadm.8.in
>> @@ -2727,6 +2727,14 @@ option and it is transparent for assembly feature.
>>  .IP \(bu 4
>>  Roaming between Windows(R) and Linux systems for IMSM metadata is not
>>  supported during grow process.
>> +.IP \(bu 4
>> +When growing a raid0 device, the new component disk size (or external
>> +backup size) should be larger than LCM(old, new) * chunk-size * 2. Here
>> +LCM stands for Least Common Multiple calculation, old and new are
>> +devices number before and after the grow operation, "* 2" comes from
> 
> device numbers
> 
> Note, that I am not a native speaker.

Neither me :-) Thanks for the review, I will wait for comments from Neil
and Jes, then post an update version.

-- 

Coly Li
