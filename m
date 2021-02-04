Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445FB30C409
	for <lists+linux-raid@lfdr.de>; Tue,  2 Feb 2021 16:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhBBPjS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 2 Feb 2021 10:39:18 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39339 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbhBBPPe (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 2 Feb 2021 10:15:34 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1l6xLu-0002oq-Ri; Tue, 02 Feb 2021 16:12:26 +0100
Subject: Re: [PATCH 2/2] dm crypt: support using trusted keys
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        =?UTF-8?Q?Jan_L=c3=bcbbe?= <jlu@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Baryshkov <dbaryshkov@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        dm-devel@redhat.com, keyrings@vger.kernel.org,
        kernel@pengutronix.de, linux-integrity@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>
References: <20210122084321.24012-1-a.fatoum@pengutronix.de>
 <20210122084321.24012-2-a.fatoum@pengutronix.de>
 <YAsT/N8CHHNTZcj3@kernel.org> <YAsW8DAt3vc68rLA@kernel.org>
 <5d44e50e-4309-830b-79f6-f5d888b1ef69@pengutronix.de>
Message-ID: <8cd946c4-558d-ca66-7026-a574034b4757@pengutronix.de>
Date:   Tue, 2 Feb 2021 16:12:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <5d44e50e-4309-830b-79f6-f5d888b1ef69@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-raid@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 22.01.21 20:04, Ahmad Fatoum wrote:
> On 22.01.21 19:18, Jarkko Sakkinen wrote:
>> On Fri, Jan 22, 2021 at 08:05:51PM +0200, Jarkko Sakkinen wrote:
>>> On Fri, Jan 22, 2021 at 09:43:21AM +0100, Ahmad Fatoum wrote:
>>>> Commit 27f5411a718c ("dm crypt: support using encrypted keys") extended
>>>> dm-crypt to allow use of "encrypted" keys along with "user" and "logon".
>>>>
>>>> Along the same lines, teach dm-crypt to support "trusted" keys as well.

Gentle ping.
Is there anything further you require from me regarding these two patches?

>>>>
>>>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>>>> ---
>>>
>>> Is it possible to test run this with tmpfs? Would be a good test
>>> target for Sumit's ARM-TEE trusted keys patches.
> 
> I tested these on top of Sumit's patches with TPM and a CAAM blobifier
> backend, I am preparing. The system I am developing these patches against
> doesn't have a TEE.  Steps to test these changes:
> 
> #!/bin/sh
> 
> DEV=/dev/loop0
> ALGO=aes-cbc-essiv:sha256
> KEYNAME=kmk
> BLOCKS=20
> 
> fallocate -l $((BLOCKS*512)) /tmp/loop0.img
> losetup -P $DEV /tmp/loop0.img
> mount -o remount,rw /
> KEY="$(keyctl add trusted $KEYNAME 'new 32' @s)"
> keyctl pipe $KEY >$HOME/kmk.blob
> 
> TABLE="0 $BLOCKS crypt $ALGO :32:trusted:$KEYNAME 0 $DEV 0 1 allow_discards"
> echo $TABLE | dmsetup create mydev
> echo $TABLE | dmsetup load mydev
> dd if=/dev/zero of=/dev/mapper/mydev
> echo "It works!" 1<> /dev/mapper/mydev
> cryptsetup close mydev
> 
> reboot
> 
> DEV=/dev/loop0
> ALGO=aes-cbc-essiv:sha256
> KEYNAME=kmk
> BLOCKS=20
> 
> losetup -P $DEV $HOME/loop0.img
> keyctl add trusted $KEYNAME "load $(cat $HOME/kmk.blob)" @s
> TABLE="0 $BLOCKS crypt $ALGO :32:trusted:$KEYNAME 0 $DEV 0 1 allow_discards"
> echo $TABLE | dmsetup create mydev
> echo $TABLE | dmsetup load mydev
> 
> # should print that It works!
> hexdump -C /dev/mapper/mydev
> 
>>> https://lore.kernel.org/linux-integrity/1604419306-26105-1-git-send-email-sumit.garg@linaro.org/
>>
>> Also, I would hold merging *this* patch up until we are able to
>> test TEE trusted keys with TEE trusted keys.
> 
> Which blocks which? I tested this with TPM-Trusted keys, so it's usable
> as is. For convenient usage, it would be nice to have cryptsetup
> support for trusted and encrypted keys. I intended to look at this next week.
> 
> Cheers,
> Ahmad
> 
>>
>> /Jarkko
>>
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
