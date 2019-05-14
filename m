Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81C301CF30
	for <lists+linux-raid@lfdr.de>; Tue, 14 May 2019 20:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfENSis (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 May 2019 14:38:48 -0400
Received: from mail.thelounge.net ([91.118.73.15]:55083 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfENSis (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 May 2019 14:38:48 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 453RKK1KDszXLx;
        Tue, 14 May 2019 20:38:45 +0200 (CEST)
Subject: Re: Help restoring a raid10 Array (4 disk + one spare) after a hard
 disk failure at power on
To:     eric.valette@free.fr, linux-raid@vger.kernel.org
References: <87d22dc0-4b45-e13f-86e1-d3e9fbd7f55d@free.fr>
 <1bc43f99-3c57-db16-64d2-e5ab7d2e27cf@thelounge.net>
 <dd7cd835-23f5-38de-0bb7-e13a408ef83a@free.fr>
 <5a28b0de-c50a-fdd1-f6ea-7746da3c9a6e@thelounge.net>
 <9fcb4980-b0d4-9f20-8e37-fd2dc4768e78@free.fr>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <66e55468-4d42-ab61-7621-90af2d37f78e@thelounge.net>
Date:   Tue, 14 May 2019 20:38:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9fcb4980-b0d4-9f20-8e37-fd2dc4768e78@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 14.05.19 um 20:33 schrieb Eric Valette:
> Fine. Again where is it documented? The documentation the contrary. So
> go and fix the doc instead of ranting again end user.

you better cool down given that *i am* an enduser and when you think you
reach anything by piss off ousers hwich show you how your setup should
look like you are likely wrong

>> but the kernel line contains mentioning the 3 raid-arrays explicit
>> rd.md.uuid=1d691642:baed26df:1d197496:4fb00ff8
>> rd.md.uuid=b7475879:c95d9a47:c5043c02:0c5ae720
>> rd.md.uuid=ea253255:cb915401:f32794ad:ce0fe396
> Do not want to do that messing in grub automatic config files...

do you want your problems solved forever or not?

that setup exists since 2011 and survived several dist-upgrades and
moving to different hardware while "gubr2-mkconfig -o
/boot/grub2/grub.cfg" always make ssure all my options are included

[root@srv-rhsoft:~]$ cat /etc/default/grub
GRUB_TIMEOUT=1
GRUB_DISTRIBUTOR="Fedora"
GRUB_SAVEDEFAULT="false"
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="quiet libata.force=noncq audit=0 rd.plymouth=0
plymouth.enable=0 rd.md.uuid=b7475879:c95d9a47:c5043c02:0c5ae720
rd.md.uuid=1d691642:baed26df:1d197496:4fb00ff8
rd.md.uuid=ea253255:cb915401:f32794ad:ce0fe396 rd.luks=0 rd.lvm=0
rd.dm=0 zswap.enabled=0 selinux=0 net.ifnames=0 biosdevname=0
clocksource=hpet noisapnp noresume hibernate=no printk.time=0
nmi_watchdog=0 acpi_osi=Linux vconsole.font=latarcyrheb-sun16
vconsole.keymap=de-latin1-nodeadkeys locale.LANG=de_DE.UTF-8"
GRUB_DISABLE_RECOVERY="true"
GRUB_DISABLE_SUBMENU="true"
GRUB_DISABLE_OS_PROBER="true"
GRUB_ENABLE_BLSCFG="false"
