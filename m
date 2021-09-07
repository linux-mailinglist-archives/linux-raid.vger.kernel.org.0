Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633E14022F6
	for <lists+linux-raid@lfdr.de>; Tue,  7 Sep 2021 07:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbhIGFCn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 Sep 2021 01:02:43 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:59413 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236276AbhIGFCm (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 7 Sep 2021 01:02:42 -0400
Received: from host86-157-192-80.range86-157.btcentralplus.com ([86.157.192.80] helo=[192.168.1.112])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1mNTEk-0009Mq-G0; Tue, 07 Sep 2021 06:01:35 +0100
Subject: Re: mdadm resync causes stable system to crash every 2 or 3 hours
To:     Ryan Patterson <ryan.goat@gmail.com>, linux-raid@vger.kernel.org
References: <CA+Kggd7mUF9MWdJsLtAQMv=KXtwaNvj6BqfM+NMyffE86iHBoQ@mail.gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <6136F1C2.4020804@youngman.org.uk>
Date:   Tue, 7 Sep 2021 05:59:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CA+Kggd7mUF9MWdJsLtAQMv=KXtwaNvj6BqfM+NMyffE86iHBoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 07/09/21 01:44, Ryan Patterson wrote:
> My file server is usually very stable.  The past week I had two mdadm
> arrays that required recync operations.
> * newly created raid6 array (14 x 16TB seagate exos)
> * existing raid 6 array, after a reboot resync on hot spare (14 x 4TB
> seagate barracuda)

Aaarghhh

See
https://raid.wiki.kernel.org/index.php/Linux_Raid

And especially
https://raid.wiki.kernel.org/index.php/Timeout_Mismatch

That might not be your problem, but it's the very first thing you should
address!

Cheers,
Wol
