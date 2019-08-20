Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41866956DB
	for <lists+linux-raid@lfdr.de>; Tue, 20 Aug 2019 07:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbfHTFtO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 20 Aug 2019 01:49:14 -0400
Received: from guest-port.merlins.org ([173.11.111.148]:49457 "EHLO
        mail1.merlins.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTFtN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 20 Aug 2019 01:49:13 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1hzx16-0004Q8-Bl by authid <merlin>; Mon, 19 Aug 2019 22:49:12 -0700
Date:   Mon, 19 Aug 2019 22:49:12 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     o1bigtenor <o1bigtenor@gmail.com>
Cc:     linux-block@vger.kernel.org,
        Linux-RAID <linux-raid@vger.kernel.org>
Subject: Re: 5.1.21 Dell 2950 terrible swraid5 I/O performance with swraid on top of Perc 5/i raid0/jbod
Message-ID: <20190820054912.GJ5431@merlins.org>
References: <20190819070823.GH12521@merlins.org> <CAPpdf5-82P0ri7KB34g_eWS6SKdVapCgUtYphwOL6E+HUwimcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpdf5-82P0ri7KB34g_eWS6SKdVapCgUtYphwOL6E+HUwimcg@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Aug 19, 2019 at 06:42:23AM -0500, o1bigtenor wrote:
> Not to discourage you from a possibly interesting and fruitful endeavor
> but when I bought myself a slightly newer dell server I traded out the
> PERC card for a newer version (model 700 IIRC) and then I things
> were quite a big different. Said board, bought used, wasn't very
> expensive. YMMV

Well, just received my H700 today, plugged it in, not everything is perfect
because I'm missing a cable, but sure enough, my rebuild speeds got 8 times
faster and the system stopped hanging all the time if I do any I/O.

I still think there was something fairly unexpected/wrong with the Perc 5/i
outside of it being a cheap card, but I have other things to worry about to
spend more time to find out :)
That said, if anyone wants the card for cost of shipping (US only please,
shipping abroad is too much of a pain), let me know and I'll give it to you.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
