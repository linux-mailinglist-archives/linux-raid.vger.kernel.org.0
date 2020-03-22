Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0995718E593
	for <lists+linux-raid@lfdr.de>; Sun, 22 Mar 2020 01:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgCVAcx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 21 Mar 2020 20:32:53 -0400
Received: from atl.turmel.org ([74.117.157.138]:51385 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbgCVAcw (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 21 Mar 2020 20:32:52 -0400
Received: from [108.243.25.188] (helo=[192.168.20.61])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1jFoXr-0000s8-Qd; Sat, 21 Mar 2020 20:32:51 -0400
Subject: Re: Raid6 recovery
To:     Glenn Greibesland <glenngreibesland@gmail.com>
Cc:     antlists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org,
        NeilBrown <neilb@suse.com>
References: <CA+9eyijuUEJ7Y8BuxkKaZ=v8zbPpwixOezngPjtJzaLsBd+A4Q@mail.gmail.com>
 <5E75163B.2050602@youngman.org.uk>
 <CA+9eyigMV-E=FwtXDWZszSsV6JOxxFOFVh6WzmeH=OC3heMUHw@mail.gmail.com>
 <ab2a40b6-b4ab-9ff8-aef6-02d8cce8d587@youngman.org.uk>
 <CA+9eyig8U2Tzi1wF97k7eDu5vKg5Jc2sRXKaw0OCy7Cbc9HMog@mail.gmail.com>
 <c55be05d-22ee-4676-7878-5bf99ccc80f9@turmel.org>
 <CA+9eyiicKrPh9YTrGN5FjOU7zMVMqO3=8yGszWkV67fJxrtKrw@mail.gmail.com>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <50fc13d2-bd5f-d3c3-09f6-f7274aeaf917@turmel.org>
Date:   Sat, 21 Mar 2020 20:32:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CA+9eyiicKrPh9YTrGN5FjOU7zMVMqO3=8yGszWkV67fJxrtKrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 3/21/20 6:12 PM, Glenn Greibesland wrote:

[trim /]

> So to summarize what happened and what I've learned:
> I had a RAID6 array with only 16 out of 18 working drives.
> I received an email from mdadm saying another drive failed.
> I ran a full offline smart test that completed successfuly.
> 
> The drive was in F (failed) state. I used --re-add and mdadm overwrote
> the superblock turning it into a spare drive instead of putting the
> drive back into slot 10.
> I should have used --assemble --force.
> 
> Am I correct?

Yes.

However, there have been bugs in --force that would cause it to not 
assemble.  Also, I believe latest behavior for --re-add would not have 
damaged the metadata.


Phil
