Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA6E3FCDA6
	for <lists+linux-raid@lfdr.de>; Tue, 31 Aug 2021 21:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbhHaTUs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 31 Aug 2021 15:20:48 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:56965 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbhHaTUl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 31 Aug 2021 15:20:41 -0400
Received: from weisslap.aisec.fraunhofer.de ([178.27.102.95]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MVNEv-1mSgSp1aK7-00SKLc; Tue, 31 Aug 2021 21:19:32 +0200
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Song Liu <song@kernel.org>, Eric Paris <eparis@redhat.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-audit@redhat.com
Subject: [PATCH v3 0/3] dm: audit event logging
Date:   Tue, 31 Aug 2021 21:18:37 +0200
Message-Id: <20210831191845.7928-1-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bQSyqX7gzsyHfW6ItopsEcogtOFcgqMpcpbkBlqNfgXJTvZcBaA
 FAUB5KPiu44/uxGyHh3UqcCJ9gQwwuOlq72qahbv0xtBaNqz3wWwP5OmBKpM2YI3a4sGtgW
 qlcd7EXkHQuTrYOWpqRmLeF05EgDwa/tnkS5AgpSJHKdwWHtVqGzd8e0fl4gw9BERg9wbZ/
 AucUldHvLz0VlOZoG93jg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:A/O4J6mxtHY=:9dAyRyAlowvW26ufpwFqAc
 WDuDw97ygAtM7WwKzJYJI2iusOf0j0zuKaOwSdlYAKdg5pmeK1GKOnqaUf8P3CIU7JY+dUeGR
 1+VYKpIL8Q1h4WrkrqKAM189UXkkBouwjSQKgcsdwLxi/JNcEZF3Egh77VmoDOS9/Ex+D+G6l
 +pQ+PB54RSuLcMts6bGm8PWtv/DEj6QlfZVI6sVGgIFWOrBp+EPem5haz/3Ny02Elwzb3o7ok
 0EtyOGJAyb3AZRyE0/x5m2W5rp/pByxXqHYXwH1+YL1MhLyU1cPAZgQXUOU33rq8jVsejx9Yg
 C71lZLXzn7cLEfv5r+XqOJA5hoqGw02xFFpduBOJCD/y5rVlAzQxsLt0TQ/n1PSsq5qqMl8xf
 3LtDxBOWuSvJQEtZXBrWul9jDlyZR5wOLajhwbW25q6cTPx0oxuGSvFbERfuWB5tI5L1geRu0
 rboLU8cWXct2n3oqTTMfr3Pp2ewjDcUmqGv6jj559mj0khfceNkbEW3l4Xdcnj80oaZjjXs8s
 bJ5HHIYtKn/Mf5CrMxCGbtjlokPVEyckf3KYV47NtAUEGqIZjblYTPhwYY6/hGviUzEXSl1Ri
 kWXJeogYleJE1dFr/mR9xwzhgtNL0EbQ6jZNKzPsRUwdWLxjhrq23jxUatX8yEf1Hnq7w8P4+
 AtMjfDUsg4P2RmzP3HEBWTQjUU19sgnPa6FagZ6qF9rMrxsFOrPwdKjazsFqPtp3eZn05SrAC
 eUDatYH9CXUdyNt79lm5p7e9uR+jlWc8M7UB9K+CZsyjehCrGzbCYpsFRyw=
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

dm integrity and also stacked dm crypt devices track integrity
violations internally. Thus, integrity violations could be polled
from user space, e.g., by 'integritysetup status'.

From an auditing perspective, we only could see that there were
a number of integrity violations, but not when and where the
violation exactly was taking place. The current error log to
the kernel ring buffer, contains those information, time stamp and
sector on device. However, for auditing the audit subsystem provides
a separate logging mechanism which meets certain criteria for secure
audit logging.

With this small series we make use of the kernel audit framework
and extend the dm driver to log audit events in case of such
integrity violations. Further, we also log construction and
destruction of the device mappings.

We focus on dm-integrity and stacked dm-crypt devices for now.
However, the helper functions to log audit messages should be
applicable to dm-verity too.

The first patch introduce generic audit wrapper functions.
The second patch makes use of the audit wrapper functions in the
dm-integrity.c.
The third patch uses the wrapper functions in dm-crypt.c.

The audit logs look like this if executing the following simple test:

# dd if=/dev/zero of=test.img bs=1M count=1024
# losetup -f test.img
# integritysetup -vD format --integrity sha256 -t 32 /dev/loop0
# integritysetup open -D /dev/loop0 --integrity sha256 integritytest
# integritysetup status integritytest
# integritysetup close integritytest
# integritysetup open -D /dev/loop0 --integrity sha256 integritytest
# integritysetup status integritytest
# dd if=/dev/urandom of=/dev/loop0 bs=512 count=1 seek=100000
# dd if=/dev/mapper/integritytest of=/dev/null

-------------------------
audit.log from auditd

type=UNKNOWN[1336] msg=audit(1630425039.363:184): module=integrity
op=ctr ppid=3807 pid=3819 auid=1000 uid=0 gid=0 euid=0 suid=0 fsuid=0
egid=0 sgid=0 fsgid=0 tty=pts2 ses=3 comm="integritysetup"
exe="/sbin/integritysetup" subj==unconfined dev=254:3
error_msg='success' res=1
type=UNKNOWN[1336] msg=audit(1630425039.471:185): module=integrity
op=dtr ppid=3807 pid=3819 auid=1000 uid=0 gid=0 euid=0 suid=0 fsuid=0
egid=0 sgid=0 fsgid=0 tty=pts2 ses=3 comm="integritysetup"
exe="/sbin/integritysetup" subj==unconfined dev=254:3
error_msg='success' res=1
type=UNKNOWN[1336] msg=audit(1630425039.611:186): module=integrity
op=ctr ppid=3807 pid=3819 auid=1000 uid=0 gid=0 euid=0 suid=0 fsuid=0
egid=0 sgid=0 fsgid=0 tty=pts2 ses=3 comm="integritysetup"
exe="/sbin/integritysetup" subj==unconfined dev=254:3
error_msg='success' res=1
type=UNKNOWN[1336] msg=audit(1630425054.475:187): module=integrity
op=dtr ppid=3807 pid=3819 auid=1000 uid=0 gid=0 euid=0 suid=0 fsuid=0
egid=0 sgid=0 fsgid=0 tty=pts2 ses=3 comm="integritysetup"
exe="/sbin/integritysetup" subj==unconfined dev=254:3
error_msg='success' res=1

type=UNKNOWN[1336] msg=audit(1630425073.171:191): module=integrity
op=ctr ppid=3807 pid=3883 auid=1000 uid=0 gid=0 euid=0 suid=0 fsuid=0
egid=0 sgid=0 fsgid=0 tty=pts2 ses=3 comm="integritysetup"
exe="/sbin/integritysetup" subj==unconfined dev=254:3
error_msg='success' res=1

type=UNKNOWN[1336] msg=audit(1630425087.239:192): module=integrity
op=dtr ppid=3807 pid=3902 auid=1000 uid=0 gid=0 euid=0 suid=0 fsuid=0
egid=0 sgid=0 fsgid=0 tty=pts2 ses=3 comm="integritysetup"
exe="/sbin/integritysetup" subj==unconfined dev=254:3
error_msg='success' res=1

type=UNKNOWN[1336] msg=audit(1630425093.755:193): module=integrity
op=ctr ppid=3807 pid=3906 auid=1000 uid=0 gid=0 euid=0 suid=0 fsuid=0
egid=0 sgid=0 fsgid=0 tty=pts2 ses=3 comm="integritysetup"
exe="/sbin/integritysetup" subj==unconfined dev=254:3
error_msg='success' res=1

type=UNKNOWN[1337] msg=audit(1630425112.119:194): module=integrity
op=integrity-checksum dev=254:3 sector 77480 res=0
type=UNKNOWN[1337] msg=audit(1630425112.119:195): module=integrity
op=integrity-checksum dev=254:3 sector 77480 res=0
type=UNKNOWN[1337] msg=audit(1630425112.119:196): module=integrity
op=integrity-checksum dev=254:3 sector 77480 res=0
type=UNKNOWN[1337] msg=audit(1630425112.119:197): module=integrity
op=integrity-checksum dev=254:3 sector 77480 res=0
type=UNKNOWN[1337] msg=audit(1630425112.119:198): module=integrity
op=integrity-checksum dev=254:3 sector 77480 res=0
type=UNKNOWN[1337] msg=audit(1630425112.119:199): module=integrity
op=integrity-checksum dev=254:3 sector 77480 res=0
type=UNKNOWN[1337] msg=audit(1630425112.119:200): module=integrity
op=integrity-checksum dev=254:3 sector 77480 res=0
type=UNKNOWN[1337] msg=audit(1630425112.119:201): module=integrity
op=integrity-checksum dev=254:3 sector 77480 res=0
type=UNKNOWN[1337] msg=audit(1630425112.119:202): module=integrity
op=integrity-checksum dev=254:3 sector 77480 res=0
type=UNKNOWN[1337] msg=audit(1630425112.119:203): module=integrity
op=integrity-checksum dev=254:3 sector 77480 res=0

v3 Changes:
- Use of two audit event types AUDIT_DM_EVENT und AUDIT_DM_CTRL
- Additionally use audit_log_task_info in case of AUDIT_DM_CTRL messages
- Provide consistent fields per message type as suggested by Paul
- Added sample events to commit message of [1/3] as suggested by Paul
- Rebased on v5.14


v2 Changes:
- Fixed compile errors if CONFIG_DM_AUDIT is not set
- Fixed formatting and typos as suggested by Casey

Michael Weiß (3):
  dm: introduce audit event module for device mapper
  dm integrity: log audit events for dm-integrity target
  dm crypt: log aead integrity violations to audit subsystem

 drivers/md/Kconfig         | 10 +++++
 drivers/md/Makefile        |  4 ++
 drivers/md/dm-audit.c      | 79 ++++++++++++++++++++++++++++++++++++++
 drivers/md/dm-audit.h      | 62 ++++++++++++++++++++++++++++++
 drivers/md/dm-crypt.c      | 22 +++++++++--
 drivers/md/dm-integrity.c  | 25 ++++++++++--
 include/uapi/linux/audit.h |  2 +
 7 files changed, 196 insertions(+), 8 deletions(-)
 create mode 100644 drivers/md/dm-audit.c
 create mode 100644 drivers/md/dm-audit.h

-- 
2.20.1

