Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF97219033D
	for <lists+linux-raid@lfdr.de>; Tue, 24 Mar 2020 02:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCXBS5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 23 Mar 2020 21:18:57 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:11722 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgCXBS4 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 23 Mar 2020 21:18:56 -0400
Received: from [81.153.122.12] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jGXqv-0008Sn-Fm; Tue, 24 Mar 2020 00:55:34 +0000
Subject: Re: Please show descriptive message about degraded raid when booting
To:     Roger Heflin <rogerheflin@gmail.com>,
        Patrick Dung <patdung100@gmail.com>
Cc:     Linux RAID <linux-raid@vger.kernel.org>
References: <CAJTWkdvU3of87+-zyUPn7uDBen8ZBswujwMn8wYSiwZb=0V3EQ@mail.gmail.com>
 <CAJTWkdtYbmSapP0cG+nknTQWcn1ut4NaF4v5rEtS0wwvkuMH=A@mail.gmail.com>
 <CAAMCDeeRD51jy8syBoXD_zy2jWFHfG+v0n5AkEHu5-_X0K3+Lg@mail.gmail.com>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <f49f6418-cf92-7dec-77b4-ef099a39bd58@youngman.org.uk>
Date:   Tue, 24 Mar 2020 00:55:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAAMCDeeRD51jy8syBoXD_zy2jWFHfG+v0n5AkEHu5-_X0K3+Lg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 23/03/2020 18:13, Roger Heflin wrote:
> Those default timeouts are usually at least 30 seconds, but in the
> past the scsi subsystem did some retrying internally.  The timeout
> needs to be higher than the length of time the disk could take.
> Non-enterprise, non-raid disks generally have this timeout set 60-120
> seconds hence MD waiting to see if the failure is a sector read
> failure (will be a no-response until the disk timeout) or a complete
> disk failure (no response ever).

https://raid.wiki.kernel.org/index.php/Timeout_Mismatch

The whole website is reasonably up-to-date, so it's worth a read.

Cheers,
Wol
