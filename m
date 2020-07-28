Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EBE230724
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jul 2020 12:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgG1KCL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 06:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgG1KCL (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 Jul 2020 06:02:11 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A989EC061794
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 03:02:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y10so20065045eje.1
        for <linux-raid@vger.kernel.org>; Tue, 28 Jul 2020 03:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FDbu9m1TTCufc2EQwo0FeF5WnvNyS6BqIbew5XbwG0Y=;
        b=hNWyoTr0ukdAenVEok7h/+Rv4QeK3qicG1KJIzdQpgWtHK8MfBDRVcdyYJR+dOehB5
         99aglEO3k2l12ippF0ZN4/hFE1FpnHENll9dIqfgLSwglt6pMYBG5MWc+o9T70T+MUlS
         QoUCpmeCaSzbO/vzIgMrW409sr6UUve2WeLgIHJGOFGyhV9LYnk8KLqu4ROI5rjRhl5F
         1PA5MSNMYXi2B8VOJrANHJD3Qn0BQMlEgBLLaNXMpgbfR7+Ntv98Afy08sGF47mOCXXL
         yfjFUA5Z0xmRxwQJSrf+Aa2EZDxF+AMton287yTY84rUONWxEGtxw2NhkUVTLE0a1GRx
         vO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FDbu9m1TTCufc2EQwo0FeF5WnvNyS6BqIbew5XbwG0Y=;
        b=djZ9zZRZMphgRaYxHl1TF3IQ5GbUk5Oz6D8V85w34F2w/62VeCWi2ztFAIyTxdmr5y
         ZGbELkMjpz1/uKXfK4DUjIzCyzCvQFNY9jEWA69AS7J6k3/+oA8vdKlwjheBM2VSMUKU
         uv3jnCzGNLFa7/xeVmMM2VpwdVcPOZT1PV+bKYCStCNjcTdtkdIik85mh4un4ZIvFD0M
         iFW1FWU0UGabqrt8l+wLgDeabOMgkzy4Dj9xJOyd3LJVrH+9s26KA+HEpq5DdjBo/gJX
         T41JqSsTGC4gPi6/RRolkx9MGQSqGYOl8ERJLbjb5o3qWlvp3KqkLjaEErqsTOdOIyd/
         M2Ow==
X-Gm-Message-State: AOAM532v8b+T2frdN4kSKGCwNgsD9XZJRJ0zgdZtJOdV7Zsw+ik40cws
        vISFUc/t9Yz7R+cpjEdgf050UQDtwkkl4g==
X-Google-Smtp-Source: ABdhPJwDeUWzlHELNNRESmg4byYgms/pB5SzBCYFRA26Hi2/mX4ofgey76c2aUMnDm0oXKnWUurbHA==
X-Received: by 2002:a17:906:3e4f:: with SMTP id t15mr11330603eji.368.1595930529344;
        Tue, 28 Jul 2020 03:02:09 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:34cb:1cd0:d3a5:9c35])
        by smtp.gmail.com with ESMTPSA id b24sm9929530edn.33.2020.07.28.03.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:02:08 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 0/5] misc patches for md
Date:   Tue, 28 Jul 2020 12:01:38 +0200
Message-Id: <20200728100143.17813-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

Please review the patchset which has quite small change, :).

Thanks,
Guoqing

Guoqing Jiang (5):
  md: register new md sysfs file 'uuid' read-only
  md/raid5: remove the redundant setting of STRIPE_HANDLE
  md: print errno in super_written
  raid5-cache: hold spinlock instead of mutex in r5c_journal_mode_show
  raid5: don't duplicate code for different paths in handle_stripe

 Documentation/admin-guide/md.rst |  4 ++++
 drivers/md/md.c                  | 12 +++++++++++-
 drivers/md/raid5-cache.c         |  9 +++------
 drivers/md/raid5.c               | 17 +++++------------
 4 files changed, 23 insertions(+), 19 deletions(-)

-- 
2.17.1

