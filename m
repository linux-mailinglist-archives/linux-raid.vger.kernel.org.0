Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F053764ADC
	for <lists+linux-raid@lfdr.de>; Thu, 27 Jul 2023 10:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbjG0IMV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 27 Jul 2023 04:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjG0ILS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 27 Jul 2023 04:11:18 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209A62D6A
        for <linux-raid@vger.kernel.org>; Thu, 27 Jul 2023 01:07:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6862d4a1376so188285b3a.0
        for <linux-raid@vger.kernel.org>; Thu, 27 Jul 2023 01:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445196; x=1691049996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ddhCZTkz2TFo7oGCFzg4uU7nrLecafIDKLLill2eh8=;
        b=EEgKRQyP19rDGzyMkxrAyrND65/av9N1ZEpraFKdjf5iHd/PgC9Uhy/xnwzeo3ff8l
         m3TJD5UzpvFEDeBzcRtJtOD/qHmmEUSLFJuussVMd7PAkAK7iQKGftfC2f44nNeUEfJr
         mKle0CkHpRLYz5sWKpGW6Zb4t5WjMo/pANabwTgogYiGmsOD2+fKJGiw7ZJ36fC4jq2K
         1KqECLKCfE0K//MR+hlNLb+3ZgY7viYlU4DaknQaSi+VFe2dV+fDBnzCaNkdmNFv1cVa
         f6nuMbduVm+LsREYRbVVclCckYchB0Qi+6OZAWegvIeaDdeHomKe1HhIBSolAxF7uDUX
         dSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445196; x=1691049996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ddhCZTkz2TFo7oGCFzg4uU7nrLecafIDKLLill2eh8=;
        b=IaPz9J/1aSG6B87kK0hTae5BeJ82PIaZ9tbSneXUTq4yukGCHkveHnwQzVLMcDfrPE
         0uTauohVncH8Z++RMizC2SzDUFht5d4OTOdln1S7GFPC6DVf1vIhFU84IlMJjz6t/2CR
         m4iB/bFY3KhrnoEOlu9xKxKV7AO4PzazCj6iIZDwAhb28Hc5dYpBGz9XyLKCpYRbosda
         1G86ydzcekqxVRF5RJKuL5W8oapvdvx7ek+rKsst5WPHAzbHm32fL0WEHkUIO/hfqGf3
         CnyOU4GxnUGtRY/pGe+frVomYYBp8oUj0Z8HaPW8c0JXWZ/zbeS3GSps+xbOqw9CX43b
         MY3g==
X-Gm-Message-State: ABy/qLZZSbXCw0SavVe9l5nlhMNG+3ZOd6IzQvYtIyNuz3ueYMJNl7nu
        qJJpmvPV45LrMkmmIl4Oq7mOIA==
X-Google-Smtp-Source: APBJJlGC9GcjpF//RTfgHk/e3ibfMuX5WCzda5QO/QIZ+yDcAz1vV0DX9dFwhd70yzWPOAQ384luFQ==
X-Received: by 2002:a05:6a21:6da1:b0:134:1671:6191 with SMTP id wl33-20020a056a216da100b0013416716191mr5882289pzb.0.1690445196605;
        Thu, 27 Jul 2023 01:06:36 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:06:36 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 04/49] mm: shrinker: remove redundant shrinker_rwsem in debugfs operations
Date:   Thu, 27 Jul 2023 16:04:17 +0800
Message-Id: <20230727080502.77895-5-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The debugfs_remove_recursive() will wait for debugfs_file_put() to return,
so the shrinker will not be freed when doing debugfs operations (such as
shrinker_debugfs_count_show() and shrinker_debugfs_scan_write()), so there
is no need to hold shrinker_rwsem during debugfs operations.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/shrinker_debug.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 3ab53fad8876..f1becfd45853 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -55,11 +55,6 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 	if (!count_per_node)
 		return -ENOMEM;
 
-	ret = down_read_killable(&shrinker_rwsem);
-	if (ret) {
-		kfree(count_per_node);
-		return ret;
-	}
 	rcu_read_lock();
 
 	memcg_aware = shrinker->flags & SHRINKER_MEMCG_AWARE;
@@ -92,7 +87,6 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 
 	rcu_read_unlock();
-	up_read(&shrinker_rwsem);
 
 	kfree(count_per_node);
 	return ret;
@@ -117,7 +111,6 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 	struct mem_cgroup *memcg = NULL;
 	int nid;
 	char kbuf[72];
-	ssize_t ret;
 
 	read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
 	if (copy_from_user(kbuf, buf, read_len))
@@ -146,12 +139,6 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 		return -EINVAL;
 	}
 
-	ret = down_read_killable(&shrinker_rwsem);
-	if (ret) {
-		mem_cgroup_put(memcg);
-		return ret;
-	}
-
 	sc.nid = nid;
 	sc.memcg = memcg;
 	sc.nr_to_scan = nr_to_scan;
@@ -159,7 +146,6 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 
 	shrinker->scan_objects(shrinker, &sc);
 
-	up_read(&shrinker_rwsem);
 	mem_cgroup_put(memcg);
 
 	return size;
-- 
2.30.2

