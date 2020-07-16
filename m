Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F01222455
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jul 2020 15:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgGPNyb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jul 2020 09:54:31 -0400
Received: from mail.thelounge.net ([91.118.73.15]:53777 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgGPNya (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Jul 2020 09:54:30 -0400
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4B6wjH144KzXTV;
        Thu, 16 Jul 2020 15:54:27 +0200 (CEST)
Subject: Re: Programmatically check "global" RAID state?
To:     Ian Pilcher <arequipeno@gmail.com>, linux-raid@vger.kernel.org
References: <repl8o$ggb$1@ciao.gmane.io>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <7b42170b-3ee6-bbea-f9bf-a0bdb49932c9@thelounge.net>
Date:   Thu, 16 Jul 2020 15:54:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <repl8o$ggb$1@ciao.gmane.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 16.07.20 um 15:38 schrieb Ian Pilcher:
> I want to write a quick script/program for my NAS that will initiate a
> check of one of my RAID devices every night.  However, I want it to skip
> the check if either of the following is true:
> 
> * Another check/resync is in process on any RAID device, or
> 
> * Any of the RAID devices on the system are unhealthy (degraded or
>   failed).
> 
> Is there any way to programmatically check the "global" status of the
> RAID subsystem like this, or am I stuck iterating through all of the
> devices (likely via sysfs) and checking them individually?  (I'm pretty
> sure that I am "stuck" but wanted to check just in case.)

cat /proc/mdstat | grep -P 'cond1|cond2|cond3' should do the trick, if
the output is empty: go
