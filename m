Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8166413993C
	for <lists+linux-raid@lfdr.de>; Mon, 13 Jan 2020 19:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAMSq5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 13 Jan 2020 13:46:57 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:40944 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbgAMSq5 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 13 Jan 2020 13:46:57 -0500
Received: from [81.135.72.163] (helo=[192.168.1.162])
        by smtp.hosts.co.uk with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1ir4jm-0004FZ-6L; Mon, 13 Jan 2020 18:46:55 +0000
Subject: Re: Reassembling Raid5 in degraded state
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Christian Deufel <christian.deufel@inview.de>,
        linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
References: <54384251-9978-eb99-e7ec-2da35f41566c@inview.de>
 <5E1C86F4.4070506@youngman.org.uk>
 <CAPhsuW45052b5OjoWgQhs0r50CeisBS3ya3nGi74Jr0_8HDB5A@mail.gmail.com>
From:   Wol <antlists@youngman.org.uk>
Message-ID: <7b7c8d20-6402-485b-5251-956637acb7db@youngman.org.uk>
Date:   Mon, 13 Jan 2020 18:46:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW45052b5OjoWgQhs0r50CeisBS3ya3nGi74Jr0_8HDB5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 13/01/2020 17:31, Song Liu wrote:
>> Song, Neil,
>>
>> Just a guess as to what went wrong, but the array event count does not
>> match the disk counts. Iirc this is one of the events that cause an
> Which mismatch do you mean?
> 
>> assemble to stop. Is it possible that a crash at the wrong moment could
>> interrupt an update and trigger this problem?
> It looks like sdc1 failed first. Then sdd1 and sdf1 got events for sdc1 failed.
> Based on super block on sdd1 and sdf1, we already have two failed drive,
> so assemble stopped.
> 
> Does this answer the question?
> 
Sorry yes it does. My fault for mis-reading the logs the OP sent.

Cheers.,
Wol
