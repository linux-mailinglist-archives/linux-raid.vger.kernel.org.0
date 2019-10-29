Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFBEE91EF
	for <lists+linux-raid@lfdr.de>; Tue, 29 Oct 2019 22:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfJ2VV3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 29 Oct 2019 17:21:29 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:40837 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728592AbfJ2VV2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 29 Oct 2019 17:21:28 -0400
Received: from [IPv6:2001:980:b8b2:1:953c:3bd3:747b:48b4]
 ([IPv6:2001:980:b8b2:1:953c:3bd3:747b:48b4])
        by smtp-cloud9.xs4all.net with ESMTPSA
        id PYvdiVL9XsBskPYveiJ36O; Tue, 29 Oct 2019 22:21:26 +0100
To:     linux-raid@vger.kernel.org
From:   Andreas <a@hegyi.info>
Subject: raid0 layout issue documentation / confusions
Message-ID: <1389f13b-eaf0-7ae2-d99b-697ae008f2c9@hegyi.info>
Date:   Tue, 29 Oct 2019 22:21:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH/8nABs4xloWWTTi7z1auKZS84xZFv8V3GEf9iqlIxVVujP5hdDle7nDrNeTjhx+8dIrfeUvxI2HkwL/n2rMpriTuxHezJtgTvUHc+0srzeqdRzzD9p
 A96h6GknBw7yXAh6VhEeoKYnUdDhrS/MZ2f+nBC1sYclqn46jvJ7XPAijBLe0m3WYFMCwHJky6bIhLzCMOGWjQfIzggzkX1yupaGJwU7+nKEJqz1V7v4vUEn
 YXHLBad0lXJYPtyDW+2fR3fWqbFIsMsMsxnBiFaPzKg=
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

(I wanted to react to the thread "admin-guide page for raid0 layout issue", but I just registered and I don't know how to respond to
existing messages.)

I would like to make some suggestions regarding the recent raid0 layout patch, as it made my system unbootable, and it took me quite some 
time to figure out what was wrong and how to fix it. I also encountered  confusion on the web. I am just a regular user, not a programmer or 
linux guru, so take my suggestions as such.

* Everywhere where the values are documented, all three of 0, 1, and 2 should be explicitly documented (not only two of them). If I am not 
mistaken, 0 means "unset", 1 means "old layout" (kernel 3.14 and older), 2 means "new layout" (3.15 and later).

* When trying to assemble existing array but without the kernel parameter set (i.e. set to 0) it silently fails. Only in the kernel ring 
buffer there is a message:
  md/raid0:md0: cannot assemble multi-zone RAID0 with default_layout setting
  md/raid0: please set raid.default_layout to 1 or 2

   When trying to create a raid0 array, it gives an error, but it is not helpful:
     mdadm: Defaulting to version 1.2 metadata
     mdadm: RUN_ARRAY failed: Unknown error 524

For both cases, and both places (mdamd and dmesg) should be more informative.

* The recommended parameter value for new raid0 arrays should be made clear. I guess it's 2.

* Various places where documentation could (or should) be added:
	- mdamd error messags
	- kernel ring buffer messages
	- mdadm man page
	- mdadm wiki
	- kernel parameter documentation pages

Confusions:
* The definition of the parameter values is wrong in the patch description:
https://github.com/torvalds/linux/commit/c84a1372df929033cb1a0441fb57bd3932f39ac9#diff-158c54ea7ccae01a77ae3f5d44ab0f94 it says 0 is old, 1 
is new. Please fix, because this contributes to confusion, and may even lead to data corruption.

* On the raid mailing list https://www.spinics.net/lists/raid/msg63337.html someone said "new (1) and old (2) vs. unset (0)". No one 
objected, but I guess that this is also wrong?

* Two webpages (of the rare ones on this issue) are conflicting on what is the meaning of parameter 1 and 2.
         https://blog.icod.de/2019/10/10/caution-kernel-5-3-4-and-raid0-default_layout/ says 1 is old, 2 is new.
         https://www.reddit.com/r/linuxquestions/comments/debx7w/mdadm_raid0_default_layout/ says 2 is old, 1 is new.

* https://blog.icod.de/2019/10/10/caution-kernel-5-3-4-and-raid0-default_layout/ suggests that the kernel parameters should be set in GRUB 
as GRUB_CMDLINE_LINUX_DEFAULT="raid0.default_layout=2" (or 1), but in my opinion it should set GRUB_CMDLINE_LINUX_DEFAULT because 
GRUB_CMDLINE_LINUX_DEFAULT is not used in recovery mode, but GRUB_CMDLINE_LINUX is. So, please document all possible (recommended) ways to 
set the parameter: GRUB,  /etc/modprobe.d/00-local.conf, and /sys/module/raid0/parameters/default_layout.

* I was also wondering why the patch had to disable assembling if it was a working array on my system. Isn't it obvious, based on the kernel 
version with which it worked before the update, whether it should be 1 or 2? Why wasn't it possible to first automatically set the default 
kernel variable in grub.cfg and then do the update?

* Why is this parameter actually a *kernel* parameter. While not very likely, it is possible that two arrays with different layouts (needing 
different parameter settings) will end up in the same machine. In such a case any parameter choice may lead to data corruption. I would 
think that the layout parameter is a property of the specific array, so it should be in the meta-data of the array itself.


