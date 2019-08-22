Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB421988B8
	for <lists+linux-raid@lfdr.de>; Thu, 22 Aug 2019 02:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfHVAwW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 21 Aug 2019 20:52:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44501 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfHVAwW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 21 Aug 2019 20:52:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so2317531plr.11
        for <linux-raid@vger.kernel.org>; Wed, 21 Aug 2019 17:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3BwfZddPISiWTAepsKyyO7g4JReLyhQhGUH1LXlCS2o=;
        b=Ui0ETZ/tulBr+t0qixC90uvNkSgfKD9PNXkRxjNbt3C0isf0xUBDVPI0UOJ1bl7hqH
         1E91A3d6WNAlYgq5pOF4m68c9DC+e2jPy/53Co/tcM6XDDXhETsekb2o5JypddeDRSBd
         vAK9lpwEUA7dkT8vrXeFm+PWLLs62Um7Lzqbgo4ev/X8vvo0u3M990J0zM+VmtYjO/y/
         zPomr6FwPU+zEDXcW21ZV5szEDQrSd4juwSnN2CCy3QiynNYa2300GiMfauyXdylQUC0
         HyahDSxNiie92H7CMNFBmHcFDpUxHucrkRrRPHX3idJj3GMEHBK1H9RghNxF0muj7BG4
         3w+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3BwfZddPISiWTAepsKyyO7g4JReLyhQhGUH1LXlCS2o=;
        b=EBrrVRQt1OJ47HT4JrisjZ10HLrmWJbxPnP5gi73lOHCny0KQTYqWHaxgMGCJyMMlb
         7v9ZoLh4bt5LDaPNCpcVCvZoRdHZkHntoVS4kXZHdrhG5QG/CAGjNjD8MDD8ao1yjdw0
         aGwqY1YKdCrViD2L5Ami3lkKIKnWUvlmady2aQ9uUsywi3Ve8M6d6ZgDBNPI/sD3PK2T
         osQWIvAywbI+eCcGinfK9xnB2mcIjVDKCFRIdy0jyplFRnDOFAeHA0xA/CEaGyWBRLWx
         w9ELIUtmes+L+lO/037ICpJpmRpUhcqUHUldeWG3hY6KhkI8HyjrYgA1VtM381iC0VLa
         Q55g==
X-Gm-Message-State: APjAAAVZ2E9das1RN9WBmoq6BGUrEZJf/qh8UHd3W1mMSav2ewFkDQRu
        aXs4JYtCu13mNlRUnIvttoktu2dQtUeNfg==
X-Google-Smtp-Source: APXvYqxZW67yIMYAvt8jiQooj2oM34aIr9lW1IFfNzsyZmtwcvYEe+Ck8cMHeCQz0ebA69bRu+jZpg==
X-Received: by 2002:a17:902:306:: with SMTP id 6mr36608582pld.86.1566435141401;
        Wed, 21 Aug 2019 17:52:21 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id m125sm25154988pfm.139.2019.08.21.17.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 17:52:20 -0700 (PDT)
Subject: Re: [PATCH] md: update MAINTAINERS info
To:     NeilBrown <neilb@suse.com>, Song Liu <songliubraving@fb.com>,
        linux-raid@vger.kernel.org
References: <20190821184525.1459041-1-songliubraving@fb.com>
 <51398ca1-44de-3b80-6381-54f594b6c251@kernel.dk>
 <87h86aghmo.fsf@notabene.neil.brown.name>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e24cfc57-9855-c85d-b875-da8fa4c90a60@kernel.dk>
Date:   Wed, 21 Aug 2019 18:52:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87h86aghmo.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 8/21/19 6:37 PM, NeilBrown wrote:
> On Wed, Aug 21 2019, Jens Axboe wrote:
> 
>> On 8/21/19 12:45 PM, Song Liu wrote:
>>> I haven't been reviewing patches for md in the past few months. So I
>>      ^^^^^^^
>>
>> have?
>>
>>> guess I should just be the maintainer.
>>
>> I'm fine with it. Neil?
> 
> I'm very happy that Song has stepped up here.  He appears to be
> appropriately responsive and competent at review - neither too accepting
> or too dismissive.
> I support his request to officially be maintainer.

Thanks Neil, and I do agree. Song, I'll apply your patch with some of
the verbiage changed.

-- 
Jens Axboe

