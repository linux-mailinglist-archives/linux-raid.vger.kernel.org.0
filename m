Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4274E1D4F63
	for <lists+linux-raid@lfdr.de>; Fri, 15 May 2020 15:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgEONk6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 15 May 2020 09:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgEONk5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 15 May 2020 09:40:57 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB69C061A0C
        for <linux-raid@vger.kernel.org>; Fri, 15 May 2020 06:40:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i15so3562551wrx.10
        for <linux-raid@vger.kernel.org>; Fri, 15 May 2020 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DPmjeIBTNr97ET8puGpvWbLP1h/n+lu+TxjQft6FeLE=;
        b=caUsKcHD7yroS24ysKGuiy9efbnv/eZQx5ngDhka6lsDJrrP2VPEVGq35wZHEq0coV
         O4BQnRKz9L/3Qr7lqyy7+ceR6gHRf09mIpUuUW0NJbJFn0eupshSWTKWPSiScrOolhtn
         i9L1QeueqbjyYvKvL8FHWxqGc/U/mb3VvYDDgg+ud7dtChauBcdVALhAR6vxQbCdxVid
         sRHFWFUgg8q/4A4jurR5xDXf+5A0uG5vn0GMq3JpP5HD6aEdOx0Ls0748JCCU2Pf4/bq
         jOEBS+2lZzxLLb/7siy8r70fepi/XoOtWb8vI1RM/yJg2nXZ5DPp58PIC4a+3aUvrrwk
         tblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DPmjeIBTNr97ET8puGpvWbLP1h/n+lu+TxjQft6FeLE=;
        b=T/X5ZQAIs5z50hPg70VZyufbjAkRRMjaqujMSrpOr0yaMA4p/38p4CTqkllqNTmUH3
         4FSdJJVx/tzWfaeCPi3AaCKU9IeAINuB4AS7U6X1b1VHJuzUJuQqYVhDhp135wb0ua7w
         ZEnh2Hwhpo0yN4TiR3hugTfSDwlgjIO+Qqci/LUBne9mCtRiC1GOutxUaZQf4ghPdMRG
         OQr9DZBFYofqUqbMWlPEzeoUvghPGNv1FhjczIkEkxqUdVnaj/8RAlsA48/PZej764un
         T+XAVXIYEWkRf6UmBqm1WOavtRhnwbdwhCco2s/4cbQSJyOgdgHpW7/X2WJK0QO2an5T
         9eGw==
X-Gm-Message-State: AOAM533FGx/Av3WHoqPVbAdZiCokXtp/Nj2yY5wR47YaEv6LvhQf+i7x
        AylO+0aA++pVJwOqlRXXL41HMHRzHiTchg==
X-Google-Smtp-Source: ABdhPJwbNOracQYTHxMzX6qSOKCUMprhj4wh64yNMfxUlboGc+UWaQe6lVbQgTX8dTgjWHi/DuNslA==
X-Received: by 2002:a5d:684f:: with SMTP id o15mr4259519wrw.89.1589550055052;
        Fri, 15 May 2020 06:40:55 -0700 (PDT)
Received: from gjiang-5491.profitbricks.net ([2001:16b8:48fe:dd00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id v8sm3918702wrs.45.2020.05.15.06.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 06:40:54 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 0/2] Fix build issues
Date:   Fri, 15 May 2020 15:40:24 +0200
Message-Id: <20200515134026.8084-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jes,

The first patch resolve the build issue of 'make raid6check', and the second
one is for the issue which appeared during 'make everything'. Maybe it is
better to resolve the issues before release 4.2.

BTW, compile test only.

Thanks,
Guoqing

Guoqing Jiang (2):
  uuid: split uuid.c from util.c
  restripe: fix ignoring return value of ‘read’

 Makefile   |  6 ++--
 restripe.c |  6 +++-
 util.c     | 87 ---------------------------------------------------
 uuid.c     | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+), 91 deletions(-)
 create mode 100644 uuid.c

-- 
2.17.1

