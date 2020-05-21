Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A291DCDBB
	for <lists+linux-raid@lfdr.de>; Thu, 21 May 2020 15:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgEUNH3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 May 2020 09:07:29 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:12445 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728208AbgEUNH3 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 21 May 2020 09:07:29 -0400
Received: from [81.154.111.47] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jbkv1-0009eL-7n; Thu, 21 May 2020 14:07:27 +0100
Subject: Re: disks & prices plus python (was "Re: failed disks, mapper, and
 "Invalid argument"")
To:     David T-G <davidtg-robot@justpickone.org>,
        Linux RAID list <linux-raid@vger.kernel.org>
References: <20200520200514.GE1415@justpickone.org>
 <5EC5BBEF.7070002@youngman.org.uk> <20200520235347.GF1415@justpickone.org>
 <5EC63745.1080602@youngman.org.uk> <20200521110103.GG1415@justpickone.org>
 <5EC66C2E.90901@youngman.org.uk> <20200521123059.GN1415@justpickone.org>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <326faa2c-ba38-6cd4-c09c-ea321779e339@youngman.org.uk>
Date:   Thu, 21 May 2020 14:07:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521123059.GN1415@justpickone.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 21/05/2020 13:30, David T-G wrote:
> % > %
> % > % Seagate Barracudas:-(
> % >
> % > Yep.  They were good "back in the day" ...
> %
> % Still are. Just not for raid..
> 
> Oh!  Well, that's nice to know.  Of course, I had been hoping to move
> these out to another system after upgrading to larger, but maybe that's
> not an option:-(   They are going to be worlds better than the existing
> crap drives in there now, though, so here's hoping I can put them to use.

General advice is don't use them for parity raid - ie 5 or 6! They're 
okay (but not adviseable) for mirrors.

So if you really want to use them in a raid array, I'd go for a 6TB 
raid-10. Okay, you've lost 3TB of disk space, but you've bought a 66% 
chance of surviving a 2-disk failure.

I'm not sure what I'm going to do with mine. I've bought an add-in eSATA 
card to go with my eSATA drive bay, so I may well use them as external 
backups.

Cheers,
Wol
