Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52347108DE0
	for <lists+linux-raid@lfdr.de>; Mon, 25 Nov 2019 13:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfKYMbd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 Nov 2019 07:31:33 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:54252 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfKYMbd (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 25 Nov 2019 07:31:33 -0500
Received: from [86.135.165.148] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iZDWc-0008E8-5G; Mon, 25 Nov 2019 12:31:31 +0000
Subject: Re: Deep into potential data loss issue
To:     Ian Kelling <ian@iankelling.org>, Ian Kelling <iank@fsf.org>
References: <3fc5f3df-0589-645c-f36a-2eee83e8bccd () gnu ! org>
 <871rtw5z9e.fsf@fsf.org> <87zhgk4d4r.fsf@iankelling.org>
 <87y2w44bhf.fsf@iankelling.org>
Cc:     linux-raid@vger.kernel.org
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5DDBC9A1.2000808@youngman.org.uk>
Date:   Mon, 25 Nov 2019 12:31:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <87y2w44bhf.fsf@iankelling.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 25/11/19 08:16, Ian Kelling wrote:
> 
> Ian Kelling <ian@iankelling.org> writes:
> 
>> The partitions showed up, but the filesystems are full of errors and
>> generally unusable.
> 
> update: I ran mdadm --create again with a different device ordering and
> that seems to have fixed the problem.
> 
OWWWWW .....

Okay, it's good that you've fixed the problem, but you really shouldn't
be using --create unless you really have no other options left.

UPGRADE MDADM. It's a linux-only program, it's backwards compatible with
all raids, and 3.x is ancient ...

I'm guessing you haven't seen the linux raid web-site ...
https://raid.wiki.kernel.org/index.php/Linux_Raid

And I'm saying this to people with problems now - investigate
dm-integrity for any new drives. It's new, but if you've got a drive
that won't copy properly it looks like it'll be a god-send for helping
to recover an array. What I've just discovered is that if you use the
--no-wipe option, a drive should refuse to "read before write" which is
exactly what you want when using ddrescue. Whether it works correctly
with raid yet is another matter ... When I get a chance I'll be writing
it up for the website.

Cheers,
Wol
