Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D0735249A
	for <lists+linux-raid@lfdr.de>; Fri,  2 Apr 2021 02:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhDBAqz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 1 Apr 2021 20:46:55 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:56931 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231168AbhDBAqy (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 1 Apr 2021 20:46:54 -0400
Received: from host86-156-102-23.range86-156.btcentralplus.com ([86.156.102.23] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1lS7xc-0001Ts-4E; Fri, 02 Apr 2021 01:46:52 +0100
Subject: Re: how do i bring this disk back into the fold?
To:     David T-G <davidtg-robot@justpickone.org>,
        Linux RAID list <linux-raid@vger.kernel.org>
References: <20210328021210.GA1415@justpickone.org>
 <20210402004001.GH1711@justpickone.org>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <62cc89ea-b9cf-d8a3-3d52-499fd84f7cc3@youngman.org.uk>
Date:   Fri, 2 Apr 2021 01:46:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210402004001.GH1711@justpickone.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 02/04/2021 01:40, David T-G wrote:
> % Before I go too crazy ...  What do I need to do to bring sde1 back into
> % the RAID volume, either to catch up the missing 17k events (probably
> % preferred) or just to rebuild it?
> [snip]
> 
> Any advice?

mdadm --re-add?

Re-add will replay all the missed updates if it can, if it can't it just 
does an add and rebuilds.

Check the man page for details, and come back if it looks scary ...

Cheers,
Wol
