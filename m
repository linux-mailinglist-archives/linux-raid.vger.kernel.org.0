Return-Path: <linux-raid+bounces-2652-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992BE961BED
	for <lists+linux-raid@lfdr.de>; Wed, 28 Aug 2024 04:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6E78B226B7
	for <lists+linux-raid@lfdr.de>; Wed, 28 Aug 2024 02:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCF541A8F;
	Wed, 28 Aug 2024 02:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccgY0sn5"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85695199B9
	for <linux-raid@vger.kernel.org>; Wed, 28 Aug 2024 02:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724811167; cv=none; b=VltJTGJ+CRChe8ECtBddZZY5UVg5dI3zvJXbUuv509lmIoPmBXBnsinTQvhkt4MOLG7bvQwt8/6udXcEOVnrieHhZfli9bNkeNHkK7Jljr6cEIzyANTf8EI2+YaG9SCR2xP8XgPySTw8m++wXKBpQnp6nPkCoHSdvV0FVXV13S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724811167; c=relaxed/simple;
	bh=NlIXywn103hmbIvNI7t45fJ7x57KZ2xFODYgbsr3fbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZszKSTVqJJSP2WjdnFUvRo4YMqhrEvDlawO7e7eIUpnDEFv5hiESmP6MQAgjoCIMXxov21pzm+KlZTXBAIAeBxuez/sy/I0T0jTD5c/DX/pPKv3vay9Er4KslCnR4RxR53mRs+3llVwk2WeNrMX+lbB/tr6vhYcUhTUW0rB08Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ccgY0sn5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724811164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZEBkdeVCLuo/Jd6z7j1RE6T3dAcznWBnGYmgr5DDUo=;
	b=ccgY0sn53LQHCdYcRclKXH05yrimjwQks5c7KECpD7/iIZvOcf5lNkP6omqDD5gF2+tpsx
	iMz6x9bvmxjHAvYuBKOiqjdUiOA7huFD4ltfk1i5qNs1lJ4I8J4G9ysS7siR3z1ntRe2R1
	pKblWRsNUJwMGH/YNIjqaE2Ree/lFqk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-9J2DHNfYNI6Lm_TO68h4aA-1; Tue,
 27 Aug 2024 22:12:41 -0400
X-MC-Unique: 9J2DHNfYNI6Lm_TO68h4aA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 678911955F65;
	Wed, 28 Aug 2024 02:12:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.24])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 857753001FF9;
	Wed, 28 Aug 2024 02:12:36 +0000 (UTC)
From: Xiao Ni <xni@redhat.com>
To: mariusz.tkaczyk@linux.intel.com
Cc: ncroxon@redhat.com,
	linux-raid@vger.kernel.org
Subject: [PATCH 06/10] mdadm/tests: 07changelevels fix
Date: Wed, 28 Aug 2024 10:11:46 +0800
Message-Id: <20240828021150.63240-7-xni@redhat.com>
In-Reply-To: <20240828021150.63240-1-xni@redhat.com>
References: <20240828021150.63240-1-xni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

There are five changes to this case.

1. remove testdev check. It can't work anymore and check if it's a
block device directly.

2. It can't change level and chunk size at the same time

3. Sleep more than 10s before check wait.
The test devices are small. Sometimes it can finish so quickly once
the reshape just starts. mdadm will be stuck before it waits reshape
to start. So the sync speed is limited. And it restores the sync speed
when it waits reshape to finish. It's good for case without backup
file.

It uses systemd service mdadm-grow-continue to monitor reshape
progress when specifying backup file. If reshape finishes so quickly
before it starts monitoring reshape progress, the daemon will be stuck
too. Because reshape_progress is 0 which means the reshape hasn't been
started. So give more time to let service can get right information
from kernel space.

But before getting these information. It needs to suspend array. At
the same time the reshape is running. The kernel reshape daemon will
update metadata 10s. So it needs to limit the sync speed more than 10s
before restoring sync speed. Then systemd service can suspend array
and start monitoring reshape progress.

4. Wait until mdadm-grow-continue service exits
mdadm --wait doesn't wait systemd service. For the case that needs
backup file, systemd service deletes the backup file after reshape
finishes. In this test case, it runs next case when reshape finishes.
And it fails because it can't create backup file because the backup
file exits.

5. Don't reshape from raid5 to raid1. It can't work now.

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 tests/07changelevels        | 27 ++++++++++++---------------
 tests/07changelevels.broken |  9 ---------
 tests/func.sh               |  4 ++++
 3 files changed, 16 insertions(+), 24 deletions(-)
 delete mode 100644 tests/07changelevels.broken

diff --git a/tests/07changelevels b/tests/07changelevels
index a328874ac43f..3df8660e6bae 100644
--- a/tests/07changelevels
+++ b/tests/07changelevels
@@ -10,7 +10,6 @@ export MDADM_GROW_VERIFY=1
 dotest() {
  sleep 2
  check wait
- testdev $md0 $1 19968 64 nd
  blockdev --flushbufs $md0
  cmp -s -n $[textK*1024] $md0 /tmp/RandFile || { echo cmp failed; exit 2; }
  # write something new - shift chars 4 space
@@ -24,7 +23,7 @@ checkgeo() {
  # level raid_disks chunk_size layout
  dev=$1
  shift
- sleep 0.5
+ sleep 15
  check wait
  sleep 1
  for attr in level raid_disks chunk_size layout
@@ -43,22 +42,25 @@ checkgeo() {
 
 bu=/tmp/md-test-backup
 rm -f $bu
-mdadm -CR $md0 -l1 -n2 -x1 $dev0 $dev1 $dev2 -z 19968
-testdev $md0 1 $mdsize1a 64
+mdadm -CR $md0 -l1 -n2 -x1 $dev0 $dev1 $dev2
+[ -b $md0 ] || die "$1 isn't a block device."
 dd if=/tmp/RandFile of=$md0
 dotest 1
 
-mdadm --grow $md0 -l5 -n3 --chunk 64
+mdadm --grow $md0 -l5 -n3
+checkgeo md0 raid5 3
 dotest 2
 
 mdadm $md0 --add $dev3 $dev4
 mdadm --grow $md0 -n4 --chunk 32
+checkgeo md0 raid5 4 $[32*1024]
 dotest 3
 
 mdadm -G $md0 -l6 --backup-file $bu
+checkgeo md0 raid6 5 $[32*1024]
 dotest 3
 
-mdadm -G /dev/md0 --array-size 39936
+mdadm -G /dev/md0 --array-size 37888
 mdadm -G $md0 -n4 --backup-file $bu
 checkgeo md0 raid6 4 $[32*1024]
 dotest 2
@@ -67,14 +69,11 @@ mdadm -G $md0 -l5 --backup-file $bu
 checkgeo md0 raid5 3 $[32*1024]
 dotest 2
 
-mdadm -G /dev/md0 --array-size 19968
+mdadm -G /dev/md0 --array-size 18944
 mdadm -G $md0 -n2 --backup-file $bu
 checkgeo md0 raid5 2 $[32*1024]
 dotest 1
 
-mdadm -G --level=1 $md0
-dotest 1
-
 # now repeat that last few steps only with a degraded array.
 mdadm -S $md0
 mdadm -CR $md0 -l6 -n5 $dev0 $dev1 $dev2 $dev3 $dev4
@@ -83,7 +82,7 @@ dotest 3
 
 mdadm $md0 --fail $dev0
 
-mdadm -G /dev/md0 --array-size 37888
+mdadm -G /dev/md0 --array-size 35840
 mdadm -G $md0 -n4 --backup-file $bu
 dotest 2
 checkgeo md0 raid6 4 $[512*1024]
@@ -103,12 +102,10 @@ dotest 2
 mdadm -G $md0 -l5 --backup-file $bu
 dotest 2
 
-mdadm -G /dev/md0 --array-size 18944
+mdadm -G /dev/md0 --array-size 17920
 mdadm -G $md0 -n2 --backup-file $bu
 dotest 1
 checkgeo md0 raid5 2 $[512*1024]
 mdadm $md0 --fail $dev2
 
-mdadm -G --level=1 $md0
-dotest 1
-checkgeo md0 raid1 2
+mdadm -S $md0
diff --git a/tests/07changelevels.broken b/tests/07changelevels.broken
index 9b930d932c48..000000000000
--- a/tests/07changelevels.broken
+++ /dev/null
@@ -1,9 +0,0 @@
-always fails
-
-Fails with errors:
-
-    mdadm: /dev/loop0 is smaller than given size. 18976K < 19968K + metadata
-    mdadm: /dev/loop1 is smaller than given size. 18976K < 19968K + metadata
-    mdadm: /dev/loop2 is smaller than given size. 18976K < 19968K + metadata
-
-    ERROR: /dev/md0 isn't a block device.
diff --git a/tests/func.sh b/tests/func.sh
index e7ccc4fc66eb..567d91d9173e 100644
--- a/tests/func.sh
+++ b/tests/func.sh
@@ -362,6 +362,10 @@ check() {
 		do
 			sleep 0.5
 		done
+		while ps auxf | grep "mdadm --grow --continue" | grep -v grep
+		do
+			sleep 1
+		done
 		echo $min > /proc/sys/dev/raid/speed_limit_min
 		echo $max > /proc/sys/dev/raid/speed_limit_max
 	;;
-- 
2.32.0 (Apple Git-132)


