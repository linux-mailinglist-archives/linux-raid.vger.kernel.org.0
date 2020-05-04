Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205E71C35BB
	for <lists+linux-raid@lfdr.de>; Mon,  4 May 2020 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgEDJa0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 May 2020 05:30:26 -0400
Received: from forward104o.mail.yandex.net ([37.140.190.179]:33763 "EHLO
        forward104o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728071AbgEDJa0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 4 May 2020 05:30:26 -0400
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id D583994168B;
        Mon,  4 May 2020 12:30:17 +0300 (MSK)
Received: from mxback4q.mail.yandex.net (mxback4q.mail.yandex.net [IPv6:2a02:6b8:c0e:6d:0:640:ed15:d2bd])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id D362FCF4000C;
        Mon,  4 May 2020 12:30:17 +0300 (MSK)
Received: from vla5-e763f15c6769.qloud-c.yandex.net (vla5-e763f15c6769.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:e763:f15c])
        by mxback4q.mail.yandex.net (mxback/Yandex) with ESMTP id j0hxr7Qwq0-UHcqOkcs;
        Mon, 04 May 2020 12:30:17 +0300
Received: by vla5-e763f15c6769.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id y5kzI0XNj1-UGraZjvv;
        Mon, 04 May 2020 12:30:16 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: WD Red drives are now SMR drives?
To:     antlists <antlists@youngman.org.uk>,
        Linux RAID <linux-raid@vger.kernel.org>
References: <b012e351-54cb-47c5-5fd7-fd2ee22322ed@youngman.org.uk>
From:   Michal Soltys <msoltyspl@yandex.pl>
Message-ID: <26b6116b-5a4f-f8a7-34d0-0dcc58c8702d@yandex.pl>
Date:   Mon, 4 May 2020 11:30:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b012e351-54cb-47c5-5fd7-fd2ee22322ed@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/4/20 1:38 AM, antlists wrote:
> Has anyone else picked up on this? Apparently 1TB and 8TB drives are 
> still CMR, but new drives between 2 and 6 TB are now SMR drives.
> 
> https://www.extremetech.com/computing/309730-western-digital-comes-clean-shares-which-hard-drives-use-smr 
> 
> 
> What impact will this have on using them in raid arrays?

blocksandfiles had quite a few articles recently about this (and it's 
not only WD overall, but only WD used them sneakily in NAS dedicated drives)

https://blocksandfiles.com/2020/04/24/western-digital-smr-drives-policy-change/

(and many preceeding articles)
