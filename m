Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55ACE2303BF
	for <lists+linux-raid@lfdr.de>; Tue, 28 Jul 2020 09:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgG1HSd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 03:18:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31629 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727066AbgG1HSd (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 28 Jul 2020 03:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595920712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=R9xi7kUgHlV2wzWorbJJQor5LYhHsnkPSkmqB8QQm0U=;
        b=itS1ScMNlyzA6lu9n316oUGM5+Olo3TkCKNrShLDsKk525idqQNrruePEpayGcv1LSnZ08
        +8Ga9E9Ri5MCMIt7nQsfYWM2cVeJao2Mc+C5l9xUMdYNG78nyjTqjVjhQ6Ecin5+IY9XEX
        5WzzWfJ30wMc6n3+Ne7IG+2s8siJAaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-1WDyHdPCMUKJZDmA7hsGXg-1; Tue, 28 Jul 2020 03:18:29 -0400
X-MC-Unique: 1WDyHdPCMUKJZDmA7hsGXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCB32107B832;
        Tue, 28 Jul 2020 07:18:28 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E548F79D1F;
        Tue, 28 Jul 2020 07:18:25 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     song@kernel.org, linux-raid@vger.kernel.org
Cc:     colyli@suse.de, ncroxon@redhat.com, heinzm@redhat.com
Subject: [PATCH V2 0/3] Improve handling raid10 discard request
Date:   Tue, 28 Jul 2020 15:18:20 +0800
Message-Id: <1595920703-6125-1-git-send-email-xni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 drivers/md/raid10.c | 297 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 318 insertions(+), 19 deletions(-)

-- 
2.7.5

