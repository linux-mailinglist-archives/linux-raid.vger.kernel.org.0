Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C50DFA498A
	for <lists+linux-raid@lfdr.de>; Sun,  1 Sep 2019 15:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfIANRv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 1 Sep 2019 09:17:51 -0400
Received: from mail.thelounge.net ([91.118.73.15]:18841 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbfIANRv (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 1 Sep 2019 09:17:51 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 46Lv0D4c07zXYb;
        Sun,  1 Sep 2019 15:17:43 +0200 (CEST)
Subject: Re: md0: bitmap file is out of date, resync
To:     Mathias G <newsnet-mg-2016@tuxedo.ath.cx>,
        Hou Tao <houtao1@huawei.com>, Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <92ce64ba-2c55-8ef8-3ddf-3bbf867ec4f8@tuxedo.ath.cx>
 <CAPhsuW4Gss2ie2wv_GmT2Xz-5vU+XP=KR6cxh-qOOQPKtOz9ag@mail.gmail.com>
 <a2e4b1a0-e614-2eb3-c673-96fbfbc5ae69@tuxedo.ath.cx>
 <CAPhsuW6+ooVkKznfT19x4HquN+g4WVb-31PvKKt=01fE_wJZEg@mail.gmail.com>
 <1942a84d-ec30-b089-1e17-62e032e5f728@tuxedo.ath.cx>
 <11eb3461-b801-0808-614a-766e090ecdc8@tuxedo.ath.cx>
 <08cf0895-dd00-5499-4d22-c03f3676eb25@huawei.com>
 <4e2077ec-454b-2adc-69bc-4e04cf7f24ea@tuxedo.ath.cx>
 <949eebea-e4b7-7f89-da16-d227fa8521f9@huawei.com>
 <03e58a31-8f47-22d2-51c5-91214f63c544@tuxedo.ath.cx>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <9bbfc1d8-f7d7-6a5d-83c4-a51f4cb794d2@thelounge.net>
Date:   Sun, 1 Sep 2019 15:17:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <03e58a31-8f47-22d2-51c5-91214f63c544@tuxedo.ath.cx>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 01.09.19 um 14:49 schrieb Mathias G:
> Thanks for the code snipped. I tried to put the script to
> /usr/lib/systemd/system-shutdown/
> 
> but it was not executed at all.
> 
> I remembered that I tried to create some debug info by myself and I had
> to put the script to:
> /lib/systemd/system-shutdown/
> instead to make it working. No idea why, the execute bit was set

beause you obvisouly have a very old distribution where /lib is still
not a symlink to /usr/lib

https://www.freedesktop.org/wiki/Software/systemd/TheCaseForTheUsrMerge/

