Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C08F19A404
	for <lists+linux-raid@lfdr.de>; Wed,  1 Apr 2020 05:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbgDADjY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 31 Mar 2020 23:39:24 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:46854 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbgDADjY (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 31 Mar 2020 23:39:24 -0400
Received: by mail-vk1-f196.google.com with SMTP id s139so6318311vka.13
        for <linux-raid@vger.kernel.org>; Tue, 31 Mar 2020 20:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iowni-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScgeZs79CnODw9wKydqlsChEjTt4DXLvL8htTV02MaY=;
        b=coHomDecpvO7HzxDviL7H0p8LlKed3QMu8tphshkFh0w4Lc7f1wO7alk2Vx5UOOaal
         claiqEg4CvcXjSsQiCQLhvNMgFE9ViJYvagIfvb1jaYNlyoM/EaLNehbOFUlyvb+LqsR
         7JrXN7lJmGqXXukYO1I6NIMSMM0lQv8nuNIPzli5IM3HH/QDTmi4j3M+6v1tZk/iYv9U
         u+fHAuc52nYbMiMfZ1D+lPE8D2q32wrgjt3hmwLq0Bg4eQyHqXGE5n5M+dqtgcHwf2el
         qpMNTFKyMMvd7T3+HbmN1cbVFBRl41wJLpltOaVOrdukPzLemkI689cjhgT34dt9PKuG
         ieBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScgeZs79CnODw9wKydqlsChEjTt4DXLvL8htTV02MaY=;
        b=DSTd2Jpvp3DmWbavy4lP+IezeISCPZV7VdjZHH74QAEORlqQlHrwtdz3csmrjxpI1h
         VrFxOLhVMtCxEmdEJq8IWL7I7mxYcsUkxOta4lSkpGe3W5GZ1ItOfdsXmX+/Zt9p8V/O
         DuAI5VMNOfKQjWrbs1QSOBUmsMKEQif0qkXUsrIp+ELPXf2ZM1uDfFRK1x2IZ+gmCp+P
         ARznmDkb0GaVISC2lSLcwahcoFdB7s2JHPDj5DSJlFO2273rd6TnKeYTw8ARqieQQbUS
         x4IFsFX/NSWzuBGuAosli02xYHQ7fL7UUis9ytDYZld9Mwkhaxt/tkMk9PjHGJpUbS/5
         P59A==
X-Gm-Message-State: AGi0PuaAvNTFbuUKmCZ/fajuqlNuwVmsDBJa89iaPL0e2Q3AhNy5NsIP
        4cHKDpKZhxBXCme86DjjWX1Q7op+aNTd6wpvordOY56u
X-Google-Smtp-Source: APiQypIZwmWJwWQA6KSAnyQ6k0nYKeTTt6LEwbmimE+SjeUDctzvcBbJy0IU+Qo2wIIouPVo6dOcAzYCeI8zzHMbPPs=
X-Received: by 2002:ac5:c911:: with SMTP id t17mr14335478vkl.81.1585712362438;
 Tue, 31 Mar 2020 20:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAB00BMjPSg2wdq7pjt=AwmcDmr0ep2+Xr0EAy6CNnVhOsWk8pg@mail.gmail.com>
 <058b3f48-e69d-2783-8e08-693ad27693f6@youngman.org.uk> <CAB00BMgYmi+4XvdmJDWjQ8qGWa9m0mqj7yvrK3QSNH9SzYjypw@mail.gmail.com>
 <1d6b3e00-e7dd-1b19-1379-afe665169d44@turmel.org> <CAB00BMg50zcerSLHShSjoOcaJ0JQSi2aSqTFfU2eQQrT12-qEg@mail.gmail.com>
 <e77280ef-a5ac-f2d8-332c-dec032ddc842@turmel.org>
In-Reply-To: <e77280ef-a5ac-f2d8-332c-dec032ddc842@turmel.org>
From:   Daniel Jones <dj@iowni.com>
Date:   Tue, 31 Mar 2020 21:39:11 -0600
Message-ID: <CAB00BMj5kihqwOY-FOXv-tqG1b2reMnUVkdmB9uyNAeE7ESasw@mail.gmail.com>
Subject: Re: Requesting assistance recovering RAID-5 array
To:     Phil Turmel <philip@turmel.org>
Cc:     antlists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello Phil, et al.,

Phil, after reading through your email I have some questions.

> The array had bad block logging turned on.  We won't re-enable this
> mis-feature.  It is default, so you must turn it off in your --create.

Am I able to turn off during --create?  The man page for mdadm on my
system (mdadm - v4.1 - 2018-10-01) suggests that --update=no-bbl can
be used for --assemble and --manage but doesn't list it for --create.

> However, the one we know appears to be the typical you'd get from
> one reshape after a modern default creation (262144).

> You'll have to test four combinations: all at 261124 plus one at a
> time at 262144.

I'm confused by the offsets. The one remaining superblock I have
reports "Data Offset : 261120 sectors".  Your email mentions 261124
and 262144. I don't understand how these three values are related?

I think it is most likely that my one existing superblock with 261120
is one of the original three drives and not the fourth drive that was
added later.  (Based on the position in drive bay).

So possible offsets (I'm still not clear on this) could be:

a) all 261120
b) all 261124
c) all 262144
d) three at 261120, one at 262144
e) three at 261120, one at 261124
f) three at 261124, one at 261120
g) three at 261124, one at 262144
h) three at 262144, one at 261120
i) three at 262144, one at 261124

( this ignores the combinations of not knowing which drive gets the
oddball offset )
( this also ignores for now the offsets of 259076 and 260100 mentioned below )

> 2) Member order for the other drives.  Three drives taken three at a
> time is six combinations.
>
> 3) Identity of the first drive kicked out. (Or do we know?)  If not
> known, there's four more combinations: whether to leave out or one of
> three left out.

Can I make any tentative conclusions from this information:

  Device Role : Active device 1
  Array State : .AAA ('A' == active, '.' == missing, 'R' == replacing)

I know /dev/sde is the device that didn't initially respond to BIOS
and suspect it is the "missing" drive from my superblock.

I know that /dev/sdc is the drive with a working superblock that
reports itself as "Active device 1".

I don't know how mdadm counts things (starting at 0 or starting at 1,
left to right or right to left, including or excluding the missing
drive).

Would it be reasonable for a first guess that:

.AAA = sde sdd sdc sdb  (assuming the order is missing, active 0,
active 1, active 2) ?

Procedure questions:

If I understand all the above, attempted recovery is going to be along
the lines of:

mdadm --create /dev/md0 --force --assume-clean --readonly
--data-offset=261120 --chunk=512K --level=5 --raid-devices=4 missing
/dev/sdd /dev/sdc /dev/sdb
fsck -n /dev/md0

Subject to:
Don't know if --force is desirable in this case?
Might need to try different offsets from above.  Don't know how to set
offsets if they are different per drive.
Should I start with guessing "missing" for 1 or should I start with all 4?
Might need to try all device orders.

> Start by creating partitions on all devices, preferably at 2048 sectors.
> (Should be the default offered.)  Use data offsets 259076 and 260100
> instead of 261124 and 262144.

If I understand, this is an alternative to recreating the whole-disk
mdadm containing one partition. Instead it would involve creating new
partition tables on each physical drive, creating one partition per
table, writing superblocks to the new /dev/sd[bcde]1 with offsets
adjusted by either 2044 or 2048 sectors, and then doing the fsck on
the assembled RAID.

I think the advantage proposed here is that it prevents this
"automated superblock overwrite" from happening again if/when I try
the motherboard upgrade, but the risk I'm not comfortable with yet is
going beyond "do the minimum to get it working again". Although it
isn't practical for me to do a dd full backup of these drives, if I
can get the array mounted again I can copy off the most important data
before doing a grander repartitioning.

Can you advise on any of the above?

Thanks,
DJ
