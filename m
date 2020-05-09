Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B231CC5AB
	for <lists+linux-raid@lfdr.de>; Sun, 10 May 2020 02:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgEJAFt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 9 May 2020 20:05:49 -0400
Received: from forward105o.mail.yandex.net ([37.140.190.183]:49886 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbgEJAFt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 9 May 2020 20:05:49 -0400
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 May 2020 20:05:48 EDT
Received: from mxback23j.mail.yandex.net (mxback23j.mail.yandex.net [IPv6:2a02:6b8:0:1619::223])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id A126B4200461
        for <linux-raid@vger.kernel.org>; Sun, 10 May 2020 02:57:54 +0300 (MSK)
Received: from myt6-efff10c3476a.qloud-c.yandex.net (myt6-efff10c3476a.qloud-c.yandex.net [2a02:6b8:c12:13a3:0:640:efff:10c3])
        by mxback23j.mail.yandex.net (mxback/Yandex) with ESMTP id 74PDmXI1Db-vsrKaOuP;
        Sun, 10 May 2020 02:57:54 +0300
Received: by myt6-efff10c3476a.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id lXKp7CziYz-vr38b7SU;
        Sun, 10 May 2020 02:57:53 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: Assemblin journaled array fails
From:   Michal Soltys <msoltyspl@yandex.pl>
To:     linux-raid <linux-raid@vger.kernel.org>
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
Message-ID: <70dad446-7d38-fd10-130f-c23797165a21@yandex.pl>
Date:   Sun, 10 May 2020 01:57:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Anyway, I did some tests with manually snapshotted component devices 
(using dm snapshot target to not touch underlying devices).

The raid manages to force assemble in read-only mode with missing 
journal device, so we probably will be able to recover most data 
underneath this way (as a last resort).

The situation I'm in now is likely from uncelan shutdown after all (why 
the machine failed to react to ups properly is another subject).

I'd still want to find out why is - apparently - a journal device giving 
issues (contrary to what I'd expect it to do ...), with notable mention of:

1) mdadm hangs (unkillable, so I presume in kernel somewhere) and eats 1 
cpu when trying to assemble the raid with journal device present; once 
it happens I can't do anything with the array (stop, run, etc.) and can 
only reboot the server to "fix" that

2) mdadm -D shows nonsensical device size after assembly attempt (Used 
Dev Size : 18446744073709551615)

3) the journal device (which itself is md raid1 consisting of 2 ssds) 
assembles, checks (0 mismatch_cnt) fine - and overall looks ok.


 From other interesting things, I also attempted to assemble the raid 
with snapshotted journal. From what I can see it does attempt to do 
something, judging from:

dmsetup status:

snap_jo2: 0 536870912 snapshot 40/33554432 16
snap_sdi1: 0 7812500000 snapshot 25768/83886080 112
snap_jo1: 0 536870912 snapshot 40/33554432 16
snap_sdg1: 0 7812500000 snapshot 25456/83886080 112
snap_sdj1: 0 7812500000 snapshot 25928/83886080 112
snap_sdh1: 0 7812500000 snapshot 25352/83886080 112

But it doesn't move from those values (with mdadm doing nothing eating 
100% cpu as mentioned earlier).


Any suggestions how to proceed would very be appreciated.
