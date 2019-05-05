Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F366141B0
	for <lists+linux-raid@lfdr.de>; Sun,  5 May 2019 20:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfEESCH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 5 May 2019 14:02:07 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:54916 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbfEESCH (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 5 May 2019 14:02:07 -0400
Received: from [192.168.28.30] (unknown [86.74.176.27])
        (Authenticated sender: julien.robin28)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 114E7B00571
        for <linux-raid@vger.kernel.org>; Sun,  5 May 2019 20:02:05 +0200 (CEST)
From:   Julien ROBIN <julien.robin28@free.fr>
Subject: New complete guide for irreversible mdadm failures recovery
To:     Linux Raid <linux-raid@vger.kernel.org>
Message-ID: <b40052a0-5228-869d-a534-18dd7c366705@free.fr>
Date:   Sun, 5 May 2019 20:02:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi folks,

In my previous mail I said that having found really valuable 
information, interesting tests on the Internet, and thanks to a lot of 
attempts and tests I've done on my own with a dedicated machine, I would 
have some time to add a lot of valuable information that isn't into the 
official wiki about recovering from situation that could have been 
considered as definitely lost.

It took me some more time, and a lot of validation and thorough tests 
(as no error, bad advice, or unverified supposition can be allowed). I 
also managed to understand (and show) how to very simply use overlays so 
that write operation can't happen to any real RAID member.

The guide is about everything to know when recreating a new array over a 
not working anymore or seriously screwed past existing one. After a 
clear introduction about what it technically covers and implies.

It's also about recovery of accidentally overwritten member(s), and/or 
understanding about rebuild process effects on the different members of 
an array. In case of RAID6 for example, an erroneous full rewrite of 
every member can surprisingly be recovered in some situations - and in 
which case which rewritten disk has been rewritten with what - and is it 
recoverable, and how.

https://raid.wiki.kernel.org/index.php/Irreversible_mdadm_failure_recovery

I did my best efforts for the English correctness; anyway feel free to 
feedback or correct if you see some errors (be it English or technical 
things, although it has been thoroughly tested).

Best regards,
Julien Robin
