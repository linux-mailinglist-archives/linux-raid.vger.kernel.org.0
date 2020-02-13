Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32AFB15C093
	for <lists+linux-raid@lfdr.de>; Thu, 13 Feb 2020 15:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgBMOpe (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 13 Feb 2020 09:45:34 -0500
Received: from os.inf.tu-dresden.de ([141.76.48.99]:42832 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBMOpd (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 13 Feb 2020 09:45:33 -0500
X-Greylist: delayed 1583 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2020 09:45:32 EST
Received: from [2002:8d4c:3001:48::120:84] (helo=jupiter)
        by os.inf.tu-dresden.de with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256) (Exim 4.93.0.3)
        id 1j2FKe-0000pY-M0; Thu, 13 Feb 2020 15:19:08 +0100
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
To:     mplaneta@os.inf.tu-dresden.de, Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Song Liu <song@kernel.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-erofs@lists.ozlabs.org
Subject: [PATCH] Remove WQ_CPU_INTENSIVE flag from unbound wq's
Date:   Thu, 13 Feb 2020 15:18:23 +0100
Message-Id: <20200213141823.2174236-1-mplaneta@os.inf.tu-dresden.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The documentation [1] says that WQ_CPU_INTENSIVE is "meaningless" for
unbound wq. I remove this flag from places where unbound queue is
allocated. This is supposed to improve code readability.

1. https://www.kernel.org/doc/html/latest/core-api/workqueue.html#flags

Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
---
 drivers/crypto/hisilicon/qm.c | 3 +--
 drivers/md/dm-crypt.c         | 2 +-
 drivers/md/dm-verity-target.c | 2 +-
 drivers/md/raid5.c            | 2 +-
 fs/erofs/zdata.c              | 2 +-
 5 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index b57da5ef8b5b..4a39cb2c6a0b 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -1148,8 +1148,7 @@ struct hisi_qp *hisi_qm_create_qp(struct hisi_qm *qm, u8 alg_type)
 	qp->qp_id = qp_id;
 	qp->alg_type = alg_type;
 	INIT_WORK(&qp->work, qm_qp_work_func);
-	qp->wq = alloc_workqueue("hisi_qm", WQ_UNBOUND | WQ_HIGHPRI |
-				 WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM, 0);
+	qp->wq = alloc_workqueue("hisi_qm", WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
 	if (!qp->wq) {
 		ret = -EFAULT;
 		goto err_free_qp_mem;
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index c6a529873d0f..44d56325fa27 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3032,7 +3032,7 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 						  1, devname);
 	else
 		cc->crypt_queue = alloc_workqueue("kcryptd/%s",
-						  WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM | WQ_UNBOUND,
+						  WQ_MEM_RECLAIM | WQ_UNBOUND,
 						  num_online_cpus(), devname);
 	if (!cc->crypt_queue) {
 		ti->error = "Couldn't create kcryptd queue";
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 0d61e9c67986..20f92c7ea07e 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -1190,7 +1190,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	}
 
 	/* WQ_UNBOUND greatly improves performance when running on ramdisk */
-	v->verify_wq = alloc_workqueue("kverityd", WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM | WQ_UNBOUND, num_online_cpus());
+	v->verify_wq = alloc_workqueue("kverityd", WQ_MEM_RECLAIM | WQ_UNBOUND, num_online_cpus());
 	if (!v->verify_wq) {
 		ti->error = "Cannot allocate workqueue";
 		r = -ENOMEM;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index ba00e9877f02..cd93a1731b82 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -8481,7 +8481,7 @@ static int __init raid5_init(void)
 	int ret;
 
 	raid5_wq = alloc_workqueue("raid5wq",
-		WQ_UNBOUND|WQ_MEM_RECLAIM|WQ_CPU_INTENSIVE|WQ_SYSFS, 0);
+		WQ_UNBOUND|WQ_MEM_RECLAIM|WQ_SYSFS, 0);
 	if (!raid5_wq)
 		return -ENOMEM;
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 80e47f07d946..b2a679f720e9 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -43,7 +43,7 @@ void z_erofs_exit_zip_subsystem(void)
 static inline int z_erofs_init_workqueue(void)
 {
 	const unsigned int onlinecpus = num_possible_cpus();
-	const unsigned int flags = WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE;
+	const unsigned int flags = WQ_UNBOUND | WQ_HIGHPRI;
 
 	/*
 	 * no need to spawn too many threads, limiting threads could minimum
-- 
2.24.1

