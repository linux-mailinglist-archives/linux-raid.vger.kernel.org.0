Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9EC1F7A12
	for <lists+linux-raid@lfdr.de>; Fri, 12 Jun 2020 16:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgFLOr5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Fri, 12 Jun 2020 10:47:57 -0400
Received: from sender11-op-o12.zoho.eu ([31.186.226.226]:17438 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgFLOrz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 12 Jun 2020 10:47:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591973252; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Kyrig1cQrSd8mQeLKjls52wAvAA4g5aUzlWOJpVpf7XPpMpsWLhUIjOfJuk8FVnYNhCJiRbwrgwUXgeTFDkL+CATQTSYfmi4+UanKqq0ik0AbdqJWozmWj1KGGUMZRqB95nUKDHkc6nOFt6K6az8jVYujEzQ1uMkZ9Ozb147Fdg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1591973252; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=hR+1I2xDfvaNQZoavTq85FB9ZM4o6OU42+q4U5Hbo18=; 
        b=kMv+PIKhJQxlWHXpUFEswKNM4E1l/VquNsXacQOoLPNeX1+Jn/2B39n7DWMn0CcVTFyWFOHMERHCgv1ftAMbAPJDnn4JRbTKvlN2nMcI49LJ0cgaCZIZhmGcjySh9+tTTOILfy3mNlxqwB+hxdgnEVSAQMv43jY8XIhOnMEYHEc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.165.210] (163.114.130.7 [163.114.130.7]) by mx.zoho.eu
        with SMTPS id 1591973249344814.8820957619894; Fri, 12 Jun 2020 16:47:29 +0200 (CEST)
Subject: Re: [PATCH v2] Use more secure HTTPS URLs
To:     "Tkaczyk, Mariusz" <mariusz.tkaczyk@intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>,
        "Tanska, Kinga" <kinga.tanska@intel.com>
References: <20200528145224.19062-1-pmenzel@molgen.mpg.de>
 <8b02033d-7570-e654-dc18-a96f0a71d00c@trained-monkey.org>
 <31fb5c7a-90c9-1810-1087-9dfa32c2f7f3@molgen.mpg.de>
 <SA0PR11MB454273621EA4A4876B1D3503FF820@SA0PR11MB4542.namprd11.prod.outlook.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <8dbfb508-618a-0e4f-b18c-db2b0212d169@trained-monkey.org>
Date:   Fri, 12 Jun 2020 10:47:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <SA0PR11MB454273621EA4A4876B1D3503FF820@SA0PR11MB4542.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Mariusz,

Thanks for the pointer. Lets update the man page to point to this, it's
better than nothing.

Cheers,
Jes

On 6/9/20 5:15 AM, Tkaczyk, Mariusz wrote:
> Hi,
> I'm recommending this link:
> https://www.intel.com/content/www/us/en/support/products/122484/memory-and-storage/ssd-software/intel-virtual-raid-on-cpu-intel-vroc.html
> 
> Currently we don't have any online superblock description, redirecting to the VROC support page is the best we can do.
> Previous link is permanently dead.
> 
> Thanks,
> Mariusz
> 
> -----Original Message-----
> From: linux-raid-owner@vger.kernel.org <linux-raid-owner@vger.kernel.org> On Behalf Of Paul Menzel
> Sent: Friday, June 5, 2020 8:23 PM
> To: Jes Sorensen <jes@trained-monkey.org>; Tkaczyk, Mariusz <mariusz.tkaczyk@intel.com>
> Cc: linux-raid@vger.kernel.org; Baldysiak, Pawel <pawel.baldysiak@intel.com>; Tanska, Kinga <kinga.tanska@intel.com>
> Subject: Re: [PATCH v2] Use more secure HTTPS URLs
> 
> Dear Jes,
> 
> 
> Am 05.06.20 um 17:17 schrieb Jes Sorensen:
>> On 5/28/20 10:52 AM, Paul Menzel wrote:
>>> All URLs in the source are available over HTTPS, so convert all URLs 
>>> to HTTPS with the command below.
>>>
>>>      git grep -l 'http://' | xargs sed -i 's,http://,https://,g'
>>>
>>> Revert the changes to announcement files `ANNOUNCE-*` as requested by 
>>> the maintainer.
>>>
>>> Cc: linux-raid@vger.kernel.org
>>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>> ---
>>>   external-reshape-design.txt      | 2 +-
>>>   mdadm.8.in                       | 6 +++---
>>>   mdadm.spec                       | 4 ++--
>>>   raid6check.8                     | 2 +-
>>>   restripe.c                       | 2 +-
>>>   udev-md-raid-safe-timeouts.rules | 2 +-
>>>   6 files changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/external-reshape-design.txt 
>>> b/external-reshape-design.txt index 10c57cc..e4cf4e1 100644
>>> --- a/external-reshape-design.txt
>>> +++ b/external-reshape-design.txt
>>> @@ -277,4 +277,4 @@ sync_action
>>>   
>>>   ...
>>>   
>>> -[1]: Linux kernel design patterns - part 3, Neil Brown 
>>> http://lwn.net/Articles/336262/
>>> +[1]: Linux kernel design patterns - part 3, Neil Brown 
>>> +https://lwn.net/Articles/336262/
>>> diff --git a/mdadm.8.in b/mdadm.8.in
>>> index 9e7cb96..7f32762 100644
>>> --- a/mdadm.8.in
>>> +++ b/mdadm.8.in
>>> @@ -367,7 +367,7 @@ Use the Intel(R) Matrix Storage Manager metadata format.  This creates a
>>>   which is managed in a similar manner to DDF, and is supported by an
>>>   option-rom on some platforms:
>>>   .IP
>>> -.B http://www.intel.com/design/chipsets/matrixstorage_sb.htm
>>> +.B https://www.intel.com/design/chipsets/matrixstorage_sb.htm
>>
>> Sorry for being a pain, but this link isn't actually valid.
> 
> Sorry, for not mentioning that in the commit message. Indeed the original page is gone, but the plain HTTP URL gets redirected to HTTPS, so it doesn’t change the behavior from before.
> 
> ```
> $ curl -I http://www.intel.com/design/chipsets/matrixstorage_sb.htm
> HTTP/1.1 301 Moved Permanently
> Server: AkamaiGHost
> Content-Length: 0
> Location: https://www.intel.com/design/chipsets/matrixstorage_sb.htm
> Date: Fri, 05 Jun 2020 18:20:43 GMT
> Connection: keep-alive
> Set-Cookie: detected_bandwidth=LOW; path=/; domain=.intel.com; secure; HttpOnly
> Set-Cookie: src_countrycode=DE; path=/; domain=.intel.com; secure; HttpOnly
> Access-Control-Allow-Origin: *
> X-Content-Type-Options: nosniff
> 
> ```
> 
> So, maybe take this patch, and the outdated URL can be fixed in a follow-up once it’s known.
> 
>> Does someone from Intel know what to point at?
> 
> That’d be great.
> 
> 
> Kind regards,
> 
> Paul
> 


