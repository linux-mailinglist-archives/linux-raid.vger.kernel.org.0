Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 273FE1965D1
	for <lists+linux-raid@lfdr.de>; Sat, 28 Mar 2020 12:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgC1Let (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 28 Mar 2020 07:34:49 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:63228 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgC1Let (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 28 Mar 2020 07:34:49 -0400
Received: from [81.153.42.4] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jI909-0001kk-Dv; Sat, 28 Mar 2020 10:47:41 +0000
Subject: Re: Raid-6 won't boot
To:     Alexander Shenkin <al@shenkin.org>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <7ce3a1b9-7b24-4666-860a-4c4b9325f671@shenkin.org>
 <3868d184-5e65-02e1-618a-2afeb7a80bab@youngman.org.uk>
 <ccab6f84-aab3-f483-e473-64d95cbeb7cc@shenkin.org>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <11a7a5ff-e95a-5068-1ba5-057f5a95f52c@youngman.org.uk>
Date:   Sat, 28 Mar 2020 10:47:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ccab6f84-aab3-f483-e473-64d95cbeb7cc@shenkin.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 27/03/2020 15:27, Alexander Shenkin wrote:
> Thanks Wol,
> 
> Booting in SystemRescueCD and looking in /proc/mdstat, two arrays are
> reported.  The first (md126) in reported as inactive with all 7 disks
> listed as spares.  The second (md127) is reported as active
> auto-read-only with all 7 disks operational.  Also, the only
> "personality" reported is Raid1.  I could go ahead with your suggestion
> of mdadm --stop array and then mdadm --assemble, but I thought the
> reporting of just the Raid1 personality was a bit strange, so wanted to
> check in before doing that...

Always remember - provided you don't use a --force, it won't do any 
damange. Given that booting into a rescue CD didn't assemble correctly, 
it looks like --stop then --assemble won't work. You need to follow the 
instructions in "when things go wrogn".

Cheers,
Wol
