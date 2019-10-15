Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C7BD6C95
	for <lists+linux-raid@lfdr.de>; Tue, 15 Oct 2019 02:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfJOAoR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 14 Oct 2019 20:44:17 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:13176 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfJOAoR (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 14 Oct 2019 20:44:17 -0400
Received: from [86.132.37.73] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iKAwh-0002jA-8H; Tue, 15 Oct 2019 01:44:15 +0100
Subject: Re: Degraded RAID1
To:     Curtis Vaughan <curtis@npc-usa.com>, linux-raid@vger.kernel.org
References: <qo31v1$31rr$2@blaine.gmane.org>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5DA5165E.8070609@youngman.org.uk>
Date:   Tue, 15 Oct 2019 01:44:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <qo31v1$31rr$2@blaine.gmane.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 15/10/19 00:56, Curtis Vaughan wrote:
> I have reason to believe one HD in a RAID1 is dying. But I'm trying to 
> understand what the logs and results of various commands are telling me. 
> Searching on the Internet is very confusing. BTW, this is for and Ubuntu 
> Server 18.04.2 LTS.

Ubuntu LTS ... hmmm. What does "mdadm --version" tell you?
> 
> It seems to me that the following information is telling me on device is 
> missing. It would seem to me that sda is gone.

Have you got any diagnostics for sda? Is it still in /dev? has it been
kicked from the system? Or just the raid?

Take a look at
https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
Especially the "asking for help" page. It gives you loads of diagnostics
to run.

Basically, we need to know whether sda has died, or whether it's a
problem with raid (especially with older mdadm, like I suspect you may
have, the problem could lie there).
> 
> Anyhow, for example, I received an email:
> 
> A DegradedArray event had been detected on md device /dev/md0.

Do you have a spare drive to replace sda? If you haven't, it might be an
idea to get one - especially if you think sda might have failed. In that
case, fixing the raid should be pretty easy. So long as fixing it
doesn't tip sdb over the edge ...
> 
> Faithfully yours, etc.
> 
Cheers,
Wol

