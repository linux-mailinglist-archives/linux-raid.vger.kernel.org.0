Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8BA21552A8
	for <lists+linux-raid@lfdr.de>; Fri,  7 Feb 2020 08:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgBGHC0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 7 Feb 2020 02:02:26 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:36352 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGHC0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 7 Feb 2020 02:02:26 -0500
Received: by mail-ot1-f53.google.com with SMTP id j20so1207993otq.3
        for <linux-raid@vger.kernel.org>; Thu, 06 Feb 2020 23:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=nWUSemmhI0Dos8BVNnLLcoGgqYS6Rb4rb0zp7j9jXtM=;
        b=X/MZudj9ZVtrgzvOAyn1gxaoG43pz+MeeRUMsT/fmfjqeI48AIDfBKM7SIAcvDHjpH
         zXZ7BOnQKAgpVEGle/rzNiDS2Ngp+G7UD1NxYeH18pfQ4Ea9O81/70VVHQErdV59/kWV
         5BY9bXn8LnjR3crBAJeDsfA42jggSLmuGhdT+JPZZBZZ2/uWHRgL4oE163V3V+tPpxM5
         2ft0DeAQlu7/bHJgdGtkwujkOB9gSzrQGmVyvG6jDG5aIPt1tExsl/3ANGgT6pzD3t7v
         Qr+Kkatm7VQE03HMK+8fxFyW9diKO2k6X2pzRolBWgWJlyZ5sJxkaKYBMMUvstV3Z2vn
         6SFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nWUSemmhI0Dos8BVNnLLcoGgqYS6Rb4rb0zp7j9jXtM=;
        b=XkI6qeJIvPXzOhHDadMZAkaqeOMDdsid9Abdqhe0GflyJgbqzu5o8g1ZhNoVOKBN7H
         rXpN6Vr0JYXe7UJ/QtrY5FxLr2iSmNqzqLQm4jGiti+xB9mODeagUC7R8BhMVzSUSLRN
         o3ikNGmY14CqSiqiLNoIRiuNmkJHYsrZQoXau3syn9n6uLfY0da1u1LTFvU47v77bmwH
         gW4qdp+CKN70oRkXbqOhYmz+KrNntHUKAeYz0dKtsHZmrcMOmj6e5IV567qiqN/bsb9g
         ugOUec/6+R+ZNi75rCVqdB0toRRGMdSDgXO8ccaWrWLFno4oa5epUrUXW6VcOrj3qB/f
         RhFw==
X-Gm-Message-State: APjAAAXE3xqrsf/yeQfjT6BSd4ZTmLUbJ1fdbLlaqh0FcG8d2wvVZeII
        DeX+ZOTmLxiJFBGb25eqxpI6j/Oc
X-Google-Smtp-Source: APXvYqwsboO+btGY9STm7gKq1D2fiUaws27DhCa4wdiox6Sj7oaO8JVgVp+gRgsCaHQ+6lgYtvwEyA==
X-Received: by 2002:a05:6830:1317:: with SMTP id p23mr1590320otq.3.1581058945169;
        Thu, 06 Feb 2020 23:02:25 -0800 (PST)
Received: from [192.168.3.59] ([47.187.193.82])
        by smtp.googlemail.com with ESMTPSA id w201sm765266oif.29.2020.02.06.23.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 23:02:24 -0800 (PST)
Subject: Re: Is it possible to break one full RAID-1 to two degraded RAID-1?
To:     Wols Lists <antlists@youngman.org.uk>,
        Reindl Harald <h.reindl@thelounge.net>,
        Linux Raid <linux-raid@vger.kernel.org>
References: <1120831b-13e6-6a5d-8908-ee6a312e7302@gmail.com>
 <aa41492c-1ad7-070f-9bc6-646977364758@thelounge.net>
 <2c4fedff-a1c9-6ca3-5385-72b542a4a0b4@gmail.com>
 <551449ed-49f9-e567-09d3-981f4cf9eea9@thelounge.net>
 <5E32855D.3020906@youngman.org.uk>
From:   Ram Ramesh <rramesh2400@gmail.com>
Message-ID: <0c70c04f-d8d0-0c44-e603-46c101b21cc1@gmail.com>
Date:   Fri, 7 Feb 2020 01:02:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5E32855D.3020906@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I got no response on this and want to take a shot before going the 
backup way.

Assuming (hda1 and hdb1 in raid1 md0) Will the following work?

 1. Fail and remove hdb1
 2. Create new RAID1 md1 with hdb1 and missing
 3. dd md0 onto md1
 4. Make both bootable. (I suppose I need to change UUID of md1
    partitions. I suppose that is easy)
 5. Boot both and double check
 6. Now upgrade md0 without fear.
 7. Boot and test the new system for a couple of days to make sure
    everything is fine.
 8. If that fails, delete md0, and add hda1 to md1. If not delete md1
    and add hdb1 to md0

Regards
Ramesh

On 1/30/20 1:27 AM, Wols Lists wrote:
> On 30/01/20 06:30, Reindl Harald wrote:
>>> Thanks. I thought of this, but both disk in question are nvme ssd with
>>>> manually added heat sink. It will be a hassle to remove and reinstall. I
>>>> think I will go with the back up rather than remove disk physically.
>> why would you remove it phyiscally to remove it rom the array? seriously?
> Because if you physically remove it, BOTH disks will think they are the
> surviving copy. You could "assemble" either disk on its own and recover
> the array.
>
> But if you remove a disk with --fail --remove, does that tamper with the
> superblock? Would that prevent that disk being re-assembled on its own?
> Seriously. I don't know. And were I in the OP's shoes I would be asking
> the same question.
>
> This is where you want something COW in the stack. Lvm. Btrfs. Where you
> can just take a snapshot, upgrade the system, and if it all goes
> pear-shaped you throw the snapshot away.
>
> Cheers,
> Wol

