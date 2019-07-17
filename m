Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 695D66BEC5
	for <lists+linux-raid@lfdr.de>; Wed, 17 Jul 2019 17:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfGQPEb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 17 Jul 2019 11:04:31 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:34322 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfGQPEa (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 17 Jul 2019 11:04:30 -0400
Received: by mail-ed1-f45.google.com with SMTP id s49so26149035edb.1
        for <linux-raid@vger.kernel.org>; Wed, 17 Jul 2019 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WhI6M+AGuoSqUafxwo0CaEiW+3k0rl14ZRgGHOfbffI=;
        b=Mf6HBiAY4H4YoRik+2dCP19yJviO4V8/1LTSuElPpmnO8eJMteaU4MwIKLYvJldlok
         XU/wyEsBrAhuwdBNDsQiWs20rdb9fGpoUlBDUDWGieiMOdJg/DiBXCCRVrqd9dB0TsIZ
         s6amHsX+P7R884pOHrBfAvWa8G887IIb65fyjq4DW6/09fxFxCl32DmzaTvarnhy870/
         +BaPLB4eE5HqKoztZ/9cDiVLfx2MUM/iffXYEityR/M9I3TP5Sf6ZtnI1ZYlfZM2znC+
         VPKajSfTM7gLQy7yb9C90q9fAAnwE7fXrSa4mo6q+B9xXTw1egP9OahbDzgRE4oNessP
         SZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WhI6M+AGuoSqUafxwo0CaEiW+3k0rl14ZRgGHOfbffI=;
        b=BM1b9b2Wco4ko/7Q4B8PEEZ3v/j6OmJNqv6C2CW8h7aHPz+GQWa4ODYbwoRZZEyvXz
         uKYNiF9Z+jK2DMQmNNLbSJv4KFUJtb+JMsXwNtCLmMb1IyamiJeHjoHO/zPbOy8rqUzy
         eucnn4o2IUR5BYIfIAmMEGHccR2gkH2IhHoWmMYuJtRgrD+qfWbRAq5VBKHymTUMSkIf
         uWtWLR9RQyJyqWfiOXEJFTBykdkty4c7Az7SNfLjx2cwM6d+KSyl0OAibs+Bh1rFjGQc
         qnggp+AksGsfgXG1VoraWBvfC9BGBZ6hrqt6rJS/A7s2Eg/wECF2IXqn+vSP7KwD6dx2
         fCAg==
X-Gm-Message-State: APjAAAUrrhc3tRKFkD6gmlh6VxVLW2YJOyc9KP+XJw2cCmQTeLyz8RC6
        VrwdQ4fLKDbQG4F4OIME0gmY6+pGzxw=
X-Google-Smtp-Source: APXvYqxr5GByxNs9FTY6OyQjFRO2MIMH2GY+tYCZowNQgKxne0S5h1ODI5ameNlfoXdU+Qdguf4nWQ==
X-Received: by 2002:a17:906:cec9:: with SMTP id si9mr3722497ejb.38.1563375868614;
        Wed, 17 Jul 2019 08:04:28 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:aca9:a21f:3714:dd32? ([2001:1438:4010:2540:aca9:a21f:3714:dd32])
        by smtp.gmail.com with ESMTPSA id l50sm7091122edb.77.2019.07.17.08.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 08:04:28 -0700 (PDT)
Subject: Re: slow BLKDISCARD on RAID10 md block devices
To:     Lennert Buytenhek <buytenh@wantstofly.org>,
        linux-raid@vger.kernel.org
References: <20190717090200.GD2080@wantstofly.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <ba5f3065-2659-866e-d431-73d9bb7b7295@cloud.ionos.com>
Date:   Wed, 17 Jul 2019 17:04:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190717090200.GD2080@wantstofly.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 7/17/19 11:02 AM, Lennert Buytenhek wrote:
> Hello!
> 
> I've been running into an issue with background fstrim on large xfs
> filesystems on RAID10d SSDs taking a lot of time to complete and
> starving out other I/O to the filesystem.  There seem to be a few
> different issues involved here, but the main one appears to be that
> BLKDISCARD on a RAID10 md block device sends many small discard
> requests down to the underlying component devices (while this doesn't
> seem to be an issue for RAID0 or for RAID1).
> 
> It's quite easy to reproduce this with just using in-memory loop
> devices, for example by doing:
> 
>          cd /dev/shm
>          touch loop0
>          touch loop1
>          touch loop2
>          touch loop3
>          truncate -s 7681501126656 loop0
>          truncate -s 7681501126656 loop1
>          truncate -s 7681501126656 loop2
>          truncate -s 7681501126656 loop3
>          losetup /dev/loop0 loop0
>          losetup /dev/loop1 loop1
>          losetup /dev/loop2 loop2
>          losetup /dev/loop3 loop3
> 
>          mdadm --create -n 4 -c 512 -l 0 --assume-clean /dev/md0 /dev/loop[0123]
>          time blkdiscard /dev/md0
> 
>          mdadm --stop /dev/md0
> 
>          mdadm --create -n 4 -c 512 -l 1 --assume-clean /dev/md0 /dev/loop[0123]
>          time blkdiscard /dev/md0
> 
>          mdadm --stop /dev/md0
> 
>          mdadm --create -n 4 -c 512 -l 10 --assume-clean /dev/md0 /dev/loop[0123]
>          time blkdiscard /dev/md0
> 
> This simulates trimming RAID0/1/10 arrays with 4x7.68TB component
> devices, and the blkdiscard completion times are as follows:
> 
>          RAID0   0m0.213s
>          RAID1   0m2.667s
>          RAID10  10m44.814s

IIUC, there is no dedicated function for discard request for raid10 and raid1, raid1
has better performance than raid10 because of the new barrier mechanism or it doesn't
need to translate the address from virtual to physical.

Thanks,
Guoqing
