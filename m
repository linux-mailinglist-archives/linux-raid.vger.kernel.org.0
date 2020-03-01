Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A87C1174F48
	for <lists+linux-raid@lfdr.de>; Sun,  1 Mar 2020 20:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgCATzN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 1 Mar 2020 14:55:13 -0500
Received: from len.romanrm.net ([91.121.86.59]:47076 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgCATzN (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 1 Mar 2020 14:55:13 -0500
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Mar 2020 14:55:12 EST
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id E0C964031E;
        Sun,  1 Mar 2020 19:48:06 +0000 (UTC)
Date:   Mon, 2 Mar 2020 00:48:06 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     antlists <antlists@youngman.org.uk>
Cc:     William Morgan <therealbrewer@gmail.com>,
        linux-raid@vger.kernel.org
Subject: Re: Grow array and convert from raid 5 to 6
Message-ID: <20200302004806.54852908@natsu>
In-Reply-To: <fa393999-3f56-0bcf-b097-462a209f1eae@youngman.org.uk>
References: <CALc6PW7C30Z6bccQLXLPf8zYuM=aBVZ_hLgW3i5gqZFVsLRpfA@mail.gmail.com>
        <fa393999-3f56-0bcf-b097-462a209f1eae@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sun, 1 Mar 2020 19:07:56 +0000
antlists <antlists@youngman.org.uk> wrote:
 
> --add disk2 ..." to give an array with 4 active drives and 4 spares. 
> Then you can upgrade to raid 6 - "--grow --level=6 --raid-devices=8".

This feels risky and unclear, for instance what will be the array state if 2
disks fail during this conversion? Would it depend on which ones have failed?

Instead I'd suggest doing this in two steps. First and foremost, add one disk
and convert to RAID6 in a special way:

  --grow --level=6 --raid-devices=5 --layout=preserve

...due to the last bit (see the man page), this will be really fast and will
not even rewrite existing data on the old 4 disks; But you will get a
full-blown RAID6 redundancy array, albeit with a weird on-disk layout.

Then add 3 remaining disks, and

  --grow --level=6 --raid-devices=8 --layout=normalise

Additionally, before you even begin, consider do you really want to go with
such a setup in the first place. I used to run large RAID6s with a single
filesystem on top, but then found them to be too much of a single point of
failure, and now moved on to merging individual disks on the FS level (using
MergerFS or mhddfs) for convenience, and doing 100% backups of everything
for data loss protection. Backups which you have to do anyway, as anyone will
tell you RAID is not a replacement for backup; but with a RAID6 there's too
much of a temptation to skimp on them, which tends to bite badly in the end.
Also back then it seemed way too expensive to backup everything, now with
todays HDD sizes and prices that's no longer so.

-- 
With respect,
Roman
