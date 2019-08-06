Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C52DD8293A
	for <lists+linux-raid@lfdr.de>; Tue,  6 Aug 2019 03:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbfHFBdP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 5 Aug 2019 21:33:15 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:43134 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfHFBdP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 5 Aug 2019 21:33:15 -0400
Received: by mail-qk1-f172.google.com with SMTP id m14so35969822qka.10
        for <linux-raid@vger.kernel.org>; Mon, 05 Aug 2019 18:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=0k+cuamUdDVdN4d6B4zYoRDL9NpuUH05OEeJy4cmmco=;
        b=rpBbUeHoFKP/TgEqVpqzijV5goomCN0I29kNkBAqaNtvADaOSlWlchKIJQ/w1CXD86
         F3XpH3OooH2mRcesUHDYF/9haf0zK1zX97/4xjx5EP/NxESyNunlLxLi69uYeoAQ/hCE
         IcjUqkTynw/WDu2PS39XaFznu/5PSwRl2bV84s8MnbFLZ8TGkQ7jeSXAC8bW+vsFFi2K
         6uPV65B1IfLqMpqB1agzm/IocJNVh+fiATpXPE1etT294asYvrCWULcJ+kEyMzIbuh58
         Tto6VmALNXT7vwyNRJKUSJHwKcX3Fta7d2DZ/FTn8i+gapOWwwRG2S4ExuGl6eBCbMfK
         bRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0k+cuamUdDVdN4d6B4zYoRDL9NpuUH05OEeJy4cmmco=;
        b=VRa26mgsWy7HUZm/gSmMWpGuYa0G7MPc72Zqnj6GM+TUg3OxczXHGTEOKjvwsPCJ1y
         k7NgtZiqWnwpT5fSng85AQqehI+yZESMs7491acdxEJnbKDHdia6pqRVBnjgydYzMHjy
         fhTIkNFPNOMtxTDE0Aso8hjhS72g9rqJfZKe9P8p/vYN6dKcPOVBCXrZHm+/sJf5mj0k
         EKB2j4a+pQy48AikjUGLLEQNqhZWtJULssG0Muj2QGGNnS5ACbsmw2FNfGoYMQbqZ4MI
         MNpAH3lqUBg5sdAwyjAnnp1vr63aXZ7BeXo1l4Q01pcB9mFimBzvfPBlJmFKPDpdVu61
         1FZg==
X-Gm-Message-State: APjAAAXgXndfi6aEsKNqO1Nw+Eq2JH1HP2Xcs8l622DlW6bAiYoywUHV
        dXU8+EjdTXkU6YK0IrdKVDuczFmC970=
X-Google-Smtp-Source: APXvYqwFk2lCRZCe1Yhe+rPTNfzeQoKSr5DtqCNmE/0sSIEvmucnoaEA6hxT4NXph4XnUr6L991lhA==
X-Received: by 2002:a37:484a:: with SMTP id v71mr1081607qka.29.1565055193750;
        Mon, 05 Aug 2019 18:33:13 -0700 (PDT)
Received: from [10.10.10.77] (c-73-114-170-41.hsd1.ma.comcast.net. [73.114.170.41])
        by smtp.gmail.com with ESMTPSA id f133sm39160144qke.62.2019.08.05.18.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 18:33:12 -0700 (PDT)
Subject: Re: Raid5 2 drive failure (and my spare failed too)
To:     Reindl Harald <h.reindl@thelounge.net>, linux-raid@vger.kernel.org
References: <8006bdd5-55df-f5f6-9e2e-299a7fd1e64a@gmail.com>
 <019fb3fb-38e3-4080-2198-d5049a9cb46e@thelounge.net>
From:   Ryan Heath <gaauuool@gmail.com>
Message-ID: <0658bed2-ebc1-5de1-c2fa-4beb8d488972@gmail.com>
Date:   Mon, 5 Aug 2019 21:33:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <019fb3fb-38e3-4080-2198-d5049a9cb46e@thelounge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

So this is the approximately response I expected however I do want to 
pose a few additional queries:

So if I read the output correctly it appears that /dev/sdb is the most 
recent drive to fail it does appear that it is only slightly out of sync 
with the rest four drives that are currently functioning, what is it 
exactly that keeps things from being forced back online?

If as I suspect /dev/sdb was the last drive to fail... I have looked at 
it via smartctl and the drive still appears to be functional so wouldn't 
recreating be an option? I think this is the area which I was suspecting 
I might need guidance.

On 8/4/19 4:03 PM, Reindl Harald wrote:
>
> Am 04.08.19 um 20:49 schrieb Ryan Heath:
>> I have a 6 drive raid5 with two failed drives (and unbeknownst to me my
>> spare died awhile back). I noticed the first failed drive a short time
>> ago and got a drive to replace it (and a new spare too) but before I
>> could replace it a second drive failed. I was hoping to force the array
>> back online since the recently failed drive appears to be only slightly
>> out of sync but get:
>>
>> mdadm: /dev/md127 assembled from 4 drives - not enough to start the array.
>>
>> I put some important data on this array so I'm really hoping someone can
>> provide guidance to force this array online, or otherwise get this array
>> back to a state allowing me to rebuild.
> there is not enough data for a rebuild on a RAID5
>
> you now learned backups the hard way as well as watch your log in
> context of "and unbeknownst to me my spare died awhile back"

