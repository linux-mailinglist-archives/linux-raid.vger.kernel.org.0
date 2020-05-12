Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3A11D01A0
	for <lists+linux-raid@lfdr.de>; Wed, 13 May 2020 00:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgELWLW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 12 May 2020 18:11:22 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:35618 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgELWLW (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 12 May 2020 18:11:22 -0400
Received: from [86.146.232.119] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jYd7Q-000623-8J
        for linux-raid@vger.kernel.org; Tue, 12 May 2020 23:11:20 +0100
To:     Linux RAID <linux-raid@vger.kernel.org>
From:   antlists <antlists@youngman.org.uk>
Subject: New wiki page
Message-ID: <ed2b8085-4ec4-2ad1-9f37-0206f20f4f1e@youngman.org.uk>
Date:   Tue, 12 May 2020 23:11:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Just in case anyone wants to take a look ...

https://raid.wiki.kernel.org/index.php/System2020

I'm finally building my new system, and I've got the host SUSE system 
booting and enabling my dm-integrity protected raid 1s. This page 
basically documents the story so far of setting it up, so other people 
can use it as a cookbook for something similar.

Okay, I've still got to bootstrap the gentoo system that it's going to 
be, but if anyone interested can take a look and give me advice for 
improvements on the story that will be great.

Cheers,
Wol
