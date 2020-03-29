Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBE971970C6
	for <lists+linux-raid@lfdr.de>; Mon, 30 Mar 2020 00:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgC2Wbg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 29 Mar 2020 18:31:36 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:43475 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728704AbgC2Wbg (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 29 Mar 2020 18:31:36 -0400
Received: from [81.153.42.4] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jIgSs-0001x4-Dc; Sun, 29 Mar 2020 23:31:34 +0100
Subject: Re: Requesting help repairing a RAID-6 array
To:     "crowston.name" <kevin@crowston.name>, linux-raid@vger.kernel.org
References: <etPan.5e80defb.10afc736.32ba@crowston.name>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <fc847f59-b221-c97c-28d6-813f8d79f15f@youngman.org.uk>
Date:   Sun, 29 Mar 2020 23:31:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <etPan.5e80defb.10afc736.32ba@crowston.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 29/03/2020 18:45, crowston.name wrote:
> === START OF INFORMATION SECTION ===
> Device Model:     ST3000DM001-1CH166
> Serial Number:    Z1F50Y21
> Firmware Version: CC29

Seagate Barracuda :-( Not suitable as a raid drive.

Have you read https://raid.wiki.kernel.org/index.php/Timeout_Mismatch

If you're not running that timeout script you are, unfortunately, a 
perfect example of why Barracudas aren't a good idea. If that script 
fixes most of your problems (it won't help you retrieve the array, but 
it *will* help you keep the array alive while you try to recover your 
data off it) then you need to replace all drives with more suitable ones 
asap - Ironwolves perhaps?

Cheers,
Wol
