Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770F6242038
	for <lists+linux-raid@lfdr.de>; Tue, 11 Aug 2020 21:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHKTZY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Aug 2020 15:25:24 -0400
Received: from mifritscher.de ([188.40.170.105]:38786 "EHLO
        mail.mifritscher.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgHKTZX (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Aug 2020 15:25:23 -0400
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Aug 2020 15:25:23 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mifritscher.de (Postfix) with ESMTP id 7B35F3A18B1
        for <linux-raid@vger.kernel.org>; Tue, 11 Aug 2020 21:19:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mifritscher.vserverkompetenz.de
Received: from mail.mifritscher.de ([127.0.0.1])
        by localhost (mail.mifritscher.vserverkompetenz.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n19eabwLvH5V for <linux-raid@vger.kernel.org>;
        Tue, 11 Aug 2020 21:19:08 +0200 (CEST)
Received: from [192.168.99.138] (55d4f57d.access.ecotel.net [85.212.245.125])
        by mail.mifritscher.de (Postfix) with ESMTPSA id 3D0413A0E6A
        for <linux-raid@vger.kernel.org>; Tue, 11 Aug 2020 21:19:08 +0200 (CEST)
Subject: Re: Recommended filesystem for RAID 6
To:     linux-raid@vger.kernel.org
References: <CAF-KpgYcEF5juR9nFPifZunPPGW73kWVG9fjR3=WpufxXJcewg@mail.gmail.com>
 <1381759926.21710099.1597158389614.JavaMail.zimbra@karlsbakk.net>
From:   Michael Fritscher <michael@fritscher.net>
Message-ID: <4a7bfca8-af6e-cbd1-0dc4-feaf1a0288be@fritscher.net>
Date:   Tue, 11 Aug 2020 21:19:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1381759926.21710099.1597158389614.JavaMail.zimbra@karlsbakk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

if you really want to use these tiny 2 TB HDDs - yes, RAID 6 (2x - the
second for the backup system on a physically different location) is a
good choice.

But: If you can, buy some 8-12 TB HDDs and forget the old rusty tiny
HDDs. You'll save a lot at the system - and power.

ext4 is fine. In my experience, it is rock-solid, and also fsck.ext4 is
fairly qick (don't know what Roy is doing that it is so slow - do you
really made a full-fledged ext4 with journal or a old ext2 file system?^^)

Another way would be deploying zfs with raid-z2 (Yes, I can hear the
screams :-D )

Best regards,
Michael Fritscher
