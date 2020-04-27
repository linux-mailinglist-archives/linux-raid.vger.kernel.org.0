Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DC61BA67F
	for <lists+linux-raid@lfdr.de>; Mon, 27 Apr 2020 16:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgD0Od1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Mon, 27 Apr 2020 10:33:27 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17094 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgD0Od1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 27 Apr 2020 10:33:27 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Apr 2020 10:33:26 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1587998003; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=bjm4Xh0MpfWqJsjP6xWPBuiDNW6vntBSJ4ipwyDLiixeM+s+JcPfMj00we8AWcOgiXx/tFABfY8eFlFSJO51cyuJguxKYyjbzmM5+24RpLCclagHq870cFjeEjQOunVq9chLCjET5AecJC6Rt+0dMYUmkK6Wh29OJ+dyOvM6N9o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1587998003; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=66go+qUnL+0x9DFyMdB/ulwyIsDDfR/PxnTEkOoJt6s=; 
        b=ErKLQMJxee18qAoHCJWVVSvAgvLiKa7rnP+Y4JD2L/edru6L71Xuh1j6cBiTTEjDmcnz06G9JkakaZUMjBR36ejq9jRXFiMExcGiYoYkQJULc/0Iyu0v18BboUO5SQSHhUmjPHmhftCfYGzrRw5ECWbqO1yOQWqUqHpFxPDxRUo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=trained-monkey.org;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.71.206] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 1587998002095329.7605526240973; Mon, 27 Apr 2020 16:33:22 +0200 (CEST)
Subject: Re: [PATCH] Detail: adding sync status for cluster device
To:     Zhong Lidong <lidong.zhong@suse.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-raid@vger.kernel.org
References: <20200413144128.26177-1-lidong.zhong@suse.com>
 <bcd5713f-d2e8-d358-17c9-323f9c125d1b@cloud.ionos.com>
 <5c7b0055-917c-87ee-237f-1deaeb6fc575@suse.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <ca0df151-4d01-9122-fbcf-5baf281ec86a@trained-monkey.org>
Date:   Mon, 27 Apr 2020 10:33:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5c7b0055-917c-87ee-237f-1deaeb6fc575@suse.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/14/20 4:03 AM, Zhong Lidong wrote:
> 
> 
> On 4/14/20 3:25 PM, Guoqing Jiang wrote:
>> On 13.04.20 16:41, Lidong Zhong wrote:
>>> On the node with /proc/mdstat is
>>>
>>> Personalities : [raid1]
>>> md0 : active raid1 sdb[4] sdc[3] sdd[2]
>>>        1046528 blocks super 1.2 [3/2] [UU_]
>>>          recover=REMOTE
>>>        bitmap: 1/1 pages [4KB], 65536KB chunk
>>>
>>> the 'State' of 'mdadm -Q -D' is accordingly
>>
>> Maybe rephrase it a little bit, something like.
>>
>> "Let's change the 'State' of 'mdadm -Q -D' accordingly "
>>
>> Just FYI .
>>
> 
> Thank you for your suggestion, Guoqing. I'll send the
> patch again.
> 

Please mark the patch as v2 when you repost it with a change like this.

Thanks,
Jes



