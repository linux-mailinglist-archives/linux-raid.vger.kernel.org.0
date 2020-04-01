Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3908319AD22
	for <lists+linux-raid@lfdr.de>; Wed,  1 Apr 2020 15:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbgDANvl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 1 Apr 2020 09:51:41 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:37485 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732166AbgDANvl (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 1 Apr 2020 09:51:41 -0400
Received: from [81.153.42.4] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jJcHD-0007vE-9L; Wed, 01 Apr 2020 13:15:24 +0100
Subject: Re: Requesting assistance recovering RAID-5 array
To:     Daniel Jones <dj@iowni.com>, Phil Turmel <philip@turmel.org>
References: <CAB00BMjPSg2wdq7pjt=AwmcDmr0ep2+Xr0EAy6CNnVhOsWk8pg@mail.gmail.com>
 <058b3f48-e69d-2783-8e08-693ad27693f6@youngman.org.uk>
 <CAB00BMgYmi+4XvdmJDWjQ8qGWa9m0mqj7yvrK3QSNH9SzYjypw@mail.gmail.com>
 <1d6b3e00-e7dd-1b19-1379-afe665169d44@turmel.org>
 <CAB00BMg50zcerSLHShSjoOcaJ0JQSi2aSqTFfU2eQQrT12-qEg@mail.gmail.com>
 <e77280ef-a5ac-f2d8-332c-dec032ddc842@turmel.org>
 <CAB00BMj5kihqwOY-FOXv-tqG1b2reMnUVkdmB9uyNAeE7ESasw@mail.gmail.com>
 <061b695a-2406-fc00-dd6d-9198b85f3b1b@turmel.org>
 <CAB00BMi3zhfVGpeE_AyyKiu1=MY2icYgfey0J3GeO8z9ZDAQbg@mail.gmail.com>
Cc:     linux-raid@vger.kernel.org
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5E8485DA.2050803@youngman.org.uk>
Date:   Wed, 1 Apr 2020 13:15:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CAB00BMi3zhfVGpeE_AyyKiu1=MY2icYgfey0J3GeO8z9ZDAQbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 01/04/20 07:03, Daniel Jones wrote:
> Thanks Phil,
> 
> I'll read this a couple of times and try some commands (likely on an
> overlay) tomorrow.

If you CAN overlay, then DO. If you can't back up the drives, the more
you can do to protect them from being accidentally written to, the better.

Cheers,
Wol
