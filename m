Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD8AED80B
	for <lists+linux-raid@lfdr.de>; Mon,  4 Nov 2019 04:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfKDD3U (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 3 Nov 2019 22:29:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:44298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728444AbfKDD3U (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 3 Nov 2019 22:29:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BCA7CAF65;
        Mon,  4 Nov 2019 03:29:18 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jes Sorensen <jes.sorensen@gmail.com>
Date:   Mon, 04 Nov 2019 14:27:49 +1100
Subject: [PATCH 0/2 v2] mdadm: address the RAID0 layout problem
Cc:     linux-raid@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Song Liu <liu.song.a23@gmail.com>
Message-ID: <157283799101.17723.14738560497847478383.stgit@noble.brown>
In-Reply-To: <157247951643.8013.12020039865359474811.stgit@noble.brown>
References: <157247951643.8013.12020039865359474811.stgit@noble.brown>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This is a second version for my mdadm enhancement to help handle the
RAID0 layout problem.  Thanks a lot to Dann for the review.
I suspect these are now ready to land.

NeilBrown

---

NeilBrown (2):
      Create: add support for RAID0 layouts.
      Assemble: add support for RAID0 layouts.


 Assemble.c |    8 ++++++++
 Create.c   |   11 +++++++++++
 Detail.c   |    5 +++++
 maps.c     |   12 ++++++++++++
 md.4       |   21 +++++++++++++++++++++
 mdadm.8.in |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
 mdadm.c    |   12 ++++++++++++
 mdadm.h    |    8 +++++++-
 super0.c   |    6 ++++++
 super1.c   |   42 ++++++++++++++++++++++++++++++++++++++++--
 10 files changed, 168 insertions(+), 4 deletions(-)

--
Signature

