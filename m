Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2597B32327
	for <lists+linux-raid@lfdr.de>; Sun,  2 Jun 2019 13:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfFBLdU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 2 Jun 2019 07:33:20 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:13756 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfFBLdT (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 2 Jun 2019 07:33:19 -0400
Received: from [86.153.107.66] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1hXOjl-00072f-Bs
        for linux-raid@vger.kernel.org; Sun, 02 Jun 2019 12:33:18 +0100
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
To:     linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <6b34f202-65c4-b6f9-0ae1-cbb517c2b8f2@suse.com>
 <20190601053925.GO4569@bitfolk.com> <20190601085024.GA7575@www5.open-std.org>
 <20190601233151.GP4569@bitfolk.com> <20190602032609.GQ4569@bitfolk.com>
 <20190602085139.GA10257@www5.open-std.org>
 <20190602094300.GA12631@www5.open-std.org>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5CF3B3FC.1060402@youngman.org.uk>
Date:   Sun, 2 Jun 2019 12:33:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20190602094300.GA12631@www5.open-std.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 02/06/19 10:43, keld@keldix.com wrote:
> 3. migrating from one raid type to another, some of these are more important
> than others. IMHO migrating from current md raid10 RAID-0+1 to RAID-1+0
> layouts would be quite important.

Note that raid-10 is not raid-1+0 is not raid-0+1 as far as linux is
concerned.

Provided that you have more disks in the array than you have disks in
your raid-0 striped set, raid-10 will spread the mirror across disks. So
you can have raid-10 across 3 drives, while you need four drives for 1+0
or 0+1.

Cheers,
Wol
