Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091D11D0706
	for <lists+linux-raid@lfdr.de>; Wed, 13 May 2020 08:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgEMGSP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 May 2020 02:18:15 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:39086 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbgEMGSO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 13 May 2020 02:18:14 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49MPcP1Dx8z1qs3K
        for <linux-raid@vger.kernel.org>; Wed, 13 May 2020 08:18:13 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49MPcP18NNz1qspF
        for <linux-raid@vger.kernel.org>; Wed, 13 May 2020 08:18:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id yrIZqZ8xcwAc for <linux-raid@vger.kernel.org>;
        Wed, 13 May 2020 08:18:12 +0200 (CEST)
X-Auth-Info: 0U4EkeIJ7RWAs15wXqhGcE7zU287LBfa7fti4Sl7Us8=
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <linux-raid@vger.kernel.org>; Wed, 13 May 2020 08:18:12 +0200 (CEST)
Received: by janitor.denx.de (Postfix, from userid 108)
        id 3640AA014A; Wed, 13 May 2020 08:18:12 +0200 (CEST)
Received: from gemini.denx.de (gemini.denx.de [10.4.0.2])
        by janitor.denx.de (Postfix) with ESMTPS id 88638A0054;
        Wed, 13 May 2020 08:18:02 +0200 (CEST)
Received: from gemini.denx.de (localhost [IPv6:::1])
        by gemini.denx.de (Postfix) with ESMTP id 3BA97240E1A;
        Wed, 13 May 2020 08:18:02 +0200 (CEST)
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-raid@vger.kernel.org
From:   Wolfgang Denk <wd@denx.de>
Subject: Re: raid6check extremely slow ?
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <20200512183251.GA11548@lazy.lzy>
References: <20200510120725.20947240E1A@gemini.denx.de> <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com> <20200511064022.591C5240E1A@gemini.denx.de> <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com> <20200511161415.GA8049@lazy.lzy> <23d84744-9e3c-adc1-3af1-6498b9bcf750@cloud.ionos.com> <20200512160712.GB7261@lazy.lzy> <e24b0703-a599-45ef-f6b6-0a713cfa414c@cloud.ionos.com> <20200512183251.GA11548@lazy.lzy>
Comments: In-reply-to Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
   message dated "Tue, 12 May 2020 20:32:51 +0200."
Date:   Wed, 13 May 2020 08:18:02 +0200
Message-Id: <20200513061802.3BA97240E1A@gemini.denx.de>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Piergiorgio,

In message <20200512183251.GA11548@lazy.lzy> you wrote:
>
> > > > xmalloc.o dlink.o
> > > > sysfs.o: In function `sysfsline':
> > > > sysfs.c:(.text+0x2adb): undefined reference to `parse_uuid'
> > > > sysfs.c:(.text+0x2aee): undefined reference to `uuid_zero'
> > > > sysfs.c:(.text+0x2af5): undefined reference to `uuid_zero'
> > > > collect2: error: ld returned 1 exit status
> > > > Makefile:220: recipe for target 'raid6check' failed
> > > > make: *** [raid6check] Error 1
> > > I cannot see this problem.
> > > I could compile without issue.
> > > Maybe some library is missing somewhere,
> > > but I'm not sure where.
> > 
> > Do you try with the fastest mdadm tree? But could be environment issue ...
>
> I'm using Fedora, so I downloaded
> the .srpm package, installed, enabled
> raid6check, patched and rebuild...

Fedora 32 is still at mdadm-4.1 (Mon Oct 1 14:27:52 2018), but it
seems the significant change was introduced bu commit b06815989
"mdadm: load default sysfs attributes after assemblation" (Wed Jul 10
13:38:53 2019).

If you try to build top of tree you should see the problem, too
[and the -Werror issue I mentioned before, which is also fixed
in Fedora by local distro patches.]

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
As far as the laws of mathematics refer to reality, they are not cer-
tain, and as far as they are certain, they do not refer  to  reality.
                                                   -- Albert Einstein
