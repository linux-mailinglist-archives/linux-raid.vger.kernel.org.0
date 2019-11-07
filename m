Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7AECF2F8B
	for <lists+linux-raid@lfdr.de>; Thu,  7 Nov 2019 14:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388924AbfKGNfn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 Nov 2019 08:35:43 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:46955 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388856AbfKGNfl (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 7 Nov 2019 08:35:41 -0500
Received: from [81.148.226.176] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iShwq-0001jC-3G; Thu, 07 Nov 2019 13:35:40 +0000
Subject: Re: [PATCH] raid456: avoid second retry of read-error
To:     Xiao Ni <xni@redhat.com>, Nigel Croxon <ncroxon@redhat.com>,
        linux-raid@vger.kernel.org, liu.song.a23@gmail.com
References: <20191104200157.31656-1-ncroxon@redhat.com>
 <5DC0C34B.1040102@youngman.org.uk>
 <a91541f0-f38f-6b9f-b02c-b6b803e9673c@redhat.com>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5DC41DAB.6020405@youngman.org.uk>
Date:   Thu, 7 Nov 2019 13:35:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <a91541f0-f38f-6b9f-b02c-b6b803e9673c@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 07/11/19 13:17, Xiao Ni wrote:
> 
> 
> On 11/05/2019 08:33 AM, Wols Lists wrote:
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
> Hi Wol
> 
> What's the meaning of "two errors on a raid-5"? Two read errors happen
> on one disk?
> Or there are two read errors on two disks?
> 
Two read errors on two disks, so that you can't recalculate from parity.

Basically, what I was thinking was "does this patch mean that if we get
a read error, we read the parity instead and recalculate the block that
failed?". If that is the case, what happens if we get a second read
error and can't recalculate?

Because, aiu real-world behaviour, it's quite normal for the first read
to fail and the retry to succeed. So if this patch does what I think
(feel free to tell me I'm wrong :-) a double read error would make raid
return a read error, when actually the old code would have resulted in
the read being successful, if a bit slower.

Cheers,
Wol

