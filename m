Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F61B2C99C9
	for <lists+linux-raid@lfdr.de>; Tue,  1 Dec 2020 09:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgLAIqC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 1 Dec 2020 03:46:02 -0500
Received: from mout01.posteo.de ([185.67.36.65]:37489 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgLAIqC (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 1 Dec 2020 03:46:02 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 57476160061
        for <linux-raid@vger.kernel.org>; Tue,  1 Dec 2020 09:45:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.jp; s=2017;
        t=1606812305; bh=BilTHcDnXeZKLk3EssTYDMELextUIqx/zSQ92fEKllE=;
        h=Date:From:To:Cc:Subject:From;
        b=dvMFImxzQDeqQK6mlthuNfEHwU90X7c/ufZro3htV3Lr9h/xaNCkvBTSgb3+pPn2B
         WZnyVqLxW526mCno+3/vDkzR72qaYvA8xEjJaO09WmDQIYzEa20oDfd8QtksdkcAMb
         k7snFulp0scmGkJ3EY/uj1QGueQP0diX9fKUsTmKa2POg6Orzhz/xPlk7BMifP6c0V
         4OGtMru1JUh7eIHsw3V7LZvhXHB7ADz+EkFPyEy9x94QO/wcwFZmBrxE7p01jAArB0
         rninJOYNHEG4fr6uKsofEsCLCss7vx2gnUQyecH1Ocd2CUXazXe7vGp3EDhN1/zf8I
         7OM7gyoyWLLvA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4ClbJc4kZYz6tm8;
        Tue,  1 Dec 2020 09:45:04 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Dec 2020 09:45:04 +0100
From:   c.buhtz@posteo.jp
To:     antlists <antlists@youngman.org.uk>
Cc:     David T-G <davidtg-robot@justpickone.org>,
        linux-raid@vger.kernel.org
Subject: Re: partitions & filesystems (was "Re: =?UTF-8?Q?=3F=3F=3Froot=20?=
 =?UTF-8?Q?account=20locked=3F=3F=3F=20after=20removing=20one=20RAID=31=20?=
 =?UTF-8?Q?hard=20disc=22=29?=
In-Reply-To: <01a571de-8ae8-3d9e-6f3d-16555ad93ea3@youngman.org.uk>
References: <e6b7a61d16a25c433438c670fa4c0b4f@posteo.de>
 <20201130200503.GV1415@justpickone.org>
 <01a571de-8ae8-3d9e-6f3d-16555ad93ea3@youngman.org.uk>
Message-ID: <1914ec9a6f74130a8e6399c08edefdc1@posteo.de>
X-Sender: c.buhtz@posteo.jp
User-Agent: Posteo Webmail
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I think my missunderstand depends also on my bad english?

Am 30.11.2020 21:51 schrieb antlists:
> On 30/11/2020 20:05, David T-G wrote:
>> You don't see any "filesystem" or, more correctly, partition in your
>> 
>>    fdisk -l
>> 
>> output because you have apparently created your filesystem on the 
>> entire
>> device (hey, I didn't know one could do that!).
> 
> That, actually, is the norm. It is NOT normal to partition a raid 
> array.

In my understanding you are contradicting yourself here.
Is there a difference between
   "create filesystem on the entire device"
and
   "partition a raid array"
?
