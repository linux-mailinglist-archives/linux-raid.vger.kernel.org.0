Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A319A8B9
	for <lists+linux-raid@lfdr.de>; Fri, 23 Aug 2019 09:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbfHWHZ3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 23 Aug 2019 03:25:29 -0400
Received: from smtp03.mail.qldc.ch ([212.60.46.172]:45973 "EHLO
        smtp03.mail.qldc.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731421AbfHWHZ3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 23 Aug 2019 03:25:29 -0400
X-Greylist: delayed 550 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Aug 2019 03:25:28 EDT
Received: from tuxedo.ath.cx (55-153-16-94.dyn.cable.fcom.ch [94.16.153.55])
        by smtp03.mail.qldc.ch (Postfix) with ESMTPS id D6A102059A;
        Fri, 23 Aug 2019 09:16:15 +0200 (CEST)
Received: from [10.0.70.110] (neptun.gms.local [10.0.70.110])
        by tuxedo.ath.cx (Postfix) with ESMTP id 392263451EA;
        Fri, 23 Aug 2019 09:16:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tuxedo.dynu.net;
        s=mail; t=1566544575;
        bh=eEwkA6wewAjgZVYvMs6BsrKkZYqP8EZg53s32E5HHP8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ebEQWagjdhIi2DN1Uf+H2o0GtPzo0cGTHjEhgp1vyjL/jptYEJ0Nkry2WfHM0u0Jb
         JqWcIVhT0WMUWHtjUqkpmr1t1jodn99C6Cx4RN3aiIkJT+tfd+X7XVuHQ4s/vHbABH
         g2N8ZRvUTVNKlKCQRf56PFzocdwnvDeJR7hDow98=
Subject: Re: md0: bitmap file is out of date, resync
To:     Hou Tao <houtao1@huawei.com>, Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <92ce64ba-2c55-8ef8-3ddf-3bbf867ec4f8@tuxedo.ath.cx>
 <CAPhsuW4Gss2ie2wv_GmT2Xz-5vU+XP=KR6cxh-qOOQPKtOz9ag@mail.gmail.com>
 <a2e4b1a0-e614-2eb3-c673-96fbfbc5ae69@tuxedo.ath.cx>
 <CAPhsuW6+ooVkKznfT19x4HquN+g4WVb-31PvKKt=01fE_wJZEg@mail.gmail.com>
 <1942a84d-ec30-b089-1e17-62e032e5f728@tuxedo.ath.cx>
 <11eb3461-b801-0808-614a-766e090ecdc8@tuxedo.ath.cx>
 <08cf0895-dd00-5499-4d22-c03f3676eb25@huawei.com>
From:   Mathias G <newsnet-mg-2016@tuxedo.ath.cx>
Message-ID: <4e2077ec-454b-2adc-69bc-4e04cf7f24ea@tuxedo.ath.cx>
Date:   Fri, 23 Aug 2019 09:16:13 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8pre)
 Gecko/20071022 Thunderbird/2.0.0.6 Mnenhy/0.7.5.0
MIME-Version: 1.0
In-Reply-To: <08cf0895-dd00-5499-4d22-c03f3676eb25@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tuxedo.ath.cx
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Song, Hi Tao
I kept an eye on the RAID status after the last update I did on the system.
The first boot after the update was ok, the RAID was clean. I did a
clean shutdown and the next as I switched on the computer the RAID was
rebuilding again (this was yesterday)

I have no more ideas what to do - maybe reinstall the whole system and
start from scratch?

Thank you
-- 
kind regards
 mathias
