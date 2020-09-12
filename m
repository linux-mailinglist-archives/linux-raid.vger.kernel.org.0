Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F24267BC9
	for <lists+linux-raid@lfdr.de>; Sat, 12 Sep 2020 20:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgILSl1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 12 Sep 2020 14:41:27 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:63900 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgILSlY (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 12 Sep 2020 14:41:24 -0400
Received: from host86-136-163-47.range86-136.btcentralplus.com ([86.136.163.47] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1kHASg-0006Z4-71; Sat, 12 Sep 2020 19:41:22 +0100
Subject: Re: Linux raid-like idea
To:     John Stoffel <john@stoffel.org>
Cc:     linux-raid@vger.kernel.org
References: <1cf0d18c-2f63-6bca-9884-9544b0e7c54e.ref@aim.com>
 <1cf0d18c-2f63-6bca-9884-9544b0e7c54e@aim.com>
 <e3cb1bbe-65eb-5b75-8e99-afba72156b6e@youngman.org.uk>
 <ef3719a9-ae53-516e-29ee-36d1cdf91ef1@aim.com>
 <5F54146F.40808@youngman.org.uk>
 <274cb804-9cf1-f56c-9ee4-56463f052c09@aim.com>
 <ddd9b5b9-88e6-e730-29f4-30dfafd3a736@youngman.org.uk>
 <38f9595b-963e-b1f5-3c29-ad8981e677a7@aim.com>
 <9220ea81-3a81-bb98-22e3-be1a123113a1@youngman.org.uk>
 <24413.1342.676749.275674@quad.stoffel.home>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <9ba44595-8986-0b22-7495-d8a15fb96dbd@youngman.org.uk>
Date:   Sat, 12 Sep 2020 19:41:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <24413.1342.676749.275674@quad.stoffel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 12/09/2020 18:28, John Stoffel wrote:
> I had one of my 4tb disks fall out of my main VG, but I didn't lose
> and data, I just checked the disk and added it back in.  I've got a
> new 4tb disk on order along with a drive cage so I can balance things
> better.
> 
> But it's almost to the point where it's cheaper to buy a pair of 8tb
> drives to replace the 4x4tb drives I'm using now.  But I probably
> won't.
> 
You should have bought an 8TB to replace the 4 ... one more failure :-( 
and you would have your 2x8 (and raid-0 the remaining 4s to provide your 
3rd mirror).

> I could  write for hours here... it's a tough problem space to work
> through.

Made worse if, like me, you're more into logical completeness than "will 
it finish in finite time" :-)

Cheers,
Wol
