Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41645AAAB7
	for <lists+linux-raid@lfdr.de>; Thu,  5 Sep 2019 20:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388968AbfIESTd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 5 Sep 2019 14:19:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35234 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388847AbfIESTd (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 5 Sep 2019 14:19:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id g7so3914383wrx.2
        for <linux-raid@vger.kernel.org>; Thu, 05 Sep 2019 11:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=exd2YvDoi9oo70/NI/+i7fCJSjs2dcBIYeLYSQXfCys=;
        b=YwQrZZQCQbTTrxYpBkKn3Q0UHT1qEW7vsVtHLNxnewZhkGdHefv9+z7BPLEkMD8wZw
         eDQKqA7VrCa4VihHfDnCDbQDzOPMFbtYFcEFyfa4+hAFpwuB+K+bOWrRAinnYU99caLI
         CzluhfmUrpVAgLz7+NfyuZg08aE3i5hkPK8OpTCIdlVfDzcuhu9FPHZWO2QbCVMtEY1y
         pI/5UoAFq0OqedpcexwlWOGQ9kPCdZL3woPfKJ5cmW0aXVGbWGun3V6zWqivfE6bSX1S
         V4QbQGJq4ENGA+T7QHIZ5hwKAKEORvP9U99jit73O22OBV3Gx6rneUCDoUgPtz3B8KK2
         /41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=exd2YvDoi9oo70/NI/+i7fCJSjs2dcBIYeLYSQXfCys=;
        b=UR1cemMpq7+b4slLO0rZV686GuMf1OmQzbHZdOzUN430hw/FN0mv74SZh4hcycVor7
         ++0UYjdNKM7GmQVPw6Mh/l9h7ydPjKIph+1n76Dv++YDO8tKNNJnv5QK9IznC7KqvJUL
         DZLBIB1qWO3NG0BNZQfGg7BL3iyRIqYa6IfV6mQ2/DRaZUQ9G45bQ+GyO6aiPnz296zR
         ts0I0/lRLhCC4aDJm7PWcGa2keCNqBuNxU3YaLMYJgYYV6pbt+xfAiRELkvVviILlANk
         IPHrwmNluHDT/ijQ/NsC1fXNNFvRuh61zCUa3oVOcLJnco4ED3gpNWY9paxKMHNo1pOG
         rfBQ==
X-Gm-Message-State: APjAAAXNNC1zbR3XPk0C7iKDeZJ83188PDrQInrpqTp6TjOMbR1emzYO
        RuRcAgUdhsut3LFInZBf7iwkKOAV11rY4af10yG6GHCBBmQ=
X-Google-Smtp-Source: APXvYqyKwa0vSZCjUkYlyPipXfEv2ir/K+hkSqmG6Kk+Ybvb+WhgWj9DGrx3vk5JCy7J2qKWqR3WsOJUIgMYNEWYPnc=
X-Received: by 2002:adf:e390:: with SMTP id e16mr3964901wrm.29.1567707571031;
 Thu, 05 Sep 2019 11:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <9dd94796-4398-55c5-b4b6-4adfa2b88901@redhat.com>
 <fc3391a1-2337-4f9a-1f09-8a0882000084@redhat.com> <7429a69e-0b27-53de-2ad8-01d8ebbc2bb4@redhat.com>
 <20190905160512.GA17672@cthulhu.home.robinhill.me.uk>
In-Reply-To: <20190905160512.GA17672@cthulhu.home.robinhill.me.uk>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 5 Sep 2019 12:19:19 -0600
Message-ID: <CAJCQCtTiJS437Dc9FOiYNKr-=MX7xHabX-G0O=2TbgqR5nz+uw@mail.gmail.com>
Subject: Re: raid6 with dm-integrity should not cause device to fail
To:     Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Sep 5, 2019 at 10:15 AM Robin Hill <robin@robinhill.me.uk> wrote:
>
>
> I'm not clear what you (or the author of the article) are expecting
> here. You've got a disk (or disks) with thousands of read errors -
> whether these are dm-integrity mismatches or disk-level read errors
> doesn't matter - the disk is toast and needs replacing ASAP (or it's in
> an environment where it - and you - probably shouldn't be).

That sounds to me like a policy question. The kernel code should be
able to handle the errors, including even rate limiting if the errors
are massive. It's a policy question whether X number errors per unit
time, or Y:Z ratio bad to good sectors have been read, is the limit.
And it's reasonable for md developers to pick a sane default for that
policy. But to just say 1000's of corruptions are inherently a device
failure, when easily 1 million more in the same time frame are good?
You'd be giving up a better chance of recovery during rebuilds/device
replacements by flat out ejecting such a device. Also the device could
be network. It could be transient. Or the problem discovered and fixed
way before the device is ejected, and manually readded and rebuilt.


> Admittedly, with dm-integrity we can probably trust that anything read
> from the disk which makes it past the integrity check is valid, so there
> may be cases where the data on there is needed to complete a stripe.
> That seems a rather theoretical and contrived circumstance though - in
> most cases you're better just kicking the drive from the array so the
> admin knows that it needs replacing.

I don't agree that a heavy hammer is needed in order to send a notification.


-- 
Chris Murphy
