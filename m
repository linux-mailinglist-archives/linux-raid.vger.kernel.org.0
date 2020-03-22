Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC80E18E582
	for <lists+linux-raid@lfdr.de>; Sun, 22 Mar 2020 01:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgCVAFK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 21 Mar 2020 20:05:10 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:55310 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbgCVAFK (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 21 Mar 2020 20:05:10 -0400
Received: from [86.146.112.25] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jFo71-0001ep-98; Sun, 22 Mar 2020 00:05:08 +0000
Subject: Re: Raid6 recovery
To:     Phil Turmel <philip@turmel.org>,
        Glenn Greibesland <glenngreibesland@gmail.com>
References: <CA+9eyijuUEJ7Y8BuxkKaZ=v8zbPpwixOezngPjtJzaLsBd+A4Q@mail.gmail.com>
 <5E75163B.2050602@youngman.org.uk>
 <CA+9eyigMV-E=FwtXDWZszSsV6JOxxFOFVh6WzmeH=OC3heMUHw@mail.gmail.com>
 <ab2a40b6-b4ab-9ff8-aef6-02d8cce8d587@youngman.org.uk>
 <CA+9eyig8U2Tzi1wF97k7eDu5vKg5Jc2sRXKaw0OCy7Cbc9HMog@mail.gmail.com>
 <c55be05d-22ee-4676-7878-5bf99ccc80f9@turmel.org>
Cc:     linux-raid@vger.kernel.org, NeilBrown <neilb@suse.com>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5E76ABB2.9010506@youngman.org.uk>
Date:   Sun, 22 Mar 2020 00:05:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <c55be05d-22ee-4676-7878-5bf99ccc80f9@turmel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 21/03/20 19:24, Phil Turmel wrote:
> If UREs do break your array again, you will need to use an
> error-ignoring copy tool (some flavor of ddrescue) to put the readable
> data onto a new device, remove the old device from the system, and then
> --assemble --force with the replacement.  Repeat as needed.

I would NOT recommend it at the moment - it's untested and reputedly
breaks raids 5 & 6, but look at dm-integrity. If we could trust it, it
would be a wonderful tool with ddrescue.

Hopefully I'm about to have a wonderful system with 6 or so drives I can
play with as a raid test-bed, and I'm hoping to do a load of work on this.

Cheers,
Wol
