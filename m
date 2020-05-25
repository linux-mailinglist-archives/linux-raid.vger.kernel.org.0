Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883A71E135E
	for <lists+linux-raid@lfdr.de>; Mon, 25 May 2020 19:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389605AbgEYRZ6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 13:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389251AbgEYRZ5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 May 2020 13:25:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E5DC061A0E
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 10:25:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c3so13466286wru.12
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 10:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=zPhJgnn6wDgU62I2NgtytcEWHUfOhC1lV0Uq7n4z1wE=;
        b=qCV5B5acseRsii3a6DQApZHturySlGlgcD3iJYqSFbruaZi80ilfoEW10qYYP/oboc
         AN3PeK6Ata4kGTsQ5OLIMvSF4ZH9rpbpCFgOo/VEvgP7T1FSrSDJ5qZfinfQf1vxyOYl
         nLZSRYHcx291toDF9sFh0s6cYvA57ZgPlUJNJ2+JNx6OctDIVGsNWT4r9GE8DdhdcyQy
         jVKzHIvLvsG4twkGJQjOkUieOJnD7WIDLSrxmAfGbnHdA+GAGx9EVfRjyyEiyLu+dvku
         KyXd+4Gz72ri0Wi2KFcX1fMCou5xfO/esRnf3ruFCjM1Kvn+hfQzW93h7cUOPSluHITq
         0cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=zPhJgnn6wDgU62I2NgtytcEWHUfOhC1lV0Uq7n4z1wE=;
        b=cwsEyAaLc6Hg8FL+6cUvpFQlk+zL7yXDnx51d7s1QUjfNAWz1QSr89xxp9UIWFh6Pz
         tc3NSwAbIeLIpGRuA3eu5JD4+x82m63jCaG+/QSOP1KPEad1cxz5m+c40hms28IcvkD/
         jip3udgmatI/awOykPoWtLy7LvTPj3LC1nOvawOqS6PB21NwcltnbmxSAiIbsmdqtTC1
         KGmdeawPgKurOjf7ticxLHJ4JcIAb8SfTAAMxjit8HRDESyoVgZp4XXhkDydUbMzJmA5
         +IAkLcwDu6R3qPs+vVQr6A36tNtdYpos9trDD4w2LH0IlmmqaNDBAztDpDhcwVKkC8Ir
         LzVg==
X-Gm-Message-State: AOAM531zHrOvN70rQYyjqkhyUHNWGRo1Kda0uZsrut+YSEM632e7937m
        /h+oQnL+8pn2/om+gC35d8FKJUR/GmA=
X-Google-Smtp-Source: ABdhPJww2uQFzJGJXAXSCWT2vQ62+zL58KTi18s4pHsqOkH2z2D3KLFIK9nVUl0yBNQ8Vq9W3dbO2A==
X-Received: by 2002:a5d:5006:: with SMTP id e6mr15514058wrt.170.1590427555214;
        Mon, 25 May 2020 10:25:55 -0700 (PDT)
Received: from [192.168.188.88] ([46.28.163.233])
        by smtp.gmail.com with ESMTPSA id g82sm2373883wmf.1.2020.05.25.10.25.54
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 10:25:54 -0700 (PDT)
To:     linux-raid@vger.kernel.org
From:   Thomas Grawert <thomasgrawert0282@gmail.com>
Subject: help requested for mdadm grow error
Message-ID: <7d95da49-33d8-cd4d-fa3f-0f3d3074cb30@gmail.com>
Date:   Mon, 25 May 2020 19:25:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi there,

I´m pretty new here and already tried finding a solution with aunt 
google - without luck. So hopefully someone of you can help me:

I´m running a NAS with 4x 12TB WD120EFAX using mdadm Raid5 on the basis 
of Debian 10.

Because of capacity and speed I tried adding another WD120EFAX by simply
"mdadm --grow --raid-devices=5 /dev/md0 /dev/sd[a-e]1 
--backup-file=/tmp/bu.bak"

Everything worked... but during reshape, I had a power interruption. 
When power was back, I tried to restart NAS but the md disappeared.

Long story short... after asking aunt Google I managed to get the raid5 
up "active, not started":

root@nas:~# mdadm -D /dev/md0
/dev/md0:
         Version : 1.2
   Creation Time : Sun May 17 00:23:42 2020
      Raid Level : raid5
   Used Dev Size : 18446744073709551615
    Raid Devices : 5
   Total Devices : 5
     Persistence : Superblock is persistent

     Update Time : Mon May 25 16:05:38 2020
           State : active, Not Started
  Active Devices : 5
Working Devices : 5
  Failed Devices : 0
   Spare Devices : 0

          Layout : left-symmetric
      Chunk Size : 512K

   Delta Devices : 1, (4->5)

            Name : nas:0  (local to host nas)
            UUID : d7d800b3:d203ff93:9cc2149a:804a1b97
          Events : 38602

     Number   Major   Minor   RaidDevice State
        0       8        1        0      active sync   /dev/sda1
        1       8       17        1      active sync   /dev/sdb1
        2       8       33        2      active sync   /dev/sdc1
        4       8       49        3      active sync   /dev/sdd1
        5       8       65        4      active sync   /dev/sde1


I already tried to repair the md0 using the mentioned way from 
https://serverfault.com/questions/776170/mdadm-grow-power-failure-dev-md2-no-longer-detected-raid5 
... however, the raid didn´t start.

Unfortunately the raid is not mountable (cannot read superblock), even 
readonly. So it´s impossible to run a backup of stored data, for now.

Any help is highly appreciated.

Greetings

Thomas

