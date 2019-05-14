Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E12C01D0B9
	for <lists+linux-raid@lfdr.de>; Tue, 14 May 2019 22:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfENUg3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 May 2019 16:36:29 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:41658 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbfENUg3 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 May 2019 16:36:29 -0400
Received: from [86.154.25.122] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1hQe9z-0007nd-Aj; Tue, 14 May 2019 21:36:27 +0100
Subject: Re: Help restoring a raid10 Array (4 disk + one spare) after a hard
 disk failure at power on
To:     eric.valette@free.fr, Julien ROBIN <julien.robin28@free.fr>,
        linux-raid@vger.kernel.org
References: <87d22dc0-4b45-e13f-86e1-d3e9fbd7f55d@free.fr>
 <b4c92096-3096-63ff-24ea-b2745b20942c@free.fr>
 <27ab1f31-f125-4043-e417-6942a1d57965@free.fr>
 <cb0ab61f-788a-2c7d-ed17-5588726793fe@free.fr>
 <ecdd014f-9fb3-03ea-0272-7e05ccd69eb8@free.fr>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5CDB26CA.1070208@youngman.org.uk>
Date:   Tue, 14 May 2019 21:36:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <ecdd014f-9fb3-03ea-0272-7e05ccd69eb8@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14/05/19 18:41, Eric Valette wrote:
> On 14/05/2019 19:25, Julien ROBIN wrote:
> 
> Thanks a lot. I think I'm ok (rather will be in 5 hours).
> 
>> mdadm --assemble /dev/md0 /dev/loop0 /dev/loop1 /dev/loop3 /dev/loop4
>> mdadm: /dev/md0 assembled from 3 drives and 1 spare - need all 4 to
>> start it (use --run to insist).
> 
> I only did mdadm --assemble --run /dev/md0
> 
> and it started rebuilding automatically using the spare. Dunno why it
> did not work automatically (did not put --run the first time I tried).

If an array is degraded for some reason, it will often refuse to start
running. It actually makes a lot of sense that the array should refuse
to come back without some sort of operator intervention. (That refusal
is only for the first time - if the operator starts a faulty array, it
will then happily re-start.)

This is (sort of) documented on the raid wiki. I'd love to add more
detail but my raid-fu isn't good enough to know what actually happens,
so I can't document it ... :-)

Cheers,
Wol
