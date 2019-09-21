Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A288AB9FDA
	for <lists+linux-raid@lfdr.de>; Sun, 22 Sep 2019 00:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfIUWHY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 21 Sep 2019 18:07:24 -0400
Received: from mail.prgmr.com ([71.19.149.6]:38296 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfIUWHY (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 21 Sep 2019 18:07:24 -0400
Received: from [192.168.1.65] (unknown [99.0.85.144])
        (Authenticated sender: srn)
        by mail.prgmr.com (Postfix) with ESMTPSA id 688DD720068;
        Sat, 21 Sep 2019 23:02:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com 688DD720068
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1569121355;
        bh=3Kl+vXfnHCoGIUx2Dzqkl009SHTBqf9ghiow878C2yU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Htm3K0CXTy0FXzysdl9jle4i4GuVzX9ESZM+Mv3IxYgMvtoxadFNs+FgRi7hrvfFl
         tFqenTSqNA6BKybwHOpq8QH4gEJviJthVaBqgkwvHrNnHDInY84/Nl2apXFJph7KLv
         0QySLzuJl7vKR4OpqvF+zPpTLeUhsWLvIM88WNPk=
Subject: Re: RAID 10 with 2 failed drives
To:     Liviu.Petcu@ugal.ro
Cc:     'John Stoffel' <john@stoffel.org>, linux-raid@vger.kernel.org
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro>
 <23940.1755.134402.954287@quad.stoffel.home>
 <094701d56f7c$95225260$bf66f720$@ugal.ro>
 <cf597586-a450-f85a-51e1-76df59f22839@prgmr.com>
 <23941.15337.175082.79768@quad.stoffel.home>
 <001e01d5705d$b1785360$1468fa20$@ugal.ro>
 <8a277324-d9b8-f2c9-bec0-5ed90c6e3eb4@prgmr.com>
 <004f01d570aa$48705410$d950fc30$@ugal.ro>
 <006301d570c4$f0353f20$d09fbd60$@ugal.ro>
From:   Sarah Newman <srn@prgmr.com>
Message-ID: <65e41893-8f77-1bbe-ed58-328364a87f3d@prgmr.com>
Date:   Sat, 21 Sep 2019 15:07:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <006301d570c4$f0353f20$d09fbd60$@ugal.ro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9/21/19 2:38 PM, Liviu Petcu wrote:

> 
> # mdadm --assemble --force /dev/md1 /dev/loop0p2 /dev/loop1p2 /dev/loop2p2 /dev/loop3p2 /dev/loop4p2 /dev/loop5p2
> mdadm: cannot open device /dev/loop0p2: No such file or directory
> mdadm: /dev/loop0p2 has no superblock - assembly aborted
> 
> It is wrong? Or something I broke?

You need to run kpartx -av on each loopback device and then access the partitions in /dev/mapper.
