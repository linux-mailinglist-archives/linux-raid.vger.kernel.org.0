Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07857138FD6
	for <lists+linux-raid@lfdr.de>; Mon, 13 Jan 2020 12:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAMLKw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 13 Jan 2020 06:10:52 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:37994 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgAMLKw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 13 Jan 2020 06:10:52 -0500
Received: by mail-ed1-f42.google.com with SMTP id i16so8077720edr.5
        for <linux-raid@vger.kernel.org>; Mon, 13 Jan 2020 03:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gB9V8qXF2rHl+R6Qs3+Et39V71kM95tp905vvHBm+FQ=;
        b=hGVbq7usjUKljeRlyz2q2lMm6sZSl3e0O7nABxTXief+0etzSyuR4sIyGnaIlSIyTv
         XD4da6ViK5qWsC4hrW1ygl/dEIljSkpg/3xvemJ8lfgQClL3p3Ohcvp+rX1VvnXCqs/G
         K1l8y4AGMIkKgll4pSk3K63TyhHJzzmSzMD/lrwBvIAz/ZtqhRlh/ur2fFYpqgdkQa4q
         2tBiGwdrzRAXiyr4DOekOWRIMcOLeRmC4OvBV2jHIaFfo8oj9VmcAorLFwn8I12ai2Xj
         Pr/7yRHn+L/6r6HH38fzgQV0mFGsQXl5vJbXqwVLOmdz44w5qy/Nr+h44xbaoiIAcT/h
         lx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gB9V8qXF2rHl+R6Qs3+Et39V71kM95tp905vvHBm+FQ=;
        b=C6s7u28B+u6IZXiSUU7EToEDglghpm52z5Zx5L5aAni9f7xIKrj/FaYgyHRM5jU0ax
         5LYRcblnodLK92sPU8sZUVSKPFqJ7kUU0gGKKFarIXfxPHV2OO2PGDLvnr8jazVopZ+R
         0PPveOrwvNCekrQwZ8R2a/WPB4aBDYUjOsR9ruPRGc9MQtZetBkgGCAALZCzfuOk3X0o
         2nMGLyieuY8qvGRVIJdy4L1Gc8bEQpNzpXKel4Hhwwv5sQnb4srTeIoqXilmZvMKwm8t
         B8Wqz0iGOFPA+Fc6rrEkwTg9sjAyHA/KsmMCIjUCrkc43hf4pLLveYg02fkffyCw6+w4
         /iag==
X-Gm-Message-State: APjAAAXlehWgP4yp6O/iDzzi2R3NkYqTnWT6VNW/ACBITHKMmkNxKr3m
        GEKzqaN5HBRp+IaymWiQZ72G5y9UDb4=
X-Google-Smtp-Source: APXvYqybMts4i4+a8CV98K1ghb/x6kZNz02i5/gWM5U7TItIYAjpV7NRTn/bKC7ypXcMn0/1o/uZdg==
X-Received: by 2002:a17:906:d935:: with SMTP id rn21mr13360626ejb.147.1578913850101;
        Mon, 13 Jan 2020 03:10:50 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:d9a:2eb8:42f1:918d? ([2001:1438:4010:2540:d9a:2eb8:42f1:918d])
        by smtp.gmail.com with ESMTPSA id qw15sm457995ejb.92.2020.01.13.03.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2020 03:10:49 -0800 (PST)
Subject: Re: hung-task panic in raid5_make_request
To:     Alexander Lyakas <alex.bolshoy@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>, liu.song.a23@gmail.com
References: <CAGRgLy4Yi1HNqNO0MLq5xjRRgWe7EaByRYF5sA3fFVa1tmpNvA@mail.gmail.com>
 <09e8a682-3f91-6b34-58a0-235dbb130901@cloud.ionos.com>
 <CAGRgLy4netkysnF6CS2MkVBp17ipZr5D4Z4wQ6B0w2XXg51OkQ@mail.gmail.com>
 <CAGRgLy6xx5dT0StoiUNLThVknLvNUR5Emc0mEg_dnJmWth3=9A@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <2a9e8231-c5e2-8f63-2fc4-bed24fc21959@cloud.ionos.com>
Date:   Mon, 13 Jan 2020 12:10:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAGRgLy6xx5dT0StoiUNLThVknLvNUR5Emc0mEg_dnJmWth3=9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Alex,

On 1/12/20 8:46 AM, Alexander Lyakas wrote:
> Hi Guoqing,
>
> We have tried the proposed patch, but still hit the hung-task panic in
> the same place[1]. How can we debug this further?

Can you print the information (atomic_read(&conf->active_stripes),
conf->max_nr_stripes and conf->cache_state)  just before the
wait_event_lock_irq? Then we can verify which condition is not meet
here. Also pls dump the value of sysfs nodes, something like.

linux:/sys/block/md5/md # find -mindepth 1 -maxdepth 1 -type 
f|sort|xargs -r egrep .


BTW, could you try latest kernel? And is it possible to reproduce the panic?

Thanks,
Guoqing
