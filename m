Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77AB9122E8E
	for <lists+linux-raid@lfdr.de>; Tue, 17 Dec 2019 15:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfLQOYS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Dec 2019 09:24:18 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31689 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728573AbfLQOYS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 17 Dec 2019 09:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576592657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oqXxqpDieaud69D0QQsDa9CGjmoHkr5uEIkYFRhOPyU=;
        b=QjlUS7iEUcN1ojsIcHjEsQKQjrRHjS9e6oWp7CrqXmhJ47DPwE5vVUaDCKcQH7Wz/2zHds
        0YfayZA1zxKcfL7/4KjDqypd38ufj4DvnOzz/tqlkTSyt2wkZwmeGtpm/LUxrK9JLMkq5n
        LB0DMv84Y9rggWZCmKTj4BFHZ1IdSVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-AOcxUX58PqS4E8EK7hUWTQ-1; Tue, 17 Dec 2019 09:24:14 -0500
X-MC-Unique: AOcxUX58PqS4E8EK7hUWTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E995812D65A3;
        Tue, 17 Dec 2019 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3CDA1001281;
        Tue, 17 Dec 2019 14:24:11 +0000 (UTC)
To:     Jes Sorensen <jes.sorensen@gmail.com>, NeilBrown <neilb@suse.com>,
        linux-raid <linux-raid@vger.kernel.org>
From:   Xiao Ni <xni@redhat.com>
Subject:  Broken Environment syntax in mdcheck_start/mdcheck_continue.service
Message-ID: <60128448-c1e6-5155-7ad8-fc19493fc9b1@redhat.com>
Date:   Tue, 17 Dec 2019 22:24:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi all

In rhel7 we encounter one systemd service failed problem.

[root@intel-rosecity-07 ~]# systemctl start mdcheck_start
[root@intel-rosecity-07 ~]# systemctl status mdcheck_start -l
=E2=97=8F mdcheck_start.service - MD array scrubbing
    Loaded: loaded (/usr/lib/systemd/system/mdcheck_start.service;=20
static; vendor preset: disabled)
    Active: inactive (dead)

Dec 17 09:16:59 intel-rosecity-07.khw1.lab.eng.bos.redhat.com=20
systemd[1]: [/usr/lib/systemd/system/mdcheck_start.service:14] Invalid=20
environment assignment, ignoring: MDADM_CHECK_DURATION=3D"6 hours"

This patch can fix this problem. So is it a systemd syntax problem? The=20
service can start sucessfully in rhel8.

diff --git a/systemd/mdcheck_start.service b/systemd/mdcheck_start.servic=
e
index f17f1aa..da62d5f 100644
--- a/systemd/mdcheck_start.service
+++ b/systemd/mdcheck_start.service
@@ -11,7 +11,7 @@ Wants=3Dmdcheck_continue.timer

  [Service]
  Type=3Doneshot
-Environment=3D MDADM_CHECK_DURATION=3D"6 hours"
+Environment=3D "MDADM_CHECK_DURATION=3D6 hours"
  EnvironmentFile=3D-/run/sysconfig/mdadm
  ExecStartPre=3D-/usr/lib/mdadm/mdadm_env.sh
  ExecStart=3D/usr/share/mdadm/mdcheck --duration ${MDADM_CHECK_DURATION}


Best Regards

Xiao


