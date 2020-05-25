Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39001E1482
	for <lists+linux-raid@lfdr.de>; Mon, 25 May 2020 20:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389644AbgEYSzH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 14:55:07 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:12037 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389242AbgEYSzH (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 25 May 2020 14:55:07 -0400
Received: from [81.154.111.47] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jdIFd-000CCb-7q; Mon, 25 May 2020 19:55:05 +0100
Subject: Re: help requested for mdadm grow error
To:     Thomas Grawert <thomasgrawert0282@gmail.com>,
        linux-raid@vger.kernel.org
References: <7d95da49-33d8-cd4d-fa3f-0f3d3074cb30@gmail.com>
 <5ECC09D6.1010300@youngman.org.uk>
 <ff4ea9cd-ab35-0990-5946-4a72d4021658@gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5ECC1488.3010804@youngman.org.uk>
Date:   Mon, 25 May 2020 19:55:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <ff4ea9cd-ab35-0990-5946-4a72d4021658@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 25/05/20 19:18, Thomas Grawert wrote:
> 
>> https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn
>>
>> Especially
>>
>> https://raid.wiki.kernel.org/index.php/Asking_for_help
>>
>> More will follow but we need this info.
> 
> You´re totally right. Sorry for not quoting.
> 
> All drives are new.
> 
> root@nas:~# smartctl --xall /dev/sda
> smartctl 6.6 2016-05-31 r4324 [x86_64-linux-4.9.0-12-amd64] (local build)
> Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org
> 
> === START OF INFORMATION SECTION ===
> Device Model:     WDC WD120EFAX-68UNTN0

The EFAX had me worried a moment, but these are 12TB Reds? That's fine.
A lot of the smaller drives are now shingled, ie not fit for purpose!

Debian 10 - I don't know my Debians - how up to date is that? Is it a
new kernel with not much backports, or an old kernel full of backports?

What version of mdadm?


That said, everything looks good. There are known problems - WITH FIXES
- growing a raid 5 so I suspect you've fallen foul of one. I'd sort out
a rescue disk that you can boot off as you might need it. Once we know a
bit more the fix is almost certainly a rescue disk and resume the
reshape, or a revert-reshape and then reshaping from a rescue disk. At
which point, you'll get your array back with everything intact.

Cheers,
Wol
