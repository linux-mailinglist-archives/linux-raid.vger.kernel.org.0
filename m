Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4676C103A06
	for <lists+linux-raid@lfdr.de>; Wed, 20 Nov 2019 13:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbfKTMZa (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 20 Nov 2019 07:25:30 -0500
Received: from icebox.esperi.org.uk ([81.187.191.129]:50842 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbfKTMZa (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 20 Nov 2019 07:25:30 -0500
X-Greylist: delayed 2750 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Nov 2019 07:25:29 EST
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.15.2/8.15.2) with ESMTP id xAKBcSkH010085;
        Wed, 20 Nov 2019 11:38:28 GMT
From:   Nix <nix@esperi.org.uk>
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     Coly Li <colyli@suse.de>, Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-raid@vger.kernel.org, NeilBrown <neilb@suse.de>,
        jes.sorensen@gmail.com
Subject: Re: [PATCH] mdadm.8: add note information for raid0 growing operation
References: <20191105075540.56013-1-colyli@suse.de>
        <605de72e-0771-adc8-d39c-fc9e634e9b9b@molgen.mpg.de>
        <29133ed2-98d0-94c0-8787-711ec7d5cb1a@suse.de>
        <5DC1727C.5030409@youngman.org.uk>
Emacs:  don't cry -- it won't help.
Date:   Wed, 20 Nov 2019 11:39:26 +0000
In-Reply-To: <5DC1727C.5030409@youngman.org.uk> (Wols Lists's message of "Tue,
        5 Nov 2019 13:00:44 +0000")
Message-ID: <87blt6g4k1.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC--Metrics: loom 1480; Body=6 Fuz1=6 Fuz2=6
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5 Nov 2019, Wols Lists spake thusly:

> On 05/11/19 12:44, Coly Li wrote:
>>>> are devices number before and  after  the grow operation, "* 2" comes
>>> > 
>>> > device numbers
>> Copied. I am not sure whether it should be "device numbers" or maybe
>> "devices numbers", this confuses me *^_^*
>> 
> It is "device numbers".
>
> The trick for English is to ask yourself what is the singular form. Here
> it is "device number". Then convert that to plural by adding an "s" at
> the end.
>
> English never "doubles up" as far as I'm aware (and I bet someone comes
> up with an obscure example where it does :-)

Doubling up, I'm not sure of, but pluralizing an unexpected word can
happen. Borrowed noun phrases from other languages that have adjectives
following nouns are one case I can think of. e.g. A court martial -> two
courts martial. But frankly even most native English speakers get this
wrong, so you could well consider this to be an example of 19th-century
grammatical pettifoggery that doesn't actually resemble the grammar
encoded inside native speakers' brains ("court martials" doesn't sound
that wrong to *me*, sorry 19th-century grammarians).

> (My exception? "never", and "not ever" are the same.

They are similar, but 'not ever' is often more emphatic. :)
