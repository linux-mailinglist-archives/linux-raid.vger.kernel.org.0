Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D210E7FF5
	for <lists+linux-raid@lfdr.de>; Tue, 29 Oct 2019 06:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbfJ2F4B (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 29 Oct 2019 01:56:01 -0400
Received: from magic.merlins.org ([209.81.13.136]:36024 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731519AbfJ2F4B (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 29 Oct 2019 01:56:01 -0400
Received: from svh-gw.merlins.org ([173.11.111.145]:52318 helo=saruman.merlins.org)
        by mail1.merlins.org with esmtps 
        (Cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.92 #3)
        id 1iPKU3-0004eZ-1S; Mon, 28 Oct 2019 22:55:59 -0700
Received: from merlin by saruman.merlins.org with local (Exim 4.80)
        (envelope-from <marc@merlins.org>)
        id 1iPKU2-0006m7-GT; Mon, 28 Oct 2019 22:55:58 -0700
Date:   Mon, 28 Oct 2019 22:55:58 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-raid@vger.kernel.org
Message-ID: <20191029055558.GI18282@merlins.org>
References: <20191028202732.GV15771@merlins.org>
 <20191029023445.15022961@natsu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029023445.15022961@natsu>
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

On Tue, Oct 29, 2019 at 02:34:45AM +0500, Roman Mamedov wrote:
> On Mon, 28 Oct 2019 13:27:32 -0700
> Marc MERLIN <marc@merlins.org> wrote:
> 
> > Out of desperation, I ran hdrecover /dev/sdx on all my drives. It reads the
> > whole drive block by block, allowing to re-read a block many times to try
> > and rescue data from it, or just re-write it with 0's.
> > That one again, ran fine, no error.
> 
> It is weird that this succeeds, usually a "pending sector" means it's
> unreadable until overwritten.
> 
> One possibility is that your RAID card either sets up a HPA at the end of each
> drive to store metadata there, or just presents them as somewhat smaller than
> their actual size to the OS. If the pending sectors happen to be in that
> walled off area, then no wonder that no OS tools can get to them.
 
You are correct, the raid card does wall off a very small portion of the
drive, but I'm pretty sure it's fewer sectors than the number of pending
sectors I already have.

> See `hdparm -N`, or if possible compare `blockdev --getsize64` with the same
> model drives which are not connected via a RAID controller.

Not easy to do, but I do know that indeed not the entire drive is
visible by the OS. Sigh, I hate those silly raid cards without
real passthrough :(

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
