Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B287A7719
	for <lists+linux-raid@lfdr.de>; Wed,  4 Sep 2019 00:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfICWgT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 3 Sep 2019 18:36:19 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:24018 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfICWgT (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 3 Sep 2019 18:36:19 -0400
Received: from [81.153.82.187] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1i5HPM-00051Y-Cj; Tue, 03 Sep 2019 23:36:17 +0100
Subject: Re: [PATCH v3 1/2] md raid0/linear: Mark array as 'broken' and fail
 BIOs if a member is gone
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-raid <linux-raid@vger.kernel.org>
References: <20190822161318.26236-1-gpiccoli@canonical.com>
 <73C4747E-7A9E-4833-8393-B6A06C935DBE@fb.com>
 <8163258e-839c-e0b8-fc4b-74c94c9dae1d@canonical.com>
 <F0E716F8-76EC-4315-933D-A547B52F1D27@fb.com>
 <5D68FEBC.9060709@youngman.org.uk>
 <CAHD1Q_ypdBKhYRVLrg_kf4L8LdXk8rgiiSQjtmoC=jyRv5M5jQ@mail.gmail.com>
 <8a55b0b6-25a9-d76b-1a6a-8aaed8bde8a7@canonical.com>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5D6EEAE0.7060400@youngman.org.uk>
Date:   Tue, 3 Sep 2019 23:36:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <8a55b0b6-25a9-d76b-1a6a-8aaed8bde8a7@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 03/09/19 20:53, Guilherme G. Piccoli wrote:
> Wols, in order to reduce code size and for clarity, I've kept the helper
> as "is_mddev_broken()" - thanks for the suggestion anyway!

That's fine - it was just a suggestion and if you feel your version is
clearer ...

Cheers,
Wol
