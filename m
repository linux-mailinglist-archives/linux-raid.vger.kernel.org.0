Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 880F7B9E72
	for <lists+linux-raid@lfdr.de>; Sat, 21 Sep 2019 17:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438061AbfIUPNd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 21 Sep 2019 11:13:33 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:28898 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfIUPNc (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 21 Sep 2019 11:13:32 -0400
Received: from [86.132.37.92] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iBh4k-0001tr-7u; Sat, 21 Sep 2019 16:13:30 +0100
Subject: Re: RAID 10 with 2 failed drives
To:     Liviu.Petcu@ugal.ro, 'John Stoffel' <john@stoffel.org>,
        'Sarah Newman' <srn@prgmr.com>
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro>
 <23940.1755.134402.954287@quad.stoffel.home>
 <094701d56f7c$95225260$bf66f720$@ugal.ro>
 <cf597586-a450-f85a-51e1-76df59f22839@prgmr.com>
 <23941.15337.175082.79768@quad.stoffel.home>
 <001e01d5705d$b1785360$1468fa20$@ugal.ro>
Cc:     linux-raid@vger.kernel.org
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5D863E19.4000309@youngman.org.uk>
Date:   Sat, 21 Sep 2019 16:13:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <001e01d5705d$b1785360$1468fa20$@ugal.ro>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 21/09/19 10:19, Liviu Petcu wrote:
> Yes. Only one of the 2 disks reported by mdadm as failed, is broken. I
> almost finished making images of all the discs, and for the second "failed"
> disc ddrescue reported error-free copying. I intend to use the images to
> recreate the array. I haven't done this before, but I hope I can handle
> it...

Could be that failure that knocked the other drive out of the array too.
Dunno why it should happen with SATA, they're supposedly independent,
but certainly with the old PATA disks in pairs, a problem with one drive
could affect the other.

Cheers,
wol
