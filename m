Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6830F1E153C
	for <lists+linux-raid@lfdr.de>; Mon, 25 May 2020 22:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390258AbgEYUa3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 16:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389950AbgEYUa3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 May 2020 16:30:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D53C061A0E
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 13:30:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i15so18180998wrx.10
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 13:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=GKk9d/aEyCvK++4ivlbLe/vfCzRUYGBV8yhzXOabBSA=;
        b=b+n3huj3G/vM6Por6skhL6ui2+ltjo4faeXJmbvekE+PWOfJQ6tOTZCFaR5N7o8U08
         P9l7+BbS8KkY+6Gkna78DsINd7D0Zkju2UeuhLxyvU6b92HS814RIABpRgMyOwSQYpXA
         NC8dU3Oxh9d+A6foXudIpuxMLrx7A1IHb/XQ0TwjdhZSkOWuQy0GOEAN1NZznYM6XGg7
         Dfay3eR/csSOmsXrT2B07EzxcjKHxjBC1Tlf6bxNAmgRykn7ghXwQ4ARPnIb6C8CAVQm
         sPwLDNPntWCQI3+OgV08U758HNGX0jRvnIJvwrhF2JuwtMmxDLLEEd9GTFRYuImsdRAT
         /hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=GKk9d/aEyCvK++4ivlbLe/vfCzRUYGBV8yhzXOabBSA=;
        b=fePPDaTddGOTK/Rumjm94PWN7PNL8phceq6KGHDdI00YFNkYs2XOvzHS1IVmkVsf/w
         83HibIT8dq/DhjhrJ5Riwx2LqD7/HrMtXtIT6Wy+ojukyTMO5g2sc+jFuyMWJoLwZAko
         m4c2XBmNAVMf9f3rXn1Ppv8YCcCWytxWcL5CgO7yyC4Gahf07tPrOv4eU4J9w38NLMnL
         ItRn1NgsQ0eKPmttX353pfbme2p+df2hQIvviMoXligTczXfnm9qgrdvlX9/3YgVpp/l
         sZb1m7zpfBYQeK60hPt9cbrs6xrdxpe41zUG0HSw+SSifHSMTXR+uDGP51gdjK23dYSr
         YgfQ==
X-Gm-Message-State: AOAM531TaDzuvy+B8zADLdC7rzuLZJ6GFEvfX0jNmBOgME0Os+8iAPJh
        qiZY4myCYkj7gxMJ9SdifHnS89/z8uo=
X-Google-Smtp-Source: ABdhPJwKs+fJFc/FoWpvpNLDPGBib0iu9sqe9Ify/BCLkvLavprUHJqeA3+jGWkQhibZ4CJeLIV0Mw==
X-Received: by 2002:a5d:628c:: with SMTP id k12mr9116321wru.211.1590438625955;
        Mon, 25 May 2020 13:30:25 -0700 (PDT)
Received: from [192.168.188.88] ([46.28.163.233])
        by smtp.gmail.com with ESMTPSA id z132sm20577902wmc.29.2020.05.25.13.30.25
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 13:30:25 -0700 (PDT)
Subject: Re: help requested for mdadm grow error
Cc:     linux-raid@vger.kernel.org
References: <7d95da49-33d8-cd4d-fa3f-0f3d3074cb30@gmail.com>
 <5ECC09D6.1010300@youngman.org.uk>
 <ff4ea9cd-ab35-0990-5946-4a72d4021658@gmail.com>
 <5ECC1488.3010804@youngman.org.uk>
 <4891e1e8-aaee-b36b-4131-ca7deb34defd@gmail.com>
 <alpine.DEB.2.20.2005252132080.7596@uplift.swm.pp.se>
From:   Thomas Grawert <thomasgrawert0282@gmail.com>
Message-ID: <103b80fa-029f-ecdc-d470-5cc591dc8dd0@gmail.com>
Date:   Mon, 25 May 2020 22:30:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.2005252132080.7596@uplift.swm.pp.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


Am 25.05.2020 um 21:33 schrieb Mikael Abrahamsson:
> On Mon, 25 May 2020, Thomas Grawert wrote:
>
>> The Debian 10 is the most recent one. Kernel version is 
>> 4.9.0-12-amd64. mdadm-version is v3.4 from 28th Jan 2016 - seems to 
>> be the latest, because I can´t upgrade to any newer one using apt 
>> upgrade.
>
> Are you sure about this? From what I can see debian 10 ships with 
> mdadm v4.1 and newer kernels than 4.9.
>
Thanks to Mikael to hit my nose :)

System is now at Debian 10 with Kernel 5.5.0.0.bpo.2-amd64. mdadm is at 4.1:

root@nas:~# cat /etc/os-release
PRETTY_NAME="Debian GNU/Linux 10 (buster)"
NAME="Debian GNU/Linux"
VERSION_ID="10"
VERSION="10 (buster)"
VERSION_CODENAME=buster
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"

root@nas:~# uname -r
5.5.0-0.bpo.2-amd64

root@nas:~# mdadm -V
mdadm - v4.1 - 2018-10-01

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
              State : active, FAILED, Not Started
     Active Devices : 5
    Working Devices : 5
     Failed Devices : 0
      Spare Devices : 0

             Layout : left-symmetric
         Chunk Size : 512K

Consistency Policy : unknown

      Delta Devices : 1, (4->5)

               Name : nas:0  (local to host nas)
               UUID : d7d800b3:d203ff93:9cc2149a:804a1b97
             Events : 38602

     Number   Major   Minor   RaidDevice State
        -       0        0        0      removed
        -       0        0        1      removed
        -       0        0        2      removed
        -       0        0        3      removed
        -       0        0        4      removed

        -       8        1        0      sync   /dev/sda1
        -       8       81        4      sync   /dev/sdf1
        -       8       65        3      sync   /dev/sde1
        -       8       49        2      sync   /dev/sdd1
        -       8       33        1      sync   /dev/sdc1

root@nas:~#


It seems, mdadm.conf or anything else is broken?

