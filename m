Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5754777BAA6
	for <lists+linux-raid@lfdr.de>; Mon, 14 Aug 2023 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjHNNyk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 14 Aug 2023 09:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjHNNyV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 14 Aug 2023 09:54:21 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0515D10E4
        for <linux-raid@vger.kernel.org>; Mon, 14 Aug 2023 06:54:19 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-688142a392eso3166210b3a.3
        for <linux-raid@vger.kernel.org>; Mon, 14 Aug 2023 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1692021258; x=1692626058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=izkBVqSXJvYottr+Ujvc43aPG4/6VkeC0ETnYCtOlGc=;
        b=I8Lu4ZldLanNZRYZZQzW1LQLNUyAzPI+BKhv3x56tfDZrwNStLD5h8lla+jOEkfQQl
         qxZM0LikM3TWytGKdmLjTEos/3cD5x6FRK9Oj5qybhoyEyhQaXSlsW1K6ztR3tfRAGd7
         /C76BJq7MZIGUVyOhvIHIQUjijMb04Pj8+469RE84R9H64QIbS6AD5YV4pNoVufAtmFp
         7MdxgYjx2t1iovZ0HFxQGFAROj/Zg6VWXNkBdGZkVP1AHYSjKei+8/Lr08IOL5rvFpVj
         XphaQqzVIPvTh6jhv7qT08GujsOgje41m9N4K9Da3TesK+Eubz72udlqs4Sa07Y3dUqi
         cyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692021258; x=1692626058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izkBVqSXJvYottr+Ujvc43aPG4/6VkeC0ETnYCtOlGc=;
        b=EiUe4Pwhx4l+/b3Q9LmdsACU3aQJe0Z0w45bF6evh686cs68MDlRA6AgGwcshGUk9f
         zVEN9ekn3KNvZw4RR2X03d0ITpuIVl0iqOyVRqyBX+7NIXORFBkfOw4C2voHzLazFB5d
         gC+UFIx2tQ/1Afejq1PhsaXlCXO38+JMohqYGx0RtwCK8CtwdbEqdDARxJj1rFo9MH9U
         dNrTGv3I5zn8ZPhDxQsTW7sPodFozv8aLFiAUNJ1kpCTl0THi6mOJNSvv1h6A47EhNbF
         jk87XH6h/PTP82cRqI2RSnzk3GQqx6hkp3CtW/ASzG/DccwUd3idJWBmccT+SxKotRhf
         DaUA==
X-Gm-Message-State: AOJu0YwA7bjFo6wzmePaEtNOg8gAulz2fyC0nz6mB6ezS0s//xxteI6I
        kwvjXrvC2J0abW+aajCmkd3XyQ==
X-Google-Smtp-Source: AGHT+IG66NQuBbj0i2OZZbmB2Ro/Ijg2b68TmH+eOursiucZrzM4Ies9uQZUuLrIOIZurfmFHZGmiQ==
X-Received: by 2002:a05:6a20:1052:b0:12f:dc31:a71e with SMTP id gt18-20020a056a20105200b0012fdc31a71emr10058587pzc.56.1692021258329;
        Mon, 14 Aug 2023 06:54:18 -0700 (PDT)
Received: from nixos.tailf4e9e.ts.net ([47.75.78.161])
        by smtp.googlemail.com with ESMTPSA id m26-20020a056a00165a00b006874a6850e9sm7962122pfc.215.2023.08.14.06.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:54:18 -0700 (PDT)
From:   Xueshi Hu <xueshi.hu@smartx.com>
To:     yukuai3@huawei.com, song@kernel.org, dan.j.williams@intel.com,
        neilb@suse.de, akpm@linux-foundation.org, neilb@suse.com
Cc:     linux-raid@vger.kernel.org, Xueshi Hu <xueshi.hu@smartx.com>
Subject: [PATCH v6 0/3] md/raid1: call free_r1bio() before allow_barrier()
Date:   Mon, 14 Aug 2023 21:53:53 +0800
Message-Id: <20230814135356.1113639-1-xueshi.hu@smartx.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Because raid reshape changes the r1conf::raid_disks and the mempool, it
orders that there's no in-flight r1bio when reshaping. However, the
current caller of allow_barrier() allows the reshape
operation to proceed even if the old r1bio requests have not been freed.

-> v2:
	- fix the problem one by one instead of calling
	blk_mq_freeze_queue() as suggested by Yu Kuai
-> v3:
	- add freeze_array_totally() to replace freeze_array() instead
	  of gave up in raid1_reshape()
	- add a missed fix in raid_end_bio_io()
	- add a small check at the start of raid1_reshape()
-> v4:
	- add fix tag and revise the commit message
	- drop patch 1 as there is an ongoing systematic fix for the bug
	- drop patch 3 as it's unrelated which will be sent in
	another patch
-> v5:
	- split the patch into three parts, with each individual patch fix
	one bug.
-> v6:
	- drop the fix tag in patch 1.


Xueshi Hu (3):
  md/raid1: call free_r1bio() before allow_barrier()
  md/raid1: free the r1bio firstly before waiting for blocked rdev
  md/raid1: keep the barrier held until handle_read_error() finished

 drivers/md/raid1.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
2.40.1

