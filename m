Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9818919DDF4
	for <lists+linux-raid@lfdr.de>; Fri,  3 Apr 2020 20:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391138AbgDCSaK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 3 Apr 2020 14:30:10 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38304 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgDCSaJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 3 Apr 2020 14:30:09 -0400
Received: by mail-ua1-f67.google.com with SMTP id g10so3107090uae.5
        for <linux-raid@vger.kernel.org>; Fri, 03 Apr 2020 11:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iowni-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JC99XsHcSDC6PBQia+kRhr/6VvEmIAhMQXm5lPOmxZM=;
        b=TjzON+gUSyyzGA02O3oxjCK3qAUf7sA2u/MT1zPmwagLt9bPAoRBhwPqIvpLW4SHab
         1yJGfWSJlt4vzQ1Y33JxIQ2z4CynuS3e78HJxw0M2gC2JjzPk9mg/QRvJrDFAqIhP/KC
         yQ+9oVprO5rjxkwdVj94L791ph8EAwfw6nVeYrBtWssYwgLO0uc3rAHoed2E6olAMapF
         p8RUs18cVZVJcUiNLtvkDN8zeWQ+Lcdb5Z+AnQPf+71aaYLkTm4vn5M/p002RK+KzcZh
         rhqBQeq4bFwAvPhx7ZzavGClAaJEIgMhv1GdqsaVZcnRykUc/PvIl2U68r6f0hHobeye
         6VTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JC99XsHcSDC6PBQia+kRhr/6VvEmIAhMQXm5lPOmxZM=;
        b=nig1FeMw3xCJn3JKncWJfzUPMmGNpOaFmpfS+TC0mwoLk09h0//3cYB0FMFLYMWpY/
         dSLPERtXxHtzyRCj6shsTsik4/u8Z/VJNNWGgH9DLDB8/2A0OMuSkHGSx/S18jMBNI5P
         B4f0FBnE2luIeoqDH56/Ql7bzhcRBA6RZHGdEbeUmfXqgqgf+/KxegLguz6asUtZHyOl
         GL8Wgbh+mfWJuQzwX79FemIjpl/QXAqAM1paN0Of9Z00lYe5ymY4r/2cjRvlRWiron8s
         oZhXJcoE4nJJOhCctRetyQfNyJ24bOeu3FkxhLE9UHitltAU4EUQ7/a9v05wD8m7nzmA
         YCDg==
X-Gm-Message-State: AGi0PubdnIKezHen3txrJrK0Y4pJWrpmDjLjxCxun+tITo6pCSzcAk3N
        TjpuqZQOG1/w5hzT08PNKdVzzYs31LdmU0SoDuX5CIxAIm4=
X-Google-Smtp-Source: APiQypKor1P7psR3vC+bOGfpKZdZCLU20+UZdvaZNYM5uZYJfeRIxTy9lbckhjyFPOvBZalY3eAQ94YTs9JQzuawrqs=
X-Received: by 2002:ab0:6850:: with SMTP id a16mr8008213uas.43.1585938608716;
 Fri, 03 Apr 2020 11:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAB00BMjPSg2wdq7pjt=AwmcDmr0ep2+Xr0EAy6CNnVhOsWk8pg@mail.gmail.com>
 <058b3f48-e69d-2783-8e08-693ad27693f6@youngman.org.uk> <CAB00BMgYmi+4XvdmJDWjQ8qGWa9m0mqj7yvrK3QSNH9SzYjypw@mail.gmail.com>
 <1d6b3e00-e7dd-1b19-1379-afe665169d44@turmel.org> <CAB00BMg50zcerSLHShSjoOcaJ0JQSi2aSqTFfU2eQQrT12-qEg@mail.gmail.com>
 <e77280ef-a5ac-f2d8-332c-dec032ddc842@turmel.org> <CAB00BMj5kihqwOY-FOXv-tqG1b2reMnUVkdmB9uyNAeE7ESasw@mail.gmail.com>
 <061b695a-2406-fc00-dd6d-9198b85f3b1b@turmel.org> <CAB00BMi3zhfVGpeE_AyyKiu1=MY2icYgfey0J3GeO8z9ZDAQbg@mail.gmail.com>
 <5E8485DA.2050803@youngman.org.uk> <9a303b9b-52b8-f0c6-4288-120338c6572f@turmel.org>
 <CAB00BMig177NjEbBQgfjQ5gZE3QPTR-B6FD9i8oczHqf7mMqcg@mail.gmail.com>
 <1f4b8c74-4c38-6ea4-6868-b28f9e5c4a10@turmel.org> <e75f80f4-70d4-e283-b3bc-c78bd0d55a8a@turmel.org>
 <CAB00BMhU76rjvQv9v-HxM8Harc9ssLBANWfPsW9abbSRNgwoUQ@mail.gmail.com> <bb554b86-3dc0-8cb2-c279-f8841742195c@turmel.org>
In-Reply-To: <bb554b86-3dc0-8cb2-c279-f8841742195c@turmel.org>
From:   Daniel Jones <dj@iowni.com>
Date:   Fri, 3 Apr 2020 12:29:56 -0600
Message-ID: <CAB00BMgwCbtGYJ_hX3_rZv3uaOd7vrHuEebqsPLHp3S96tJaRw@mail.gmail.com>
Subject: Re: Requesting assistance recovering RAID-5 array
To:     Phil Turmel <philip@turmel.org>
Cc:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello again,

> Don't do the --add operation until you've copied anything critical in the array to external backups (while running with 3 of 4).

Everything from the array has been backed up elsewhere.

Up until now the only writes intentionally done to the physical drives
have been the new partition tables.  Everything else has been through
the overlay.

Now I think I'm ready to run a --create as follows on the physical drives:
mdadm --create /dev/md0 --assume-clean --data-offset=129536 --level=5
--chunk=512K --raid-devices=4 missing /dev/sdc1 /dev/sdd1 /dev/sde1

After that I'd try to re-add the rejected drive?
mdadm --manage /dev/md0 --add /dev/sdb1

Part of me wonders about just rebuilding the whole thing and then
copying the data back, but I don't know that would be any better then
this path.

Thanks,
DJ
