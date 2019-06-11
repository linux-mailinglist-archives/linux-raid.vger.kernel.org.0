Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9CD3C12E
	for <lists+linux-raid@lfdr.de>; Tue, 11 Jun 2019 04:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390454AbfFKCNw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 10 Jun 2019 22:13:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390172AbfFKCNw (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 10 Jun 2019 22:13:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C29EC309175F;
        Tue, 11 Jun 2019 02:13:51 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A390019C68;
        Tue, 11 Jun 2019 02:13:49 +0000 (UTC)
Subject: Re: [PATCH 1/1] raid5-cache: Need to do start() part job after adding
 journal device
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Michal Soltys <soltys@ziu.info>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Nigel Croxon <ncroxon@redhat.com>
References: <1559047314-8460-1-git-send-email-xni@redhat.com>
 <CAPhsuW4cM6Lut0Ueqip4mLVVbGRmXDmdtcMTR-cwmc98etQ4gA@mail.gmail.com>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <79011358-24c1-1c59-43d7-75fe6c6c0967@redhat.com>
Date:   Tue, 11 Jun 2019 10:13:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4cM6Lut0Ueqip4mLVVbGRmXDmdtcMTR-cwmc98etQ4gA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 11 Jun 2019 02:13:52 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 06/07/2019 12:36 AM, Song Liu wrote:
> On Tue, May 28, 2019 at 5:42 AM Xiao Ni <xni@redhat.com> wrote:
>> In d5d885fd(md: introduce new personality funciton start()) it splits the init
>> job to two parts. The first part run() does the jobs that do not require the
>> md threads. The second part start() does the jobs that require the md threads.
> nit: checkpatch.pl complains
>
> WARNING: Possible unwrapped commit description (prefer a maximum 75
> chars per line)
> #57:
> In d5d885fd(md: introduce new personality funciton start()) it splits the init
>
> I fixed this in my tree, so no need to resend.
>
>> Now it just does run() in adding new journal device. It needs to do the second
>> part start() too.
>>
>> Fixes: f6b6ec5cfac(raid5-cache: add journal hot add/remove support)
> Shall we say Fixes d5d885fd(md: introduce new personality funciton
> start()) here?
> Or do we really need the fix to earlier versions with f6b6ec5cfac?
Hi Song

You are right. It's better to put d5d885fd in the Fixes line.

Regards
Xiao
