Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED69B1D4E45
	for <lists+linux-raid@lfdr.de>; Fri, 15 May 2020 14:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgEOM6y (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 15 May 2020 08:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgEOM6y (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 15 May 2020 08:58:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4812C061A0C
        for <linux-raid@vger.kernel.org>; Fri, 15 May 2020 05:58:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id y3so3488438wrt.1
        for <linux-raid@vger.kernel.org>; Fri, 15 May 2020 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7O/fJkYoT2XFZC/JR0UOIibuKRKY239o3R1VxpozTQY=;
        b=BIhTSrEAkPlGtKtzmdpFWHEPpItUrmIj0IrZzLCoXmrZxrSgPVueTdX+6hbqk68E3w
         aaG9tBthgcgecwhhb1i+QcyNmpz2WijOhRNhnSPpAvNvJDayEyG+g0QXUfm3HYfQMyKt
         mSQZGFy9I+0u5iHZG2vQt4U/Va43hA2G+DolP7IUGMzx7FRN0gRVxGHB0qSp822zGP7M
         UrkLfcMMG4Z5xGQnrDeympWs1zQFzX/rw24F17pdkkpAr/UkjuMDTrsr0AuQM+dYT4VB
         KrMDhmAcJl+cSnKuJdj5xQTPuLKnePvoobtuJCa5Zptm0AjILIxznWv/gQvwV+HHQQOQ
         YDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7O/fJkYoT2XFZC/JR0UOIibuKRKY239o3R1VxpozTQY=;
        b=H+zPr/8DNayeqkmI4BTd4zQfF2RBkEiKyGAFIMsxGRDOfM3WeXMhmw/HM2IT6cBuaM
         HJWuNfKPOUrGEYWhTorFsK4Vj7YSGUHcn1qeKCrOTIZbQGORIZqwmk9etGf0Utc3WBd8
         FogpVxI2fSoK2TzetKnpAANds9NHhkTSbU1Tcu2Qpy16wrS3NMlIM73hk+HEY4Qgjmzk
         W32SHZ2FFMOs4kp+svy2F7rZqExGMBNh2nk+23CPdNvNJST+C+qcwCuPYWUpBe6O0tCJ
         UR56+PutV3/k1sc+hc+Koouu2EcWqHIwVNohwg1HQwlOXPwTdMHJ8L+kM9DaU3z8pFC/
         43VQ==
X-Gm-Message-State: AOAM532SG0Tu/fsaktRy7RpxH26BdkQ3K6QjL+4HyIODlblxlEsPHHXS
        JsCknH5C1saj2Jv/lA72JrUBTkWeAJ05AQ==
X-Google-Smtp-Source: ABdhPJxbPj6ZuU0DkA4u/1o14Rs9kW3IxWLU2G1ofaV5tzJy+PUv4oSvRdLU95eNFyV3LTVxEoV5IQ==
X-Received: by 2002:a5d:51c9:: with SMTP id n9mr4129734wrv.84.1589547530927;
        Fri, 15 May 2020 05:58:50 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48fe:dd00:e80e:f5df:f780:7d57? ([2001:16b8:48fe:dd00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id y185sm3481279wmy.11.2020.05.15.05.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 05:58:50 -0700 (PDT)
Subject: Re: raid6check extremely slow ?
To:     Wolfgang Denk <wd@denx.de>,
        "Andrey Jr. Melnikov" <temnota.am@gmail.com>
Cc:     linux-raid@vger.kernel.org
References: <20200510120725.20947240E1A@gemini.denx.de>
 <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>
 <20200511064022.591C5240E1A@gemini.denx.de>
 <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com>
 <20200511161415.GA8049@lazy.lzy>
 <23d84744-9e3c-adc1-3af1-6498b9bcf750@cloud.ionos.com>
 <20200512160712.GB7261@lazy.lzy> <20200513060753.81496240E1A@gemini.denx.de>
 <sq72pg-98v.ln1@banana.localnet> <20200515115417.BD9BA240E1A@gemini.denx.de>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <af96aff0-a940-f036-450a-bbb801064c4a@cloud.ionos.com>
Date:   Fri, 15 May 2020 14:58:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515115417.BD9BA240E1A@gemini.denx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/15/20 1:54 PM, Wolfgang Denk wrote:
> Dear "Andrey Jr. Melnikov",
>
> In message <sq72pg-98v.ln1@banana.localnet> you wrote:
>>> ...
>>> gcc -O2  -o raid6check raid6check.o restripe.o sysfs.o maps.o lib.o xmalloc.o dlink.o
>>> /usr/bin/ld: sysfs.o: in function `sysfsline':
>>> sysfs.c:(.text+0x2707): undefined reference to `parse_uuid'
>>> /usr/bin/ld: sysfs.c:(.text+0x271a): undefined reference to `uuid_zero'
>>> /usr/bin/ld: sysfs.c:(.text+0x2721): undefined reference to `uuid_zero'
>> raid6check miss util.o object. Add it to CHECK_OBJS
> This makes things just worse.  With this, I get:
>
> ...
> gcc -Wall -Wstrict-prototypes -Wextra -Wno-unused-parameter -Wimplicit-fallthrough=0 -O2 -DSendmail=\""/usr/sbin/sendmail -t"\" -DCONFFILE=\"/etc/mdadm.conf\" -DCONFFILE2=\"/etc/mdadm/mdadm.conf\" -DMAP_DIR=\"/run/mdadm\" -DMAP_FILE=\"map\" -DMDMON_DIR=\"/run/mdadm\" -DFAILED_SLOTS_DIR=\"/run/mdadm/failed-slots\" -DNO_COROSYNC -DNO_DLM -DVERSION=\"4.1-77-g3b7aae9\" -DVERS_DATE="\"2020-05-14\"" -DUSE_PTHREADS -DBINDIR=\"/sbin\"  -o util.o -c util.c
> gcc -O2  -o raid6check raid6check.o restripe.o sysfs.o maps.o lib.o xmalloc.o dlink.o util.o
> /usr/bin/ld: util.o: in function `mdadm_version':
> util.c:(.text+0x702): undefined reference to `Version'
> /usr/bin/ld: util.o: in function `fname_from_uuid':
> util.c:(.text+0xdce): undefined reference to `super1'
> /usr/bin/ld: util.o: in function `is_subarray_active':
> util.c:(.text+0x30b3): undefined reference to `mdstat_read'
> /usr/bin/ld: util.c:(.text+0x3122): undefined reference to `free_mdstat'
> /usr/bin/ld: util.o: in function `flush_metadata_updates':
> util.c:(.text+0x3ad3): undefined reference to `connect_monitor'
> /usr/bin/ld: util.c:(.text+0x3af1): undefined reference to `send_message'
> /usr/bin/ld: util.c:(.text+0x3afb): undefined reference to `wait_reply'
> /usr/bin/ld: util.c:(.text+0x3b1f): undefined reference to `ack'
> /usr/bin/ld: util.c:(.text+0x3b29): undefined reference to `wait_reply'
> /usr/bin/ld: util.o: in function `container_choose_spares':
> util.c:(.text+0x3c84): undefined reference to `devid_policy'
> /usr/bin/ld: util.c:(.text+0x3c9b): undefined reference to `pol_domain'
> /usr/bin/ld: util.c:(.text+0x3caa): undefined reference to `pol_add'
> /usr/bin/ld: util.c:(.text+0x3cbc): undefined reference to `domain_test'
> /usr/bin/ld: util.c:(.text+0x3ccb): undefined reference to `dev_policy_free'
> /usr/bin/ld: util.c:(.text+0x3d11): undefined reference to `dev_policy_free'
> /usr/bin/ld: util.o: in function `set_cmap_hooks':
> util.c:(.text+0x3f80): undefined reference to `dlopen'
> /usr/bin/ld: util.c:(.text+0x3f9c): undefined reference to `dlsym'
> /usr/bin/ld: util.c:(.text+0x3fad): undefined reference to `dlsym'
> /usr/bin/ld: util.c:(.text+0x3fbe): undefined reference to `dlsym'
> /usr/bin/ld: util.o: in function `set_dlm_hooks':
> util.c:(.text+0x4310): undefined reference to `dlopen'
> /usr/bin/ld: util.c:(.text+0x4330): undefined reference to `dlsym'
> /usr/bin/ld: util.c:(.text+0x4341): undefined reference to `dlsym'
> /usr/bin/ld: util.c:(.text+0x4352): undefined reference to `dlsym'
> /usr/bin/ld: util.c:(.text+0x4363): undefined reference to `dlsym'
> /usr/bin/ld: util.c:(.text+0x4374): undefined reference to `dlsym'
> /usr/bin/ld: util.o:util.c:(.text+0x4385): more undefined references to `dlsym' follow
> /usr/bin/ld: util.o: in function `set_cmap_hooks':
> util.c:(.text+0x3fed): undefined reference to `dlclose'
> /usr/bin/ld: util.o: in function `set_dlm_hooks':
> util.c:(.text+0x43e5): undefined reference to `dlclose'
> /usr/bin/ld: util.o:(.data+0x0): undefined reference to `super0'
> /usr/bin/ld: util.o:(.data+0x8): undefined reference to `super1'
> /usr/bin/ld: util.o:(.data+0x10): undefined reference to `super_ddf'
> /usr/bin/ld: util.o:(.data+0x18): undefined reference to `super_imsm'
> /usr/bin/ld: util.o:(.data+0x20): undefined reference to `mbr'
> /usr/bin/ld: util.o:(.data+0x28): undefined reference to `gpt'
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:221: raid6check] Error 1
>

I think we need a new uuid.c which is separated from util.c to address 
the issue,
will send patch for it later.

Thanks,
Guoqing
