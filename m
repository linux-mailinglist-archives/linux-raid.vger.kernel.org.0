Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4F5B7163
	for <lists+linux-raid@lfdr.de>; Thu, 19 Sep 2019 04:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbfISCGv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 18 Sep 2019 22:06:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387591AbfISCGv (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 18 Sep 2019 22:06:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D07718C426C;
        Thu, 19 Sep 2019 02:06:51 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE18B1001281;
        Thu, 19 Sep 2019 02:06:46 +0000 (UTC)
Subject: Re: [PATCH 1/1] Call md_handle_request directly in md_flush_request
To:     David Jeffery <djeffery@redhat.com>
Cc:     linux-raid@vger.kernel.org, ncroxon@redhat.com, heinzm@redhat.com,
        neilb@suse.de, songliubraving@fb.com
References: <1568627145-14210-1-git-send-email-xni@redhat.com>
 <20190916171514.GA1970@redhat>
 <b7271fd2-5fea-092f-860c-a129d43c3a7a@redhat.com>
 <CA+-xHTEaYtctDGfY=hq_XuxTW01+sriNb6xyS5-aqtvAkkrZNw@mail.gmail.com>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <fbeffe99-afd0-abe7-ba87-85de5ce5c8bb@redhat.com>
Date:   Thu, 19 Sep 2019 10:06:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CA+-xHTEaYtctDGfY=hq_XuxTW01+sriNb6xyS5-aqtvAkkrZNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Thu, 19 Sep 2019 02:06:51 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 09/19/2019 03:15 AM, David Jeffery wrote:
> On Tue, Sep 17, 2019 at 11:21 PM Xiao Ni <xni@redhat.com> wrote:
>> md_flush_request returns false when one flush bio has data and
>> pers->make_request function go
>> on handling it. For example the raid device is raid1. md_flush_request
>> returns false, raid1_make_request
>> go on handling the bio. If raid1_make_request fails, the bio is still
>> lost. Now it looks like only md_handle_request
>> checks the return value of pers->make_request and go on handling the bio
>> if pers->make_request fails.
> But the bio isn't lost.  Using raid1 as an example, the calling sequence is
> md_handle_request -> raid1_make_request -> md_flush_request.
> raid1_make_request is already wrapped by md_handle_request.  So this
> earlier call to md_handle_request will re-submit the bio if raid1_make_request
> returns false after md_flush_request returns false.  Anything which calls an
> mddev->pers->make_request function (only md_handle_request after patch)
> must already handle a return of false or it would also have a bug allowing I/O
> to be lost.

Thanks for the explanation. You are right. The bio can't be lost.

Regards
Xiao
>
>> There should not be a deadlock if it calls md_handle_request directly.
>> Am I right? If there is a risk, we
>> can put those bios into a list and queue a work in workqueue to handle
>> them. Is it a better way?
> I don't see a deadlock with calling md_handle_request from md_flush_request.
> It's just more stack and overhead when we could instead let the first calls to
> these functions advance the I/O instead of recursing into new instances.
>
>> Regards
>> Xiao
> David Jeffery

