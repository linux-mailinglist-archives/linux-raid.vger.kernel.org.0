Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA933194B09
	for <lists+linux-raid@lfdr.de>; Thu, 26 Mar 2020 23:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgCZWBA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 26 Mar 2020 18:01:00 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:13741 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgCZWBA (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 26 Mar 2020 18:01:00 -0400
Received: from [81.153.122.12] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jHaYc-000Bpw-An; Thu, 26 Mar 2020 22:00:58 +0000
Subject: Re: Raid-6 won't boot
To:     Alexander Shenkin <al@shenkin.org>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <7ce3a1b9-7b24-4666-860a-4c4b9325f671@shenkin.org>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <3868d184-5e65-02e1-618a-2afeb7a80bab@youngman.org.uk>
Date:   Thu, 26 Mar 2020 22:00:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7ce3a1b9-7b24-4666-860a-4c4b9325f671@shenkin.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 26/03/2020 17:07, Alexander Shenkin wrote:
> I surely need to boot with a rescue disk of some sort, but from there,
> I'm not sure exactly when I should do.  Any suggestions are very welcome!

Okay. Find a liveCD that supports raid (hopefully something like 
SystemRescueCD). Make sure it has a very recent kernel and the latest mdadm.

All being well, the resync will restart, and when it's finished your 
system will be fine. If it doesn't restart on its own, do an "mdadm 
--stop array", followed by an "mdadm --assemble"

If that doesn't work, then

https://raid.wiki.kernel.org/index.php/Linux_Raid#When_Things_Go_Wrogn

Cheers,
Wol
