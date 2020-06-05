Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3F71EFFD8
	for <lists+linux-raid@lfdr.de>; Fri,  5 Jun 2020 20:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgFESXW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 5 Jun 2020 14:23:22 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:54649 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726274AbgFESXW (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 5 Jun 2020 14:23:22 -0400
Received: from [192.168.0.6] (ip5f5af2a4.dynamic.kabel-deutschland.de [95.90.242.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 31CD320645A2C;
        Fri,  5 Jun 2020 20:23:19 +0200 (CEST)
Subject: Re: [PATCH v2] Use more secure HTTPS URLs
To:     Jes Sorensen <jes@trained-monkey.org>,
        Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
Cc:     linux-raid@vger.kernel.org,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Kinga Tanska <kinga.tanska@intel.com>
References: <20200528145224.19062-1-pmenzel@molgen.mpg.de>
 <8b02033d-7570-e654-dc18-a96f0a71d00c@trained-monkey.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <31fb5c7a-90c9-1810-1087-9dfa32c2f7f3@molgen.mpg.de>
Date:   Fri, 5 Jun 2020 20:23:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <8b02033d-7570-e654-dc18-a96f0a71d00c@trained-monkey.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Jes,


Am 05.06.20 um 17:17 schrieb Jes Sorensen:
> On 5/28/20 10:52 AM, Paul Menzel wrote:
>> All URLs in the source are available over HTTPS, so convert all URLs to
>> HTTPS with the command below.
>>
>>      git grep -l 'http://' | xargs sed -i 's,http://,https://,g'
>>
>> Revert the changes to announcement files `ANNOUNCE-*` as requested by
>> the maintainer.
>>
>> Cc: linux-raid@vger.kernel.org
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> ---
>>   external-reshape-design.txt      | 2 +-
>>   mdadm.8.in                       | 6 +++---
>>   mdadm.spec                       | 4 ++--
>>   raid6check.8                     | 2 +-
>>   restripe.c                       | 2 +-
>>   udev-md-raid-safe-timeouts.rules | 2 +-
>>   6 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/external-reshape-design.txt b/external-reshape-design.txt
>> index 10c57cc..e4cf4e1 100644
>> --- a/external-reshape-design.txt
>> +++ b/external-reshape-design.txt
>> @@ -277,4 +277,4 @@ sync_action
>>   
>>   ...
>>   
>> -[1]: Linux kernel design patterns - part 3, Neil Brown http://lwn.net/Articles/336262/
>> +[1]: Linux kernel design patterns - part 3, Neil Brown https://lwn.net/Articles/336262/
>> diff --git a/mdadm.8.in b/mdadm.8.in
>> index 9e7cb96..7f32762 100644
>> --- a/mdadm.8.in
>> +++ b/mdadm.8.in
>> @@ -367,7 +367,7 @@ Use the Intel(R) Matrix Storage Manager metadata format.  This creates a
>>   which is managed in a similar manner to DDF, and is supported by an
>>   option-rom on some platforms:
>>   .IP
>> -.B http://www.intel.com/design/chipsets/matrixstorage_sb.htm
>> +.B https://www.intel.com/design/chipsets/matrixstorage_sb.htm
> 
> Sorry for being a pain, but this link isn't actually valid.

Sorry, for not mentioning that in the commit message. Indeed the 
original page is gone, but the plain HTTP URL gets redirected to HTTPS, 
so it doesn’t change the behavior from before.

```
$ curl -I http://www.intel.com/design/chipsets/matrixstorage_sb.htm
HTTP/1.1 301 Moved Permanently
Server: AkamaiGHost
Content-Length: 0
Location: https://www.intel.com/design/chipsets/matrixstorage_sb.htm
Date: Fri, 05 Jun 2020 18:20:43 GMT
Connection: keep-alive
Set-Cookie: detected_bandwidth=LOW; path=/; domain=.intel.com; secure; 
HttpOnly
Set-Cookie: src_countrycode=DE; path=/; domain=.intel.com; secure; HttpOnly
Access-Control-Allow-Origin: *
X-Content-Type-Options: nosniff

```

So, maybe take this patch, and the outdated URL can be fixed in a 
follow-up once it’s known.

> Does someone from Intel know what to point at?

That’d be great.


Kind regards,

Paul
