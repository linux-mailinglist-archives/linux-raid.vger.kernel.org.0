Return-Path: <linux-raid+bounces-2431-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BC9951D2F
	for <lists+linux-raid@lfdr.de>; Wed, 14 Aug 2024 16:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1529428A4FE
	for <lists+linux-raid@lfdr.de>; Wed, 14 Aug 2024 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889351B3749;
	Wed, 14 Aug 2024 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpUafbNy"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85EC1B3724
	for <linux-raid@vger.kernel.org>; Wed, 14 Aug 2024 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646073; cv=none; b=F6E0fhpvihkaLGCpA9DNoHsUwJCBR5kGhK8okQQbCudFmp32+CMS/wYD53lpJKyIDelyfryhXCI4BhRb7rzrkcvF2Mee+OLyDFfwn0syeHxx5MhaGODcU0ckKmBgpG9154foo79qH0qqfOLMbJk84vW0xgJhpcBYFp9eacfxm/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646073; c=relaxed/simple;
	bh=4aol2bQWGqU7zpfnOajf765lcCf+XqwlLCMMBIrDrSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uzp+rIWzBguyx79099vidmQGEhrv9dGvLytjHG6+XukEMeKi7UH7+vSbZ9Hv7dKhxsLaeuH3wR8PY0kn0nm6uVbWMJMbstSi7cJS1PwLbo5AVlDCrgoZf+yLDQBRqq3DAOcxPEBCDuHYCmY6VSKxzA+f5YRzp2JG9qGeTzJ9Dzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpUafbNy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723646070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1mwLzvfKy/AKPotQsw4SiDKdUt3reAnrpkwNcVstlDw=;
	b=RpUafbNybH1sLaD0pec0efNq5GY8jpT7Qu/X7oniI/EnpQTfsKJHTRHdtxw3IB7LCJkiJ+
	j0Y6gOHQDAwyhx6PQyVZyAhKuu+P/KZrJvFeiq7GtCLUmi/QWpCiRdlie69rZEqpBkZpr2
	YSnSZmZAjfCvfi7pFBflGPFFu0e6LSM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-xmUo1VUkOParfHt08LfSbg-1; Wed,
 14 Aug 2024 10:34:25 -0400
X-MC-Unique: xmUo1VUkOParfHt08LfSbg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 277381955F6A;
	Wed, 14 Aug 2024 14:34:22 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EFE1E300019A;
	Wed, 14 Aug 2024 14:34:18 +0000 (UTC)
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
Subject: [RFC dlm/next 00/12] dlm: net-namespace functionality
Date: Wed, 14 Aug 2024 10:34:02 -0400
Message-ID: <20240814143414.1877505-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi,

this patch-series is huge but brings a lot of basic "fun" net-namespace
functionality to DLM. Currently you need a couple of Linux kernel
instances running in e.g. Virtual Machines. With this patch-series I
want to break out of this virtual machine world dealing with multiple
kernels need to boot them all individually, etc. Now you can use DLM in
only one Linux kernel instance and each "node" (previously represented
by a virtual machine) is separate by a net-namespace. Why
net-namespaces? It just fits to the DLM design for now, you need to have
them anyway because the internal DLM socket handling on a per node
basis. What we do additionally is to separate the DLM lockspaces (the
lockspace that is being registered) by net-namespaces as this represents
a "network entity" (node). There might be reasons to introduce a
complete new kind of namespaces (locking namespace?) but I don't want to
do this step now and as I said net-namespaces are required anyway for
the DLM sockets.

You need some new user space tooling as a new netlink net-namespace aware
UAPI is introduced (but can co-exist with configfs that operates on
init_net only). See [0] for more steps, there is a copr repo for the
new tooling and can be enabled by:

$ dnf copr enable aring/nldlm
$ dnf install nldlm

or compile it yourself.

Then there is currently a very simple script [1] to show a 3 nodes cluster
using gfs2 on a multiple loop block devices on a shared loop block device
image (sounds weird but I do something like that). There are currently
some user space synchronization issues that I solve by simple sleeps, but
they are only user space problems.

To test it I recommend some virtual machine "but only one" and run the
[1] script. Afterwards you have in your executed net-namespace the 3
mountpoints /cluster/node1, /cluster/node2/ and /cluster/node3. Any vfs
operations on those mountpoints acts as a per node entity operation.

We can use it for testing, development and also scale testing to have a
large number of nodes joining a lockspace (which seems to be a problem
right now). Instead of running 1000 vms, we can run 1000 net-namespaces
in a more resource limited environment. For me it seems gfs2 can handle
several mounts and still separate the resource according their global
variables. Their data structures e.g. glock hash seems to have in their
key a separation for that (fsid?). However this is still an experimental
feature we might run into issues that requires more separation related
to net-namespaces. However basic testing seems to run just fine.

Limitations

I disable any functionality for the DLM character device that allow
plock handling or do DLM locking from user space. Just don't use any
plock locking in gfs2 for now. But basic vfs operations should work. You
can even sniff DLM traffic on the created "dlmsw" virtual bridge.

- Alex

[0] https://gitlab.com/netcoder/nldlm
[1] https://gitlab.com/netcoder/gfs2ns-examples/-/blob/main/three_nodes

Alexander Aring (12):
  dlm: introduce dlm_find_lockspace_name()
  dlm: disallow different configs nodeid storages
  dlm: add struct net to dlm_new_lockspace()
  dlm: handle port as __be16 network byte order
  dlm: use dlm_config as only cluster configuration
  dlm: dlm_config_info config fields to unsigned int
  dlm: rename config to configfs
  kobject: add kset_type_create_and_add() helper
  kobject: export generic helper ops
  dlm: separate dlm lockspaces per net-namespace
  dlm: add nldlm net-namespace aware UAPI
  gfs2: separate mount context by net-namespaces

 drivers/md/md-cluster.c |    3 +-
 fs/dlm/Makefile         |    2 +
 fs/dlm/config.c         | 1291 +++++++++++++++----------------------
 fs/dlm/config.h         |  215 +++++--
 fs/dlm/configfs.c       |  882 ++++++++++++++++++++++++++
 fs/dlm/configfs.h       |   19 +
 fs/dlm/debug_fs.c       |   24 +-
 fs/dlm/dir.c            |    4 +-
 fs/dlm/dlm_internal.h   |   24 +-
 fs/dlm/lock.c           |   64 +-
 fs/dlm/lock.h           |    3 +-
 fs/dlm/lockspace.c      |  220 ++++---
 fs/dlm/lockspace.h      |   12 +-
 fs/dlm/lowcomms.c       |  525 ++++++++--------
 fs/dlm/lowcomms.h       |   29 +-
 fs/dlm/main.c           |    5 -
 fs/dlm/member.c         |   36 +-
 fs/dlm/midcomms.c       |  287 ++++-----
 fs/dlm/midcomms.h       |   31 +-
 fs/dlm/nldlm.c          | 1330 +++++++++++++++++++++++++++++++++++++++
 fs/dlm/nldlm.h          |  176 ++++++
 fs/dlm/plock.c          |    2 +-
 fs/dlm/rcom.c           |   16 +-
 fs/dlm/rcom.h           |    3 +-
 fs/dlm/recover.c        |   17 +-
 fs/dlm/user.c           |   63 +-
 fs/dlm/user.h           |    2 +-
 fs/gfs2/glock.c         |    8 +
 fs/gfs2/incore.h        |    2 +
 fs/gfs2/lock_dlm.c      |    6 +-
 fs/gfs2/ops_fstype.c    |    5 +
 fs/gfs2/sys.c           |   27 +-
 fs/ocfs2/stack_user.c   |    2 +-
 include/linux/dlm.h     |    9 +-
 include/linux/kobject.h |   10 +-
 lib/kobject.c           |   55 +-
 36 files changed, 3941 insertions(+), 1468 deletions(-)
 create mode 100644 fs/dlm/configfs.c
 create mode 100644 fs/dlm/configfs.h
 create mode 100644 fs/dlm/nldlm.c
 create mode 100644 fs/dlm/nldlm.h

-- 
2.43.0


