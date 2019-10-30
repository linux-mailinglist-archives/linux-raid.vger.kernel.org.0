Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A144E9F2B
	for <lists+linux-raid@lfdr.de>; Wed, 30 Oct 2019 16:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfJ3Pfa (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 30 Oct 2019 11:35:30 -0400
Received: from magic.merlins.org ([209.81.13.136]:46704 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfJ3Pfa (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 30 Oct 2019 11:35:30 -0400
Received: from svh-gw.merlins.org ([173.11.111.145]:51550 helo=saruman.merlins.org)
        by mail1.merlins.org with esmtps 
        (Cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.92 #3)
        id 1iPq0C-0003Vt-5J; Wed, 30 Oct 2019 08:35:18 -0700
Received: from merlin by saruman.merlins.org with local (Exim 4.80)
        (envelope-from <marc@merlins.org>)
        id 1iPq0B-0005Fg-RT; Wed, 30 Oct 2019 08:35:15 -0700
Date:   Wed, 30 Oct 2019 08:35:15 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     Tim Small <tim@buttersideup.com>,
        Jorge Bastos <jorge.mrbastos@gmail.com>,
        Roman Mamedov <rm@romanrm.net>, linux-raid@vger.kernel.org
Message-ID: <20191030153515.GC28297@merlins.org>
References: <20191030025346.GA24750@merlins.org>
 <5DB9A9CC.9090007@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DB9A9CC.9090007@youngman.org.uk>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 173.11.111.145
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Checker-Version: SpamAssassin 3.4.2-mmrules_20121111 (2018-09-13) on
        magic.merlins.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=7.0 tests=GREYLIST_ISWHITE,SPF_SOFTFAIL,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.2-mmrules_20121111
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: merlins.org]
        *  1.0 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        * -1.5 GREYLIST_ISWHITE The incoming server has been whitelisted for
        *      this receipient and sender
Subject: Re: Cannot fix Current_Pending_Sector even after check and repair
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Oct 30, 2019 at 03:18:36PM +0000, Wols Lists wrote:
> On 30/10/19 02:53, Marc MERLIN wrote:
> > On Tue, Oct 29, 2019 at 12:05:02PM +0000, Jorge Bastos wrote:
> >> > Same, especially with WD drives, they appear to be false positives, if
> >> > you can take the disk offline a full disk write will usually get rid
> >> > of them.
> 
> > I see. So somehow reading all the sectors with hdrecover does not
> > trigger anything, but dd'ing 0s over the entire drive would reset this?
> 
> Because a "pending" error is a sector that is unreadable, but if you
> don't write to it, the drive can't test whether the error is "transient"
> corruption, or whether the sector needs to be relocated. And of course,
> because it can't read the sector it can't do a transparent write because
> it doesn't know what was there to start with to write back ...

I understand that, but if hdrecover can read the sector, it never
rewrites it given that it was read fine, so nothing happens.
But the drive should see that the block with issues, just got read, and
reset the sector as non pending.
Clearly that isn't happening, though.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
