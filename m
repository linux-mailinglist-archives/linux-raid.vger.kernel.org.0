Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB1D913B68F
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jan 2020 01:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgAOAmJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jan 2020 19:42:09 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:24988 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728774AbgAOAmJ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 Jan 2020 19:42:09 -0500
Received: from [81.135.72.163] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1irWCu-0002j4-Bw; Wed, 15 Jan 2020 00:06:49 +0000
Subject: Re: Debian Squeeze raid 1 0
To:     Rickard Svensson <myhex2020@gmail.com>, linux-raid@vger.kernel.org
References: <CAC4UdkbjUVSpkBM88HB0UJMqXh+Pd7CRLaya=s81xMGs-9+m_Q@mail.gmail.com>
 <5E1D6C8E.8030607@youngman.org.uk>
 <CAC4UdkbwYvPHgufBPjNTWzcZW0FcGgGrbmFD_k_mc-Z7NVH9Pw@mail.gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5E1E5798.60406@youngman.org.uk>
Date:   Wed, 15 Jan 2020 00:06:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CAC4UdkbwYvPHgufBPjNTWzcZW0FcGgGrbmFD_k_mc-Z7NVH9Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14/01/20 23:11, Rickard Svensson wrote:
> Hi, I'm very grateful for all  help!
> 
> The Debian 6  mdadm version is:
> mdadm - v3.1.4 - 31st August 2010

Mmmmm ... yes using the new mdadm is very much advisable ...
> 
> I have avoided doing much with the server...
> And the server is still running, did not want to stop it...  But I
> should stop it now?

Have you got an esata port? Can you hook up the replacement drive(s) to
it? That sounds a good plan. You could use USB, but that's probably
going to be a LOT slower.

I can understand not wanting to shut the server down.
> 
> Attaches  below a summary in the log, /sde died by the 9th, but came
> back as /sdf  ???
> And the 12th /sdc dies, and the morning after I discover the problem.
> What I've done since then is only.
> * Remont drive as read only
> * Unmounted ext4, to run fsck
> And that's when I realized it might be even worse.
> 
Well, so long as nothing has written to the drives, and you can recover
a copy, then you should be okay ... cross fingers ...
> 
> My idea is to make a ddrescue copy of the problem disks, and then in a
> new Debian 10 with new mdadm, try to start the raid on the new hd
> copy..?

Yup
> 
> Yes, backing up via ddrescue sounds right.
> BTW it is gddrescue?  ddrescue in Debian 10 seems to be a Windows
> rescue program.
> 
Never heard of gddrescue. ddrescue is supposed to be a drop-in
replacement for dd, just that it doesn't error out on read failures and
has a large repertoire of tricks to try and get round errors if it can.

> I'm change to raid 1 now on the server later on, I have two new 10Tb
> drives, so not the same setup.
> But I have a 6 Tb drive, which I intend to use for this rescue.
> 
> A question about the copy. is it possible to copy to a different
> partition, for example copy sdc2 TO (new 6 TB disk) sdx1,  and then
> sde2 TO (same new disk!) sdx2...

Not a problem - raid (and linux in general) doesn't care about where the
data is, it just expects to be given a block device. It'll just slow
things down a bit. Hopefully with multiple heads per drive, not too
much, but I don't know in detail how these things work.

> And mdadm should (with same luck) be able to put it to the same md0 device.
> Or I'm asking, a copy of a partition will be the same, from what mdadm
> is looking for?
> 
Probably /dev/md126. At the end of the day, you shouldn't care. All you
want to do is assemble the array, see what it gives you as the array
device, and mount that. That should give your ext filesystem back. Run a
"no modify" fsck over it, and if it looks pretty clean (there might be a
little bit of corruption) try mounting it ro and looking it over for
problems.

When you move over to your 10TB drives (will that be a straight raid-1?)
look at dm-integrity (warning - it's experimental with raid but seems
solid for raid-1). And look at using named, not numbered, arrays. My
raid 1's are called /dev/root, /dev/home, and /dev/var.

(Fixed number raid arrays are deprecated - it counts down from 126 by
default now.)

Cheers,
Wol

