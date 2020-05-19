Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE81D941F
	for <lists+linux-raid@lfdr.de>; Tue, 19 May 2020 12:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgESKO5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 19 May 2020 06:14:57 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:32477 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgESKO5 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 19 May 2020 06:14:57 -0400
Received: from [86.146.232.119] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jazGx-0009x8-DE; Tue, 19 May 2020 11:14:55 +0100
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_2/2=5d_restripe=3a_fix_ignoring_return_val?=
 =?UTF-8?B?dWUgb2Yg4oCYcmVhZOKAmQ==?=
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jes Sorensen <jes@trained-monkey.org>
Cc:     linux-raid@vger.kernel.org
References: <20200515134026.8084-1-guoqing.jiang@cloud.ionos.com>
 <20200515134026.8084-3-guoqing.jiang@cloud.ionos.com>
 <4a888cbe-636b-b3a7-f669-8897753430d0@trained-monkey.org>
 <607932ff-0e76-9eca-1fdb-ca26428d8717@cloud.ionos.com>
 <01676778-bfc2-46d4-112b-ee16ef4cbcc1@trained-monkey.org>
 <6bd3cb34-1339-9e1b-1f57-07ef62a70818@cloud.ionos.com>
 <8671d1fb-1b59-cebf-e1f1-09490856e02b@trained-monkey.org>
 <b8df31b2-f9cf-4d4d-1846-77304b55b3ea@cloud.ionos.com>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <03f9adb1-4b1f-eba3-b376-981c06ae1e5a@youngman.org.uk>
Date:   Tue, 19 May 2020 11:14:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b8df31b2-f9cf-4d4d-1846-77304b55b3ea@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 18/05/2020 22:37, Guoqing Jiang wrote:
>> That should work, however you really should check the return value of
>> lseek as well, while looking at this.
> 
> Okay, though I did not get complain about it =-O. Anyway, will send v3.

Just for info - I'm currently building my new system, which means my old 
system will become a raid testbed. And I'm playing with dm-integrity, 
which I believe returns an integrity error not a read error when things 
go wrong.

So yes, if errors aren't handled correctly I'm quite likely to find 
myself falling over them ...

Cheers,
Wol
