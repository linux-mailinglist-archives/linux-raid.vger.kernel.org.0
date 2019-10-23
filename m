Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8650E225B
	for <lists+linux-raid@lfdr.de>; Wed, 23 Oct 2019 20:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388541AbfJWSNs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 23 Oct 2019 14:13:48 -0400
Received: from secmail.pro ([146.185.132.44]:60940 "EHLO secmail.pro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbfJWSNs (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 23 Oct 2019 14:13:48 -0400
Received: by secmail.pro (Postfix, from userid 33)
        id CA4AADF9BE; Wed, 23 Oct 2019 18:11:44 +0000 (UTC)
Received: from secmailw453j7piv.onion (localhost [IPv6:::1])
        by secmail.pro (Postfix) with ESMTP id 5F7121F356B;
        Wed, 23 Oct 2019 11:13:45 -0700 (PDT)
Received: from 127.0.0.1
        (SquirrelMail authenticated user hhardly@secmail.pro)
        by giyzk7o6dcunb2ry.onion with HTTP;
        Wed, 23 Oct 2019 11:13:45 -0700
Message-ID: <3046fd1c514436358817c807cd9dfd52.squirrel@giyzk7o6dcunb2ry.onion>
In-Reply-To: <5fdd5c39-5018-aff6-e0f8-7c2eb5f08c2d@intel.com>
References: <0a32d9235127ec7760334c3308ee6384.squirrel@giyzk7o6dcunb2ry.onion>
    <aff61b6a-15e1-555a-e507-f8dcfcfd3135@intel.com>
    <436ad5949675c156e4062fb23e27c482.squirrel@giyzk7o6dcunb2ry.onion>
    <5fdd5c39-5018-aff6-e0f8-7c2eb5f08c2d@intel.com>
Date:   Wed, 23 Oct 2019 11:13:45 -0700
Subject: Re: How to assemble Intel RST Matrix volumes?
From:   hhardly@secmail.pro
To:     "Artur Paszkiewicz" <artur.paszkiewicz@intel.com>
Cc:     linux-raid@vger.kernel.org
User-Agent: SquirrelMail/1.4.22
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> On 10/22/19 10:51 PM, hhardly@secmail.pro wrote:
>> Here is the output you asked for, which shows does show the volumes. Any
>> further assistance is greatly appreciated.
>
> I hadn't noticed earlier that you are using copies of the original disks.
> The
> issue with this is that the disks' serial numbers are stored in the
> metadata.
> You can see that in the output from "mdadm -E". Mdadm doesn't recognize a
> disk
> as an array member if its serial number does not match with what is in the
> metadata.
>
> Can you use the original disk to assemble the array and keep the copy as
> backup? Then you can rebuild the array and later replace this disk with
> another
> one if you want.

That makes sense. However, using the original physical drive, I get the
same result. I'm perplexed.  Here's the same result after trying assembly
with --scan

# IMSM_NO_PLATFORM=1 mdadm --incremental --run -v /dev/md/imsm0
mdadm: /dev/md/imsm0 is not part of an md array.

Here are the relevant lines from letting --scan do the assembly of the
container, in case that gives a hint ("no correct container type"
interesting?). What else could I do?

# IMSM_NO_PLATFORM=1 mdadm --assemble -e imsm -v --scan
mdadm: looking for devices for further assembly
.
.
.
mdadm: /dev/sdc is identified as a member of /dev/md/imsm0, slot -1.
mdadm: added /dev/sdc to /dev/md/imsm0 as -1
mdadm: Container /dev/md/imsm0 has been assembled with 1 drive
mdadm: looking for devices for further assembly
.
.
.
mdadm: /dev/md/imsm0 is a container, but we are looking for components
mdadm: no correct container type: /dev/md/imsm0

I also tried with the bad physical drive and it had the same result. Then
I attached both of the original drives and still no luck. The only
difference was:

mdadm: /dev/sdd is identified as a member of /dev/md/imsm0, slot -1.
mdadm: /dev/sdb is identified as a member of /dev/md/imsm0, slot -1.
mdadm: added /dev/sdb to /dev/md/imsm0 as -1
mdadm: added /dev/sdd to /dev/md/imsm0 as -1
mdadm: Container /dev/md/imsm0 has been assembled with 2 drives

But the volumes are still not assembled.

