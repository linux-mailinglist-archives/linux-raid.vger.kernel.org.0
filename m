Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0EA2679AC
	for <lists+linux-raid@lfdr.de>; Sat, 12 Sep 2020 13:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgILLIH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 12 Sep 2020 07:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgILLH7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 12 Sep 2020 07:07:59 -0400
Received: from mail.bitfolk.com (mail.bitfolk.com [IPv6:2001:ba8:1f1:f019::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F044AC061573
        for <linux-raid@vger.kernel.org>; Sat, 12 Sep 2020 04:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com; s=alpha;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date; bh=oDDXZTcY07kLmUXoxCMOL3ZHu1HV2LHU/L14OGFcN+M=;
        b=zXeoYNv2Zb8vxilTkBhw+JQ1ICtQ6CpATqfUvErgCC/Z8ulU2+NiUI5qLBNg+AyizTKtWTfOKW35gC9l+sYvX52M+LIY+LLkacsRBILKNZc38dwN0Eqhm+1DJsdrpXzcWoEL40NUpCy9ZuMNgaxqyEslO+B876ad61T4oLbTgiBJTWGOoR4JAO5by/Zu34ZbgmeFCcFUiv1s53LDCBH3GOSoT0CqJUrGjmPg5Ca9BculIG94DtEEMEOut8F+AyjjGYXHn/PaigpLvkEq1NpyWaeQkd3DvLBuAwIG+7z8liLrZ/AxlXzsxHoYvviDrc9rx9X23h9Z6UM7wzB5FzkQIA==;
Received: from andy by mail.bitfolk.com with local (Exim 4.84_2)
        (envelope-from <andy@strugglers.net>)
        id 1kH3Nq-0001jf-HB
        for linux-raid@vger.kernel.org; Sat, 12 Sep 2020 11:07:54 +0000
Date:   Sat, 12 Sep 2020 11:07:54 +0000
From:   Andy Smith <andy@strugglers.net>
To:     Linux Raid <linux-raid@vger.kernel.org>
Subject: Re: Config option for removing bbl on assembly?
Message-ID: <20200912110754.GE31926@bitfolk.com>
Mail-Followup-To: Linux Raid <linux-raid@vger.kernel.org>
References: <20200904074557.GT13298@bitfolk.com>
 <583511729.466.1599908325671.JavaMail.zimbra@karlsbakk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <583511729.466.1599908325671.JavaMail.zimbra@karlsbakk.net>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL:  http://strugglers.net/wiki/User:Andy
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Roy,

On Sat, Sep 12, 2020 at 12:58:45PM +0200, Roy Sigurd Karlsbakk wrote:
> …or just remove the whole bbl, since it has virtually no function
> and didn't even have it when it was introduced 10 years ago.

Yes, I saw your recent thread on the subject, and the others going
back years, and it did motivate me to think more about this.

I haven't seen an opinion from the current maintainers but I read that
Neil Brown thought it should not be removed but instead the bugs
should be found and fixed. So there doesn't seem to be any prospect
of this feature being removed.

Given that, and that there is a config option to disable it, I was
hoping it would be deemed less controversial to also have a way to
remove on next (incremental) assembly.

If you can't have your first choice of having the feature removed,
would you support that?

As an aside, I'm having a devil of a game trying to get the Debian
installer to let me use "CREATE bbl=no". Not only does
debian-installer use a config file at /tmp/mdadm.conf, but it
appears to constantly rewrite it every time you enter the MD
configuration section, so realistically it seems that the only way
to create arrays without a bbl is to do it manually from the d-i
shell.

    https://lists.debian.org/debian-boot/2020/09/msg00074.html

Cheers,
Andy
