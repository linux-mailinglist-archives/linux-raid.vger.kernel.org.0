Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BF9248EA0
	for <lists+linux-raid@lfdr.de>; Tue, 18 Aug 2020 21:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgHRT0M (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 18 Aug 2020 15:26:12 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:21436 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgHRT0L (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 18 Aug 2020 15:26:11 -0400
Received: from host86-157-102-164.range86-157.btcentralplus.com ([86.157.102.164] helo=[192.168.1.64])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1k87FI-000CZI-EY; Tue, 18 Aug 2020 20:26:08 +0100
Subject: Re: Feature request: Remove the badblocks list
To:     Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
References: <75076966.1748398.1597773608869.JavaMail.zimbra@karlsbakk.net>
Cc:     =?UTF-8?B?SMOla29u?= <hawken@thehawken.org>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5F3C2B4F.1050708@youngman.org.uk>
Date:   Tue, 18 Aug 2020 20:26:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <75076966.1748398.1597773608869.JavaMail.zimbra@karlsbakk.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 18/08/20 19:00, Roy Sigurd Karlsbakk wrote:
> As far as I can understand, this list doesn't have any reason to exist, except to annoy sysadmins.

Actually, there's at least one good reason for it to exist that I can
think of - it *could* make recovering a broken array much easier. Think
about it, I think it's documented in the wiki.

That said, I'm hoping to do some work soon that will make it redundant.

One little tip though - you've done a load of research to tell us what
we already know - as documented on the wiki - and now you're asking us
to do a load of work. If you want it done, well nobody else has bothered
so far so what makes you think they'll bother now?

Cheers,
Wol
