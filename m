Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CE7232725
	for <lists+linux-raid@lfdr.de>; Wed, 29 Jul 2020 23:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgG2VtA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 29 Jul 2020 17:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2Vs7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 29 Jul 2020 17:48:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95087C0619D2
        for <linux-raid@vger.kernel.org>; Wed, 29 Jul 2020 14:48:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a14so23012899wra.5
        for <linux-raid@vger.kernel.org>; Wed, 29 Jul 2020 14:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TUGcdYT7jELeBh5hFTATFO2S/q2U4Y1N3LaONePlylU=;
        b=jAHvluvPasMAv3yEAcO/ag6pDhwmANJTp0Vj3rApJzVQc9FW0dZk18QAPWJAd5JjyY
         mwLCFbDNf4vgOTarO7j0wfGMvJFp9mntxrnfANRGNYixB+JHuVUzY8TnOGSH2D4Lv+Pm
         UNXLlmVt/UEppIERN0gLksa/PJe6n6q71dDNIlROW+nuLevnn0roRnXzNUXA2z14QQ+K
         UD5h0O7wHAHQpQao3Bi/nM17hPBTteHJENuvQLWRb/TOHWaVBltd0ZLNs0IO2IXWAIdh
         zcLRsQQnpY3WjAjlyfEUrisUIoTzvm1Fr+yjInb0WfSpu/v+RVWc9nQ6bkYYGAXz7ZKg
         leUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TUGcdYT7jELeBh5hFTATFO2S/q2U4Y1N3LaONePlylU=;
        b=dTic2DAt5XcDgYQ3gBFfH11SJZC0anZcBjEuCRIvUo0cpLOqoMVMq/f5iOGBcpM91I
         XECQk9aTo/2kdIJrqPnkDYuDg182qJG3tJD0BdA3MHkgnm05sjr4RNxt/JV8B3lOTQkR
         lgWVF2y9zDsOQLE1PVj4n5qSSYYIA37Qa7z+gpP4EMATgDsWhDe+V0Hd5LtSKUX/KcM6
         4lDoBWzRCios5WZK6vb+3QU7IttaOLyngqc1tNAPi9uGtZim1Pjg4xJx6bimxVylL1Ws
         JVg2YsIbadSdcg1V5SBu76D1Gnky5xo98OSAJowFKnFqisF/TcERiCW0gOQeCqdGqfSQ
         cv9A==
X-Gm-Message-State: AOAM531GwKTkJkUfAG5tbFYH9G3F5h4A3sKa6krMEfvdr/TgFG8wxRvn
        h00XUbnLKr+kd3Z9eLig/xNqZltgaddTAuzH8YUsCA==
X-Google-Smtp-Source: ABdhPJyD5eHjIC07UQ3vncKTUKnlJa9bv3fNZhyLLtJa+e1BEh6f0IPK2xVWOgiTL3VfEc+AQHPQK8rv7dDnpvYo7WM=
X-Received: by 2002:adf:eb89:: with SMTP id t9mr406375wrn.65.1596059338069;
 Wed, 29 Jul 2020 14:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz> <a070c45a-0509-e900-e3f3-98d20267c8c9@cloud.ionos.com>
In-Reply-To: <a070c45a-0509-e900-e3f3-98d20267c8c9@cloud.ionos.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 29 Jul 2020 15:48:41 -0600
Message-ID: <CAJCQCtQAHr91wEwvFmh_-UB3Cd3UecSjjy6w7nOeqUktrn4UzQ@mail.gmail.com>
Subject: Re: Linux RAID with btrfs stuck and consume 100 % CPU
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Vojtech Myslivec <vojtech@xmyslivec.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        Michal Moravec <michal.moravec@logicworks.cz>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jul 29, 2020 at 3:06 PM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> Hi,
>
> On 7/22/20 10:47 PM, Vojtech Myslivec wrote:
> > 1. What should be the cause of this problem?
>
> Just a quick glance based on the stacks which you attached, I guess it
> could be
> a deadlock issue of raid5 cache super write.
>
> Maybe the commit 8e018c21da3f ("raid5-cache: fix a deadlock in superblock
> write") didn't fix the problem completely.  Cc Song.

That references discards, and it make me relook at mdadm -D which
shows a journal device:

       0     253        2        -      journal   /dev/dm-2

Vojtech, can you confirm this device is an SSD? There are a couple
SSDs that show up in the dmesg if I recall correctly.

What is the default discard hinting for this SSD when it's used as a
journal device for mdadm? And what is the write behavior of the
journal? I'm not familiar with this feature at all, whether it's
treated as a raw block device for the journal or if the journal
resides on a file system. So I get kinda curious what might happen
long term if this is a very busy file system, very busy raid5/6
journal on this SSD, without any discard hints? Is it possible the SSD
runs out of ready-to-write erase blocks, and the firmware has become
super slow doing erasure/garbage collection on demand? And the journal
is now having a hard time flushing?


-- 
Chris Murphy
