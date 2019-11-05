Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA512EFDD4
	for <lists+linux-raid@lfdr.de>; Tue,  5 Nov 2019 14:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388446AbfKENAr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 Nov 2019 08:00:47 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:51648 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388008AbfKENAr (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 5 Nov 2019 08:00:47 -0500
Received: from [86.155.171.62] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iRyRx-0005fA-5F; Tue, 05 Nov 2019 13:00:45 +0000
Subject: Re: [PATCH] mdadm.8: add note information for raid0 growing operation
To:     Coly Li <colyli@suse.de>, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20191105075540.56013-1-colyli@suse.de>
 <605de72e-0771-adc8-d39c-fc9e634e9b9b@molgen.mpg.de>
 <29133ed2-98d0-94c0-8787-711ec7d5cb1a@suse.de>
Cc:     linux-raid@vger.kernel.org, NeilBrown <neilb@suse.de>,
        jes.sorensen@gmail.com
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5DC1727C.5030409@youngman.org.uk>
Date:   Tue, 5 Nov 2019 13:00:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <29133ed2-98d0-94c0-8787-711ec7d5cb1a@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 05/11/19 12:44, Coly Li wrote:
>>> are devices number before and  after  the grow operation, "* 2" comes
>> > 
>> > device numbers
> Copied. I am not sure whether it should be "device numbers" or maybe
> "devices numbers", this confuses me *^_^*
> 
It is "device numbers".

The trick for English is to ask yourself what is the singular form. Here
it is "device number". Then convert that to plural by adding an "s" at
the end.

English never "doubles up" as far as I'm aware (and I bet someone comes
up with an obscure example where it does :-)

I'm trying to think of a good example of the differences between
languages. I know in Russian you have to negate everything so to make a
sentence negative you might have several negating words in there. In
English two negatives make an emphatic positive (though I've thought of
a nice exception here!)

(My exception? "never", and "not ever" are the same. "not never" should
mean the same as "ever" or "always" but colloquially often doesn't. But
"no never" is an emphatic "never", because actually "no" doesn't negate
the never, but is a negative word itself. English is tricky :-)

Cheers,
Wol
