Return-Path: <linux-raid+bounces-2442-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AFC951D53
	for <lists+linux-raid@lfdr.de>; Wed, 14 Aug 2024 16:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DECF1F263F5
	for <lists+linux-raid@lfdr.de>; Wed, 14 Aug 2024 14:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D081BA883;
	Wed, 14 Aug 2024 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Im8G5BgG"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3D1BA869
	for <linux-raid@vger.kernel.org>; Wed, 14 Aug 2024 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646101; cv=none; b=hqPhlyuEeA8W9ze3nOIxTE1RPAh8h35kvdBWFadHXydFRtLIC2DmA0AB0va/gXFKs8i50i6tApPZblAEzFqainW50iJajSxUHm+APoL40Jy0vlHCq/makUW47K8tggVQU8pHNxhL7ZiZ1VFpEpK+oxScajebmKD1XJ2Ry4R5Li0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646101; c=relaxed/simple;
	bh=VUzHL3QNYD0cUq81xthTlN1+buVz0eiw5Ir9rnD7ZrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnXEuPVlQ1x31fnTx5yVeTbmcNguFg/XnmFr45C3jqdyTwvT5W/z+B7LFG/yLODQvjOBVi9GRqcmfdeZtVpsJUsXy1tMO9J0hwKup4ZO1HuVZj1u3oLT06IKoWKpVM5wu1/g4nrPHNdPGt6jyHDQ6I5Qp0CyxQbNifHBCWXG3Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Im8G5BgG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723646098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BABeo0vZVeSf6PLvIml9jA7oT8qWCYSq8pbNYVtFiIQ=;
	b=Im8G5BgGPU2cFcqWU7xxx4WNZqfhAGJ0LxxafEQ868xofEor4KWnm3j0JyBOT0C4sbe1/U
	4WJWyIkXjCdOfEzLVwZBr4vH7hl5T/d7SvWXz0VlHTeSmJJ1P1t4qxOiZnpNu2YLxUS0Qz
	2Ce9c8eKOcpnaGuiKuMrmzMeArPsvgY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-N0VsBEDVMdyHV97KvlomKg-1; Wed,
 14 Aug 2024 10:34:55 -0400
X-MC-Unique: N0VsBEDVMdyHV97KvlomKg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D1DF1925380;
	Wed, 14 Aug 2024 14:34:53 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DEC49300019A;
	Wed, 14 Aug 2024 14:34:50 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	agruenba@redhat.com,
	mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	lucien.xin@gmail.com,
	aahringo@redhat.com
Subject: [RFC dlm/next 12/12] gfs2: separate mount context by net-namespaces
Date: Wed, 14 Aug 2024 10:34:14 -0400
Message-ID: <20240814143414.1877505-13-aahringo@redhat.com>
In-Reply-To: <20240814143414.1877505-1-aahringo@redhat.com>
References: <20240814143414.1877505-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This patch changes gfs2 to be the first user of the recently introduced
net-namespace feature of DLM. It uses the current net-namespace context
of the get_tree() callback of "struct fs_context_operations" that is
e.g. being called by syscalls of the coreutils mount process.

Debugfs is being disabled for non "init_net" net-namespaces as debugfs
is not net-namespace aware. Otherwise we would see kernel log error
messages about existing debugfs entries. There might be in future
another ways to get similar information with an UAPI mechanism that is
namespace aware.

With this patch you can setup a cluster in one machine without using
multiple Linux kernel instances. The idea is to use this for
developing/testing as a first use-case. Especially scale testing, a gfs2
file system with a lot of members can be setup without running a large
set of virtual machines.

There is a small example script how it works:

https://gitlab.com/netcoder/gfs2ns-examples/-/blob/main/three_nodes

it uses multiple loop block devices references to the same file to
provide a kind of shared block device (an alternative could be using dm
linear mapping, but loop block device also works). After setting up
multiple net-namespaces with a virtual bridge interface DLM can be
configured by using nldlmd that is using the recently introduced
net-namespace aware nldlm netlink API. Over a shell command like:

ip netns exec node1 sh -c "mount /dev/loop1 /cluster/node1"
ip netns exec node2 sh -c "mount /dev/loop2 /cluster/node2"
...

every cluster "node" (hereby identifier with a "node#" string in the
iproute2 namespace management mechanism) can mount the shared block
device e.g. /dev/loop1, /dev/loop# that references to the same block
image on a different file system. Note that the caller in the script
will be unmount the file system if the last user left the namespace. I
currently workaround this use case by mountbind each block device again
in a kind of "default" namespace (usually it should be where "init_net"
references to).

Then each mountpoint of "/cluster/node#" acts like being a cluster node
access to the gfs2 file system with DLM locking enabled. This offers us
new possibilities to write testcases as we operate on a single machine
and can "easier" synchronize vfs syscalls in our testcase as no
"remote machine" kind network communication is being involved.

The mount sysfs directory for gfs2 needs to be separated by
net-namespace as our mount call is from namespace view separated and be
treated as per "node" (machine) call. Otherwise we would run into
conflicts on files/directories that already exists as the cluster wide
unique identifiers are already being in use.

The gfs2 file system has some global variables and it seems it is not
necessary to separate them by net-namespace as they store a unique per
mount identifier. I didn't had problems yet and it seems it is currently
okay to do that, otherwise there might be issues with "things" that are
not net-namespace aware in gfs2 yet. However we only should find issues
only when we using net-namespaces. If a user only uses "init_net" as
this is the current default, there should not be any problems.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/gfs2/glock.c      |  8 ++++++++
 fs/gfs2/incore.h     |  2 ++
 fs/gfs2/lock_dlm.c   |  2 +-
 fs/gfs2/ops_fstype.c |  5 +++++
 fs/gfs2/sys.c        | 27 ++++++++++++++++++++++++++-
 5 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 12a769077ea0..21c72c1f6c61 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2898,6 +2898,10 @@ DEFINE_SEQ_ATTRIBUTE(gfs2_sbstats);
 
 void gfs2_create_debugfs_file(struct gfs2_sbd *sdp)
 {
+	/* debugfs is only available for init_net users */
+	if (!net_eq(read_pnet(&sdp->net), &init_net))
+		return;
+
 	sdp->debugfs_dir = debugfs_create_dir(sdp->sd_table_name, gfs2_root);
 
 	debugfs_create_file("glocks", S_IFREG | S_IRUGO, sdp->debugfs_dir, sdp,
@@ -2915,6 +2919,10 @@ void gfs2_create_debugfs_file(struct gfs2_sbd *sdp)
 
 void gfs2_delete_debugfs_file(struct gfs2_sbd *sdp)
 {
+	/* debugfs is only available for init_net users */
+	if (!net_eq(read_pnet(&sdp->net), &init_net))
+		return;
+
 	debugfs_remove_recursive(sdp->debugfs_dir);
 	sdp->debugfs_dir = NULL;
 }
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index aa4ef67a34e0..1273ef3dbef5 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -710,6 +710,8 @@ struct gfs2_sbd {
 
 	/* Lock Stuff */
 
+	possible_net_t net;
+	netns_tracker tracker;	/* keep track of net references */
 	struct lm_lockstruct sd_lockstruct;
 	struct gfs2_holder sd_live_gh;
 	struct gfs2_glock *sd_rename_gl;
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 6c5dce57a2ee..d8e1bb99dac2 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -1328,7 +1328,7 @@ static int gdlm_mount(struct gfs2_sbd *sdp, const char *table)
 	 * create/join lockspace
 	 */
 
-	error = dlm_new_lockspace(&init_net, fsname, cluster, flags,
+	error = dlm_new_lockspace(read_pnet(&sdp->net), fsname, cluster, flags,
 				  GDLM_LVB_SIZE, &gdlm_lockspace_ops, sdp,
 				  &ops_result, &ls->ls_dlm);
 	if (error) {
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index ff1f3e3dc65c..15ee0b2228a5 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -64,6 +64,8 @@ static void gfs2_tune_init(struct gfs2_tune *gt)
 
 void free_sbd(struct gfs2_sbd *sdp)
 {
+	put_net_track(read_pnet(&sdp->net), &sdp->tracker);
+
 	if (sdp->sd_lkstats)
 		free_percpu(sdp->sd_lkstats);
 	kfree(sdp);
@@ -71,6 +73,7 @@ void free_sbd(struct gfs2_sbd *sdp)
 
 static struct gfs2_sbd *init_sbd(struct super_block *sb)
 {
+	struct net *net = current->nsproxy->net_ns;
 	struct gfs2_sbd *sdp;
 	struct address_space *mapping;
 
@@ -78,6 +81,8 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb)
 	if (!sdp)
 		return NULL;
 
+	/* store the net-namespace the sdp is created into */
+	write_pnet(&sdp->net, get_net_track(net, &sdp->tracker, GFP_KERNEL));
 	sdp->sd_vfs = sb;
 	sdp->sd_lkstats = alloc_percpu(struct gfs2_pcpu_lkstats);
 	if (!sdp->sd_lkstats)
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index ecc699f8d9fc..9c23bafc592b 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -16,6 +16,7 @@
 #include <linux/uaccess.h>
 #include <linux/gfs2_ondisk.h>
 #include <linux/blkdev.h>
+#include <linux/netdevice.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -57,6 +58,20 @@ static const struct sysfs_ops gfs2_attr_ops = {
 
 static struct kset *gfs2_kset;
 
+/* gfs2 sysfs is separated by net-namespaces */
+static const struct kobj_ns_type_operations *
+gfs2_sysfs_object_child_ns_type(const struct kobject *kobj)
+{
+	return &net_ns_type_operations;
+}
+
+static const struct kobj_type gfs2_kset_ktype = {
+	.sysfs_ops      = &kobj_sysfs_ops,
+	.release	= kset_release,
+	.get_ownership  = kset_get_ownership,
+	.child_ns_type  = gfs2_sysfs_object_child_ns_type,
+};
+
 static ssize_t id_show(struct gfs2_sbd *sdp, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "%u:%u\n",
@@ -383,10 +398,19 @@ static void gfs2_sbd_release(struct kobject *kobj)
 	complete(&sdp->sd_kobj_unregister);
 }
 
+/* return the net-namespace the kobj belonging to */
+static const void *gfs2_kobj_namespace(const struct kobject *kobj)
+{
+	struct gfs2_sbd *sdp = container_of(kobj, struct gfs2_sbd, sd_kobj);
+
+	return read_pnet(&sdp->net);
+}
+
 static struct kobj_type gfs2_ktype = {
 	.release = gfs2_sbd_release,
 	.default_groups = gfs2_groups,
 	.sysfs_ops     = &gfs2_attr_ops,
+	.namespace = gfs2_kobj_namespace,
 };
 
 
@@ -797,7 +821,8 @@ static const struct kset_uevent_ops gfs2_uevent_ops = {
 
 int gfs2_sys_init(void)
 {
-	gfs2_kset = kset_create_and_add("gfs2", &gfs2_uevent_ops, fs_kobj);
+	gfs2_kset = kset_type_create_and_add("gfs2", &gfs2_uevent_ops,
+					     fs_kobj, &gfs2_kset_ktype);
 	if (!gfs2_kset)
 		return -ENOMEM;
 	return 0;
-- 
2.43.0


