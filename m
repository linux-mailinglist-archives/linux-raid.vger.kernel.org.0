Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A07E667F6A
	for <lists+linux-raid@lfdr.de>; Sun, 14 Jul 2019 16:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfGNOpQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 14 Jul 2019 10:45:16 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:64706 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbfGNOpQ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 14 Jul 2019 10:45:16 -0400
Received: from [81.155.195.121] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1hmfkY-0002g0-3q; Sun, 14 Jul 2019 15:45:14 +0100
Subject: Re: Weird behaviour of md, maybe a bug in 4.19.xx kernel?
To:     Tito <farmatito@tiscali.it>, linux-raid@vger.kernel.org
References: <f9138853-587b-3725-b375-d9a4c2530054@tiscali.it>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5D2B3FF9.8000806@youngman.org.uk>
Date:   Sun, 14 Jul 2019 15:45:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <f9138853-587b-3725-b375-d9a4c2530054@tiscali.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14/07/19 15:05, Tito wrote:
> Hi,
> I've got this email address from the MAINTAINERS file in the linux kernel
> source, so I hope it is the right place to contact.
> I'm running a debian/devuan system for a long time with several
> md arrays on the embedded controller and on a ibm M1015 card
> reflashed to LSI  SAS9211-8i with all drives in passthrough mode.
> My typical setup is:

You've got the right place. I can't see any mention of what disks you
have, because that could well be relevant.

Can I point you at the raid wiki for a good read ... :-)

https://raid.wiki.kernel.org/index.php/Linux_Raid

It contains a bunch of advice on troubleshooting and stuff, and it'll
hopefully help you identify anything weird so making it easier for you
to point us in the right direction and provide us with the stuff we need.

Cheers,
Wol
