Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA3B19E7D7
	for <lists+linux-raid@lfdr.de>; Sun,  5 Apr 2020 00:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDDWBE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 4 Apr 2020 18:01:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34353 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDDWBE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 4 Apr 2020 18:01:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id o1so14018430edv.1
        for <linux-raid@vger.kernel.org>; Sat, 04 Apr 2020 15:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5calPyOCtmEDi48URYdwpZAMFU54pQrmb6s4U/VQjHg=;
        b=Yth0dJRP4p99nmHzbptZu7QvwFfrMkqvs/VUVnJgUwTzheZ4G+qrPprlzcIyXwMLj3
         eOs4BBsrvMTDVhkbZR6h8HTmOSs1epIWfhJ2sJGM2s70OB/qMi/ryC7Eg1nvKvvPNLUY
         olTCPewXtf2/3bI0KEwxk7oQTLePiyHQnNUTABcw2+rk0yI7T/Sp3+gDc9i9nRVQBH8r
         UM6JCUK7DeFFXOqCm3sz1jRAPe+lhTf8xbNnifl/qIurSfUa63WpHaDAFTR97bdJVxlG
         Pr08F4uGu5muxA+vNba4ABxmAEgnVbh57U/SsPMfoKLMzVtw0M/0s1e6lFI9Avs2eK9k
         xLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5calPyOCtmEDi48URYdwpZAMFU54pQrmb6s4U/VQjHg=;
        b=H6r4ziUFq4VYgBfniWkVb7A0Hi/Unz+GTm6ArxMu0kWY2zm3kYNguqWKK4BuU/EZMD
         yyQ5/oDBiFYwOlmfq++u2ZS8ai6az3X1RZQ4LeTw3WQIb6HUXhRbCxovuN/mFX/ngipT
         gA8Z+0Jzr4MkyS+rpGjc4CjJ5gO1Lk1oAJrQCGBiX8Q3J3m4Vmt4QbwEH5+SKbAKRm59
         1vSEDM5+OJvLXqWedfwpuywUlsTteZNM+LVO2oeI2Z31QKONv0cfCkiPTtw4eP5EWS8W
         K4eMmf6ZDthCeUsW35b+VAMfOcC6W/k4shMGTmkyJjSQSxr01rzIoDXnZHeE1wWnQrzE
         INqA==
X-Gm-Message-State: AGi0Pub4vnujLi78s9fAs0z2iq7bIGQTE7/dkXOeAlgfgk8vl5VJIJjV
        WV3nk2oj8fEk2kbjOhiHhTSZkA==
X-Google-Smtp-Source: APiQypItH2ZGXqkvLASyTcyxiXUwGgYLTu7FPNHf+DGmNsZEDq2Y6QvNF6ZVdss+58kEPxyB2aww6w==
X-Received: by 2002:a50:f092:: with SMTP id v18mr13399323edl.77.1586037662137;
        Sat, 04 Apr 2020 15:01:02 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:e120:c0df:e1ea:ba3e])
        by smtp.gmail.com with ESMTPSA id oe24sm1718549ejb.47.2020.04.04.15.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 15:01:01 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     songliubraving@fb.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 0/4] md: fix lockdep warning
Date:   Sat,  4 Apr 2020 23:57:06 +0200
Message-Id: <20200404215711.4272-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

After LOCKDEP is enabled, we can see some deadlock issues, this patchset
makes workqueue is flushed only necessary, and the last patch is a cleanup.

Thanks,
Guoqing

Guoqing Jiang (5):
  md: add checkings before flush md_misc_wq
  md: add new workqueue for delete rdev
  md: don't flush workqueue unconditionally in md_open
  md: flush md_rdev_misc_wq for HOT_ADD_DISK case
  md: remove the extra line for ->hot_add_disk

 drivers/md/md.c | 54 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 16 deletions(-)

-- 
2.17.1

