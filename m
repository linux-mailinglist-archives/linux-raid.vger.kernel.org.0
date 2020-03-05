Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B59617ACC4
	for <lists+linux-raid@lfdr.de>; Thu,  5 Mar 2020 18:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgCERWX (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 5 Mar 2020 12:22:23 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:42760 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727405AbgCERWX (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 5 Mar 2020 12:22:23 -0500
Received: from [81.153.123.203] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1j9uCT-0006lI-Ag; Thu, 05 Mar 2020 17:22:21 +0000
Subject: Re: Need help with degraded raid 5
To:     Jinpu Wang <jinpuwang@gmail.com>,
        William Morgan <therealbrewer@gmail.com>
References: <CALc6PW74+m1tk4BGgyQRCcx1cU5W=DKWL1mq7EpriW6s=JajVg@mail.gmail.com>
 <CAD9gYJ+3gP+6aannsjzq=L0DsQ-dC2wj4SJfU3+n-t3pG0q3pg@mail.gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5E61354C.2090901@youngman.org.uk>
Date:   Thu, 5 Mar 2020 17:22:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CAD9gYJ+3gP+6aannsjzq=L0DsQ-dC2wj4SJfU3+n-t3pG0q3pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 05/03/20 14:53, Jinpu Wang wrote:
> "mdadm /dev/md0 -a /dev/sdl1"  should work for you to add the disk
> back to array, maybe you can check first with "mdadm -E /dev/sdl1" to
> make sure.

Or better, --re-add or whatever the option is. If it can find the
relevant data in the superblock, like bitmap or journal or whatever, it
will just bring the disk up-to-date. If it can't, it functions just like
add, so you've lost nothing but might gain a lot.

Cheers,
Wol
