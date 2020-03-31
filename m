Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C04CC1989CC
	for <lists+linux-raid@lfdr.de>; Tue, 31 Mar 2020 04:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgCaCJb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Mar 2020 22:09:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32914 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbgCaCJb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Mar 2020 22:09:31 -0400
Received: by mail-io1-f66.google.com with SMTP id o127so20099397iof.0
        for <linux-raid@vger.kernel.org>; Mon, 30 Mar 2020 19:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iowni-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mN3dttGhpGpvMutc8AJiz6MrbHPk9kyg+E2mnjjj9FE=;
        b=jrEmIojIOCXZSgxM575eeI92AjfNM3RD4mw8fseSis3TeHcAkNoR+JuVDE16DDrw1E
         6CiQsxgITYs0YhxPCrAy6QWPvgIyMkZYwcGne0aTBwUeIIaO5iiSVBDqVoK0f1qNB9fI
         mVjcJ4SiynfkrdejwLvTwQJ+0q5P8AOJIiPF3ZmwuLNY5yOFH0ZRv1exDd3/LuCC12jS
         AMCYTk9ZiQVbllIge4WjZ55SXfIzQhXhSoMlI56pVhVeEJ61l5rpUeUGLt2Lbz4BFs93
         h9AZEWtwiQpFAKWsXf0JNOOvTC4STU1L21lymlt/dz/84RRIjXOv0WKuE1505Gcykj0b
         uwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mN3dttGhpGpvMutc8AJiz6MrbHPk9kyg+E2mnjjj9FE=;
        b=V6GUrpJh1iNLboWKsxQJittTiuCwWR9fogMnb28VpmaUUJjfgso79fKnG1nrLA/R7Z
         IIiK3Fo5Vuya+iMjAxTMNVD3VtoCyNs/5s8tDaOAp9VrPb2MtsF0cK39ZO4KgZsMYqdA
         VlsbA1/cvwtCPd+sSGCdwHGwgWVwo4/WUCMp8K5HNvWPATLECdzv/PSFfBDnk6+MXGUI
         xbS8pD34el4URBQrVCwYJlvDpPXKVKGAAW3YPn1ytpMsT9HG5F3QuZSm1dGao0rKf39b
         pqN1F3lr/LthuysRHXYnnMDm4JDpjGniC7YcHFhGYqzdTfwwjocWzI01eLwnxRaFsFis
         Icgg==
X-Gm-Message-State: ANhLgQ2kriripV+ojgZ+zHp5mqsHSjXRKgc73Asm4v7Zpu8+A56pWcb/
        il+S6eFslZXtRicoCJeovtw92h2fZAsPs3xJTXWIYvtr2/8=
X-Google-Smtp-Source: ADFU+vsB36ybQotn2RnHAg5RlMTrmeuqOIZB/1lwGfiGh/kWLj8pRbISVfnuxieKxZflzecB/tM6Q3YWOHuVlqc6WH4=
X-Received: by 2002:a5d:9d0d:: with SMTP id j13mr13525948ioj.174.1585620568893;
 Mon, 30 Mar 2020 19:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAB00BMjPSg2wdq7pjt=AwmcDmr0ep2+Xr0EAy6CNnVhOsWk8pg@mail.gmail.com>
 <058b3f48-e69d-2783-8e08-693ad27693f6@youngman.org.uk> <CAB00BMgYmi+4XvdmJDWjQ8qGWa9m0mqj7yvrK3QSNH9SzYjypw@mail.gmail.com>
 <1d6b3e00-e7dd-1b19-1379-afe665169d44@turmel.org>
In-Reply-To: <1d6b3e00-e7dd-1b19-1379-afe665169d44@turmel.org>
From:   Daniel Jones <dj@iowni.com>
Date:   Mon, 30 Mar 2020 20:09:17 -0600
Message-ID: <CAB00BMg50zcerSLHShSjoOcaJ0JQSi2aSqTFfU2eQQrT12-qEg@mail.gmail.com>
Subject: Re: Requesting assistance recovering RAID-5 array
To:     Phil Turmel <philip@turmel.org>
Cc:     antlists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello Phil,

> your new motherboard or your distro appears to have reacted to the presence of whole-disk raid members by establishing Gnu Partition Tables on them, blowing away those drives' superblocks.

Yes, this was an unpleasant surprise.  Won't build them this way again.

> In particular, knowledge of the filesystem or nested structure (LVM?) present on the array will be needed to identify the real data offsets of the three mangled members.

I don't have the history of original creation, but I'm fairly certain
it was something straightforward like:

  mdadm --create /dev/md0 {parameters}
  sudo mkfs.ext4 /dev/md0
  mount /dev/md0 /mnt/raid5

After the array was corrupted I needed to comment out the mount from
my fstab, which was as follows (confirming ext4):

    /dev/md0                                      /mnt/raid5
   ext4    defaults        0       0

Cheers,
DJ
