Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47DFD322D4
	for <lists+linux-raid@lfdr.de>; Sun,  2 Jun 2019 11:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfFBJnC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 2 Jun 2019 05:43:02 -0400
Received: from open-std.org ([93.90.116.65]:50011 "EHLO www.open-std.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfFBJnC (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 2 Jun 2019 05:43:02 -0400
Received: by www.open-std.org (Postfix, from userid 500)
        id 79C61356A54; Sun,  2 Jun 2019 11:43:00 +0200 (CEST)
Date:   Sun, 2 Jun 2019 11:43:00 +0200
From:   keld@keldix.com
To:     linux-raid@vger.kernel.org
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
Message-ID: <20190602094300.GA12631@www5.open-std.org>
References: <20190529194136.GW4569@bitfolk.com> <6b34f202-65c4-b6f9-0ae1-cbb517c2b8f2@suse.com> <20190601053925.GO4569@bitfolk.com> <20190601085024.GA7575@www5.open-std.org> <20190601233151.GP4569@bitfolk.com> <20190602032609.GQ4569@bitfolk.com> <20190602085139.GA10257@www5.open-std.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190602085139.GA10257@www5.open-std.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

my understanding is that we have several issues at hand

1. use of ssds etc instead of hds. here optimising for rotational delays etc
is not so relevant. ssds etc are more and more important these days, while hds
are still important.

2. unbalanced devices occur frequently in raids.
Sometimes it is bad to just use the simple strategy of using first available
device, such as in disk oriented md raid10,far, where striping is
key to its perfomance. In many cases the simple strategy is probably the best.

Where the balance is very uneven, eg. using ssd and hd together, I wonder if 
you should have some caching strategy, ie caching raid, we already do this
with kernel space buffers. It could be a general layer on top of md raid.
some technology uses a caching approach having tape as the slowest media.

3. migrating from one raid type to another, some of these are more important
than others. IMHO migrating from current md raid10 RAID-0+1 to RAID-1+0
layouts would be quite important.

keld
