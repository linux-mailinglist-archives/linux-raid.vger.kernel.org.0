Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DEC2AE7DE
	for <lists+linux-raid@lfdr.de>; Wed, 11 Nov 2020 06:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgKKFRK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Nov 2020 00:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgKKFRK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 11 Nov 2020 00:17:10 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9CFC0613D1;
        Tue, 10 Nov 2020 21:17:09 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id ay21so966240edb.2;
        Tue, 10 Nov 2020 21:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S1CPELgYldtFpEc4ZPQoBxBtRZRG1YqbE3XF0gBcpeA=;
        b=A1cz4PjQHfIp1WjjrKKaLm8zLLBpmjth/Li3Ywu4KL1gphqrBHSyfIj4tLTdfCleby
         6DBKgu4umF7SoaJAlYtJPgZMeXX2iV2ho0w1B8MJRSkJiaQ7pWBoKX0tveYuOICk8eHw
         7ldN31z41yVROWa/F/8NjdGbBwcO6g8YQRWzqYsgrMN5S0tfPPSYzchG85glX+EKV1Jh
         3xKJxY1wOeTvXxQ/v3MRwmEKtVHmcSPFdE5hqahfRUKR96og/jl/sYTBzT3W4bH+mgTl
         PsluFbDyLLozdioXYIT3+eB1CRliN1RxkD75wFUKC8iTjsxgq1ap+sg+g2I47sKBER5P
         tvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S1CPELgYldtFpEc4ZPQoBxBtRZRG1YqbE3XF0gBcpeA=;
        b=EHR1O/rJ79RD3MWj+HwftWt3punud4hRlkiKPJI47NbRUEkXeF1kXEZfRilQsTh6Oy
         fodvlC741dB99rjXsRqo05oJvNakzUE6qIQWrdysq4XWdl9C/EnLnR6ptxZzcD3/7Bku
         ni1dHDo/F/cnQvN8DEg/nfXN5RrsEJuXnH1joEZCF/+E5EHTbSC6PyXCeQnEYwq/lIRt
         n/O/OlaQN9sk0BZ4N4+8OmEuia9ZlVn3s6t5sgu7zd/fT9DuJkr93a7cZlhP7XiXIZA4
         /0+LgOZj14U/ihkJFnPUmFxIM29yqDOeg4RMOzYO2mjETkolC9D98KbSNRTQ7hGigK34
         +s/Q==
X-Gm-Message-State: AOAM533zBw2NHNiO0D/CPtsmlU3DvfeKdzHeJuLLf0oA3VVD/9uGJICc
        tmeAg9SHv0kXd4DcxVxtEyuWFKaKVv8=
X-Google-Smtp-Source: ABdhPJzldFbXrSTxDuiHz4DTDyeEBpseICIhB+0hFuiFm8JTMD3UikTlLlblnsgPx41ASsmN3LRoDg==
X-Received: by 2002:a05:6402:31b6:: with SMTP id dj22mr25544730edb.348.1605071828485;
        Tue, 10 Nov 2020 21:17:08 -0800 (PST)
Received: from lb01399.pb.local (p200300ca573cea52c98ae5b6a31510db.dip0.t-ipconnect.de. [2003:ca:573c:ea52:c98a:e5b6:a315:10db])
        by smtp.gmail.com with ESMTPSA id g20sm363628ejz.88.2020.11.10.21.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 21:17:07 -0800 (PST)
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        pankaj.gupta.linux@gmail.com,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Subject: [PATCH 0/3] md: code cleanups
Date:   Wed, 11 Nov 2020 06:16:55 +0100
Message-Id: <20201111051658.18904-1-pankaj.gupta.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>

This patch series does some cleanups during my attempt to understand
the code. 

Pankaj Gupta (3):
  md: improve variable names in md_flush_request()
  md: add comments in md_flush_request()
  md: use current request time as base for ktime comparisons

 drivers/md/md.c | 12 ++++++++----
 drivers/md/md.h |  6 +++---
 2 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.20.1

