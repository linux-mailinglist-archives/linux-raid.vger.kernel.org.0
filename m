Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323E6291195
	for <lists+linux-raid@lfdr.de>; Sat, 17 Oct 2020 13:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437359AbgJQLNj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 17 Oct 2020 07:13:39 -0400
Received: from smtp2.kaist.ac.kr ([143.248.5.229]:59387 "EHLO
        smtp2.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437248AbgJQLNe (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 17 Oct 2020 07:13:34 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Oct 2020 07:13:34 EDT
Received: from unknown (HELO mail1.kaist.ac.kr) (143.248.5.247)
        by 143.248.5.229 with ESMTP; 17 Oct 2020 20:06:51 +0900
X-Original-SENDERIP: 143.248.5.247
X-Original-MAILFROM: dae.r.jeong@kaist.ac.kr
X-Original-RCPTTO: linux-raid@vger.kernel.org
Received: from kaist.ac.kr (143.248.133.220)
        by kaist.ac.kr with ESMTP imoxion SensMail SmtpServer 7.0
        id <595760cb0b67440a9c04038fe1fdce40> from <dae.r.jeong@kaist.ac.kr>;
        Sat, 17 Oct 2020 20:06:51 +0900
Date:   Sat, 17 Oct 2020 20:06:51 +0900
From:   "Dae R. Jeong" <dae.r.jeong@kaist.ac.kr>
To:     song@kernel.org
Cc:     yjkwon@kaist.ac.kr, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: WARNING in md_ioctl
Message-ID: <20201017110651.GA1602260@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

I looked into the warning "WARNING in md_ioctl" found by Syzkaller.
(https://syzkaller.appspot.com/bug?id=fbf9eaea2e65bfcabb4e2750c3ab0892867edea1)
I suspect that it is caused by a race between two concurrenct ioctl()s as belows.

CPU1 (md_ioctl())                          CPU2 (md_ioctl())
------                                     ------
set_bit(MD_CLOSING, &mddev->flags);
did_set_md_closing = true;
                                           WARN_ON_ONCE(test_bit(MD_CLOSING, &mddev->flags));

if(did_set_md_closing)
    clear_bit(MD_CLOSING, &mddev->flags);

If the above is correct, this warning is introduced
in the commit 065e519e("md: MD_CLOSING needs to be cleared after called md_set_readonly or do_md_stop").
Could you please take a look into this?

Best regards,
Dae R. Jeong


