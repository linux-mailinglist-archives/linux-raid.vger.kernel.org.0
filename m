Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE9812A413
	for <lists+linux-raid@lfdr.de>; Tue, 24 Dec 2019 21:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfLXUTG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 24 Dec 2019 15:19:06 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:36169 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfLXUTG (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 24 Dec 2019 15:19:06 -0500
Received: by mail-lf1-f49.google.com with SMTP id n12so15743991lfe.3
        for <linux-raid@vger.kernel.org>; Tue, 24 Dec 2019 12:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QYS0ypUHPwN7avkpDki6rg+4KGLZ7XQeBvSzzaDlvqw=;
        b=sdjLxUy/E2rwNRjWQnXo0qyUBTNNS7seOWdqMzHveml5h3TZyq3HEyPyR69ru8+wgN
         pck1QHeVuzj3utTwxsIUFHfNVlYqEv9on0J8mS/MdGmRRo8QMFLvKSOUSI51hFXqUoKr
         V9GpO5gnAAeiXYGAj1Hrdm4jy1NH537MqD26vaAxyqJxfEPjLzjl/ProG01v8mc3lxsW
         52clYans6qHrwVClUpHm1gPwJ8KPdFm4T8E9G2zhYYNBsb9tkMz/dkd1NTxXeOdbgNV+
         NE6ighnUXSSxZavm7Sfnkg6CuaKphUxKYavkAX02X/7z82uLVqy9W2vTgVdhJDwX/zla
         E4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QYS0ypUHPwN7avkpDki6rg+4KGLZ7XQeBvSzzaDlvqw=;
        b=DDmUcKqWlwC0LYIucDv3bdvgzG43EtyYMSyuogj7vhUXqNfFROaBsGFVrHBn+WZSyD
         xFyw2LaXBuAxoD+lenrlt1+6LbsjbmLQgzRMx0287M4NMZoiXgZy+Y14KTIjnWWb7mJW
         DxsN/X6Y7DdlQpbrDjkawirNpYN38l93ES70rDAfVk84kw97rIW68Q9Po+IFsGr2PFWl
         LM8UVot3LH5yrYfAOfd6p4XkC27urnysAtcVSFBti8Znff22WaiibOJ7eIXm6Zn/nlL9
         yMRfyDRh9pCboLnZBlkTK1bSOKhNL2bYFnWccWS9X/A0I7mWpmzNWWYbgTBlT/StYwQT
         KboQ==
X-Gm-Message-State: APjAAAX1s86IsWEwpjeW9e6ZvGXlROs1Uc2xR1fNXlvWuH3Hhv+E6LFA
        KKjJnyZR9F/qwY+j1p1l/+pGMl6MJt2sh76Ro7TsnewI
X-Google-Smtp-Source: APXvYqwaGm0RS9HLHHfPj8WzCNXT1708hvJ/kxKTEfDR8baBWn7X/eLd41NSNU0wzloSrJmd4CIVGXREnx4JQlQ8POU=
X-Received: by 2002:ac2:599c:: with SMTP id w28mr21759347lfn.78.1577218743795;
 Tue, 24 Dec 2019 12:19:03 -0800 (PST)
MIME-Version: 1.0
From:   Alexander Lyakas <alex.bolshoy@gmail.com>
Date:   Tue, 24 Dec 2019 22:18:52 +0200
Message-ID: <CAGRgLy4Yi1HNqNO0MLq5xjRRgWe7EaByRYF5sA3fFVa1tmpNvA@mail.gmail.com>
Subject: hung-task panic in raid5_make_request
To:     linux-raid <linux-raid@vger.kernel.org>, liu.song.a23@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Greetings,

We are hitting the following hung-task panic[1] with raid5 in kernel
4.14.99. It is happening every couple of days.

The raid5 in question contains three devices and has been created with command:
mdadm --create /dev/md5 --force  --raid-devices=3 --size=1522566M
--chunk=64 --level=raid5 --bitmap=internal --name=5
--uuid=47952090192D4408BDABC9628E16FD06 --run --auto=md --metadata=1.2
--homehost=zadara_vc --verbose --verbose /dev/dm-13 /dev/dm-14
/dev/dm-15

The array is not undergoing any kind of rebuild or reshape.

Similar issue for kernel 4.14.37 was reported in
https://bugzilla.kernel.org/show_bug.cgi?id=199539.

We recently moved to kernel 4.14 (long term kernel) from kernel 3.18.
With kernel 3.18 we haven't seen this issue.

Looking at the code, raid5_make_request seems to be stuck waiting for
a free stripe via raid5_make_request => raid5_get_active_stripe =>
wait_event_lock_irq().
Looking with gdb:

(gdb) l *raid5_make_request+0x1b7
0xa697 is in raid5_make_request (./include/linux/compiler.h:183).
178     })
179
180     static __always_inline
181     void __read_once_size(const volatile void *p, void *res, int size)
182     {
183             __READ_ONCE_SIZE;
184     }
185
186     #ifdef CONFIG_KASAN
187     /*

The READ_ONCE call seems to be used by list_empty, which is called
from wait_event_lock_irq [2]

How can this be debugged further?

Thanks,
Alex.

[1]
[155653.946408] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[155653.947333] kworker/u4:94   D    0  6178      2 0x80000000
[155653.949159] Call Trace:
[155653.949576]  ? __schedule+0x290/0x8a0
[155653.950052]  ? blk_flush_plug_list+0xc1/0x250
[155653.950688]  schedule+0x2f/0x90
[155653.951173]  raid5_make_request+0x1b7/0xb10 [raid456]
[155653.951765]  ? wait_woken+0x80/0x80
[155653.952216]  ? wait_woken+0x80/0x80
[155653.952673]  md_handle_request+0x131/0x1a0 [md_mod]
[155653.953310]  md_make_request+0x65/0x170 [md_mod]
[155653.953963]  generic_make_request+0x123/0x320
[155653.954473]  ? submit_bio+0x6c/0x140
[155653.954981]  submit_bio+0x6c/0x140

[2]

if (!sh) {
set_bit(R5_INACTIVE_BLOCKED,
&conf->cache_state);
r5l_wake_reclaim(conf->log, 0);
wait_event_lock_irq(
conf->wait_for_stripe,
!list_empty(conf->inactive_list + hash) &&
(atomic_read(&conf->active_stripes)
< (conf->max_nr_stripes * 3 / 4)
|| !test_bit(R5_INACTIVE_BLOCKED,
     &conf->cache_state)),
*(conf->hash_locks + hash));
