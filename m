Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1602256DC
	for <lists+linux-raid@lfdr.de>; Mon, 20 Jul 2020 07:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgGTE6i (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Jul 2020 00:58:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54799 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgGTE6i (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 20 Jul 2020 00:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595221117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EyLZmbbbOLe0uHSkjAkXHaeBQihT1WzkgzZ7uts+2rc=;
        b=Fl48gv0+SFNrhORoObB34xFfAxvMRjODS/cQQAojloDc/C37kr5b2nUxFaDds97Kr7N1Jn
        yCTd/KiDOi7Pqn1KkOwYrTW6YChOoeexUVOjppUv6ZLLrH7yj7VXz/sOS1HisIanjq9OUi
        sOJTC25Ja3m87OVbtGzGBoR8NkttW5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-FxPf_rh-OtubInarMKkGMA-1; Mon, 20 Jul 2020 00:58:35 -0400
X-MC-Unique: FxPf_rh-OtubInarMKkGMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18DDB800688;
        Mon, 20 Jul 2020 04:58:34 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02AA278524;
        Mon, 20 Jul 2020 04:58:30 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     song@kernel.org, linux-raid@vger.kernel.org
Cc:     colyli@suse.de, ncroxon@redhat.com, heinzm@redhat.com
Subject: [PATCH V1 0/3] Improve handling raid10 discard request
Date:   Mon, 20 Jul 2020 12:58:25 +0800
Message-Id: <1595221108-10137-1-git-send-email-xni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi all

Now mkfs on raid10 which is combined with ssd/nvme disks takes a long time.
This patch set tries to resolve this problem.

Xiao Ni (3):
  Move codes related with submitting discard bio into one function
  extend r10bio devs to raid disks
  improve raid10 discard request

 drivers/md/md.c     |  22 ++++
 drivers/md/md.h     |   3 +
 drivers/md/raid0.c  |  15 +--
 drivers/md/raid10.c | 286 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 307 insertions(+), 19 deletions(-)

-- 
2.7.5

