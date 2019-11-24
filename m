Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1717A10853C
	for <lists+linux-raid@lfdr.de>; Sun, 24 Nov 2019 23:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfKXWHS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 24 Nov 2019 17:07:18 -0500
Received: from eggs.gnu.org ([209.51.188.92]:60307 "EHLO eggs.gnu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfKXWHR (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 24 Nov 2019 17:07:17 -0500
Received: from fencepost.gnu.org ([2001:470:142:3::e]:53502)
        by eggs.gnu.org with esmtp (Exim 4.71)
        (envelope-from <sudoman@gnu.org>)
        id 1iZ02G-0000w8-4N
        for linux-raid@vger.kernel.org; Sun, 24 Nov 2019 17:07:16 -0500
Received: from jumpgate.fsf.org ([74.94.156.211]:50946 helo=[172.16.0.64])
        by fencepost.gnu.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <sudoman@gnu.org>)
        id 1iZ02F-00069n-Pw
        for linux-raid@vger.kernel.org; Sun, 24 Nov 2019 17:07:15 -0500
From:   Andrew Engelbrecht <sudoman@gnu.org>
Subject: Deep into potential data loss issue
Openpgp: preference=signencrypt
Autocrypt: addr=sudoman@gnu.org; prefer-encrypt=mutual; keydata=
 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
 074QweOPoYvVRQw=
To:     linux-raid@vger.kernel.org
Message-ID: <3fc5f3df-0589-645c-f36a-2eee83e8bccd@gnu.org>
Date:   Sun, 24 Nov 2019 17:07:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Icedove/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello RAID mailing list,

We recently ran into an issue with a degraded raid array. The drive in
question was able to read, but writes were in some sort of failure state
due to a lack of re-mappable sectors.

--replace wasn't an option with our version of mdadm, so we tried
removing the faulty partition and adding a new one (using a partition
from another drive already in the array). that failed when a bad block
was discovered. We tried re-adding the faulty drive, but it died completely.

One of our admins went into the data center, and unfortunately unplugged
the wrong drive, then plugged it back in. Oddly enough, the drive letter
did not change for that drive partition. All looked okay.

A bit later, the new partition we had tried to add earlier was a part of
the array again, and there was a syncing process taking place, possibly
by setting the "0xfd" disk label for "Linux raid autodetect" earlier on
that drive. This partition had a new drive letter, unlike the one that
remained in the array.

We decided to shut down the machine so we could add in sata cables to
add more drives to aid with recovery. However the raid array did not
come back.

We are unable to start the array with either sdd1 or sdd2 (sdd2 is the
one that we tried adding previously) and the --run option. sdd1 can't
get added to the array at all. Bitmaps are not shown for the device.
sdd2 is marked with (R), which I am told means "replacing", but I don't
know more than that.


md127 : inactive sde1[0] sdg1[3] sdd2[5](R)
      702896904 blocks super 1.2


The number of events on sdd1, which was originally in the array, is less
than sde1, sdg1 and sdd2, which all have the same number of events.

Is it safe to attempt to re-assemble a degraded array with three members
using --force on sde1, sdg1 and sdd2?

Thanks for your help,
Andrew
