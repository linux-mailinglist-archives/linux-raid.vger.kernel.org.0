Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7662120641D
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jun 2020 23:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390587AbgFWVQZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Jun 2020 17:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390781AbgFWU1i (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 23 Jun 2020 16:27:38 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B24C061573
        for <linux-raid@vger.kernel.org>; Tue, 23 Jun 2020 13:27:37 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id i74so19983698oib.0
        for <linux-raid@vger.kernel.org>; Tue, 23 Jun 2020 13:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OqYG6ZouDCf7QGv56qoShOStLRNeFFY6nOKOBeMJ3wo=;
        b=eOQMtFy+jbV85tVtJmH1nnVoz+PqoLcJEtglnmkILWvlGl9vroyXnTHYbBsHaI2FYL
         y/N+fWGqWfnGVZ2u8NJl8EJhKMJcm5qq7rSRGk2f5T5nDY4zuD/rqYlbmi3y1Il2GMBp
         JQDnmBO9ogapeVgtNkt2jZplahyiL1rj3Hze+b2cHmQJB/xo8myvltFnhxAjHB/p1kHd
         9ZSF0srRvJvw61wYeb4hJbt96NptdWD52WQ6AGQGMBkXESPMELtri1XyyN7NKK/uHAVj
         h3NptT0CSFSIIPYBhfLp1lOFMOmquxuNw72g5ChFOF4PjIBCOXlIKzUK00BfylaqvAxz
         /Ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OqYG6ZouDCf7QGv56qoShOStLRNeFFY6nOKOBeMJ3wo=;
        b=hKZ+uALzYu7PvaKnXT5lh4tMaVQPA1rC5Pc+2dCm86hPL41M3gZV5YkcbOrS2lOfDt
         EgqGFRxbGrEH+BtOut9d24HpfQ2w6naniUnqWCPLmit03dfF5DydFhw4rufRO52QI4wg
         +/Po8GyOoabfV5YRlCkAtLH9fvXq3YNJC0o+5UOoV9Ttdh83IxnSBlO1jbaUw3m3xh+g
         Z+/b1b7dewr+1b4jquabEkCrHiqwvfoScqSMb3mVZV5CdV3vFg446B6swO/jYRNOiOLE
         ih+BR8THMz01EyUfnRcCDO/8XnSDR+A5FKyT/pamh5NYJAULEcYpneEKrTnc41PIfCoP
         Kb9A==
X-Gm-Message-State: AOAM5320vOyfKQo10ZO6pZwaq8ZfFVh42ihUg9MA4Y/c0exFVmEvSqGI
        JSgMPsECEJRBofTrrcoMSTB/Oex3
X-Google-Smtp-Source: ABdhPJz7eekRVWCv4FacW6fG+F0KMiFTfNEtcv278/DZAWdWWyBX0KfwBDEzEE95koDTbgY69bhcpA==
X-Received: by 2002:aca:aa8d:: with SMTP id t135mr3517245oie.75.1592944056918;
        Tue, 23 Jun 2020 13:27:36 -0700 (PDT)
Received: from ian.penurio.us ([2605:6000:8c8b:a4fa:222:4dff:fe4f:c7ed])
        by smtp.gmail.com with ESMTPSA id h10sm1490074ooe.44.2020.06.23.13.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 13:27:36 -0700 (PDT)
Subject: Re: RAID types & chunks sizes for new NAS drives
To:     John Stoffel <john@stoffel.org>
Cc:     linux-raid@vger.kernel.org
References: <rco1i8$1l34$1@ciao.gmane.io>
 <24305.24232.459249.386799@quad.stoffel.home>
From:   Ian Pilcher <arequipeno@gmail.com>
Message-ID: <1ba7c1be-4cb1-29a5-d49c-bb26380ceb90@gmail.com>
Date:   Tue, 23 Jun 2020 15:27:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <24305.24232.459249.386799@quad.stoffel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/22/20 8:45 PM, John Stoffel wrote:
> This is a terrible idea.  Just think about how there is just one head
> per disk, and it takes a signifigant amount of time to seek from track
> to track, and then add in rotational latecy.  This all adds up.
> 
> So now create multiple seperate RAIDS across all these disks, with
> competing seek patterns, and you're just going to thrash you disks.

Hmm.  Does that answer change if those partition-based RAID devices
(of the same RAID level/settings) are combined into LVM volume groups?

I think it does, as the physical layout of the data on the disks will
end up pretty much identical, so the drive heads won't go unnecessarily
skittering between partitions.

> Sorta kinda maybe... In either case, you only get 1 drive more space
> with RAID 6 vs RAID10.  You can suffer any two disk failure, while
> RAID10 is limited to one half of each pair.  It's a tradeoff.

Yeah.  For some reason I had it in my head that RAID 10 could survive a
double failure.  Not sure how I got that idea.  As you mention, the only
way to get close to that would be to do a 4-drive/partition RAID 10 with
a hot-spare.  Which would actually give me a reason for the partitioned
setup, as I would want to try to avoid a 4TB or 8TB rebuild.  (My new
drives are 8TB Seagate Ironwolfs.)

> Look at the recent Arstechnica article on RAID levels and
> performance.  It's an eye opener.

I assume that you're referring to this?

 
https://arstechnica.com/information-technology/2020/04/understanding-raid-how-performance-scales-from-one-disk-to-eight/

There's nothing really new in there.  Parity RAID sucks.  If you can't
afford 3-legged mirrors, just go home, etc., etc.

> I don't think larger chunk sizes really make all that much difference,
> especially with your plan to use multiple partitions.

 From what I understand about "parity RAID" (RAID-5, RAID-6, and exotic
variants thereof), one wants a smaller stripe size if one is doing
smaller writes (to minimize RMW cycles), but larger chunks increase the
speed of multiple concurrent sequential readers.

> You also don't say how *big* your disks will be, and if your 5 bay NAS
> box can even split like that, and if it has the CPU to handle that.
> Is it an NFS connection to the rest of your systems?

The disks are 8TB Seagate Ironwolf drives.  This is my home NAS, so it
need to handle all sorts of different workloads - everything from media
serving acting as an iSCSI target for test VMs.

It runs NFS, Samba, iSCSI, various media servers, Apache, etc.  The
good news is that there isn't really any performance requirement (other
than my own level of patience).  I basically just want to avoid
handicapping the performance of the NAS with a pathological setting
(such as putting VM root disks on a RAID-6 device with a large chunk
size perhaps?).

> Honestly, I'd just setup two RAID1 mirrors with a single hot spare,
> then use LVM on top to build the volumes you need.  With 8tb disks,
> this only gives you 16Tb of space, but you get performance, quicker
> rebuild speed if there's a problem with a disk, and simpler
> management.

I'm not willing to give up that much space *and* give up tolerance
against double-failures.  Having come to my senses on what RAID-10
can and can't do, I'll probably be doing RAID-6 everywhere, possibly
with a couple of different chunk sizes.

> With only five drives, you are limited in what you can do.  Now if you
> could add a pair of mirror SSDs for caching, then I'd be more into
> building a single large RAID6 backing device for media content, then
> use the mirrored SSDs as a cache for a smaller block of day to day
> storage.

No space for any SSDs unfortunately.

Thanks for the feedback!

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================
