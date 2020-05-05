Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AFC1C522C
	for <lists+linux-raid@lfdr.de>; Tue,  5 May 2020 11:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgEEJtD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 May 2020 05:49:03 -0400
Received: from mail.thelounge.net ([91.118.73.15]:25139 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgEEJtC (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 May 2020 05:49:02 -0400
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 49GZgJ6N4VzY81;
        Tue,  5 May 2020 11:49:00 +0200 (CEST)
Subject: Re: RAID 1 | Test Booting from /dev/sdb
To:     Stefanie Leisestreichler 
        <stefanie.leisestreichler@peter-speer.de>,
        Wols Lists <antlists@youngman.org.uk>,
        linux-raid@vger.kernel.org
References: <221092f3-5b8a-5d95-01d9-261e6449f747@peter-speer.de>
 <5EB12900.3030505@youngman.org.uk>
 <608e4d08-a99d-97f3-0476-3a880096f858@peter-speer.de>
 <5EB1333E.1010801@youngman.org.uk>
 <be57a390-734b-c215-aa59-e07c531354a0@peter-speer.de>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <430ad5c7-0dda-8494-2abb-b79aad39a71a@thelounge.net>
Date:   Tue, 5 May 2020 11:49:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <be57a390-734b-c215-aa59-e07c531354a0@peter-speer.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 05.05.20 um 11:42 schrieb Stefanie Leisestreichler:
> On 05.05.20 11:34, Wols Lists wrote:
>> No. The journal or bitmap are stored as part of the array, not the
>> filesystem. sdb will have a load of "flags" set to say "these blocks
>> were written to while the array was degraded". So when sda is added back
>> in, these delayed writes will be copied from sdb to sda.
> 
> When sdb copies the changes it has in the blocks /var/log sits on, will
> this result in the array showing the changes made to /var/log when it
> was booted using sdb only or did I get this wrong?

the array is just fine and the filesystem on-top never takes any notice
because it's a different layer not knowing anything about the RAID

the array is just a block device like a single disk for upper layers
