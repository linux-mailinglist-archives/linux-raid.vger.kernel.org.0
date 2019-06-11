Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010163C483
	for <lists+linux-raid@lfdr.de>; Tue, 11 Jun 2019 08:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390485AbfFKGwO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Jun 2019 02:52:14 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:51388 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfFKGwO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Jun 2019 02:52:14 -0400
Date:   Tue, 11 Jun 2019 06:52:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1560235932;
        bh=LQSUffDbO2wleD0V8K3HRXfNh1rxyovJ1kg+pvAu9KA=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=l/n2xb/u5wlaLs8zM0qDiDTBkylZmeaobAZusCilrrdnC8Nktg3vLadKIvBo53Lg1
         D/PIzlbvLilBsc2hGd0bCX2G8wxMvwluv8iSUEb2tHDF/BO3yR4FI6+M9oDqvlkP8o
         xKP2QV1E/zwW2mhCsDspmOlQsSlbOuw9FeHlZEbc=
To:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
From:   Fisher <fisherthepooh@protonmail.com>
Reply-To: Fisher <fisherthepooh@protonmail.com>
Subject: RAID5 R5_Wantread BUG_ON in fetch_block
Message-ID: <_0w6rNy077CcKFoikRSv0XHMrxKYlqFv6SiJsBZRsdWV5azI0uwyHL1KibAxU9Xy6b2OOuyLei2DwVkc0kIXDe_QneHmHda1Fw0Grj7LfbQ=@protonmail.com>
Feedback-ID: 9Qu1KKHEcnQ-bKszPau2cdh2be1P4X3006lMkI1eP2SK_OSh15c0De44Tu-Egx84xTck3dONeTWRCjCwoqkXdw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

Recently I was doing I/O stress test on my raid5,

however, I stepped into a BUG_ON and I had no idea why would that happen,

the BUG_ON(test_bit(R5_Wantread, &dev->flags)) is in fetch_block function i=
n raid5.c.

After looking the source code, I found that the bit R5_Wantread

would be cleared in ops_run_io if the read operation is about to be conduct=
ed,

the only reason the read was not handled is that the write is handled at th=
e same time,

is there any possible reason that could happen? or under what condition

BUG_ON(test_bit(R5_Wantread, &dev->flags)) would happen?

thanks,

