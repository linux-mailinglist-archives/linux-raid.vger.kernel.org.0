Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7D9142BC
	for <lists+linux-raid@lfdr.de>; Mon,  6 May 2019 00:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfEEWPF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 5 May 2019 18:15:05 -0400
Received: from smtpq1.mnd.mail.iss.as9143.net ([212.54.34.164]:39106 "EHLO
        smtpq1.mnd.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727232AbfEEWPF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 5 May 2019 18:15:05 -0400
X-Greylist: delayed 1178 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 May 2019 18:15:03 EDT
Received: from [212.54.34.119] (helo=smtp11.mnd.mail.iss.as9143.net)
        by smtpq1.mnd.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rudy@grumpydevil.homelinux.org>)
        id 1hNP6S-0008RD-HB; Sun, 05 May 2019 23:55:24 +0200
Received: from 94-214-94-139.cable.dynamic.v4.ziggo.nl ([94.214.94.139] helo=imail.office.romunt.nl)
        by smtp11.mnd.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <rudy@grumpydevil.homelinux.org>)
        id 1hNP6S-0005MX-Bn; Sun, 05 May 2019 23:55:24 +0200
Received: from [192.168.30.15] (cenedra.office.romunt.nl [192.168.30.15])
        by imail.office.romunt.nl (8.15.2/8.15.2/Debian-8) with ESMTP id x45LtF2e010061;
        Sun, 5 May 2019 23:55:16 +0200
Subject: Re: Raid1 syncing every Sunday morning.
To:     "Renaud (Ron) OLGIATI" <renaud@olgiati-in-paraguay.org>,
        Linux Raid <linux-raid@vger.kernel.org>
References: <20190505173439.1ba86d9d@olgiati-in-paraguay.org>
From:   Rudy Zijlstra <rudy@grumpydevil.homelinux.org>
Openpgp: preference=signencrypt
Autocrypt: addr=rudy@grumpydevil.homelinux.org; prefer-encrypt=mutual;
 keydata=
 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
 PfrjUkVA/G4GKRxwMbN+43xPqys=
Message-ID: <25aa55d2-9f7e-97d0-c49d-b4f4699fd2c4@grumpydevil.homelinux.org>
Date:   Sun, 5 May 2019 23:55:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190505173439.1ba86d9d@olgiati-in-paraguay.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.100.3 at hermes
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        hermes.office.romunt.nl
X-SourceIP: 94.214.94.139
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=Y8yGTSWN c=1 sm=1 tr=0 a=MLz4jdL9LhxtSH7CRyKX8g==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=E5NmQfObTbMA:10 a=LvKCH4V3Ob7qTbcwhBwA:9 a=QEXdDO2ut3YA:10
X-Ziggo-Spam-Status: No
X-Spam-Status: No
X-Spam-Flag: No
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 05/05/2019 23.34, Renaud (Ron) OLGIATI wrote:
> It has come to my notice that for the last five Sundays, when I logged-in on my computer in the morning, I find rhe Raid1 arrays re-syncing. mornings, I
>
>  I have checked (crontab -l) both the root and user crontabs, nothing there that is planned for Sundays.
>
>
Which distribution?
