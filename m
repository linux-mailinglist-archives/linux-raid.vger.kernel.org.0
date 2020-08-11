Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2698B2415C9
	for <lists+linux-raid@lfdr.de>; Tue, 11 Aug 2020 06:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgHKEms (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Aug 2020 00:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgHKEms (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Aug 2020 00:42:48 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD31C06174A
        for <linux-raid@vger.kernel.org>; Mon, 10 Aug 2020 21:42:48 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d2so5937161lfj.1
        for <linux-raid@vger.kernel.org>; Mon, 10 Aug 2020 21:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hGeER03x2NjfwoCdRQYL0VNpYe+ZQlmzTtE14nnOL08=;
        b=IDs1fz1mra+LNyMEvdYpclwng9MF0ogNg1sEBpB2cPAYot36pTHWs9bvEWjam/ui44
         zEbAjHKMYbV0u6lvO+wW7cn/Sp4MUwKJxpzIsA1J4rxf8v/tm59tcfJYE/RVJtL0PNWH
         eqfn2dm/d/UAXp9pZEpTYWxY30d6KxQpi964iKN0nhadieLBBywV6M9KNSFKvNrKUclw
         BCAWVAkDakobCPg7Vx9/rdfIIiLtecew4VZfnwdBeXNW7gtB/3Zy/0xr6ei4F7hM/lkR
         ohfoiw5HsvX0fB5lK4Lm/3oAN1y/iITz+7YRQTXlMY3weS1mbj/4lJCBqqk1SLBEfP4g
         xtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hGeER03x2NjfwoCdRQYL0VNpYe+ZQlmzTtE14nnOL08=;
        b=k+qzfqqyzHwEiaJeKDHprboOXEySPf6MhazeW0wEsIfpFYrxNXelyGgGroch6yVi17
         P+UbZ/THkQ3Iz/WgFKXUnbNi4vghBk+hG6R1m5Fo5uzl6I8jszOMMe5A9UeLmCO78k2w
         3+dI8JJKXjngYfz8QobC0sBe8rnzuX3xUNatz4LN+UUEcPukoRYXQrl2Hntig1VVsGby
         4lkL+T8C6AOq1w7C2IHWUH5SQHlbAyZ9xJBPCh9CWUE3i3GvRyQIzEiwekH6vvs0Yyzj
         TSv+9VuIct55hMWtXiKBt/O9CL11rDghxERMAy+CHes4CttEeoto4fUX9hsiMgL87kXP
         O3gQ==
X-Gm-Message-State: AOAM532QwdFpbhHYJQXs7/arRXsDaAe5bXZGwo4YxWaVfJ/MNiETemzv
        kKG+8cszoLL2zuZWHVXb1atl1kTTcBNKWhhbHmZzrGrzw/o=
X-Google-Smtp-Source: ABdhPJz45P1eVojVweJvTSPXTWxsHbX6YLCaSMBj4t/PwBXDvvOVzPFcVN3N8O6CTmYZXktS5BukCYR5c9xffKpXG/I=
X-Received: by 2002:a19:c519:: with SMTP id w25mr2305508lfe.24.1597120965405;
 Mon, 10 Aug 2020 21:42:45 -0700 (PDT)
MIME-Version: 1.0
From:   George Rapp <george.rapp@gmail.com>
Date:   Tue, 11 Aug 2020 00:42:33 -0400
Message-ID: <CAF-KpgYcEF5juR9nFPifZunPPGW73kWVG9fjR3=WpufxXJcewg@mail.gmail.com>
Subject: Recommended filesystem for RAID 6
To:     Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello Linux RAID community -

I've been running an assortment of software RAID arrays for a while
now (my oldest Creation Time according to 'mdadm --detail' is April
2011) but have been meaning to consolidate my five active arrays into
something easier to manage. This weekend, I finally found enough cheap
2TB disks to get started. I'm planning on creating a RAID 6 array due
to the age and consumer-grade quality of my 16 2TB disks.

Use case is long-term storage of many small files and a few large ones
(family photos and videos, backups of other systems, working copies of
photo, audio, and video edits, etc.)? Current usable space is about
10TB but my end state vision is probably upwards of 20TB. I'll
probably consign the slowest working disks in the server to an archive
filesystem, either RAID 1 or RAID 5, for stuff I care less about and
backups; the archive part can be ignored for the purposes of this
exercise.

My question is: what filesystem type would be best practice for my use
case and size requirements on the big array? (I have reviewed
https://raid.wiki.kernel.org/index.php/RAID_and_filesystems, but am
looking for practitioners' recommendations.)  I've run ext4
exclusively on my arrays to date, but have been reading up on xfs; is
there another filesystem type I should consider? Finally, are there
any pitfalls I should know about in my high-level design?

Details:
# uname -a
Linux backend5 5.7.11-200.fc32.x86_64 #1 SMP Wed Jul 29 17:15:52 UTC
2020 x86_64 x86_64 x86_64 GNU/Linux
# mdadm --version
mdadm - v4.1 - 2018-10-01

Finally, and this is inadequate given the value I've received from the
efforts of this group, but thanks for many years of supporting mdadm
and helping with software RAID issues, including the recovery
procedures you have written up and guided me through. This group's
efforts have saved my data, my bacon, and my sanity on more than one
occasion.
--
George Rapp  (Pataskala, OH) Home: george.rapp -- at -- gmail.com
LinkedIn profile: https://www.linkedin.com/in/georgerapp
Phone: +1 740 936 RAPP (740 936 7277)
