Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A314C55DD18
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jun 2022 15:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbiF0Swk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 Jun 2022 14:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239745AbiF0Swj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 27 Jun 2022 14:52:39 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2437EBC
        for <linux-raid@vger.kernel.org>; Mon, 27 Jun 2022 11:52:34 -0700 (PDT)
Received: from host86-158-155-35.range86-158.btcentralplus.com ([86.158.155.35] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1o5tqa-0005rr-Fa;
        Mon, 27 Jun 2022 19:52:33 +0100
Message-ID: <6ee3bff1-b7b4-5309-6a9e-d23c868f2e59@youngman.org.uk>
Date:   Mon, 27 Jun 2022 19:52:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: what's wrong with RAID-10? (was "Re: moving a working array")
Content-Language: en-GB
To:     Reindl Harald <h.reindl@thelounge.net>,
        David T-G <davidtg-robot@justpickone.org>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <CAPpdf595_7eW8amX8eueMxgjaWvLW-hWHh1SHHaGAt8YyP7yDw@mail.gmail.com>
 <7683b644cf076f8db06d60fdd3e4f88424f35bd2.camel@gmail.com>
 <92378403-adf6-dedb-828c-81b331c1d8c1@youngman.org.uk>
 <20220627104109.GJ18273@justpickone.org>
 <d058da47-528e-f9af-dbb1-5941eef72b56@youngman.org.uk>
 <4b90d4e6-186c-23ea-78be-c507bcc04427@thelounge.net>
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <4b90d4e6-186c-23ea-78be-c507bcc04427@thelounge.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 27/06/2022 19:41, Reindl Harald wrote:
> 
> 
> Am 27.06.22 um 17:10 schrieb Wols Lists:
>> On 27/06/2022 11:41, David T-G wrote:
>>> Wol, et al --
>>>
>>> ...and then Wols Lists said...
>>> %
>>> % On 24/06/2022 15:09, Wilson Jonathan wrote:
>>> % > On Fri, 2022-06-24 at 08:38 -0500, o1bigtenor wrote:
>>> % > >
>>> % > > I have a working (no issues) raid-10 array in one box.
>>> %
>>> % Bummer. It's a raid-10. A raid-1 would have been easier.
>>> [snip]
>>>
>>> This tripped me.  I presumed that the reason for -10, not least because
>>> he also said "these 4 drives", was because the array space is bigger 
>>> than
>>> just one hard drive size, ie 6T on 4ea 3T drives.  How would RAID-1 work
>>> for that storage?  And why would it be easier than RAID-10?
>>>
>> Just that raid-1 would have been a simple case of two drives, each a 
>> backup of the other. Keep one safe, put the other in the new system.
>>
>> With raid-10, it's much more complicated - you can't just do that :-(
> 
> you can easily do that with RAID10

Only if all the disks are the same size ... and an even number ...

Cheers,
Wol
