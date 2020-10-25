Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956652981FD
	for <lists+linux-raid@lfdr.de>; Sun, 25 Oct 2020 14:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416448AbgJYNyg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 25 Oct 2020 09:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416446AbgJYNyg (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 25 Oct 2020 09:54:36 -0400
X-Greylist: delayed 583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Oct 2020 06:54:35 PDT
Received: from hoggar.fisica.ufpr.br (hoggar.fisica.ufpr.br [IPv6:2801:82:80ff:7fff::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED66C0613CE
        for <linux-raid@vger.kernel.org>; Sun, 25 Oct 2020 06:54:35 -0700 (PDT)
Received: by hoggar.fisica.ufpr.br (Postfix, from userid 577)
        id D7DC83620303; Sun, 25 Oct 2020 10:44:46 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=fisica.ufpr.br;
        s=201705; t=1603633486;
        bh=ZQYTB0R+ZUo6fyG3SgggEguKCWQOVBqO6BntqF3M/y8=;
        h=Date:From:To:Subject:From;
        b=wwBP4ro1CKw+DGZLWMTf5uHsIZY6mb9V52mCiRv696lqcvdMtU3goyfa5Uv4sf/cr
         74/6dnG5H/Mh15zZQ1tM0h9XSRPXqhYvtl1qBgz27WgMiDjiojPQcpbWiwJGjxA1I+
         2KwL0+X+I+GAeW0rVwNM15nhqYZnMiVnYzjlBUfOqtQTauqkj7kTBhAQj5h3bEUgzC
         Cc/ZbwnRjptgGoV65itJjyEbgdMgr3c74l4XVcxoZbsvlcBZ7NKZyTtkfvCmtFO0W6
         aSd5zYc51kizK5dDlUeL4s29CCRv1RWv9+EPlUZMoHm8uwNqJ9kSOv7SdMLgZAAbic
         NQDRqF7FeF3MA==
Date:   Sun, 25 Oct 2020 10:44:46 -0300
From:   Carlos Carvalho <carlos@fisica.ufpr.br>
To:     linux-raid@vger.kernel.org
Subject: crash with 5.8.11 and 5.8.13
Message-ID: <20201025134446.GA16905@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

We had kernel panic with 5.8.11 and 5.8.13. Here's the trace, copied manually
from the console:

r5l_log_stripe
r5l_write_stripe
ops_run_io
? async_gen_syndrome
? ops_run_reconstruct6
handle_stripe
raid5_do_work
? __switch_to_asm
process_one_work
worker_thread
? process_scheduled_works
kthread
? __kthread_queue_delayed_work
ret_from_fork

The machine has an array with 14 disks and one with 20, both with it's own
journal ssd. It has high I/O flux and is usually very stable. The first crash
happened with 5.8.13; I downgraded to 5.8.11 and it happened again. In both
cases I had done a check on the arrays (simultaneously) by doing echo check >
/sys/block/md<number>/md/sync_action. Note that the crash happened more than
24h after the checks had successfully finished.

The only thing I've changed from the usual procedure is to change
/sys/block/md<number>/md/group_thread_cnt. I normally use 5 to not limit checks
by cpu. In the crash cases I raised group_thread_cnt to 10 soon after the
checks started.

Any ideas?
