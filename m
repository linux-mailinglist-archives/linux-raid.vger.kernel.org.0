Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404331DDAD6
	for <lists+linux-raid@lfdr.de>; Fri, 22 May 2020 01:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbgEUXRq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 May 2020 19:17:46 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:42609 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730716AbgEUXRp (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 21 May 2020 19:17:45 -0400
Received: from [81.154.111.47] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jbuRb-0003HO-8i; Fri, 22 May 2020 00:17:44 +0100
Subject: Re: re-add syntax
To:     David T-G <davidtg-robot@justpickone.org>,
        Linux RAID list <linux-raid@vger.kernel.org>
References: <20200520235347.GF1415@justpickone.org>
 <5EC63745.1080602@youngman.org.uk> <20200521110139.GW1711@justpickone.org>
 <20200521112421.GK1415@justpickone.org> <5EC66D4E.8070708@youngman.org.uk>
 <20200521123306.GO1415@justpickone.org>
 <828a3b59-f79c-a205-3e1e-83e34ae93eac@youngman.org.uk>
 <20200521131500.GP1415@justpickone.org>
 <20200521180700.GT1415@justpickone.org>
 <CAAMCDecB+CU-EGtx+4bMPKBYcy65sgT-8MW=s=OeviyZeq6URA@mail.gmail.com>
 <20200521225230.GU1415@justpickone.org>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <48fe44c5-f43e-3167-fd08-077dfc429cf2@youngman.org.uk>
Date:   Fri, 22 May 2020 00:17:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521225230.GU1415@justpickone.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 21/05/2020 23:52, David T-G wrote:
> Roger, et al --
> 
> ...and then Roger Heflin said...
> %
> % For re-add to work the array must have a bitmap, so that mdadm knows
> % what parts of the disk need updating.
> [snip]
> 
> Ahhhhh...  Thanks!
> 
> I've wondered about an internal bitmap vs not.  I also wonder how big the
> bitmap is and where else I might stick it ...
> 
Bear in mind the bitmap is obsolete ... I need to get my head round it, 
but you should upgrade from bitmap to journal ... amongst other things, 
this fixes the "raid 5 write hole" - not sure what it is but it seems 
inherent in the design of raid 5 that if something goes wrong it is easy 
to lose data. Journalling presumably fixes that the same way it fixes 
write losses in general ...

(Oh - and if you somehow manage to switch on bitmaps and journals 
together the resulting array will refuse to assemble. The current tools 
won't let you have both, but older versions can.)

Cheers,
Wol
