Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25E18A7F53
	for <lists+linux-raid@lfdr.de>; Wed,  4 Sep 2019 11:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfIDJ2B (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 4 Sep 2019 05:28:01 -0400
Received: from smtp03.mail.qldc.ch ([212.60.46.172]:51415 "EHLO
        smtp03.mail.qldc.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbfIDJ2B (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 4 Sep 2019 05:28:01 -0400
Received: from tuxedo.ath.cx (55-153-16-94.dyn.cable.fcom.ch [94.16.153.55])
        by smtp03.mail.qldc.ch (Postfix) with ESMTPS id 5EE0220073;
        Wed,  4 Sep 2019 11:27:58 +0200 (CEST)
Received: from [10.0.70.110] (neptun.gms.local [10.0.70.110])
        by tuxedo.ath.cx (Postfix) with ESMTP id 3B1213441A0;
        Wed,  4 Sep 2019 11:27:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tuxedo.dynu.net;
        s=mail; t=1567589278;
        bh=DU6+LHtusAtKrb8pP59jZ5eI30544PUAO31SXutKe1A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HA+jLjcpcEbBm1pU9mJQSxH+BPVFHXJRpIrtZ7mOAcCvlh2EINDf8CdhqNlLWCpDU
         pSf+iZs8vjM9cG8YztAlsvysxBoG3gNQhQ5RdONoQwHRNL4K14G9m5KUt/e/Djxyoj
         n2PYcYQh+T3ARObtFD02397+RtowzyoSiwvSVxmg=
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
 <4e2077ec-454b-2adc-69bc-4e04cf7f24ea@tuxedo.ath.cx>
 <949eebea-e4b7-7f89-da16-d227fa8521f9@huawei.com>
 <03e58a31-8f47-22d2-51c5-91214f63c544@tuxedo.ath.cx>
 <523fd84a-905b-95fb-6fb2-d9eee87e9e39@huawei.com>
From:   Mathias G <newsnet-mg-2016@tuxedo.ath.cx>
Message-ID: <2578a76b-1cab-3339-01a2-59b239cb6e42@tuxedo.ath.cx>
Date:   Wed, 4 Sep 2019 11:27:56 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8pre)
 Gecko/20071022 Thunderbird/2.0.0.6 Mnenhy/0.7.5.0
MIME-Version: 1.0
In-Reply-To: <523fd84a-905b-95fb-6fb2-d9eee87e9e39@huawei.com>
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

Hi Tao

On 03.09.19 03:03, Hou Tao wrote:
> As showed in the following lines, we should use "&>" and "&>>" to save the
> output from both the standard output and standard error output:
> 
> mdadm -D /dev/md* &> /md_debug.txt
> mdadm -S /dev/md* &>> /md_debug.txt
> 
> Could you please update the code snippet accordingly ?
Done! Thank you.
-- 
kind regards
 mathias
