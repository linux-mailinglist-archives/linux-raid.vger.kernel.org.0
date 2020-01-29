Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0889514D31A
	for <lists+linux-raid@lfdr.de>; Wed, 29 Jan 2020 23:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgA2WcR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 29 Jan 2020 17:32:17 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:34512 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgA2WcR (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 29 Jan 2020 17:32:17 -0500
Received: by mail-ot1-f43.google.com with SMTP id a15so1269341otf.1
        for <linux-raid@vger.kernel.org>; Wed, 29 Jan 2020 14:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=ceXV6PVS2rNd2v4spBbYfooMIfBC49B2iFSQjROScsU=;
        b=p2NRaFJIAICFq43Xey4GFfeexlxg0wh9syYo/6AZbcLaVU21tR2KhwACr1leu1tuaS
         E6c8Xc81m/18AvWHfhAyJrVVUwOSDqizObcsBejY/XUA3VW/o6oe4hrT//9RFgVeaL4D
         af1kCpl1pilCAbc5A87oZbUZ8mhhnb5OVl5uFqm5gnIPLjVw3D4qxRLsG0vJJJfIXbfK
         Zo1p/A4ZJkU6+quv50kgipNUCDqU6EfWfU1AkHMlFJlNPtkptVmm37UhXxedSIJDjgOb
         08oQxFebH5KE+pCPkazYRqrTTvmWGjn25qRqQ9yAH3uMmxXmg+7fFATdsJisq86pXbZV
         HnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ceXV6PVS2rNd2v4spBbYfooMIfBC49B2iFSQjROScsU=;
        b=HLJeHe1dQzFucmE3pqRaKxh96kBv8Nzw3xmygswbEmx4Z3PixFHVYkmx5axo3Qov5m
         NkvQ4a1nmyLbFf90RCdtY7Xm2gBRH8z8PoUT4JktIabzhr6rZlmnVmSE0lrNJmWHFfGd
         KPVcYnCPSYRxHYM2zumHLkdDssb/etIx3k2aizmxqvWbTWO0YaEKE/Qe8HH1p/w52+8o
         /DFZjvc07EDP4NcOe0RQ7e6MJiVSjsFg9NXfLnyT5xC0sEVNGI+E345iH1I+by+Al6lS
         XIS9QRmNPiAOB7+q4BBmQGsgf3annF5MNZBHRypq8H6kZV/9skawWO+1UBVT7At5fJ+3
         Tf2A==
X-Gm-Message-State: APjAAAUjXiKmfR4UxJKSmmEm9CyDAMUTRNa58DYjo9f7NNa7Bj2aRpP8
        7JqaxTZFu6+KxHnuC46ABCL4Uj45
X-Google-Smtp-Source: APXvYqzjQEuqs2aJ+UpfdTfwU2aSgRphl52QXHl/qSc8XXItp8tF7dMErnpsC/3rSE0f13WV/C+73A==
X-Received: by 2002:a9d:4c14:: with SMTP id l20mr1194213otf.125.1580337136522;
        Wed, 29 Jan 2020 14:32:16 -0800 (PST)
Received: from [192.168.3.59] ([47.187.193.82])
        by smtp.googlemail.com with ESMTPSA id b9sm1143358otf.56.2020.01.29.14.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 14:32:16 -0800 (PST)
Subject: Re: Is it possible to break one full RAID-1 to two degraded RAID-1?
To:     Reindl Harald <h.reindl@thelounge.net>,
        Linux Raid <linux-raid@vger.kernel.org>
References: <1120831b-13e6-6a5d-8908-ee6a312e7302@gmail.com>
 <aa41492c-1ad7-070f-9bc6-646977364758@thelounge.net>
From:   Ram Ramesh <rramesh2400@gmail.com>
Message-ID: <2c4fedff-a1c9-6ca3-5385-72b542a4a0b4@gmail.com>
Date:   Wed, 29 Jan 2020 16:32:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <aa41492c-1ad7-070f-9bc6-646977364758@thelounge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 1/28/20 10:09 PM, Reindl Harald wrote:
>
> Am 29.01.20 um 04:17 schrieb Ram Ramesh:
>> I have my entire debian 9.0 installation (root/usr/home etc) in two nvme
>> RAID-1 mirror. Is it possible to break them in to two degraded arrays?
>>
>> Specifically I want to do this.
>>
>> 1. Break current debian 9 full RAID1 into two degraded RAID1 A & RAID1  B
>> 2. Boot only A and upgrade to debian 10 and make sure it works
>> 3. If it works, add B back into A and get Debian 10 in fully complete RAID1
>> 4. If it does not work, I boot B and add A back and get back debian 9
>>     in full working RAID1
> i would simply remove one disk completly and in case i want to keep the
> upgraded system wipe it and resync afterwards or when i want back to the
> old one put it back and wipe the modified
>
> full resync, done

Thanks. I thought of this, but both disk in question are nvme ssd with 
manually added heat sink. It will be a hassle to remove and reinstall. I 
think I will go with the back up rather than remove disk physically. I 
was just exploring if I can avoid back up by using one of the RAID1 
disks. After all, mirror just means that.

Regards
Ramesh
