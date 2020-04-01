Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68DB719AEA6
	for <lists+linux-raid@lfdr.de>; Wed,  1 Apr 2020 17:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbgDAPVi (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 1 Apr 2020 11:21:38 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45595 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732707AbgDAPVi (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 1 Apr 2020 11:21:38 -0400
Received: by mail-vs1-f65.google.com with SMTP id x82so58436vsc.12
        for <linux-raid@vger.kernel.org>; Wed, 01 Apr 2020 08:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iowni-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYnqAJxLP5xeXIRytYPZfWDqlK46jI3gXiWpLyXsB+I=;
        b=SVWwtuk8V/YfgVn0Lv+Jb7YVMB8WPg47HGd7syDT/8P0jAaS0qhnz5gMSh8seH8aEz
         Rohwkeky/smETIG/7bCqM1G59YNyp6tLeg5Y9XnmzIk5zHzTD+Uq0l1m1QfZb4uu5R/C
         PABW4+IPVj9/ltGJit+W3cdrzkL81bwoH7moyOeADUqBsrA0sUXHmmaBxE82VPArCnLe
         dWppEQWlDPfnLfd6RfNejNHnmy3aY51TdbXA9Z1tEjcflEv2ClttI/aL+phUH9omI8Sc
         Jybke8KV0qD075AsZ/x/q8rHP7uZ2fOOJosa09ZYKydbFk2kVyLEzAhsjhj5hplTHx6v
         BSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYnqAJxLP5xeXIRytYPZfWDqlK46jI3gXiWpLyXsB+I=;
        b=lXIx+zM2IfOu+BHILQuD8jprio3ybmAuK183JvBtq8Fb1okdcYeACZWKJO84MdFXSJ
         2tjSasod14Dl8KkEmqzlJx1jT+b0ah8dUImd6ii17Hgwa7HbqCkx5xb6lkPH8g63qzj3
         Yoeks2OaqrIJUxASKWGG01vF8m1GbfM7TFcNPmfH7Adyq+r+6I0xi9r9qFJKo/WGV2oT
         KsxtmqfOFRrAktu48FGP3t4DmHZL6rnN18ko/Cnf+saCb08V1qonEM44ZX/g0G2BnRjo
         Xw42c90IZ9ZJFJLq/OgmifJ3W0sflqyIS+GPl8SUy69+ZW205K00lZlJ9Aw9PTTaA4S0
         47zg==
X-Gm-Message-State: AGi0Pua4BFKhsyIKASTCHzGlnJG3tg5hCbvTShXVdgZnfyPlf4GgqKBv
        4M6UDqUT1epz5BNIV4W342Y5FSRGoR1YF0NdZNlsbbUwnE8=
X-Google-Smtp-Source: APiQypKnSBu3xUwQOeoCRRG+MZCOJ7qDFU0qP4Qg0E2cq9Y7ZwpHa6b8zQag6pEcKiUGCHlw8zGca2NOn3WY6ySuKAM=
X-Received: by 2002:a67:b60c:: with SMTP id d12mr15877019vsm.196.1585754497152;
 Wed, 01 Apr 2020 08:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAB00BMjPSg2wdq7pjt=AwmcDmr0ep2+Xr0EAy6CNnVhOsWk8pg@mail.gmail.com>
 <058b3f48-e69d-2783-8e08-693ad27693f6@youngman.org.uk> <CAB00BMgYmi+4XvdmJDWjQ8qGWa9m0mqj7yvrK3QSNH9SzYjypw@mail.gmail.com>
 <1d6b3e00-e7dd-1b19-1379-afe665169d44@turmel.org> <CAB00BMg50zcerSLHShSjoOcaJ0JQSi2aSqTFfU2eQQrT12-qEg@mail.gmail.com>
 <e77280ef-a5ac-f2d8-332c-dec032ddc842@turmel.org> <CAB00BMj5kihqwOY-FOXv-tqG1b2reMnUVkdmB9uyNAeE7ESasw@mail.gmail.com>
 <061b695a-2406-fc00-dd6d-9198b85f3b1b@turmel.org> <CAB00BMi3zhfVGpeE_AyyKiu1=MY2icYgfey0J3GeO8z9ZDAQbg@mail.gmail.com>
 <5E8485DA.2050803@youngman.org.uk> <9a303b9b-52b8-f0c6-4288-120338c6572f@turmel.org>
In-Reply-To: <9a303b9b-52b8-f0c6-4288-120338c6572f@turmel.org>
From:   Daniel Jones <dj@iowni.com>
Date:   Wed, 1 Apr 2020 09:21:25 -0600
Message-ID: <CAB00BMig177NjEbBQgfjQ5gZE3QPTR-B6FD9i8oczHqf7mMqcg@mail.gmail.com>
Subject: Re: Requesting assistance recovering RAID-5 array
To:     Phil Turmel <philip@turmel.org>
Cc:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Phil, Wols,

(Sorry for the top-post in my last reply).

I'm working through everything Phil recommended.  I am also using
overlays exactly as documented on the
"Irreversible_mdadm_failure_recovery" wiki.  Things look very
favorable so far.

A quick question on what I'm doing?

As per Phil's suggestion to put the array inside partitions, I have
created partitions inside each of /dev/mapper/sd[bcde].  The gdisk
operations end with the message:

  Warning: The kernel is still using the old partition table.
  The new table will be used at the next reboot.
  The operation has completed successfully.

My question is how to get the kernel to recognize the
/dev/mapper/sd[bcde]1 partitions I have created?  Rebooting doesn't do
anything as the overlay loop files aren't something that gets
recognized during boot.

Thanks,
DJ
