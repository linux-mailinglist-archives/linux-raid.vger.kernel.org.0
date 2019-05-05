Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76187142A6
	for <lists+linux-raid@lfdr.de>; Mon,  6 May 2019 00:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfEEWEm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 5 May 2019 18:04:42 -0400
Received: from use.bitfolk.com ([85.119.80.223]:34117 "EHLO mail.bitfolk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfEEWEm (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 5 May 2019 18:04:42 -0400
X-Greylist: delayed 1165 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 May 2019 18:04:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com; s=alpha;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date; bh=rzwImvB/M9wNrx8Vt08bNghHyejYXp4osH+3ZwzQ+2U=;
        b=DhWavZlfXznmcQujMzEe1RqvBVCzwHEIj3t+VS4XsHdEmotddvpBKcK9M7uHNuUMhsv03aLPaP7Cw4hfW+C2bt62lJhQnIH88XL3Gsj42zBDqeWXATWr5p49/EFJxrtGNTCNKYB5f4sJYGTrvCcOGyLHXLkgHsxlBozNTY2AVNvyckZ+qtJP+Oe53AQ8yqbvm8UtNbmyqF1LivtWN9s40UiSqTZZYoWeZUNXPfPEMWZgiSPfO8bQ2387vuvsys+QlYaLpgy/aKIvnGVsBom+1DsGinfn4q2kivvlhucLRYtPswDeE74zCWxzT7Ndg9DweRqoqTykU7rW7fJdB0mqcg==;
Received: from andy by mail.bitfolk.com with local (Exim 4.84_2)
        (envelope-from <andy@strugglers.net>)
        id 1hNOwd-0005Be-SY
        for linux-raid@vger.kernel.org; Sun, 05 May 2019 21:45:15 +0000
Date:   Sun, 5 May 2019 21:45:15 +0000
From:   Andy Smith <andy@strugglers.net>
To:     Linux Raid <linux-raid@vger.kernel.org>
Subject: Re: Raid1 syncing every Sunday morning.
Message-ID: <20190505214515.GF4569@bitfolk.com>
Mail-Followup-To: Linux Raid <linux-raid@vger.kernel.org>
References: <20190505173439.1ba86d9d@olgiati-in-paraguay.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505173439.1ba86d9d@olgiati-in-paraguay.org>
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

Hi,

On Sun, May 05, 2019 at 05:34:39PM -0400, Renaud (Ron) OLGIATI wrote:
> It has come to my notice that for the last five Sundays, when I logged-in on my computer in the morning, I find rhe Raid1 arrays re-syncing. mornings, I
> 
>  I have checked (crontab -l) both the root and user crontabs, nothing there that is planned for Sundays.

You'll probably find a call to /usr/share/mdadm/checkarray in a file
in /etc/cron.d/

Cheers,
Andy

-- 
https://bitfolk.com/ -- No-nonsense VPS hosting
