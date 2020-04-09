Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1801A3C00
	for <lists+linux-raid@lfdr.de>; Thu,  9 Apr 2020 23:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgDIViQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Apr 2020 17:38:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44775 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgDIViQ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 9 Apr 2020 17:38:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id c15so13724278wro.11
        for <linux-raid@vger.kernel.org>; Thu, 09 Apr 2020 14:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/5WkaMmXoLxOhSvTQCqussFf/lc51d/o10CLGlwfCVw=;
        b=iIrSNWD4LEvygsHJ+8Bd+a7mh0WXVaotpdlK07I2h9bRprAk3GwwrZMxSrG6JaGv5y
         WgHLEwnZbFOvAb2uPk+65ZbTBjTjr0hN8OAeEIDj5MxZB+ytzy48HBjIeLj5438ksP1C
         GSKBmpTT7oVkPY+QpkaI9LUhdnNW8IYVBVgncMSi00YQ1aJbu7v+So+y+FTt6S4CDkbD
         5h3eGSPH9UWMZuY+YXQRE6rsLlbhPDw1MoK2N/0eKW+h44CwC5MEFeD/nBsdIrs/imxZ
         y8dnq2LkYbbgLr2JtXrtMvBctn7yMLGOF6WvTS/R38J7yodBvfy7vHxSxAcBTBhf2vVj
         a4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/5WkaMmXoLxOhSvTQCqussFf/lc51d/o10CLGlwfCVw=;
        b=BgCWOzQSKSVwakRgtgX+37wr/9x27siFFmsvTkM69E7jbgsqIOoObaP7SSVMIArlgX
         9lWw+gOJe3ey5bKZS1+NJcVCOvIdYYDNWk2TBr67IaGHm8u0XsSGLMaopL0AC8LXAJy+
         s1BMKHMAbc9DSduO5cRf9/VvYAzHCQDTmfBT8WF43/Z+1AWkWLfiEjMXTx3Yn3y28hsi
         xHaTVd7mwO4Vq9vchhXuVBHX0tz2ieXwxaTX2LQ0azIxKeKG7008h0H2OuR/R02KVEYq
         s52VjHHtHc0WBau88j1YSc6SjP6hJadbP1SAeEaEeMme5RJD7lAxQiZyzrX/3UI1kmzM
         vGBg==
X-Gm-Message-State: AGi0PuZCRuqX/a0sV0eAJe0qmVQfxMvEKA+IN4tbrovXLs0vN/PvYLLv
        xiMy3szyuh/CTZGS4+g45Gz+aA==
X-Google-Smtp-Source: APiQypKD7waMg2LarDt3ZBGPQnO9xN1iwVIaGMLh3zJU9tigxpbt0XyU8lMusDjhnyP/b5o3simWfw==
X-Received: by 2002:adf:d4ce:: with SMTP id w14mr1206038wrk.135.1586468295065;
        Thu, 09 Apr 2020 14:38:15 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4805:100:34d4:fc5b:d862:dbd2? ([2001:16b8:4805:100:34d4:fc5b:d862:dbd2])
        by smtp.gmail.com with ESMTPSA id k133sm26928wma.0.2020.04.09.14.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 14:38:14 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: Re: [PATCH] raid5: use memalloc_noio_save()/restore in
 resize_chunks()
To:     Coly Li <colyli@suse.de>, songliubraving@fb.com
Cc:     linux-raid@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Michal Hocko <mhocko@suse.com>
References: <20200402081312.32709-1-colyli@suse.de>
 <fa7e30b9-7480-6c03-0f43-d561fed912fb@cloud.ionos.com>
 <5f27365b-768f-eb69-36ec-f4ed0c292c60@suse.de>
Message-ID: <204e9fd0-3712-4864-2bf5-38913511e658@cloud.ionos.com>
Date:   Thu, 9 Apr 2020 23:38:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5f27365b-768f-eb69-36ec-f4ed0c292c60@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 07.04.20 17:09, Coly Li wrote:
> On 2020/4/5 11:53 下午, Guoqing Jiang wrote:
>> On 02.04.20 10:13, Coly Li wrote:
>>> -    scribble = kvmalloc_array(cnt, obj_size, flags);
>>> +    scribble = kvmalloc_array(cnt, obj_size, GFP_KERNEL);
>> Maybe it is simpler to call kvmalloc_array between memalloc_noio_save
>> and memalloc_noio_restore.
>> And seems sched/mm.h need to be included per the report from LKP.
> The falgs can be,
> - GFP_KERNEL: when called from alloc_scratch_buffer()
> - GFP_NOIO: when called from resize_chunks().
>
> If the scope APIs are used inside scribble_alloc(), the first call path
> is restricted as noio, which is not expected. So I only use the scope
> APIs around the location where GFP_NOIO is used.

Thanks for the explanation. I assume it can be distinguished by check 
the flag,
eg, FYI.

if (flag == GFP_NOIO)
     memalloc_noio_save();
kvmalloc_array();
if (flag == GFP_NOIO)
     memalloc_noio_restore();
> Anyway, Michal Hocko suggests to add the scope APIs in
> mddev_suspend()/mddev_resume(). Then in the whole code path where md
> raid array is suspend, we don't need to worry the recursive memory
> reclaim I/Os onto the array. After checking the complicated raid5 code,
> I come to realize this suggestion makes sense.

Hmm, mddev_suspend/resume are called at lots of places, then it's better to
check if all the places don't allocate memory with GFP_KERNEL.

And seems In level_store(), sysfs_create_group could be called between 
suspend
and resume, then the two functions (kstrdup_const(name, GFP_KERNEL) and
kmem_cache_zalloc(kernfs_node_cache, GFP_KERNEL)) could be triggered by the
path:

sysfs_create_group ->internal_create_group -> kernfs_create_dir_ns ->
kernfs_new_node -> __kernfs_new_node

Not know memalloc_noio_{save,restore} well, but I guess it is better to 
use them
to mark a small scope, just my two cents.

Thanks,
Guoqing
