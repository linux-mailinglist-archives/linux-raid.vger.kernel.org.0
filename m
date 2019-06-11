Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5C23CEFC
	for <lists+linux-raid@lfdr.de>; Tue, 11 Jun 2019 16:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389777AbfFKOjc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Jun 2019 10:39:32 -0400
Received: from open-std.org ([93.90.116.65]:33306 "EHLO www.open-std.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389484AbfFKOjc (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 11 Jun 2019 10:39:32 -0400
Received: by www.open-std.org (Postfix, from userid 500)
        id BE92C3587F1; Tue, 11 Jun 2019 16:39:29 +0200 (CEST)
Date:   Tue, 11 Jun 2019 16:39:29 +0200
From:   keld@keldix.com
To:     Guoqing Jiang <gqjiang@suse.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: [PATCH] md/raid10: read balance chooses idlest disk for SSD
Message-ID: <20190611143929.GA13825@www5.open-std.org>
References: <20190611073311.14120-1-gqjiang@suse.com> <20190611074315.GA28052@www5.open-std.org> <1110737b-e037-9ef8-395e-83bd540e24b1@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110737b-e037-9ef8-395e-83bd540e24b1@suse.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jun 11, 2019 at 04:11:52PM +0800, Guoqing Jiang wrote:
> Hi,
> 
> On 6/11/19 3:43 PM, keld@keldix.com wrote:
> >thanks for this patch
> >
> >I think we should change the hd algorithm to chose the highest block 
> >number at least for the
> >far layout. ther outer blocks have the fastest transfer rates and also the 
> >shortest
> >distance for head movement.
> 
> I didn't investigate the performance of far layout a lot, seems there 
> was one patch
> (commit 8ed3a19563b6c " md: don't attempt read-balancing for raid10 
> 'far' layouts")
> which was aimed to do it, and you were the author, no? ;-). Or I missed 
> something.

yes , I was the author of that patch.
and it solved the problem: to get the drives to stripe, evne if the hd drives
have different transfer rates and rotation speeds.

what I think I got wrong was that it was using the inner parts of the disks
instead of the outer parts, where the transfer rate is higer and head movement less.

I am suggesting now to reverse this.

keld
