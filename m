Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78441CC231
	for <lists+linux-raid@lfdr.de>; Sat,  9 May 2020 16:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgEIOfU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 9 May 2020 10:35:20 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:59305 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgEIOfU (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 9 May 2020 10:35:20 -0400
Received: from [86.146.232.119] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jXPJy-0009pH-FJ; Sat, 09 May 2020 14:15:14 +0100
Subject: Re: Assemblin journaled array fails
To:     Michal Soltys <msoltyspl@yandex.pl>,
        linux-raid <linux-raid@vger.kernel.org>
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <9591809e-583d-ebd5-ea0f-a342868a7728@youngman.org.uk>
Date:   Sat, 9 May 2020 14:15:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 09/05/2020 11:54, Michal Soltys wrote:
> After the reboot I'm in the situation as outlined above. Any suggestion 
> how to assemble this array now ?

mdadm -v ?

uname -a ?

https://raid.wiki.kernel.org/index.php/Asking_for_help

Dunno what the problem is, and I'm hesitant to recommend it, but 
re-assembling the array without a journal might work.

You have made sure that bitmaps aren't enabled? You can't have both, but 
for historical reasons you can end up with both enabled and then the 
resulting array won't start.

Cheers,
Wol
