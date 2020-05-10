Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7A21CCD2E
	for <lists+linux-raid@lfdr.de>; Sun, 10 May 2020 21:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgEJTLz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 10 May 2020 15:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbgEJTLz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 10 May 2020 15:11:55 -0400
X-Greylist: delayed 413 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 May 2020 12:11:55 PDT
Received: from mail.prgmr.com (mail.prgmr.com [IPv6:2605:2700:0:5::4713:9506])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837F4C061A0C
        for <linux-raid@vger.kernel.org>; Sun, 10 May 2020 12:11:55 -0700 (PDT)
Received: from [192.168.2.47] (c-174-62-72-237.hsd1.ca.comcast.net [174.62.72.237])
        (Authenticated sender: srn)
        by mail.prgmr.com (Postfix) with ESMTPSA id 3DF9572008C;
        Sun, 10 May 2020 15:05:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com 3DF9572008C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1589137501;
        bh=57UkIwLTJf4VjbXbS+Sldt/K2tfZo6F24GBNyE3O7rU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Kar0+Io2uiR4GK8WjvD3+q+9Yusq+n8j6kExWNXT9lHgSVND08dLjqtQp0A5F5t/8
         t+jh6sDs4Ko470c9FC9mLP04Zp/SVRhVlam0o30Vdx76GqS1K5G2AOQoQkafWPjPEd
         q4MTnRp815O1yhIIhwj8LRXRcuGc1qXYqMy8qet8=
Subject: Re: [general question] rare silent data corruption when writing data
To:     Chris Murphy <lists@colorremedies.com>,
        Michal Soltys <msoltyspl@yandex.pl>
Cc:     John Stoffel <john@stoffel.org>,
        Roger Heflin <rogerheflin@gmail.com>,
        Linux RAID <linux-raid@vger.kernel.org>
References: <b0e91faf-3a14-3ac9-3c31-6989154791c1@yandex.pl>
 <CAAMCDef6hKJsPw3738KJ0vEEwnVKB-QpTMJ6aSeybse-4h+y6Q@mail.gmail.com>
 <24244.30530.155404.154787@quad.stoffel.home>
 <adccabc0-529f-e0a9-538f-1e5b784269e4@yandex.pl>
 <CAJCQCtRWvsKwwoZejERq=_OLXEa3JQd5RJ65tCz=X=Sp1xtRMQ@mail.gmail.com>
From:   Sarah Newman <srn@prgmr.com>
Message-ID: <cd93b47a-7d77-5491-9632-0cea1f34bbe4@prgmr.com>
Date:   Sun, 10 May 2020 12:05:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRWvsKwwoZejERq=_OLXEa3JQd5RJ65tCz=X=Sp1xtRMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/7/20 8:44 PM, Chris Murphy wrote:
> 
> I would change very little until you track this down, if the goal is
> to track it down and get it fixed.
> 
> I'm not sure if LVM thinp is supported with LVM raid still, which if
> it's not supported yet then I can understand using mdadm raid5 instead
> of LVM raid5.


My apologies if this ideas was considered and discarded already, but the bug being hard to reproduce right after reboot and the error being exactly 
the size of a page sounds like a memory use after free bug or similar.

A debug kernel build with one or more of these options may find the problem:

CONFIG_DEBUG_PAGEALLOC
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
CONFIG_PAGE_POISONING + page_poison=1
CONFIG_KASAN

--Sarah
