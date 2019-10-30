Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE41EA7E7
	for <lists+linux-raid@lfdr.de>; Thu, 31 Oct 2019 00:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfJ3X4e (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 30 Oct 2019 19:56:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:37724 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727467AbfJ3X4e (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 30 Oct 2019 19:56:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01B54B307;
        Wed, 30 Oct 2019 23:56:32 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jes Sorensen <jes.sorensen@gmail.com>
Date:   Thu, 31 Oct 2019 10:56:04 +1100
Subject: [PATCH 0/2] mdadm: address the RAID0 layout problem
Cc:     linux-raid@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Song Liu <liu.song.a23@gmail.com>
Message-ID: <157247951643.8013.12020039865359474811.stgit@noble.brown>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

As you probably know, we have a problem with RAID0 when devices
have differing sizes.
The kernel has been changed to avoid accessing arrays when it cannot
be sure of the correct layout, but that often results in data being
inaccessible.

These patches to mdadm try to address that.  I won't explain what I've
done - hopefully the man-page additions are sufficient.
Please have a look, try it out, and let me know what improvement or
changes are needed.

Thanks,
NeilBrown

---

NeilBrown (2):
      Create: add support for RAID0 layouts.
      Assemble: add support for RAID0 layouts.


 Assemble.c |    8 ++++++++
 Create.c   |   11 +++++++++++
 maps.c     |   12 ++++++++++++
 md.4       |   21 +++++++++++++++++++++
 mdadm.8.in |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
 mdadm.c    |   12 ++++++++++++
 mdadm.h    |    8 +++++++-
 super0.c   |    6 ++++++
 super1.c   |   42 ++++++++++++++++++++++++++++++++++++++++--
 9 files changed, 163 insertions(+), 4 deletions(-)

--
Signature

