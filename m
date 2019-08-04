Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B23C680C9B
	for <lists+linux-raid@lfdr.de>; Sun,  4 Aug 2019 22:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfHDUd2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 4 Aug 2019 16:33:28 -0400
Received: from arcturus.uberspace.de ([185.26.156.30]:37338 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfHDUd2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 4 Aug 2019 16:33:28 -0400
Received: (qmail 9916 invoked from network); 4 Aug 2019 20:33:27 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 4 Aug 2019 20:33:27 -0000
Date:   Sun, 4 Aug 2019 22:33:26 +0200
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     Ryan Heath <gaauuool@gmail.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: Raid5 2 drive failure (and my spare failed too)
Message-ID: <20190804203326.GA5708@metamorpher.de>
References: <8006bdd5-55df-f5f6-9e2e-299a7fd1e64a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8006bdd5-55df-f5f6-9e2e-299a7fd1e64a@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sun, Aug 04, 2019 at 02:49:32PM -0400, Ryan Heath wrote:
> I put some important data on this array so I'm really hoping someone can
> provide guidance to force this array online, or otherwise get this array
> back to a state allowing me to rebuild.

One drive seems to have failed on Jul 7 so one month ago.
Looks like /dev/sde1 went away and /dev/sdi1 failed mid-recovery.
That's device role 5, gone and outdated by now.

Then /dev/sdb1 went away on Jul 23. At that point the RAID is dead.

If /dev/sd{c,l,k,b,j}1 are still readable you might be able to recover.
So what's up with these drives? Readable or not (guess they are or 
you'd not be able to provide --examine either, eh?), errors in SMART?
If there's so much as a whiff of a read error, you want to ddrescue.

If ddrescue recovery is not 100% you can try to patch missing sectors 
with data from sde1 or sdi1 if those can be read. If those sectors were 
part of files created before Jul 7, it might result in full recovery.
(After exchanging the transplanted sectors back, which can also be 
done with ddrescue, if you preserve a copy of the log/map file.)

Use overlays for experiments:

https://raid.wiki.kernel.org/index.php/Recovering_a_failed_software_RAID#Making_the_harddisks_read-only_using_an_overlay_file

Overlays require working drives, so if your drives have partial failure, 
ddrescue to new drives first!

With overlays then, you can try things like --assemble --force, 
or even --create https://unix.stackexchange.com/a/131927/30851
using only the best drives available (clkbj) and ignoring 
the outdated (ei) which is a last resort only.

It comes down to preparation (ddrescue), trial&error and luck.

Regards
Andreas Klauer
