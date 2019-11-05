Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBDF2EFE2D
	for <lists+linux-raid@lfdr.de>; Tue,  5 Nov 2019 14:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389181AbfKENPd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 Nov 2019 08:15:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:48930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388945AbfKENPd (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 5 Nov 2019 08:15:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E2088AF47;
        Tue,  5 Nov 2019 13:15:31 +0000 (UTC)
Subject: Re: [PATCH] mdadm.8: add note information for raid0 growing operation
To:     Wols Lists <antlists@youngman.org.uk>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-raid@vger.kernel.org, NeilBrown <neilb@suse.de>,
        jes.sorensen@gmail.com
References: <20191105075540.56013-1-colyli@suse.de>
 <605de72e-0771-adc8-d39c-fc9e634e9b9b@molgen.mpg.de>
 <29133ed2-98d0-94c0-8787-711ec7d5cb1a@suse.de>
 <5DC1727C.5030409@youngman.org.uk>
From:   Coly Li <colyli@suse.de>
Organization: SUSE Labs
Message-ID: <b6295129-6200-33cb-10dc-5bed6503c442@suse.de>
Date:   Tue, 5 Nov 2019 21:15:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <5DC1727C.5030409@youngman.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2019/11/5 9:00 下午, Wols Lists wrote:
> On 05/11/19 12:44, Coly Li wrote:
>>>> are devices number before and  after  the grow operation, "* 2" comes
>>>>
>>>> device numbers
>> Copied. I am not sure whether it should be "device numbers" or maybe
>> "devices numbers", this confuses me *^_^*
>>
> It is "device numbers".
> 
> The trick for English is to ask yourself what is the singular form. Here
> it is "device number". Then convert that to plural by adding an "s" at
> the end.
> 

Let me explain why I am confused.

Because the raid0 device can be combined by many disks, there will be
multiple component devices, so I think the number should be "component
disks number". Then I mentioned old and new numbers, there are two
numbers, so I am not sure whether I should use "devices numbers",
because devices means multiple component devices, and numbers means
there are two numbers (one for old, one for new).

> English never "doubles up" as far as I'm aware (and I bet someone comes
> up with an obscure example where it does :-)
> 

By the above explanation, is it still "device numbers" ?

Thank you in advance.

-- 

Coly Li
