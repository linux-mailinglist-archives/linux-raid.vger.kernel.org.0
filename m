Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D378B34BA96
	for <lists+linux-raid@lfdr.de>; Sun, 28 Mar 2021 05:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhC1D5o (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 27 Mar 2021 23:57:44 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:62248 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhC1D5N (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 27 Mar 2021 23:57:13 -0400
Received: from host86-155-154-65.range86-155.btcentralplus.com ([86.155.154.65] helo=[192.168.1.64])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1lQMY3-0003wD-E0; Sun, 28 Mar 2021 04:57:11 +0100
Subject: Re: why won't this RAID5 device start?
To:     David T-G <davidtg-robot@justpickone.org>,
        Linux RAID list <linux-raid@vger.kernel.org>
References: <20210328021451.GB1415@justpickone.org>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <606007CA.7060809@youngman.org.uk>
Date:   Sun, 28 Mar 2021 05:36:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20210328021451.GB1415@justpickone.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 28/03/21 03:14, David T-G wrote:
> Hi, all --
> 
> I recently migrated our disk farm to a new box with a new OS build
> (openSuSE from KNOPPIX).  Aside from the usual challenges of setting
> up the world again, I have a 3-device RAID5 volume that won't start.
> The other metadevice is fine, though; I think we can say that the md
> system is running.  Soooooo ...  Where do I start?

https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn

Sorry I don't have time to look deeper right now. If someone else
doesn't chime in first, I'll take a look when I get back from work.

Cheers,
Wol
