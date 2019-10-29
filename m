Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26208E93B5
	for <lists+linux-raid@lfdr.de>; Wed, 30 Oct 2019 00:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfJ2XdC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 29 Oct 2019 19:33:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:40230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbfJ2XdC (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 29 Oct 2019 19:33:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0A00BB429;
        Tue, 29 Oct 2019 23:33:01 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jes Sorensen <jes.sorensen@gmail.com>
Date:   Wed, 30 Oct 2019 10:32:41 +1100
Subject: [PATCH 0/3] mdadm: fixes for mdcheck
Cc:     linux-raid@vger.kernel.org
Message-ID: <157239190470.30065.4500556456316521334.stgit@noble.brown>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

A few problems with mdcheck systemd units, and one with the
SUSE-specific script for generating an system environment.

Thanks,
NeilBrown


---

NeilBrown (3):
      mdcheck: when mdcheck_start is enabled, enable mdcheck_continue too.
      mdcheck: use ${} to pass variable to mdcheck
      SUSE-mdadm_env.sh: handle MDADM_CHECK_DURATION


 systemd/SUSE-mdadm_env.sh        |    3 +++
 systemd/mdcheck_continue.service |    5 ++---
 systemd/mdcheck_continue.timer   |    2 ++
 systemd/mdcheck_start.service    |    4 ++--
 systemd/mdcheck_start.timer      |    1 +
 5 files changed, 10 insertions(+), 5 deletions(-)

--
Signature

