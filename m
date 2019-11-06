Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB3BF1BAD
	for <lists+linux-raid@lfdr.de>; Wed,  6 Nov 2019 17:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfKFQwE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 6 Nov 2019 11:52:04 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:57024 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbfKFQwE (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 6 Nov 2019 11:52:04 -0500
Received: from [81.148.226.176] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iSOXK-0007L5-88; Wed, 06 Nov 2019 16:52:02 +0000
Subject: Re: [PATCH] raid456: avoid second retry of read-error
To:     Nigel Croxon <ncroxon@redhat.com>, linux-raid@vger.kernel.org,
        liu.song.a23@gmail.com
References: <20191104200157.31656-1-ncroxon@redhat.com>
 <5DC0C34B.1040102@youngman.org.uk>
 <dc736544-465e-f4eb-ca6d-e7b135074839@redhat.com>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5DC2FA31.6060503@youngman.org.uk>
Date:   Wed, 6 Nov 2019 16:52:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <dc736544-465e-f4eb-ca6d-e7b135074839@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 05/11/19 22:46, Nigel Croxon wrote:
> 
> On 11/4/19 7:33 PM, Wols Lists wrote:
>> On 04/11/19 20:01, Nigel Croxon wrote:
>>> The MD driver for level-456 should prevent re-reading read errors.
>>>
>>> For redundant raid it makes no sense to retry the operation:
>>> When one of the disks in the array hits a read error, that will
>>> cause a stall for the reading process:
>>> - either the read succeeds (e.g. after 4 seconds the HDD error
>>> strategy could read the sector)
>>> - or it fails after HDD imposed timeout (w/TLER, e.g. after 7
>>> seconds (might be even longer)
>> Okay, I'm being completely naive here, but what is going on? Are you
>> saying that if we hit a read error, we just carry on, ignore it, and
>> calculate the missing block from parity?
>>
>> If so, what happens if we hit two errors on a raid-5, or 3 on a raid-6,
>> or whatever ... :-)
>>
>> Cheers,
>> Wol
> 
> This allows the device (disk) to fail faster.  All logic is the same.
> 
> If there is a read error, it does not retry that read, it calculates
> 
> the data from the other disks.  This patch removes the retry.
> 
Ummm ...

I suspect there is a very good reason for the retry ...

Bear in mind I don't actually KNOW anything, you'll need to check with
someone who knows about these things, but I get the impression that
transient errors aren't that uncommon. It fails, you try again, it succeeds.

So if you're going to go down that route, by all means re-calculate from
parity if ONE read fails, but if you get more failures such that the
raid fails, you need to retry those reads because there is a good chance
they will succeed second time round.

Cheers,
Wol

