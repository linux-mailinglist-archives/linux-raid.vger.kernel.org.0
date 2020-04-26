Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77361B93E0
	for <lists+linux-raid@lfdr.de>; Sun, 26 Apr 2020 22:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgDZUVw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 26 Apr 2020 16:21:52 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:39197 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgDZUVw (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 26 Apr 2020 16:21:52 -0400
Received: from [86.153.107.83] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jSnmg-0008Lr-5w; Sun, 26 Apr 2020 21:21:51 +0100
Subject: Re: Hard Drive Partition Table shows partition larger than drive
To:     Robert Steinmetz <rob@steinmetznet.com>, linux-raid@vger.kernel.org
References: <6ee9392d-8867-f0b5-193e-17a516bb7e0e@steinmetznet.com>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5EA5ED5D.8060006@youngman.org.uk>
Date:   Sun, 26 Apr 2020 21:21:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <6ee9392d-8867-f0b5-193e-17a516bb7e0e@steinmetznet.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 26/04/20 18:49, Robert Steinmetz wrote:

> 
> boot and raid flags are set.
> Obviously something is wrong.
> I originally use the drive to replace another smaller drive in a Raid 1
> array and that array was created with mdadm and maybe lvm2.
> Is there a reasonable way to see if the drive has anything usable in it?
> 
Run lsdrv over the drive and see what that reports.

https://raid.wiki.kernel.org/index.php/Asking_for_help

If you post that here, hopefully somebody can help you reconstruct
whatever was there.

Cheers,
Wol
