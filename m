Return-Path: <linux-raid+bounces-2557-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C912695D072
	for <lists+linux-raid@lfdr.de>; Fri, 23 Aug 2024 16:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C70FB2154D
	for <lists+linux-raid@lfdr.de>; Fri, 23 Aug 2024 14:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4F1186E48;
	Fri, 23 Aug 2024 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CirtAwe7"
X-Original-To: linux-raid@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4770566A
	for <linux-raid@vger.kernel.org>; Fri, 23 Aug 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424889; cv=none; b=lQNgb/yy9YtqswJVE3U5jg8ivnH93OWHaM6bBK68wK/DRwjVz7M6A4XhRjqnePcKM/GSnJgRrlOMnrqx9wfZsly8eLKZ9ggpjvG1nBIA1+7PGHDL0/zgMVI6N1SjPQlw8wJpDyue9JY8ktsdhKbg5vdStVqhtwWpvGHeHLiEWFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424889; c=relaxed/simple;
	bh=/vv6GJByMqxlmPPY5KEek5A6+eUrQfZlaaXU+gKJ4MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itb52Br2hgWy0NVmUd0Cuy7xFsrX0h/ktqO4fIgMwhr+Y1HWBcbXFdkYIDKsRNGk2KiNDf3r62q4bnLXcOLnDB1awahHRFKNGjP2S2dYa9ehEFyIOoPLyj4LZ4yjXob3Cz4dx+9wxA3FrWFzy7htxK8k/dBwfEHfRc5K7W2yUwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CirtAwe7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724424888; x=1755960888;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/vv6GJByMqxlmPPY5KEek5A6+eUrQfZlaaXU+gKJ4MQ=;
  b=CirtAwe7znkWp0z+3p0I8DqUfmN0MWI6zsN34BO0MyiArhMr87DjKmIX
   8ONE1nd5CNgWtg9rXapLHomSGJAIpPAdkNn+akQMMHTzmypfStntSUcJc
   ApxhqbsydIKjVFQQczQqUqbVtsxpkfjSS2/1mKQQlOd/JiPj552GxvXXQ
   yWOBY8UL8/zunY0fEXZKCTdX42K9dxqMcLblmk3Xlyauqvp1rGKNcmejG
   eQ5QDi9wv/834gs2x8TBYY9iyhedlrifTKnTT438uqmi9RY9sLmuoP3sQ
   q2706E2ffmXOGatdIp0AcVwMfpbdWjYp6EbyeyauCOqndKw01fuiHmbjt
   g==;
X-CSE-ConnectionGUID: DIKD0X5gSk2KgKwVuUfYhQ==
X-CSE-MsgGUID: d8CujG+nSBewoiHk5DEaOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22760376"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="22760376"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 07:54:47 -0700
X-CSE-ConnectionGUID: v0MkuXCbSOylX0XfjTev5A==
X-CSE-MsgGUID: sVt0bqjBTrOxOEk1FbSu8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61816481"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.92.203])
  by fmviesa008.fm.intel.com with ESMTP; 23 Aug 2024 07:54:46 -0700
From: Kinga Stefaniuk <kinga.stefaniuk@intel.com>
To: linux-raid@vger.kernel.org
Cc: song@kernel.org,
	yukuai3@huawei.com
Subject: [PATCH v11 0/1] md: generate CHANGE uevents for md device
Date: Fri, 23 Aug 2024 16:54:37 +0200
Message-ID: <20240823145438.23432-1-kinga.stefaniuk@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch is caused by changes in mdadm - now mdmonitor is relying on udev
events instead of pooling changes on /proc/mdstat file. This change
gave possibility to send events to the userspace.
Now, more events will be read by mdmonitor, but mechanism of getting
details of the event will remain the same - all devices have to be
scanned on new event and their parameters read. It can be changed by
adding environmental data, which will fully describe this uevent,
as Kuai suggested. This change needs to be analyzed and planned,
because it requires a lot of work in md and design changes in
mdmonitor - to stop scanning all of the devices on new event and read
uevent details directly from udev. Mariusz will take care of this topic,
and follow up on this later.
Paul, the test suite which was used is internal and checks if mdmonitor
has noticed expected events. For now there is no plan for adding test,
which checking events to mdadm.

Kinga Stefaniuk (1):
  md: generate CHANGE uevents for md device

 drivers/md/md.c     | 75 +++++++++++++++++++++++++++++++--------------
 drivers/md/md.h     |  3 +-
 drivers/md/raid10.c |  2 +-
 drivers/md/raid5.c  |  2 +-
 4 files changed, 56 insertions(+), 26 deletions(-)

-- 
2.43.0


