Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A786380F67
	for <lists+linux-raid@lfdr.de>; Fri, 14 May 2021 20:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhENSHw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 May 2021 14:07:52 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:62421 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231394AbhENSHw (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 14 May 2021 14:07:52 -0400
Received: from host109-154-217-227.range109-154.btcentralplus.com ([109.154.217.227] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1lha2L-000Bbh-3P; Fri, 14 May 2021 16:47:37 +0100
Subject: Re: Looking for a good documentation on how to recover a raid
To:     =?UTF-8?Q?Michael_Marr=c3=a9?= <michael.marre@web.de>,
        linux-raid@vger.kernel.org
References: <a8c41eed-6d56-e37e-99b6-0df160cc3126@web.de>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <1b1aef27-4927-ec36-276b-09d76fd92e59@youngman.org.uk>
Date:   Fri, 14 May 2021 16:47:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a8c41eed-6d56-e37e-99b6-0df160cc3126@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14/05/2021 09:43, Michael Marré wrote:
> Hello,
> 
> I am new to this list and I would like to know if does an official FAQ 
> and/or documentation exist on how to recover a broken raid?

https://raid.wiki.kernel.org/index.php/Linux_Raid

This is as close to official as you'll get. Failures tend to follow a 
pattern, and I do try and document any variation I see, but it does tend 
to be a case of "either it's easy or it turns into a big recovery job".

Look especially at
https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
and if it's not an easy fix (it might be as simple as a forced-assembly 
followed by a fsck), post the requested info to the list and somebody 
should dive in and help.

Cheers,
Wol
