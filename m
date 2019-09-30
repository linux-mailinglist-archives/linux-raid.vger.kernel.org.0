Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F686C28A8
	for <lists+linux-raid@lfdr.de>; Mon, 30 Sep 2019 23:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbfI3VTb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Sep 2019 17:19:31 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:34100 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732441AbfI3VTb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Sep 2019 17:19:31 -0400
Received: by mail-io1-f43.google.com with SMTP id q1so42267500ion.1
        for <linux-raid@vger.kernel.org>; Mon, 30 Sep 2019 14:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m/LrtoWUOAElKXZiQrQNNml65KOe/R9njvZ3MiYiqdg=;
        b=vC1wQv2aaVU1OF/m84cCkkT4T3n4vWTdRLohaTkZMntdDTBlT+hKAJSsOGzKzobHjE
         aOlV8TbwJtCPVpl8GDLul/zsRV2o0YIg66Xyqnyd2G/Zd16t6EyVgnDveoxkMeUegMUv
         UMnQe06q1h3VcuwEbIERF7ZMvPiaKILlacNDHKNFl5whZCvAAsqHT2l5oXa7TlPTrUP8
         tFRlmn90cld9gprhMauPc7C01ywamXbcJVTXttfnARqOGqR5828o/z7YZyDmA8QILMFX
         21AHWBliI/WLznn5CUvTVG3Pcupz503wmoHNTzZMT+PFUY6E4d6/I5X/wETr3Hg3Pruo
         rmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m/LrtoWUOAElKXZiQrQNNml65KOe/R9njvZ3MiYiqdg=;
        b=PXcPpgs0D9W3YQx3yXRdrxUY9ZruboajmtnKvswFsVqpayzidHwo4ZAq/RI0IquR8U
         Rg4e0Fts2CHmaPc+CtUkuYbedqDa7YjGGQCu5eaCyyX5EDlPEVVX2R0AtKwomyOyfBVd
         q5YHGiqJOW6nl+asYTelbW1aLVzXSeeR9R1hLO02QVuTz6YdCOIjPkPjWtiPPgMG/e8I
         g4FEDt9ZsMc6HQGtFL9Q3CBK56YSpz/oXkRDsVXKxUhvZbLbsaRXPzRXRwOSSq7OUnwS
         Lc3XK2RDfX3CG9yq/hcUC2Cz4g1WV0qYOOf4nmiV8RT8PoE3aVuqR/hFPZW+NcZstV1u
         hdsw==
X-Gm-Message-State: APjAAAVvdMjnAEbnEEr6ztirZuTSQzB8RooNj/Usb5ap/q2EPEIrd+ZV
        UeCTVAyaW2oPQGF1cOFZIvFMNSzVLNM=
X-Google-Smtp-Source: APXvYqw0G8nMR34dCLiBNlJtqUbsYXVFMBlOleYP3ryeHq4DKWauMULGyG4guiPYz4ChEIuzo4d8fw==
X-Received: by 2002:a63:8c52:: with SMTP id q18mr77161pgn.284.1569872135887;
        Mon, 30 Sep 2019 12:35:35 -0700 (PDT)
Received: from [172.19.249.239] ([38.98.37.138])
        by smtp.gmail.com with ESMTPSA id t14sm14135432pgb.33.2019.09.30.12.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 12:35:35 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH, RESEND] imsm: close removed drive fd.
To:     Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20190930120104.6876-1-mariusz.tkaczyk@intel.com>
Message-ID: <28ef3a2e-b608-1aa6-78a6-5db6d7cbd044@gmail.com>
Date:   Mon, 30 Sep 2019 15:35:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190930120104.6876-1-mariusz.tkaczyk@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9/30/19 8:01 AM, Mariusz Tkaczyk wrote:
> When member drive fails, managemon prepares metadata update and adds
> the drive to disk_mgmt_list with DISK_REMOVE flag. It fills only
> minor and major. It is enough to recognize the device later.
> 
> Monitor thread while processing this update will remove the drive from
> super only if it is a spare. It never removes failed member from disks list.
> As a result, it still keeps opened descriptor to non-existing device.
> 
> If removed drive is not a spare fill fd in disk_cfg structure
> (prepared by managemon), monitor will close fd while freeing it.
> 
> Also set this drive fd to -1 in super to avoid double closing because
> monitor will close the fd (if needed) while replacing removed
> drive in array.
> 
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
> ---
>   super-intel.c | 3 +++
>   1 file changed, 3 insertions(+)

Hi Mariusz,

I actually already applied this one, but didn't get it pushed up. It'll 
go up next time I push (I am on a plane right now, so once I am back on 
the ground).

Cheers,
Jes

