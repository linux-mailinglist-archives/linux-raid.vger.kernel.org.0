Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC058223152
	for <lists+linux-raid@lfdr.de>; Fri, 17 Jul 2020 04:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGQCw4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jul 2020 22:52:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34524 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726141AbgGQCwz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Jul 2020 22:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594954375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qPPbUFuKiihIIUlUWM1GvhQIzJ5DC7EozuMP9R60PwI=;
        b=P260eWkV/8LLOlq5YT4t73a5Ow+5LUSUNeLFzte5a8plF0dXOWAhxUs5XpjxplYi+n1GMY
        jlmwL1p1Huc2YlVqYDMfuwSc/DacDgUUYdml0oEi1RrnVwyogpNE2VbQk50FKMIP+AlBsS
        BnBSMKPXnYvLZxRReYuQL01cE1bxA6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-7ijuxxW-MHq-s8SB3UVU2w-1; Thu, 16 Jul 2020 22:52:53 -0400
X-MC-Unique: 7ijuxxW-MHq-s8SB3UVU2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A3E28014D4;
        Fri, 17 Jul 2020 02:52:52 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E173724A9;
        Fri, 17 Jul 2020 02:52:50 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     song@kernel.org, linux-raid@vger.kernel.org
Subject: [PATCH RFC 0/3] Improve handling raid10 discard request
Date:   Fri, 17 Jul 2020 10:52:45 +0800
Message-Id: <1594954368-5646-1-git-send-email-xni@redhat.com>
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

 drivers/md/md.c     |  22 +++++
 drivers/md/md.h     |   3 +
 drivers/md/raid0.c  |  15 +--
 drivers/md/raid10.c | 276 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 297 insertions(+), 19 deletions(-)

-- 
2.7.5

