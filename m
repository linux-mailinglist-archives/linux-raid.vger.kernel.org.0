Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 470B946D56
	for <lists+linux-raid@lfdr.de>; Sat, 15 Jun 2019 02:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfFOA6R (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 14 Jun 2019 20:58:17 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:37251 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFOA6R (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 14 Jun 2019 20:58:17 -0400
Received: by mail-oi1-f171.google.com with SMTP id t76so3262932oih.4
        for <linux-raid@vger.kernel.org>; Fri, 14 Jun 2019 17:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=8qtHbfGqagPpu/EhB3lIGnW2gBCn0xg8KzTmlVv0v90=;
        b=Q4r7I0PVqaKIkSNblit0Z+j4b9ueYLuyij+3xoNOS9Y33hFDhgNUAH2dGOmjFpe4p7
         1NDWYaAdT/yn96PD67eRnmL2Us9qWHPPnbIcuThMzQAJOty7Nd/+9O0kMwkZPAsPdrKN
         9N6PN4FRuq748SLWUNqZvRc9kj+R89xnnj89HSNwzQiGSnNDNkzUXDMkKLh6m+k48c3U
         N8TBtYhG3eKdOa1xDxBsst1ujbD6Ln1AW0pho/MB5XC9mGxupu6Z6JkIqd5yqrFunqXP
         SH9Y6MqGY5X1XUBTN9JxmNqeNAygV5S5Wbyooeb6tLEh9sTbyZzafE7hP/Cjsq/CTiGv
         nr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
         :subject:date:message-id:mime-version:content-transfer-encoding
         :thread-index:content-language;
        bh=8qtHbfGqagPpu/EhB3lIGnW2gBCn0xg8KzTmlVv0v90=;
        b=UgsAyxPB0wkf85dPtAR8Y5I5jEWLXJ4AOQ3yhaOhav4jkfEyt/XCFUJO/063kM1AzH
         AQdQS7bMvyE8QKqsqyswYXmw54ga/vtyKEbxPG6hJRZqaKP//7Fq6q1bTMfBVUUwgbA5
         BPX05RyO9ygxeDgFScXEbudbTBDF4Vx1p/LQZMvZm0AAcH0XNeXqjCR6wJIvPUHmNOQa
         AjBjmOj2UST0NaevyFIvm1/IMqLJEbTMzrtshuSW4/soOQqSnnOnSVxAYK+FQaouRLBO
         IXVT/VmyFpbOjBlSlZ2/Ty9lHU29VLw/niUyfR/fc+6uZz5g+Jd7Zk7I8XjmVApXCqd7
         PrHw==
X-Gm-Message-State: APjAAAUtdaxmMjK5yWcFTHNndNu95BQGZWtktyNQZbUKOVJqcNuBOQPB
        xMWzA6meryAwor6rqKnYasiZLqmL
X-Google-Smtp-Source: APXvYqxbyUBJmIBASYSHBZhAEtUZrTrLExbbtr/xacHfffuF+NFlYFH28GqppOrbE6aI/xeZ8kaW3g==
X-Received: by 2002:aca:c690:: with SMTP id w138mr3471991oif.178.1560560295908;
        Fri, 14 Jun 2019 17:58:15 -0700 (PDT)
Received: from VELDA1 ([216.163.20.84])
        by smtp.gmail.com with ESMTPSA id 93sm1971477ota.77.2019.06.14.17.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 17:58:14 -0700 (PDT)
From:   Colt Boyd <coltboyd@gmail.com>
X-Google-Original-From: "Colt Boyd" <ColtBoyd@Gmail.com>
Reply-To: <ColtBoyd@Gmail.com>
To:     "'Andreas Klauer'" <Andreas.Klauer@metamorpher.de>
Cc:     <linux-raid@vger.kernel.org>
References: <CANrzNyh-dSfxGojcQqdg+FeycdvPEfH_0qJwYFQCFcVeKGgMhQ@mail.gmail.com> <20190611141621.GA16779@metamorpher.de> <CANrzNyiCF3Fhn30pJ_hWVcGyvaMrRBLAWkPD8o4+TpCDSWTkHw@mail.gmail.com> <CANrzNyiQQ1BFV87CRi7gE3-k=10Swg6U8cNa2qUpS3oo0ZW32w@mail.gmail.com> <20190611220553.GA23970@metamorpher.de>
In-Reply-To: <20190611220553.GA23970@metamorpher.de>
Subject: RE: RAID-6 aborted reshape
Date:   Fri, 14 Jun 2019 19:58:14 -0500
Message-ID: <004d01d52315$698f6bf0$3cae43d0$@Gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF3CbZEIWOLM33oAN+5SVf2cGNvXgKIz6qeAlCM1akCPki6AwI/mK8+pw1XBWA=
Content-Language: en-us
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Good news, I was able to recover the data. I am actively copying it off
right now.

This was the drive layout:
RAID Drive	Start sector
0		6144
1		6144
2		4096
3		6144
4		4096

Once I got the order right (played around in UFS Explorer) the XFS file
system was cleanly readable.

I think when the array was originally created in early 2014 it started out
as a 3 disk raid 5. It was later grown to a 4 disk raid 6 or raid 5, and
finally grown to a 5 disk raid 6. It had previously had 1 failed disk on
raid drive 2 as well.
Best guess is that the original 3 drives and the added fourth had 2048
sectors of padding past the super block or that their super block was this
much larger.
The last drive added had a sector start immediately following the 4096
sectors used for the super block. The same is true for the raid drive 2
replacement.

Is there any way to re-create the array (keeping the data intact) with this
same layout so I could access the data via linux? While I am currently
copying the data off via UFS explorer, I'd prefer to mount it under linux.

Thanks,
-Colt

-----Original Message-----
From: Andreas Klauer <Andreas.Klauer@metamorpher.de> 
Sent: Tuesday, June 11, 2019 5:06 PM
To: Colt Boyd <coltboyd@gmail.com>
Cc: linux-raid@vger.kernel.org
Subject: Re: RAID-6 aborted reshape

On Tue, Jun 11, 2019 at 12:22:53PM -0500, Colt Boyd wrote:
> > Jun  6 10:12:25 OMV1 kernel: [    2.142877] md/raid:md0: raid level 6
> > active with 5 out of 5 devices, algorithm 2
> > Jun  6 10:12:25 OMV1 kernel: [    2.196783] md0: detected capacity
> > change from 0 to 8998697828352
> > Jun  6 10:12:25 OMV1 kernel: [    3.885628] XFS (md0): Mounting V4
Filesystem
> > Jun  6 10:12:25 OMV1 kernel: [    4.213947] XFS (md0): Ending clean
mount
> 
> There is also these:
> 
> Jun  6 10:44:47 OMV1 kernel: [  449.554738] md0: detected capacity 
> change from 0 to 11998263771136 Jun  6 10:44:48 OMV1 
> postfix/smtp[2514]: 9672F6B4: replace: header
> Subject: DegradedArray event on /dev/md0:OMV1: Subject:
> [OMV1.veldanet.local] DegradedArray event on /dev/md0:OMV1 Jun  6 
> 10:46:25 OMV1 kernel: [  547.047912] XFS (md0): Mounting V4 Filesystem 
> Jun  6 10:46:28 OMV1 kernel: [  550.226215] XFS (md0): Log 
> inconsistent (didn't find previous header) Jun  6 10:46:28 OMV1 
> kernel: [  550.226224] XFS (md0): failed to find log head

See, this is very odd.

You had a md0 device with 8998697828352 capacity.

In a 5 disk RAID-6 that would come down to 2999565942784 per disk.

But then (halfhour later) you have a RAID-6 with 11998263771136 capacity.

Went up by 2999565942784... one disk worth.

Now, the way growing RAID works, you only get to use the added capacity once
the rebuild is finished. Cause otherwise you still have old data sitting in
the place new data has to go to and it would overwrite each other. So you
can't use extra capacity before finishing rebuild.

So for some reason, your RAID believed the rebuild to be completed, whether
or not that was actually the case - the mount failure suggests it went very
wrong somehow.

So it didn't work as 6-drive, and neither when re-creating as 5-drive, guess
you have to look at raw data to figure out if it makes any sense at all
(find an offset that has non-zero non-identical data across all drives, see
if the parity looks like a 5-disk or 6-disk array).

If it's both (6 drive for lower and 5 drive for higher offsets) then it
would still be stuck in mid-reshape after all and you'd have to create both
(two sets of overlays), find the reshape position and stitch it together
with dm-linear

Or some such method... that's all assuming it wasn't mounted, didn't corrupt
in other ways while it was in a bad state, had no bugs in the kernel itself
and all that.

Good luck

Andreas Klauer

