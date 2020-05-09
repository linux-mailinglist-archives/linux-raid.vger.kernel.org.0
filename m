Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205E51CC1BC
	for <lists+linux-raid@lfdr.de>; Sat,  9 May 2020 15:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgEINUq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 9 May 2020 09:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgEINUp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 9 May 2020 09:20:45 -0400
Received: from forward104p.mail.yandex.net (forward104p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3003C061A0C
        for <linux-raid@vger.kernel.org>; Sat,  9 May 2020 06:20:45 -0700 (PDT)
Received: from mxback21o.mail.yandex.net (mxback21o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::72])
        by forward104p.mail.yandex.net (Yandex) with ESMTP id EE2904B00CDE;
        Sat,  9 May 2020 16:20:39 +0300 (MSK)
Received: from myt5-aad1beefab42.qloud-c.yandex.net (myt5-aad1beefab42.qloud-c.yandex.net [2a02:6b8:c12:128:0:640:aad1:beef])
        by mxback21o.mail.yandex.net (mxback/Yandex) with ESMTP id F9UUvXdgik-KdRu1FBL;
        Sat, 09 May 2020 16:20:39 +0300
Received: by myt5-aad1beefab42.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id uBWqlNc1Uc-Kc2aoakT;
        Sat, 09 May 2020 16:20:39 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: Assemblin journaled array fails
To:     antlists <antlists@youngman.org.uk>,
        linux-raid <linux-raid@vger.kernel.org>
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <9591809e-583d-ebd5-ea0f-a342868a7728@youngman.org.uk>
From:   Michal Soltys <msoltyspl@yandex.pl>
Message-ID: <1615c45f-8f7c-fae2-ef74-a23a29857316@yandex.pl>
Date:   Sat, 9 May 2020 15:20:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9591809e-583d-ebd5-ea0f-a342868a7728@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 20/05/09 15:15, antlists wrote:
> On 09/05/2020 11:54, Michal Soltys wrote:
>> After the reboot I'm in the situation as outlined above. Any 
>> suggestion how to assemble this array now ?
> 
> mdadm -v ?

mdadm - v4.1 - 2018-10-01

> 
> uname -a ?

Linux xs22 5.4.0-0.bpo.4-amd64 #1 SMP Debian 5.4.19-1~bpo10+1 
(2020-03-09) x86_64 GNU/Linux

> 
> https://raid.wiki.kernel.org/index.php/Asking_for_help
> 
> Dunno what the problem is, and I'm hesitant to recommend it, but 
> re-assembling the array without a journal might work.

I would - if possible - want to avoid this, as the journal is 
write-back. So as a last resort only.

> 
> You have made sure that bitmaps aren't enabled? You can't have both, but 
> for historical reasons you can end up with both enabled and then the 
> resulting array won't start.
> 

Yea, I know - the bitmap is not enabled on this array.

