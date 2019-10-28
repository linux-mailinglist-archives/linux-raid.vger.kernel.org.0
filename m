Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5380CE7929
	for <lists+linux-raid@lfdr.de>; Mon, 28 Oct 2019 20:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfJ1TXc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 28 Oct 2019 15:23:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44872 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbfJ1TXc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 28 Oct 2019 15:23:32 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1iPAby-0005i1-6B
        for linux-raid@vger.kernel.org; Mon, 28 Oct 2019 19:23:30 +0000
Received: by mail-il1-f200.google.com with SMTP id d11so9713922ild.10
        for <linux-raid@vger.kernel.org>; Mon, 28 Oct 2019 12:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CmWZngY55vtaKjSbzLE4PT6hPCSdvqcy+rtLwgXoCoE=;
        b=VeQzv6VfovCEWzrzymucV+i16kDOj7w6V5wog+GQTeEZadNAtRIAQh6BYiAF372u9H
         GFl3FdN7lLLoVL0SNXO5p5jqg0ZVok3k9xYKXNg/ULfCUdSsyc91uv2eEg1wnxK8p1ln
         JEWAxHV0EVfbxV/9XjYuXGFrMKJ2XiaDNICqxbAGQHsNVI8IaFiqDSvUp4fanQi+znMj
         9Fw3Agr23EVurEXRUb8n4C9rYS8yXtMSS20/FMRWsU3x/YgbB2qgE1LfLnwL1WyDRHMo
         BnWctyUmK3SK2tcjLPIP4CgK4LMUQz6ZOyAIF1w6sG/5qvMaa85xJarRWo190fnUgX17
         xgUw==
X-Gm-Message-State: APjAAAUve8/3f2+ylEO+RY/3NW4FxO2tY+m9vY52UKHI7koH4kWySKvB
        18pEESXdui0kEm3W7bFgG+SZSqEpy0e6e1fzCCeKLI5+LS8ZfZ+b0K8lXvJ/3ulgId5dHv8hxNk
        BxiU3hC59V3pZPV4vphyvOiSuzefSunTqRl/XjP4=
X-Received: by 2002:a92:ce12:: with SMTP id b18mr23041907ilo.130.1572290609016;
        Mon, 28 Oct 2019 12:23:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx5kckE+95RqmKiTcB6QqSR49p8QwLub0KXNeRHL9ApvAWpYlHT706fZ/pUY0/HXZhNV+ii+w==
X-Received: by 2002:a92:ce12:: with SMTP id b18mr23041857ilo.130.1572290608489;
        Mon, 28 Oct 2019 12:23:28 -0700 (PDT)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id o10sm243087iob.29.2019.10.28.12.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 12:23:27 -0700 (PDT)
Date:   Mon, 28 Oct 2019 13:23:26 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     NeilBrown <neilb@suse.de>, linux-raid <linux-raid@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Ivan Topolsky <doktor.yak@gmail.com>
Subject: Re: admin-guide page for raid0 layout issue
Message-ID: <20191028192326.GA24367@xps13.dannf>
References: <20191025003117.GA19595@xps13.dannf>
 <CAPhsuW6eYTF3AaisW+QsjEneABsh+fitw7bRz_NtD3Eo_gN0eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW6eYTF3AaisW+QsjEneABsh+fitw7bRz_NtD3Eo_gN0eg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Oct 25, 2019 at 04:07:50PM -0700, Song Liu wrote:
> On Fri, Oct 25, 2019 at 12:16 PM dann frazier
> <dann.frazier@canonical.com> wrote:
> >
> > hey,
> >   I recently hit the raid0 default_layout issue and found the warning
> > message to be lacking (and google hits show that I'm not the
> > only one). It wasn't clear to me that it was referring to a kernel
> > parameter, also wasn't clear how I should decide which setting to use,
> > and definitely not clear that picking the wrong one could *cause
> > corruption* (which, AIUI, is the case). What are your thoughts on
> > adding a more admin-friendly explanation/steps on resolving the
> > problem to the admin-guide, and include a URL to it in the warning
> > message? As prior art:
> >
> >   https://github.com/torvalds/linux/commit/6a012288d6906fee1dbc244050ade1dafe4a9c8d
> >
> > If the idea has merit, let me know if you'd like me to take a stab at
> > a strawdog.
> 
> I think it is good to provide some more information for the admin.
> But I am not sure whether we need to point to a url, or just put
> everything in the message.
> 
> Please feel free to try add this information and submit patches.

Hi Song,
  Here's an RFC of what I'm thinking - but drafting this has led me to
more questions:

 - It seems like we've broken backwards compatibility when creating
   new multi-zone arrays. I expected that mdadm would still let me
   create an array w/o a kernel cmdline option in-effect, and w/o
   specifying a specific layout, and just choose a default.
   But even w/ latest mdadm git, it doesn't:
      
    $ sudo ./mdadm --create /dev/md0 --run --metadata=default \
      --homehost=akis --level=0 --raid-devices=2 /dev/vdb1 /dev/vdc1
    mdadm: /dev/vdb1 appears to be part of a raid array:
           level=raid0 devices=2 ctime=Mon Oct 28 18:55:38 2019
    mdadm: /dev/vdc1 appears to be part of a raid array:
           level=raid0 devices=2 ctime=Mon Oct 28 18:55:38 2019
    mdadm: RUN_ARRAY failed: Unknown error 524

  It also doesn't let me specify a layout:
    $ sudo ./mdadm --create /dev/md0 --run --metadata=default \
      --homehost=akis --level=0 --raid-devices=2 /dev/vdb1 /dev/vdc1 --layout=2
    mdadm: layout not meaningful for raid0 arrays.

 - Once you've decided on a layout to use, how do you make that a property
   of the array itself, and therefore avoid having to set default_layout 
   on any machine that uses it? Seems like we'd want to "bake that in"
   to the array itself. I expected that if I created a new array on a
   recent kernel that the array would remember the layout. But after
   creating a new array on 5.4-rc5 w/ default_layout set, I rebooted
   w/o a raid0.default_layout, and the kernel still refused to start
   it.

   Note: I realize my observation above does not match the text below
   in the 3rd paragraph, but I just left it for now until I learn the
   "right way".

diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guide/md.rst
index 3c51084ffd379..5364c514d7926 100644
--- a/Documentation/admin-guide/md.rst
+++ b/Documentation/admin-guide/md.rst
@@ -759,3 +759,37 @@ These currently include:
 
   ppl_write_hint
       NVMe stream ID to be set for each PPL write request.
+
+Multi-Zone RAID0 Layout Migration
+----------------------
+An unintentional RAID0 layout change was introduced in the v3.14 kernel.
+This effectively means there are 2 different layouts Linux will use to
+write data to RAID0 arrays in the wild - the "pre-3.14" way and the
+"post-3.14" way. Mixing these layouts by writing to an array while booted
+on these different kernel versions can lead to corruption.
+
+Note that this only impacts RAID0 arrays that include devices of different
+sizes. If your devices are all the same size, both layouts are equivalent,
+and your array is not at risk of corruption due to this issue.
+
+The kernel has since been updated to record a layout version when creating
+new arrays. Unfortunately, the kernel can not detect which layout was used
+for writes to pre-existing arrays, and therefore requires input from the
+administrator. This input can be provided via the
+``raid0.default_layout=<N>`` kernel command line parameter, or via the
+``layout`` attribute in the sysfs filesystem (but only when the array is
+stopped).
+
+Which layout version should I use?
+++++++++++++++++++++++++++++++++++
+If your RAID array has only been written to by a >= 3.14 kernel, then you
+should specify version 2. If your kernel has only been written to by a < 3.14
+kernel, then you should specify version 1. If the array may have already been
+written to by both kernels < 3.14 and >= 3.14, then it is possible that your
+data has already suffered corruption. Note that ``mdadm --detail`` will show
+you when an array was created, which may be useful in helping determine the
+kernel version that was in-use at the time.
+
+When determining the scope of corruption, it maybe also be useful to know
+that the area susceptible to this corruption is limited to the area of the
+array after "MIN_DEVICE_SIZE * NUM DEVICES".
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 1e772287b1c8e..e01cd52d71aa4 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -155,6 +155,8 @@ static int create_strip_zones(struct mddev *mddev, struct r0conf **private_conf)
 		pr_err("md/raid0:%s: cannot assemble multi-zone RAID0 with default_layout setting\n",
 		       mdname(mddev));
 		pr_err("md/raid0: please set raid0.default_layout to 1 or 2\n");
+		pr_err("Read the following page for more information:\n");
+		pr_err("https://www.kernel.org/doc/html/latest/admin-guide/md.html#multi-zone-raid0-layout-migration\n");
 		err = -ENOTSUPP;
 		goto abort;
 	}
