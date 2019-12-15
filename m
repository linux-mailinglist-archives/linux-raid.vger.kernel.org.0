Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 252F011F7C8
	for <lists+linux-raid@lfdr.de>; Sun, 15 Dec 2019 13:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfLOMrg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 15 Dec 2019 07:47:36 -0500
Received: from smtp04.mail.qldc.ch ([212.60.46.173]:60588 "EHLO
        smtp04.mail.qldc.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfLOMrf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 15 Dec 2019 07:47:35 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Dec 2019 07:47:35 EST
Received: from tuxedo.ath.cx (55-153-16-94.dyn.cable.fcom.ch [94.16.153.55])
        (Authenticated sender: s1cqpegm3zyxhjg0@quickline.ch)
        by smtp04.mail.qldc.ch (Postfix) with ESMTPSA id 1ACF12038C;
        Sun, 15 Dec 2019 13:38:05 +0100 (CET)
Authentication-Results: smtp04.mail.qldc.ch; dkim=pass
        reason="1024-bit key; unprotected key"
        header.d=tuxedo.dynu.net header.i=@tuxedo.dynu.net
        header.b=MgtL/HGM; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
Received: from [10.0.70.110] (neptun.gms.local [10.0.70.110])
        by tuxedo.ath.cx (Postfix) with ESMTP id C19873442C8;
        Sun, 15 Dec 2019 13:38:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tuxedo.dynu.net;
        s=mail; t=1576413485;
        bh=9zM56zYilYjbYk44clnEgilhI7JCt8fnujLt8Co6cnI=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=MgtL/HGMeSzyaPjVFLz/QJXA6czKf1YqmT2561Erkv7YPpvEuCsCih2k5+msbU+1q
         CsZWm3rC1n3uY6Scgc9hSLzoLI4D9L5fqeV7UBJaP4NOH4syw00Mk6Ml9guO5Mp+bL
         WLvbnrNKF/C2QqkjsTOijaSqiEU/6MAgsDbZCopQ=
From:   Mathias G <newsnet-mg-2016@tuxedo.ath.cx>
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
Message-ID: <3ff39ec2-e0d5-e761-2b11-622481aeef24@tuxedo.ath.cx>
Date:   Sun, 15 Dec 2019 13:38:03 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8pre)
 Gecko/20071022 Thunderbird/2.0.0.6 Mnenhy/0.7.5.0
MIME-Version: 1.0
In-Reply-To: <523fd84a-905b-95fb-6fb2-d9eee87e9e39@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tuxedo.ath.cx
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Tao, Hi Song

Just want to give some feedback after some months testing.

Since I added the provided code snipped the problem never occurred again!

Thank you very much!
-- 
kind regards
 mathias
