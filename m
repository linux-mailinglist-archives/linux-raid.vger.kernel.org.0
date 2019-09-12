Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 703A1B0C4C
	for <lists+linux-raid@lfdr.de>; Thu, 12 Sep 2019 12:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbfILKK0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 12 Sep 2019 06:10:26 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:41689 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbfILKK0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 12 Sep 2019 06:10:26 -0400
Received: by mail-ed1-f41.google.com with SMTP id z9so23405189edq.8
        for <linux-raid@vger.kernel.org>; Thu, 12 Sep 2019 03:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T9I4J0K14jCSl0TRzWejz/m4ZCeJH4cNjukPW6MqL6c=;
        b=WnB/9er3aUNnZ9OQC/Vle4COqFwwtHbAvD4Y1KZuCodXFGHOb2FhRMT42W/KtdhCDg
         OeVBWV6RefSFgumT0a10WrKPJ9R8Uyz2OLjJ7B3nPobjVUBHhCB6mPIb3luf68wF9O+h
         +kOj7KX404EcT19xMJY+7p/aFLTyJoYM1H8aZrVGitpuBPvkgVKIePQJv2ZgnztuFjxc
         HiaNVHIyvAq2IWUY1YH+QgyR/1L3H8gbN/ZWapTMhGp0bJrFtkBw3P6B0HEe1SbXV3Pe
         6eETb4owWrmyEQwrGD7Jlp1guNocd3ms/TLwyTfN3ZUoI3Haq8cgJYfV+AnuwrVD6HZx
         RWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T9I4J0K14jCSl0TRzWejz/m4ZCeJH4cNjukPW6MqL6c=;
        b=uc7KAc7OnR87K31TKrvxVnAKZKkqWdMdKIrLvC/tEYRbYiu2Avr9pu0DTINHLHb01m
         rscYf9gPYU47kR+txZOUoU0eZynW+YvWDGOjXtf/7KDNGyIjLMZ0nRJuAcJ1qMOn+6HV
         QFKIp5TLLvPjf/g7+U0auOHbEAzHjOdnUb/4SEVh2YAGEWopbrYXjVsFhIIKSdBUQ77H
         CyAoNGTV1f7Xk7jJ4Jz+e7usJ9XVZP3O5TQ84fakOeeaGAbfB1Vq2xMpW5G7TY/6kua/
         C6yjSVXNgmd5d4h4T01NgQf//mbtGoZnp/YQDJi6gABjLmSHp/oU4LBwVLEo3DZxis5x
         NHFw==
X-Gm-Message-State: APjAAAV+wZ95nv92l3fHbYNMVBqxsl+Ch2Jg1FAxL3YrLaP2YvAkLSCz
        2RxNe3KESWdAT08m53WQntg=
X-Google-Smtp-Source: APXvYqzO7Cjru7OsFlxMvKypwgsw+X/JELegvOgxuCHSUnInBcVP9P6RlmUA6u1rkN/YasXM6kuCSg==
X-Received: by 2002:a17:906:139b:: with SMTP id f27mr34209162ejc.273.1568283024935;
        Thu, 12 Sep 2019 03:10:24 -0700 (PDT)
Received: from nb01257.pb.local ([2001:1438:4010:2540:98a7:dd7f:3b50:48c5])
        by smtp.gmail.com with ESMTPSA id z39sm4709367edd.46.2019.09.12.03.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 03:10:24 -0700 (PDT)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     songliubraving@fb.com
Cc:     linux-raid@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 0/2] two trivial cleanup for raid5
Date:   Thu, 12 Sep 2019 12:10:14 +0200
Message-Id: <20190912101016.3700-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Hi,

The first remove the flag which is not used anymore.
The second uses bio_end_sector to get the end sector.

Thanks,
Guoqing

Guoqing Jiang (2):
  raid5: remove STRIPE_OPS_REQ_PENDING
  raid5: use bio_end_sector in r5_next_bio

 drivers/md/raid5.c | 1 -
 drivers/md/raid5.h | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

-- 
2.17.1

