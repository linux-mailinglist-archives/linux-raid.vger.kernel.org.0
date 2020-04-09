Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6A6C1A3395
	for <lists+linux-raid@lfdr.de>; Thu,  9 Apr 2020 13:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgDILxP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Apr 2020 07:53:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:45906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDILxP (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 9 Apr 2020 07:53:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C90BDAE30;
        Thu,  9 Apr 2020 11:53:13 +0000 (UTC)
From:   colyli@suse.de
To:     songliubraving@fb.com, linux-raid@vger.kernel.org
Cc:     mhocko@suse.com, kent.overstreet@gmail.com,
        guoqing.jiang@cloud.ionos.com, Coly Li <colyli@suse.de>
Subject: [PATCH v2 0/4] improve memalloc scope APIs usage
Date:   Thu,  9 Apr 2020 19:52:54 +0800
Message-Id: <20200409115258.19330-1-colyli@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

From: Coly Li <colyli@suse.de>

Hi folks,

The motivation of this series is to fix the incorrect GFP_NOIO flag
usage in drivers/md/raid5.c:resize_chunks(). I take the suggestion
from Michal Hocko to use memalloc scope APIs in unified entry point
mddev_suspend()/mddev_resume(). Also I get rid of the incorect GFP_NOIO
usage for scribble_alloc(), and remove redundant memalloc scope APIs
usage in mddev_create_serial_pool(), also as Song Liu suggested, update
the code comments on the header of scribble_alloc().

Thank you in advance for the review and comments.

Coly Li
---
Changelog:
v2: Add memalloc scope APIs in raid array suspend context.
v1: Original version to add memalloc scope APIs in resize_chunks().

Coly Li (4):
  md: use memalloc scope APIs in mddev_suspend()/mddev_resume()
  raid5: remove gfp flags from scribble_alloc()
  raid5: update code comment of scribble_alloc()
  md: remove redundant memalloc scope API usage

 drivers/md/md.c    |  6 ++++--
 drivers/md/md.h    |  1 +
 drivers/md/raid5.c | 22 ++++++++++++++--------
 3 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.25.0

