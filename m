Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEE01D0DB
	for <lists+linux-raid@lfdr.de>; Tue, 14 May 2019 22:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfENUvL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 May 2019 16:51:11 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:39404 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfENUvL (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 May 2019 16:51:11 -0400
Received: from [86.154.25.122] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1hQeOD-00029e-6p; Tue, 14 May 2019 21:51:09 +0100
Subject: Re: Help restoring a raid10 Array (4 disk + one spare) after a hard
 disk failure at power on
To:     Julien ROBIN <julien.robin28@free.fr>, linux-raid@vger.kernel.org
References: <87d22dc0-4b45-e13f-86e1-d3e9fbd7f55d@free.fr>
 <1bc43f99-3c57-db16-64d2-e5ab7d2e27cf@thelounge.net>
 <2e69c60c-eda3-c637-92d4-03fe67228c01@free.fr>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5CDB2A3C.7000709@youngman.org.uk>
Date:   Tue, 14 May 2019 21:51:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <2e69c60c-eda3-c637-92d4-03fe67228c01@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14/05/19 19:35, Julien ROBIN wrote:
> You're probably right, this is going a little bit out of the original
> subject but lots of tutorials online are only using block devices
> addresses as /dev/sdXN, I guess this has to be improved.

Especially when working on the command line, sdXN is a lot quicker and
easier to type :-)
> 
> Anyway blocks devices will still be necessary at creation and at a new
> member adding : the UUID used to differentiate members seems to be
> available as "UUID_SUB" but is this field is only available after the
> member insertion into the array, or after array creation.
> 

> 
> I may propose my help in some following days if I have few time
> available into the Linux Raid Wiki, but if anybody else feel comfortable
> with it, please feel free to be faster ;)
> 
> Anyway, given the amount of existing Wiki over the Internet it may be
> difficult to change this habit - but improving a wiki can always be useful.

Just don't make it too "fussy". When I cleaned up the wiki there were a
fair few places where the same information was repeated. Then instead of
not being able to find something because it's tucked away somewhere you
didn't look, you still can't find it because it's swamped by all the
(repeated) information that's all over the place.

Probably a discussion of UUIDs etc belongs in the bit on setting up a
new system. Note that the "editing guidelines" says to use UUIDs as much
as possible - what was that I said about not finding stuff because you
didn't look where it was :-)

Cheers,
Wol
