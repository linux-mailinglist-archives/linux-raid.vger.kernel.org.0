Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE2776DF04
	for <lists+linux-raid@lfdr.de>; Thu,  3 Aug 2023 05:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjHCD30 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 2 Aug 2023 23:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbjHCD24 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 2 Aug 2023 23:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BF42D65
        for <linux-raid@vger.kernel.org>; Wed,  2 Aug 2023 20:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691033291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=PQGH1/AIB+1NiDKsd40ETyEoByGaba7zoX5glIawJ9Y=;
        b=NSDg5kDnMEUwHZWa1kcb7YCAgEB4s95975MXgNZ0la4HfJjiYDxrELpY7LF1kHZnn9BBc8
        9k30GefF1ErzFfB/z89zeQQ4pmDdnPdfaB6bTuhN+7BRo2SnDqF5GvDZTWA51vzwDq9xO2
        /I5+DyBd7VZp4Y4JiP0a9dWlHqf/NTw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-yPh4_JKHPEOrVUvnFNWSyw-1; Wed, 02 Aug 2023 23:28:10 -0400
X-MC-Unique: yPh4_JKHPEOrVUvnFNWSyw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-268099fd4f5so263837a91.1
        for <linux-raid@vger.kernel.org>; Wed, 02 Aug 2023 20:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691033288; x=1691638088;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQGH1/AIB+1NiDKsd40ETyEoByGaba7zoX5glIawJ9Y=;
        b=ZDT0xTtB+roq2/euzKjXM1I8xs4zObz82OTYZAc3w2AcPquDeOIBA1CEZGXlFpYduw
         ocR+DWRoorLgDtz6haRHi00Yk3QbR8+YtjrcEaYGEhs5fQ1jIjNtz076XF4MdyeXiZkG
         NXsu96bIWKL81SmLilwVQKAEqAbYJF0wk9osV1196PIibv9zywHRI/QZYv5ZPtUdAEpF
         njuMnj+E78EA7ZSSWij8Ij2vVs69mgv5xh58v1S4rRwu0vkoCSbiYdTwS0DokDUXAoBl
         Daaxi/OnMR5DEu5tpBNqnggsEHppzzQQt+HbfxGS6MDQPheol1aJ/jy+gz4GVLlRJkGc
         D3IA==
X-Gm-Message-State: ABy/qLYf2VYc61AS1X5V6XYTesI0s0UYmBHWh0RIL+PwM0JUoQKDYuQt
        UwxQ4lDdsp/111pU9ulcsSXzjFxF9mydHBE0OVis0RR14Sn7f0U5ACqVJjxlCceqq1N8wpPEQKI
        KeWiboKAcE/IeUCCihvlJRsoyrbVV0o8NzRgcge8U43h8Ltb2nTU=
X-Received: by 2002:a17:90a:970b:b0:268:4f23:8015 with SMTP id x11-20020a17090a970b00b002684f238015mr15044747pjo.31.1691033288665;
        Wed, 02 Aug 2023 20:28:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGItPhfNTdZb++EgK4OHmkk+fRaBuWFdc+xJDNs5YhOPz5fTb/jzeaLsm/Gkz11B6iFwBjbl4zfX5lTHM6Pq/Y=
X-Received: by 2002:a17:90a:970b:b0:268:4f23:8015 with SMTP id
 x11-20020a17090a970b00b002684f238015mr15044741pjo.31.1691033288377; Wed, 02
 Aug 2023 20:28:08 -0700 (PDT)
MIME-Version: 1.0
From:   Xiao Ni <xni@redhat.com>
Date:   Thu, 3 Aug 2023 11:27:57 +0800
Message-ID: <CALTww2_FrkmafTkObCX4W1SXVeJiy45h7TR68iHUMpzfAOseHQ@mail.gmail.com>
Subject: The imsm regression tests fail
To:     "Tkaczyk, Mariusz" <mariusz.tkaczyk@linux.intel.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Mariusz

Now most imsm regression tests fail.

+++ /home/mdadm/mdadm --quiet --create --run /dev/md/vol0 --auto=md
--level=0 --size=5120 --chunk=64 --raid-disks=3 /dev/loop0 /dev/loop1
/dev/loop2 --auto=yes
+++ rv=0
+++ case $* in
+++ cat /var/tmp/stderr
mdadm: timeout waiting for /dev/md/vol0

+++ echo '**Fatal**: Array member /dev/md/vol0 not found'
**Fatal**: Array member /dev/md/vol0 not found

Could you have a look at this problem?

Best Regards
Xiao

