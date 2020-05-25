Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF88A1E177C
	for <lists+linux-raid@lfdr.de>; Mon, 25 May 2020 23:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389442AbgEYVzO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 17:55:14 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:49083 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389345AbgEYVzO (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 25 May 2020 17:55:14 -0400
Received: from [81.154.111.47] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jdL3v-000BxX-Fn; Mon, 25 May 2020 22:55:12 +0100
Subject: Re: help requested for mdadm grow error
To:     John Stoffel <john@stoffel.org>
Cc:     Thomas Grawert <thomasgrawert0282@gmail.com>,
        linux-raid@vger.kernel.org, Phil Turmel <philip@turmel.org>
References: <7d95da49-33d8-cd4d-fa3f-0f3d3074cb30@gmail.com>
 <5ECC09D6.1010300@youngman.org.uk>
 <ff4ea9cd-ab35-0990-5946-4a72d4021658@gmail.com>
 <5ECC1488.3010804@youngman.org.uk>
 <4891e1e8-aaee-b36b-4131-ca7deb34defd@gmail.com>
 <5ECC1A86.3010104@youngman.org.uk>
 <24268.15511.752645.491837@quad.stoffel.home>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <a9576863-cfce-1c08-078b-ca945bb8b551@youngman.org.uk>
Date:   Mon, 25 May 2020 22:55:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <24268.15511.752645.491837@quad.stoffel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 25/05/2020 22:45, John Stoffel wrote:
> This is Debian Buster, and it's he's upto date with debian packages,
> he's almost certainly in a stable setup.  Now maybe we need to talk
> with the Debian package maintainer for mdadm and ask them to upgrade,
> or maybe why they haven't updated recently.

If you're going to do that, I think you need to get the kernel 
maintainer to upgrade that as well...

As I see it, the CAUSE of the problem is that we have an old-but-updated 
frankenkernel. It doesn't matter whether mdadm is contemporary with the 
original pre-franken-state kernel or contemporary with the new 
up-to-date frankenkernel, the fact of the matter is that the 
relationship between mdadm and the kernel isn't regression tested beyond 
making sure that arrays assemble and run correctly.

Hence the inevitable screw-ups when users try to administer their arrays.

Cheers,
Wol
