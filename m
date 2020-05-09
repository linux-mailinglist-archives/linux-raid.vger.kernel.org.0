Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711B51CC101
	for <lists+linux-raid@lfdr.de>; Sat,  9 May 2020 13:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgEILdN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 9 May 2020 07:33:13 -0400
Received: from forward102j.mail.yandex.net ([5.45.198.243]:39731 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726600AbgEILdN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 9 May 2020 07:33:13 -0400
Received: from mxback14o.mail.yandex.net (mxback14o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::65])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id 9EE4FF20B71
        for <linux-raid@vger.kernel.org>; Sat,  9 May 2020 14:33:09 +0300 (MSK)
Received: from myt4-07bed427b9db.qloud-c.yandex.net (myt4-07bed427b9db.qloud-c.yandex.net [2a02:6b8:c00:887:0:640:7be:d427])
        by mxback14o.mail.yandex.net (mxback/Yandex) with ESMTP id VSKTLrIboT-X9GuD7lL;
        Sat, 09 May 2020 14:33:09 +0300
Received: by myt4-07bed427b9db.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id r806WGirlP-X72Ohrfe;
        Sat, 09 May 2020 14:33:07 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: Assemblin journaled array fails
From:   Michal Soltys <msoltyspl@yandex.pl>
To:     linux-raid <linux-raid@vger.kernel.org>
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
Message-ID: <b50213d9-771f-be8e-4183-659a0b4ebce5@yandex.pl>
Date:   Sat, 9 May 2020 13:32:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 20/05/09 12:54, Michal Soltys wrote:
> # At this point mdadm confirmed everything went fine
> 
> After the reboot I'm in the situation as outlined above. Any suggestion 
> how to assemble this array now ?

To expand on this: "after reboot" means a few days later - the array was 
operating fine during that time.

Attempting to assembly the arrary manually from early initramfs (before 
any udev/etc. and with manually loaded modules), e.g.:

mdadm -A /dev/md/r5_big /dev/sd[efgh]1 /dev/md/r1_journal_big

shows:

md/raid:md126: device sde1 operational as raid disk 0
md/raid:md126: device sdh1 operational as raid disk 3
md/raid:md126: device sdg1 operational as raid disk 2
md/raid:md126: device sdf1 operational as raid disk 1
md/raid:md126: raid level 5 active with 4 out of 4 devices, algorithm 2

But then mdadm is left hanging for good.

