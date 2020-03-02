Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D133A1759AE
	for <lists+linux-raid@lfdr.de>; Mon,  2 Mar 2020 12:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgCBLoO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Mar 2020 06:44:14 -0500
Received: from atl.turmel.org ([74.117.157.138]:39596 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgCBLoO (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 2 Mar 2020 06:44:14 -0500
Received: from [108.243.25.188] (helo=[192.168.20.61])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1j8jUb-0007Mu-VL; Mon, 02 Mar 2020 06:44:14 -0500
Subject: Re: Linux 5.5 Breaks Raid1 on Device instead of Partition, Unusable
 I/O
To:     "David C. Rankin" <drankinatty@suddenlinkmail.com>,
        mdraid <linux-raid@vger.kernel.org>
References: <e46b2ae7-3b88-05f2-58d7-94ee3df449e4@suddenlinkmail.com>
 <20200302102542.309e2d19@natsu>
 <920df583-1d9e-6037-1d61-cbd5e1133d4d@suddenlinkmail.com>
 <20200302115141.1e796b7c@natsu>
 <c5d8e6d2-a572-5602-6562-795ea52168ac@suddenlinkmail.com>
 <CAJCQCtTOJrvm7BnyqSSuCUa82ehZbtHgSGaQo1bzcepgdtazSw@mail.gmail.com>
 <9e31d56a-a35d-2413-b6c7-4a97445d487d@suddenlinkmail.com>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <9b1ceff4-1299-8e8a-cbc9-da717c72bba3@turmel.org>
Date:   Mon, 2 Mar 2020 06:44:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9e31d56a-a35d-2413-b6c7-4a97445d487d@suddenlinkmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi David,

On 3/2/20 4:27 AM, David C. Rankin wrote:
> On 03/02/2020 01:08 AM, Chris Murphy wrote:
>> smart also reports for /de/sdc
>>
>>    40 53 00 ff ff ff 0f  Error: UNC at LBA = 0x0fffffff = 268435455
>>
>>
>> So I'm suspicious of timeout mismatch as well.
>> https://raid.wiki.kernel.org/index.php/Timeout_Mismatch
>>
>>
>> Chris Murphy
>>
> 
> The strace between the virtualbox host and guess show and number of I/O waits
> that would seem to fit some timeout issue like that. But according to the
> page, both drives in this array provide:
> 
> SCT capabilities:              (0x1085) SCT Status supported.

SCT Status itself isn't sufficient.  You must have ERC "Error Recovery 
Control", an optional part of SCT.

smartctl -a doesn't expose that.  Use smartctl -x in general, or 
smartctl -l scterc to specifically check the needed setting.

Phil
