Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 749D3952BD
	for <lists+linux-raid@lfdr.de>; Tue, 20 Aug 2019 02:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfHTA0b (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 19 Aug 2019 20:26:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:49140 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728351AbfHTA0b (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 19 Aug 2019 20:26:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE886ABF4;
        Tue, 20 Aug 2019 00:26:29 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 20 Aug 2019 10:21:09 +1000
Subject: [PATCH 0/2] Two md fixes suitable for -stable
Cc:     linux-raid@vger.kernel.org, Jack Wang <jinpu.wang@cloud.ionos.com>
Message-ID: <156626036792.15343.14564114570071245486.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,
 follow two patches fix two unrelated issues in md.
 The second patch does address a real race, but doesn't completely
 fix the customers symptom, so there might be a follow-on patch
 once I understand what is really happening.

 And Song ... have you considered update the MAINTAINERS file
 with your details - I think that would good!

Thanks,
NeilBrown


---

NeilBrown (2):
      md: only call set_in_sync() when it is expected to succeed.
      md: don't report active array_state until after revalidate_disk() completes.


 drivers/md/md.c |   14 +++++++++-----
 drivers/md/md.h |    3 +++
 2 files changed, 12 insertions(+), 5 deletions(-)

--
Signature

