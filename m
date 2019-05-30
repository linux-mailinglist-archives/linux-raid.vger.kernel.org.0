Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3F4030187
	for <lists+linux-raid@lfdr.de>; Thu, 30 May 2019 20:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfE3SIz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 May 2019 14:08:55 -0400
Received: from use.bitfolk.com ([85.119.80.223]:52177 "EHLO mail.bitfolk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfE3SIy (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 30 May 2019 14:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com; s=alpha;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date; bh=9KPbNb2021JVVK3NxOmYxXSsydmxKIw3qk/D95tGrTI=;
        b=noZKlz/e6fNx4HUXFKIoyU4AAf4WEBkgvvQAOyJsmJAMM6bD53dGC3YU2ykMAd/Km0LZNd/qfWgifUEUJ6Qm2QraDkjV6ap7mTeFXMMit5oz77DfCL7J0R604s1q+xYzrTAAdWpXemhpNt0mdq3Vi27Fj9tNed0+/LE1hsP+Cc6pT0kxoFst7bhcDYW9FunSi1ANoWkdoxnCupgvgaSCRgxg4XuPdnAEKX+Xgd2vOeY3JNVlZ04EIDft8h4skFqDvrzTz+Yi5McLZENW/XbbdgBILWb2/DfbRnr0YV9bgtarDYKxTVjcXg7hHR0D7GSBWkPB7vPINYDfknYgfY2xPQ==;
Received: from andy by mail.bitfolk.com with local (Exim 4.84_2)
        (envelope-from <andy@strugglers.net>)
        id 1hWPTx-0003sR-PK
        for linux-raid@vger.kernel.org; Thu, 30 May 2019 18:08:53 +0000
Date:   Thu, 30 May 2019 18:08:53 +0000
From:   Andy Smith <andy@strugglers.net>
To:     linux-raid@vger.kernel.org
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
Message-ID: <20190530180853.GB4569@bitfolk.com>
Mail-Followup-To: linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <20190530100420.GA7106@www5.open-std.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530100420.GA7106@www5.open-std.org>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL:  http://strugglers.net/wiki/User:Andy
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi keld,

Thanks for the reply.

On Thu, May 30, 2019 at 12:04:20PM +0200, keld@keldix.com wrote:
> you need to clarify which layout you use with md raid10.

I did not bother as I included the commands for the array setup
which should indicate that default layout was used.

> the layouts are near, far and offset, with very different performance characteristics.

I did not think these would be of any interest on SSD/NVMe which is
my main concern and is the area where RAID-1 outperforms RAID-1 by a
factor of 3 for 100% 4KiB random reads.

> far and offset are designed to be faster than near, which I understand that you use.
> So why are you using the slowest md raid10 layout, and not mentioning this fact?

Because I did not see the point of a non-default layout for fast
flash devices.

> maybe you could run your tests for all 3 layouts?

Yes I will be happy to do this and see what happens but I'm not
optimistic that it will change matters so that RAID-10 is able to
direct most reads to the fastest half.

Still it may be interesting by itself if it does have some effect
even on SSD/NVMe.

Cheers,
Andy
