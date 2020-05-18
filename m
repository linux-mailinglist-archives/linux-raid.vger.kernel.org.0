Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6081D883F
	for <lists+linux-raid@lfdr.de>; Mon, 18 May 2020 21:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgERTbY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 May 2020 15:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgERTbY (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 May 2020 15:31:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00E3C061A0C
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 12:31:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n5so813260wmd.0
        for <linux-raid@vger.kernel.org>; Mon, 18 May 2020 12:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=prrAfp0DJcsL7nXcLYmMrLiYuFU0TYfqhQ3guTk2oac=;
        b=J/8fx5dfzaGRgWlKC0ppb3dZBzAjr5Qhj7DvrZy5kPIjuJv6sI54zCeA0NLvjpBoA7
         rGoGYygkkWlMKiCmHHsWq4iwqG9izHicTTQrToqZlP0nvDFRgsnV0Yxxx/dodpbjUIcY
         sTOU/A1fyjUe1qWkK47JHHrGqsbQTgtxV4sDVJbzkqiL6jos3Yczb8M3wzOWYSPSmdLG
         ry55zGuWBVo152bbwK5Euht1oQx70t+j5Z3uacERLa412aG+0lgOayClKdmOwa8Hhk56
         6zv5bO2DcB+sNU2yp8Y4sxxl+Hy3+G5NpZQrCKQ9AiDkZxwhCdm27NarCxz/V4BkF1ug
         cEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=prrAfp0DJcsL7nXcLYmMrLiYuFU0TYfqhQ3guTk2oac=;
        b=gnVZCceUlVT2oTTi+05GM0vr7HSPy3NkT81U8CkkzSkr9znjqoAJXZRaRmH3UMGL+1
         qIoMfrs7/8NZ3/9NcTK+8zSayDWNcoDMOUnkzRpWrT7XDkbWbdqbUosTNcngb53WzK6u
         VoaHR+QftzlAuGly8iVQc08hcfcJbAitMhQPzEosgX++xxDu+f2ChNBvA6C173fRPidC
         Vt6m1wN4xKWaCmYAqDNuubBu4Cyporz+W043OhyH8nuRlaavGl9L8w1jo1VtOuTn+qGi
         y0eRn1jRpkjl5LYnNf+w34axXJxDqabmouWY19wo3YoiIZ2TtkqVZ9xZj1zk5XPN6mu5
         W+8w==
X-Gm-Message-State: AOAM531pRMTm8vgTRXk9g22CWsx0fQ4EiqvMVGpVtKJmYSh1HzK9YNKW
        osbQp8WrxQ5RoEdHl/cZrkTH9w==
X-Google-Smtp-Source: ABdhPJz5ue2sLyBpP9zPUnNxngysKwMtjtAcNBfR8HFj8xnvaGhClzfvuYjMm80oLi2lcgAtaOQUbg==
X-Received: by 2002:a7b:c951:: with SMTP id i17mr895718wml.63.1589830282478;
        Mon, 18 May 2020 12:31:22 -0700 (PDT)
Received: from gjiang-5491.profitbricks.net ([2001:16b8:483d:6b00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id u65sm736299wmg.8.2020.05.18.12.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:31:21 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 0/2] Fix build issues
Date:   Mon, 18 May 2020 21:31:06 +0200
Message-Id: <20200518193108.26102-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jes,

Hopefully this version addresses your comments.

V2 Changes:
1. copy the whole license from util.c to uuid.c
2. check the return value of read correctly

Thanks,
Guoqing

Guoqing Jiang (2):
  uuid.c: split uuid stuffs from util.c
  restripe: fix ignoring return value of ‘read’

 Makefile   |   6 +--
 restripe.c |  10 ++++-
 util.c     |  87 -----------------------------------------
 uuid.c     | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+), 91 deletions(-)
 create mode 100644 uuid.c

-- 
2.17.1

