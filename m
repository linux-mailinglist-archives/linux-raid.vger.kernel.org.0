Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8384F38328A
	for <lists+linux-raid@lfdr.de>; Mon, 17 May 2021 16:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbhEQOtC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 17 May 2021 10:49:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:42722 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240583AbhEQOqs (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 17 May 2021 10:46:48 -0400
IronPort-SDR: xfdHs3R55nTh48ZFevJyhIV7acgy8kkJHmAqmeuMYKQquRresXsKRbmcIhl/ms88FZaqabKw7E
 TOSc2rGrSndA==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="286009412"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="286009412"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 07:39:15 -0700
IronPort-SDR: xtrsmTY3ChryvoWKlWTMhVpB9toEcS1IuY0sx2CCf9VtX32HLwdai1ZaK3DUJwfwXsBuoA2AWV
 D3Or5aKzid6A==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="472432853"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.102.23])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 07:39:13 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH 0/4] imsm: lowest namespace support
Date:   Mon, 17 May 2021 16:38:59 +0200
Message-Id: <20210517143903.10077-1-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Nvme specification doesn't guarantee the first namespace existence.  
Imsm shall use lowest one instead of first. In this patchset imsm parts
responsible for reading sysfs attrs were refactored and simplified to
generic routines. Imsm compatibility checks were moved to
validate_geometry_imsm_container. This prevents from writing metadata
to rejected drive.

Mariusz Tkaczyk (4):
  imsm: add generic method to resolve "device" links
  imsm: add devpath_to_char method
  imsm: Limit support to the lowest namespace
  Manage: Call validate_geometry when adding drive to external container

 Manage.c         |   7 ++
 platform-intel.c | 179 +++++++++++++++++++++++++++---------
 platform-intel.h |   8 +-
 super-ddf.c      |   9 +-
 super-intel.c    | 233 +++++++++++++++++++++--------------------------
 5 files changed, 256 insertions(+), 180 deletions(-)

-- 
2.26.2

