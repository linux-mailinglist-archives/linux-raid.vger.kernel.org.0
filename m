Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77F7D174F17
	for <lists+linux-raid@lfdr.de>; Sun,  1 Mar 2020 20:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgCATH6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 1 Mar 2020 14:07:58 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:13269 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbgCATH5 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 1 Mar 2020 14:07:57 -0500
Received: from [86.155.171.124] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1j8TwR-0001tj-55; Sun, 01 Mar 2020 19:07:55 +0000
Subject: Re: Grow array and convert from raid 5 to 6
To:     William Morgan <therealbrewer@gmail.com>,
        linux-raid@vger.kernel.org
References: <CALc6PW7C30Z6bccQLXLPf8zYuM=aBVZ_hLgW3i5gqZFVsLRpfA@mail.gmail.com>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <fa393999-3f56-0bcf-b097-462a209f1eae@youngman.org.uk>
Date:   Sun, 1 Mar 2020 19:07:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CALc6PW7C30Z6bccQLXLPf8zYuM=aBVZ_hLgW3i5gqZFVsLRpfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 01/03/2020 18:07, William Morgan wrote:
> I have a healthy 4 disk raid 5 array (data only, non booting) that is
> running out of space. I'd like to add 4 more disks for additional
> space, as well as convert to raid 6 for additional fault tolerance.
> I've read through the wiki page on converting an existing system, but
> I'm still not sure how to proceed. Can anyone outline the steps for
> me? Thanks for your help.

> Looks like you looked at the wrong section ... :-) Look at "a guide to mdadm".

The subsection "upgrading a mirror raid to a parity raid" contains the 
information you need, just not laid out nicely for you.

You want to "grow" your raid, and you could do it in one hit, or in 
several steps. I'd probably add the drives first, "--grow --add disk1 
--add disk2 ..." to give an array with 4 active drives and 4 spares. 
Then you can upgrade to raid 6 - "--grow --level=6 --raid-devices=8".

> A little bit of advice - MAKE SURE you have the latest mdadm, and if 
> possible an up-to-date kernel. What mdadm and kernel do you have?

If your kernel/mdadm is older, the reshape might hang at 0%. The easiest 
fix is to reboot into an up-to-date rescue disk and re-assemble the 
array, at which point it'll kick off fine. The only snag, of course, is 
that means your system is not available for normal use until the reshape 
is complete and you can reboot back into your normal setup.

Cheers,

Wol

