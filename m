Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB18C6E0AB
	for <lists+linux-raid@lfdr.de>; Fri, 19 Jul 2019 07:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfGSFnQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 19 Jul 2019 01:43:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40272 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726709AbfGSFnQ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 19 Jul 2019 01:43:16 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AED4833D961C5CE4F22E;
        Fri, 19 Jul 2019 13:43:12 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 19 Jul 2019
 13:43:04 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <neilb@suse.com>, <liu.song.a23@gmail.com>
CC:     <axboe@kernel.dk>, <linux-raid@vger.kernel.org>,
        <houtao1@huawei.com>
Subject: [PATCH 0/2] md: not need error handling when device faulty
Date:   Fri, 19 Jul 2019 13:48:45 +0800
Message-ID: <20190719054847.140905-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

This patchset optimize write error handling for raid1 and raid10.
When the device has been set faulty, error write bio did not need
to queue for error handling by raid daemon thread.


Yufen Yu (2):
  md/raid1: end bio when the device faulty
  md/raid10: end bio when the device faulty

 drivers/md/raid1.c  | 26 ++++++++++++++------------
 drivers/md/raid10.c | 26 ++++++++++++++------------
 2 files changed, 28 insertions(+), 24 deletions(-)

-- 
2.16.2.dirty

