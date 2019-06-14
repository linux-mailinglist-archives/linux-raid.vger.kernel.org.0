Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F783457DF
	for <lists+linux-raid@lfdr.de>; Fri, 14 Jun 2019 10:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfFNIvQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Jun 2019 04:51:16 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:42459 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfFNIvQ (ORCPT
        <rfc822;groupwise-linux-raid@vger.kernel.org:0:0>);
        Fri, 14 Jun 2019 04:51:16 -0400
Received: from linux-2xn2.suse.asia (prva10-snat226-2.provo.novell.com [137.65.226.36])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Fri, 14 Jun 2019 02:51:12 -0600
From:   Guoqing Jiang <gqjiang@suse.com>
To:     linux-raid@vger.kernel.org
Cc:     Guoqing Jiang <gqjiang@suse.com>
Subject: [PATCH 0/5] Fix potential data inconsistency issue with write behind device
Date:   Fri, 14 Jun 2019 17:10:34 +0800
Message-Id: <20190614091039.32461-1-gqjiang@suse.com>
X-Mailer: git-send-email 2.12.3
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

This patchset tries to avoid potential data inconsistency issue
which could happen if multi-queue device is flaged as write mostly
and write behind mode is enabled.

And thanks a lot for Neil's review for the series.

BRs,
Guoqing

Guoqing Jiang (5):
  md/raid1: fix potential data inconsistency issue with write behind
    device
  md: introduce mddev_create/destroy_wb_pool for the change of member
    device
  md-bitmap: create and destroy wb_info_pool with the change of backlog
  md-bitmap: create and destroy wb_info_pool with the change of bitmap
  md: add bitmap_abort label in md_run

 drivers/md/md-bitmap.c |  20 +++++++++
 drivers/md/md.c        | 116 +++++++++++++++++++++++++++++++++++++++++++++----
 drivers/md/md.h        |  23 ++++++++++
 drivers/md/raid1.c     |  68 ++++++++++++++++++++++++++++-
 4 files changed, 218 insertions(+), 9 deletions(-)

-- 
2.12.3

