Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 401363761D
	for <lists+linux-raid@lfdr.de>; Thu,  6 Jun 2019 16:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfFFOLs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 Jun 2019 10:11:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41944 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728667AbfFFOLs (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 6 Jun 2019 10:11:48 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DBBAE4786DC9E9199EFF
        for <linux-raid@vger.kernel.org>; Thu,  6 Jun 2019 22:11:45 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 6 Jun 2019
 22:11:42 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <linux-raid@vger.kernel.org>
CC:     <liu.song.a23@gmail.com>
Subject: [PATCH 0/2] md: fix spelling typo and remove extra blank line 
Date:   Thu, 6 Jun 2019 22:29:16 +0800
Message-ID: <20190606142918.36376-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,
This patchset fix a spelling typo and add necessary space for code.
In addtion, we get rid of some extra blank line and space.

Yufen Yu (2):
  md: fix spelling typo and add necessary space
  md/raid1: get rid of extra blank line and space

 drivers/md/md.c    | 11 ++++-------
 drivers/md/raid1.c |  9 +++------
 2 files changed, 7 insertions(+), 13 deletions(-)

-- 
2.17.2

