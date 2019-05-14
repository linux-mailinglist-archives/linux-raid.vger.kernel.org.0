Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A84C1CF80
	for <lists+linux-raid@lfdr.de>; Tue, 14 May 2019 21:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfENTAV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 May 2019 15:00:21 -0400
Received: from mail.thelounge.net ([91.118.73.15]:56721 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfENTAV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 May 2019 15:00:21 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 453RpB5P17zXLx;
        Tue, 14 May 2019 21:00:18 +0200 (CEST)
Subject: Re: Help restoring a raid10 Array (4 disk + one spare) after a hard
 disk failure at power on
To:     eric.valette@free.fr, linux-raid@vger.kernel.org
References: <87d22dc0-4b45-e13f-86e1-d3e9fbd7f55d@free.fr>
 <1bc43f99-3c57-db16-64d2-e5ab7d2e27cf@thelounge.net>
 <dd7cd835-23f5-38de-0bb7-e13a408ef83a@free.fr>
 <5a28b0de-c50a-fdd1-f6ea-7746da3c9a6e@thelounge.net>
 <9fcb4980-b0d4-9f20-8e37-fd2dc4768e78@free.fr>
 <66e55468-4d42-ab61-7621-90af2d37f78e@thelounge.net>
 <fb758347-7206-4dd9-688a-1c958a92aaaa@free.fr>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <5f13986a-bb5e-71fb-5001-2c9e1a57c38c@thelounge.net>
Date:   Tue, 14 May 2019 21:00:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fb758347-7206-4dd9-688a-1c958a92aaaa@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 14.05.19 um 20:53 schrieb Eric Valette:
> On 14/05/2019 20:38, Reindl Harald wrote:
>>
>>
>> Am 14.05.19 um 20:33 schrieb Eric Valette:
>>> Fine. Again where is it documented? The documentation the contrary. So
>>> go and fix the doc instead of ranting again end user.
>>
>> you better cool down given that *i am* an enduser and when you think you
>> reach anything by piss off ousers hwich show you how your setup should
>> look like you are likely wrong
> I only say two things:
> 
>    1) you were not helping me on my important problem which was
> restoring the array and recovering my data, just blaming a config file
> content

fine, if it's no help for you get as much as possible informations as
possible....

>    2) explaining here by blaming someone who carefully followed the
> wiki,faq and mdadm readme how RAID should be created and mdmadm config
> file should be written is probably not efficient. Update the docs luke,

frankly when you are not interested in how setups look which had never
problems with dying disks to improve your setup it#s fine for me

> BTW it appears, device naming was not the real problem in the end rather
> that if a device disappears after a reboot, you have nothing special to
> do except reassembling the array  and force rebuilding the needed spare
> if you have sufficient spare. I just expected it to be automatic.
and that's what i don't understand and likely is because of a non
perfect and not well tested setup, mine boots as long as there are two
disks holding both mirrors all the time

didn't you test how your setup behaves when you plug a drive and how to
restore it *before* put data on it - that may sound arrogant but any
redundant setup or backup is worthless until it#s tested against the
expected points of failure

