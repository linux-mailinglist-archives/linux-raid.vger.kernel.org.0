Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 420E0643C3
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jul 2019 10:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfGJIqj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 10 Jul 2019 04:46:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbfGJIqj (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 10 Jul 2019 04:46:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2040B5946F;
        Wed, 10 Jul 2019 08:46:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C0BD5FCB2;
        Wed, 10 Jul 2019 08:46:36 +0000 (UTC)
Subject: Re: Raid 1 vs Raid 5 suggestion
To:     Wols Lists <antlists@youngman.org.uk>,
        Luca Lazzarin <luca.lazzarin@gmail.com>,
        linux-raid@vger.kernel.org
References: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
 <5D25196A.9020606@youngman.org.uk>
 <da428a60-aa9a-1cd9-d766-237fd885d425@redhat.com>
 <5D25A4A4.2000609@youngman.org.uk>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <6e20bc11-9afb-3183-102e-2305990d5c89@redhat.com>
Date:   Wed, 10 Jul 2019 16:46:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <5D25A4A4.2000609@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 10 Jul 2019 08:46:39 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 07/10/2019 04:41 PM, Wols Lists wrote:
> On 10/07/19 09:35, Xiao Ni wrote:
>> It can create raid device on dm integrity device. So raid can fix the
>> silent data corruption
>> automatically itself. For example a raid1 with two members A and B. When
>> there are some
>> data corruption on A disk, the read from A will fail, because dm
>> integrity return error to
>> raid1. At this time, raid1 can fix this automatically.
> Can you point me at some documentation on how to use this? This should
> go in the raid wiki, as it sounds like it's something that users ought
> to put in the stack, and I never knew about it.
>
> Cheers,
> Wol

Yes. I learned about this from this article 
https://securitypitfalls.wordpress.com/2018/05/08/raid-doesnt-work/
As this article pointed, raid6 has problem to support this. The patch 
which I sent recent should fix this problem.

Regards
Xiao
