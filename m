Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24151DCBA0
	for <lists+linux-raid@lfdr.de>; Thu, 21 May 2020 13:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgEULGz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 May 2020 07:06:55 -0400
Received: from u17383850.onlinehome-server.com ([74.208.250.170]:53567 "EHLO
        u17383850.onlinehome-server.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728348AbgEULGy (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 21 May 2020 07:06:54 -0400
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 May 2020 07:06:54 EDT
Received: by u17383850.onlinehome-server.com (Postfix, from userid 5001)
        id F0EE9767; Thu, 21 May 2020 07:01:03 -0400 (EDT)
Date:   Thu, 21 May 2020 07:01:03 -0400
From:   David T-G <davidtg@justpickone.org>
To:     Linux RAID list <linux-raid@vger.kernel.org>
Cc:     Phil Turmel <philip@turmel.org>
Subject: Re: failed disks, mapper, and "Invalid argument"
Message-ID: <20200521110103.GG1415@justpickone.org>
References: <20200520200514.GE1415@justpickone.org>
 <5EC5BBEF.7070002@youngman.org.uk>
 <20200520235347.GF1415@justpickone.org>
 <5EC63745.1080602@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5EC63745.1080602@youngman.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Wols, et al --

...and then Wols Lists said...
% 
% On 21/05/20 00:53, David T-G wrote:
% >   ## parted
% >   Model: ATA ST4000DM000-1F21 (scsi)
...
% >   SCT capabilities:              (0x1085) SCT Status supported.
% >   SMART Error Log Version: 1
% >   ## scterc
% >   SCT Error Recovery Control command not supported
% > 
% > Curiously, note that querying just scterc as the wiki instructs says "not
% > supported", but a general smartctl query says yes.  I'm not sure how to
% > interpret this...
% 
% Seagate Barracudas :-(

Yep.  They were good "back in the day" ...


% 
% As for smartctl, you're asking two different things. Firstly is SCT
% supported (yes). Secondly, is the ERC feature supported (no).
% 
% And that second question is the killer. Your drives do not support error
% recovery. Plan to replace them with ones that do ASAP!

That would be nice.  I actually have wanted for quite some time
to grow these from 4T to 8T, but budget hasn't permitted.  Got any
particularly-affordable recommendations?

This whole problem sounds familiar to me.  I thought that it was possible
to adjust the timeouts on the software side to match the longer disk time
or similar.  Of course, I didn't know that I had a real problem in the
first place ...  But does that sound familiar to anyone?


% 
...
% 
% In the meantime, make sure you're running Brad's script, and watch out
% for any hint of lengthening read/write times. That's unlikely to be why
% your overlay drives won't mount - I suspect a problem with loopback, but
% I don't know.

I most definitely also want to be able to spot trends to get ahead of
failures.  I just don't know for what to look or how to parse it to write
a script that will say "hey, this thingie here is growing, and you said
you cared ...".


% 
% What I don't want to advise, but I strongly suspect will work, is to
% force-assemble the two good drives and the nearly-good drive. Because it
% has no redundancy it won't scramble your data because it can't do a

Should I, then, get rid of the mapper overlay stuff?  I tried pointing to
even just three devs and got that they're busy.


% rebuild, but I would VERY STRONGLY suggest you download lsdrv and get
% the output. The whole point of this script is to get the information you

You mean the output that is some error and a few lines of traceback?
Yeah, I saw that, but I don't know how to fix it.  Another problem in the
queue.


% need so that if everything does go pear shaped, you can rebuild the
% metadata from first principles. It's easy - git clone, run.

... and then debug ;-)


% 
% Cheers,
% Wol


Thanks again & HAND

:-D
-- 
David T-G
See http://justpickone.org/davidtg/email/
See http://justpickone.org/davidtg/tofu.txt

