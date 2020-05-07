Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16CD1C97CF
	for <lists+linux-raid@lfdr.de>; Thu,  7 May 2020 19:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEGRa3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 May 2020 13:30:29 -0400
Received: from forward106o.mail.yandex.net ([37.140.190.187]:56249 "EHLO
        forward106o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726308AbgEGRa2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 7 May 2020 13:30:28 -0400
Received: from mxback11g.mail.yandex.net (mxback11g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:90])
        by forward106o.mail.yandex.net (Yandex) with ESMTP id A898F5060F10
        for <linux-raid@vger.kernel.org>; Thu,  7 May 2020 20:30:20 +0300 (MSK)
Received: from myt6-efff10c3476a.qloud-c.yandex.net (myt6-efff10c3476a.qloud-c.yandex.net [2a02:6b8:c12:13a3:0:640:efff:10c3])
        by mxback11g.mail.yandex.net (mxback/Yandex) with ESMTP id qWKIk1W5iU-UKpWnq5K;
        Thu, 07 May 2020 20:30:20 +0300
Received: by myt6-efff10c3476a.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id XDStsSGVmM-UJ38xIYp;
        Thu, 07 May 2020 20:30:20 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
To:     linux-raid@vger.kernel.org
From:   Michal Soltys <msoltyspl@yandex.pl>
Subject: [general question] rare silent data corruption when writing data
Message-ID: <b0e91faf-3a14-3ac9-3c31-6989154791c1@yandex.pl>
Date:   Thu, 7 May 2020 19:30:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Note: this is just general question - if anyone experienced something similar or could suggest how to pinpoint / verify the actual cause.

Thanks to btrfs's checksumming we discovered somewhat (even if quite rare) nasty silent corruption going on on one of our hosts. Or perhaps "corruption" is not the correct word - the files simply have precise 4kb (1 page) of incorrect data. The incorrect pieces of data look on their own fine - as something that was previously in the place, or written from wrong source.

The hardware is (can provide more detailed info of course):

- Supermicro X9DR7-LN4F
- onboard LSI SAS2308 controller (2 sff-8087 connectors, 1 connected to backplane)
- 96 gb ram (ecc)
- 24 disk backplane

- 1 array connected directly to lsi controller (4 disks, mdraid5, internal bitmap, 512kb chunk)
- 1 array on the backplane (4 disks, mdraid5, journaled)
- journal for the above array is: mdraid1, 2 ssd disks (micron 5300 pro disks)
- 1 btrfs raid1 boot array on motherboard's sata ports (older but still fine intel ssds from DC 3500 series)

Raid 5 arrays are in lvm volume group, and the logical volumes are used by VMs. Some of the volumes are linear, some are using thin-pools (with metadata on the aforementioned intel ssds, in mirrored config). LVM
uses large extent sizes (120m) and the chunk-size of thin-pools is set to 1.5m to match underlying raid stripe. Everything is cleanly aligned as well.

With a doze of testing we managed to roughly rule out the following elements as being the cause:

- qemu/kvm (issue occured directly on host)
- backplane (issue occured on disks directly connected via LSI's 2nd connector)
- cable (as a above, two different cables)
- memory (unlikely - ECC for once, thoroughly tested, no errors ever reported via edac-util or memtest)
- mdadm journaling (issue occured on plain mdraid configuration as well)
- disks themselves (issue occured on two separate mdadm arrays)
- filesystem (issue occured on both btrfs and ext4 (checksumed manually) )

We did not manage to rule out (though somewhat _highly_ unlikely):

- lvm thin (issue always - so far - occured on lvm thin pools)
- mdraid (issue always - so far - on mdraid managed arrays)
- kernel (tested with - in this case - debian's 5.2 and 5.4 kernels, happened with both - so it would imply rather already longstanding bug somewhere)

And finally - so far - the issue never occured:

- directly on a disk
- directly on mdraid
- on linear lvm volume on top of mdraid

As far as the issue goes it's:

- always a 4kb chunk that is incorrect - in a ~1 tb file it can be from a few to few dozens of such chunks
- we also found (or rather btrfs scrub did) a few small damaged files as well
- the chunks look like a correct piece of different or previous data

The 4kb is well, weird ? Doesn't really matter any chunk/stripes sizes anywhere across the stack (lvm - 120m extents, 1.5m chunks on thin pools; mdraid - default 512kb chunks). It does nicely fit a page though ...

Anyway, if anyone has any ideas or suggestions what could be happening (perhaps with this particular motherboard or vendor) or how to pinpoint the cause - I'll be grateful for any.
