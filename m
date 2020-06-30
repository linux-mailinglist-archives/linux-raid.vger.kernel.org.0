Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5045320EFF7
	for <lists+linux-raid@lfdr.de>; Tue, 30 Jun 2020 09:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbgF3Hzr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Jun 2020 03:55:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24136 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730150AbgF3Hzq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 30 Jun 2020 03:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593503745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cy3YNy8GN+jupeiQ0NtM50sSsUBnRaEMIvULEFSqjX8=;
        b=Fb4DWcdNEc1XMNDAJczOIYzyHT98W3xuMlm2YEBCLxC2qtVfUUVjgIQKIN715hpmQZTtgf
        nK3l9vt/P9QV2rqjYQ5g/xywJwtsQ+f5Qfl6VA027BNs2xQzlnlJECUoLr+1vSYAwb0jGK
        lSYPLcZjrDia4qMcvBGzV/I9myC0NZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-fvkSaNwVMq2LTmR36f19bA-1; Tue, 30 Jun 2020 03:55:42 -0400
X-MC-Unique: fvkSaNwVMq2LTmR36f19bA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D55B193F560;
        Tue, 30 Jun 2020 07:55:41 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-38.pek2.redhat.com [10.72.8.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEDA774183;
        Tue, 30 Jun 2020 07:55:39 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     linux-raid@vger.kernel.org
Cc:     song@kernel.org, ncroxon@redhat.com
Subject: [PATCH 0/2] Can't grow size twice for a super1.0 array
Date:   Tue, 30 Jun 2020 15:55:35 +0800
Message-Id: <1593503737-5067-1-git-send-email-xni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi all

This are the test steps:
[root@storageqe-54 ~]# mdadm -CR /dev/md0 -l1 -n2 /dev/loop0 /dev/loop1 -e 1.0 --size=1G
[root@storageqe-54 ~]# mdadm --wait /dev/md0
[root@storageqe-54 ~]# mdadm -G /dev/md0 --size=5G
mdadm: component size of /dev/md0 has been set to 5242880K
[root@storageqe-54 ~]# mdadm --wait /dev/md0
[root@storageqe-54 ~]# mdadm -G /dev/md0 --size=6G
mdadm: Cannot set device size for /dev/md0: No space left on device

loop0                                    7:0    0   7.8G  0 loop  
└─md0                                    9:0    0     5G  0 raid1 
loop1                                    7:1    0   7.8G  0 loop  
└─md0                                    9:0    0     5G  0 raid1 

The reason is that it calcluates the max usable space in a wrong way for super1.0 array.
It uses rdev->sectors to calcuate the max usable space rather than the whole disk size.
At first it grow size and it's successful. Because rdev->sectors is set to the whole disk
size when creating raid device. super_1_load sets rdev->sectors to sb->data_size. In mdadm
it sets sb->data_size to the whole disk size rathan than the raid device size. I think it's
a wrong place too. Because of this error, it can grow size successfully at the first time.

It re-sets rdev->sectors to real raid device after reshaping to the new size. So it can't
grow size anymore.

Xiao Ni (2):
  super1.0 calculates max sectors in a wrong way
  Don't need to reset superblock start address for super1.0

 drivers/md/md.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

-- 
2.7.5

