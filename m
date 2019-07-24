Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A6D72B26
	for <lists+linux-raid@lfdr.de>; Wed, 24 Jul 2019 11:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfGXJJm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 24 Jul 2019 05:09:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34065 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfGXJJm (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 24 Jul 2019 05:09:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id s49so11628453edb.1
        for <linux-raid@vger.kernel.org>; Wed, 24 Jul 2019 02:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MCgv7Sfnr2JB+fRRP1zw1rd9shnrqCw5NTK/mE+Vxg0=;
        b=WG0Iaf5r8JhpNlJbLWp/Bbtx70GoKp0M9gsv8xH8XiWfTlVJTT6PQCs4BrmbwakSsc
         jjDkMGarqRri82eXCwA3SOb1pAEeYd7OWZtbQjvs8k3Cw3YdH8yqWRPNKXPtetx6y43z
         Yg7yXhuLbXBe0Qc/2VBc+th5dv2ObO5h3M0fnMj17qg6MX+zzk/82IySPNjt5q8X49Xs
         9DzdLtvwn01fEj1lWaBvV5dEPOQfB7XdvUvLZTke3YYuHeEzyTJD5i1B7EGgks4kWInu
         +V2EFa/0scSmi9zgVrgcZia5+SvokyotttD6e2NdtD7AzYDXql943Uc5pIiQD3VJ0Ces
         Fv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MCgv7Sfnr2JB+fRRP1zw1rd9shnrqCw5NTK/mE+Vxg0=;
        b=nMpxs6Htduky4Olijn5He4WCUW3G1ARzS1JKXsEGkOdHBktU8jAgoXHuYFPkB7BHfk
         8GieU36NAtn5uOcEBcR1ypLuXomyMggex8Rfa5P7m4oy4PO1ktqczz9OAzqVSKuAkLkH
         oWCJo7DN9Nj0p5TYWsSk7BTeDdRF+7rCXpS5rgJh9xvMLLVhT3r/V/qp5TM/6p11c59W
         699AIZoGIzoTMOE9JYPf/GpGenRZIXh0goH6MxhMXKRBPIxLB56X6m6xXoDEF9AJ82Ep
         xG1CzP1V12KiQLm3mNh8N63YEFYn2Pl717Ko7RCoriDH36rmE5uex0Z1bogvILbBrmKs
         wvPQ==
X-Gm-Message-State: APjAAAWtylrUknY8gtm0ulAvinhHx41n21txOREBTor2rlb+sCnvlXW3
        9G4niNfSGZWRu7BWGoxWPHs=
X-Google-Smtp-Source: APXvYqwUm9rNM5oytfnvb3AkdqxuHlDYzUGoPTRTGZmXD5m1mgbGW0qwUBMfhfJGfs28eyVHNyVhLg==
X-Received: by 2002:a50:ad01:: with SMTP id y1mr68666930edc.180.1563959380392;
        Wed, 24 Jul 2019 02:09:40 -0700 (PDT)
Received: from nb01257.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id nw21sm3927709ejb.15.2019.07.24.02.09.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 02:09:39 -0700 (PDT)
From:   Guoqing Jiang <jgq516@gmail.com>
X-Google-Original-From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     liu.song.a23@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 0/3] enable fail last device in raid1/10 array
Date:   Wed, 24 Jul 2019 11:09:18 +0200
Message-Id: <20190724090921.13296-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

The first patch adds the support for fail the last device in raid1/10 array,
and other two patches fix issue that the new added disk is set with In_sync
even it doesn't complete the synchorization of data.

Thanks,
Guoqing

Guoqing Jiang (3):
  md: allow last device to be forcibly removed from RAID1/RAID10.
  md: don't set In_sync if array is frozen
  md: don't call spare_active in md_reap_sync_thread if all member
    devices can't work

 drivers/md/md.c     | 45 +++++++++++++++++++++++++++++++++++++++++----
 drivers/md/md.h     |  1 +
 drivers/md/raid1.c  |  6 +++---
 drivers/md/raid10.c |  6 +++---
 4 files changed, 48 insertions(+), 10 deletions(-)

-- 
2.17.1

