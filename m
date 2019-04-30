Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76EEDF1FC
	for <lists+linux-raid@lfdr.de>; Tue, 30 Apr 2019 10:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfD3IZ2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Apr 2019 04:25:28 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:25591 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfD3IZ2 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 30 Apr 2019 04:25:28 -0400
Received: from [10.8.0.10] (unknown [88.136.184.21])
        (Authenticated sender: julien.robin28)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id B54C020040A
        for <linux-raid@vger.kernel.org>; Tue, 30 Apr 2019 10:25:25 +0200 (CEST)
From:   Julien ROBIN <julien.robin28@free.fr>
Subject: Re: RAID5 mdadm --grow wrote nothing (Reshape Status : 0% complete)
 and cannot assemble anymore
To:     linux-raid@vger.kernel.org
References: <a87383aa-3c49-0f62-6a93-9b9cb2fc60dd@free.fr>
 <96216021-6834-66ae-135d-ed654d64e5c0@free.fr>
Message-ID: <cf3a34eb-2151-0903-116b-8c6fe1a63f52@free.fr>
Date:   Tue, 30 Apr 2019 10:25:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <96216021-6834-66ae-135d-ed654d64e5c0@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Considering this situation I which I'm 100% sure that the Reshape 
procedure altered some RAID metadata/headers, without having started to 
really reshape the content (no activity, reshape procedure was stuck at 
0% and doesn't even want to continue after the reboot).

Considering previous printout :

Apr 30 02:48:37 Pix-Server-Sorel kernel: [47934.106025]  --- level:5 
rd:3 wd:3
Apr 30 02:48:37 Pix-Server-Sorel kernel: [47934.106028]  disk 0, o:1, 
dev:sdd1
Apr 30 02:48:37 Pix-Server-Sorel kernel: [47934.106029]  disk 1, o:1, 
dev:sde1
Apr 30 02:48:37 Pix-Server-Sorel kernel: [47934.106031]  disk 2, o:1, 
dev:sdb1

Considering the fantastic answer of Shane Madden here : 
https://serverfault.com/questions/347606/recover-raid-5-data-after-created-new-array-instead-of-re-using

I'm about to play the following command :

mdadm --create /dev/md0 --level=5 --raid-devices=3 /dev/sdd1 /dev/sde1 
/dev/sdb1 --assume-clean

Is it fine ?
