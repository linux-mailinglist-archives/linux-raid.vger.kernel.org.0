Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC87D1D3906
	for <lists+linux-raid@lfdr.de>; Thu, 14 May 2020 20:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgENSVB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 14 May 2020 14:21:01 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:42962 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgENSVA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 14 May 2020 14:21:00 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49NKbs2xlRz1qrff
        for <linux-raid@vger.kernel.org>; Thu, 14 May 2020 20:20:57 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49NKbs2rHHz1r3lT
        for <linux-raid@vger.kernel.org>; Thu, 14 May 2020 20:20:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id vo5qdb2VHcct for <linux-raid@vger.kernel.org>;
        Thu, 14 May 2020 20:20:47 +0200 (CEST)
X-Auth-Info: oVdRAVAVbnxylGZZE4P/oqQinXeh8CWm/nLkPrSqbPU=
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <linux-raid@vger.kernel.org>; Thu, 14 May 2020 20:20:47 +0200 (CEST)
Received: by janitor.denx.de (Postfix, from userid 108)
        id 160F2A02F3; Thu, 14 May 2020 20:20:47 +0200 (CEST)
Received: from gemini.denx.de (gemini.denx.de [10.4.0.2])
        by janitor.denx.de (Postfix) with ESMTPS id EFA8CA010E;
        Thu, 14 May 2020 20:20:41 +0200 (CEST)
Received: from gemini.denx.de (localhost [IPv6:::1])
        by gemini.denx.de (Postfix) with ESMTP id CDF1F240E1A;
        Thu, 14 May 2020 20:20:41 +0200 (CEST)
To:     Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc:     Linux Raid <linux-raid@vger.kernel.org>
From:   Wolfgang Denk <wd@denx.de>
Subject: Re: raid6check extremely slow ?
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <1999694976.3317399.1589476824607.JavaMail.zimbra@karlsbakk.net>
References: <20200510120725.20947240E1A@gemini.denx.de> <1999694976.3317399.1589476824607.JavaMail.zimbra@karlsbakk.net>
Comments: In-reply-to Roy Sigurd Karlsbakk <roy@karlsbakk.net>
   message dated "Thu, 14 May 2020 19:20:24 +0200."
Date:   Thu, 14 May 2020 20:20:41 +0200
Message-Id: <20200514182041.CDF1F240E1A@gemini.denx.de>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Roy,

In message <1999694976.3317399.1589476824607.JavaMail.zimbra@karlsbakk.net> you wrote:
>
> Try checking with iostat -x to see if one disk is performing worse
> than the other ones. This sometimes happens and can indicate a
> failure that the normal SMART/smartctl stuff can't identify. If
> you see a utilisation of one of the disks at 100%, that's the
> bastard. Under normal circumstances, you probably won't be able to
> return that, since it "works". There's a quick fix for that,
> though. Just unplug the disk, plug it into a power cable, let it
> spin up and then sharpy twist it 90 degees a few times, and it's
> all sorted out and you can return it ;)

Everything looks unsuspicious to me - all disks behave the same:

# iostat -x /dev/sd[efhijklm] 1 3
Linux 5.6.8-300.fc32.x86_64 (atlas.denx.de)     2020-05-14      _x86_64_        (8 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.19    0.00    1.06    0.15    0.00   98.60

Device            r/s     rkB/s   rrqm/s  %rrqm r_await rareq-sz     w/s     wkB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dkB/s   drqm/s  %drqm d_await dareq-sz     f/s f_await  aqu-sz  %util
sde             20.08    360.56     2.53  11.20    0.34    17.95    0.49      0.10     0.02   3.41   32.36     0.20    0.00      0.00     0.00   0.00    0.00     0.00    0.49   32.74    0.02   2.11
sdf             20.07    360.56     2.54  11.24    0.33    17.96    0.49      0.10     0.02   3.40   44.23     0.20    0.00      0.00     0.00   0.00    0.00     0.00    0.49   44.77    0.02   2.09
sdh             20.08    360.54     2.53  11.17    0.35    17.95    0.49      0.10     0.02   3.40   43.47     0.20    0.00      0.00     0.00   0.00    0.00     0.00    0.49   44.01    0.02   2.40
sdi             20.08    360.58     2.54  11.23    0.34    17.96    0.49      0.10     0.02   3.40   26.22     0.21    0.00      0.00     0.00   0.00    0.00     0.00    0.49   26.50    0.01   2.84
sdj             20.45    360.56     2.16   9.54    0.34    17.63    0.49      0.10     0.02   3.38   35.19     0.20    0.00      0.00     0.00   0.00    0.00     0.00    0.49   35.60    0.02   2.46
sdk             20.08    360.54     2.53  11.21    0.35    17.95    0.49      0.10     0.02   3.42   40.63     0.21    0.00      0.00     0.00   0.00    0.00     0.00    0.49   41.13    0.02   2.36
sdl             20.07    360.57     2.54  11.24    0.34    17.96    0.49      0.10     0.02   3.39   23.61     0.20    0.00      0.00     0.00   0.00    0.00     0.00    0.49   23.84    0.01   2.70
sdm             20.08    360.55     2.53  11.21    0.53    17.96    0.49      0.10     0.02   3.41   21.52     0.20    0.00      0.00     0.00   0.00    0.00     0.00    0.49   21.67    0.01   2.64


avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.38    0.00    1.12    0.12    0.00   98.38

Device            r/s     rkB/s   rrqm/s  %rrqm r_await rareq-sz     w/s     wkB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dkB/s   drqm/s  %drqm d_await dareq-sz     f/s f_await  aqu-sz  %util
sde             20.00    320.00     0.00   0.00    0.25    16.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   2.00
sdf             20.00    320.00     0.00   0.00    0.25    16.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   2.00
sdh             20.00    320.00     0.00   0.00    0.30    16.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   2.00
sdi             20.00    320.00     0.00   0.00    0.25    16.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   4.00
sdj             20.00    320.00     0.00   0.00    0.25    16.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   2.00
sdk             20.00    320.00     0.00   0.00    0.30    16.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   2.00
sdl             20.00    320.00     0.00   0.00    0.25    16.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   4.00
sdm             20.00    320.00     0.00   0.00    0.35    16.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   2.00


avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.25    0.00    0.88    0.00    0.00   98.87

Device            r/s     rkB/s   rrqm/s  %rrqm r_await rareq-sz     w/s     wkB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dkB/s   drqm/s  %drqm d_await dareq-sz     f/s f_await  aqu-sz  %util
sde             21.00    336.00     0.00   0.00    0.24    16.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   2.10
sdf             21.00    336.00     0.00   0.00    0.24    16.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   2.10
sdh             21.00    336.00     0.00   0.00    0.24    16.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   2.30
sdi             21.00    336.00     0.00   0.00    0.24    16.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   4.00
sdj             21.00    336.00     0.00   0.00    0.24    16.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   2.10
sdk             21.00    336.00     0.00   0.00    0.24    16.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   2.10
sdl             21.00    336.00     0.00   0.00    0.29    16.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   4.20
sdm             21.00    336.00     0.00   0.00    0.38    16.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   2.10



Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
We see things not as they are, but as we are.       - H. M. Tomlinson
