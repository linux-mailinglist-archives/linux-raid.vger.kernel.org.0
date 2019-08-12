Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEB5B8A840
	for <lists+linux-raid@lfdr.de>; Mon, 12 Aug 2019 22:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfHLURv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 12 Aug 2019 16:17:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32893 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfHLURu (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 12 Aug 2019 16:17:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id v38so11784105qtb.0
        for <linux-raid@vger.kernel.org>; Mon, 12 Aug 2019 13:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vj8R9A4R1ulIZ0Xkq3Yru1jCzsK7B1JuQwL69s5oCS8=;
        b=EW0otaZBbaldUN7IGt6wbySnloLDMu9+xjXiylljF7mvZhXiAdnEaCkNbBDRCQ82ED
         YddbUYjvxyDvtx3qMlvbTsPRDM36OdCMKo2zJ8mkTFRpWoryATDf0RVTKRiF+R7ilMhk
         K6oHqiADDq/2Uf5f9Rta3y/J1vuUQ+fF3nVS02lRaKg9oPDahtnPxKg9QRjm/XEp5hpq
         y6mbt138OpHDynmllFZJ6jvrQKXkkl0wI0BIGdpdqLtQESkLjUES9XN2qNAfTdlBVRwn
         G9CuDujtQLSozUy/5FpKs8MLEOC+6k+c01zWZIZu+q8NkxCrHdfiktSQ0eykwTunT1D0
         1+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vj8R9A4R1ulIZ0Xkq3Yru1jCzsK7B1JuQwL69s5oCS8=;
        b=EPmjAZkJ1eOpjBtbsexNs4j4IYB0J0j+PWQDoHeDy2q46HxsmRFnOk5Cs9vHt380+m
         D1YZdoPgowaL9xw0cvOpFfeLFLPeNWu2nhjmvPBM8rj0RLjDO8V7Fh6m4afZ0Dz5EtU5
         iG4h/bXTIcmcNLuYi4MYs5L+1RU7kVs03u6koJg1Qy5Wq0HGKH5tmokB+AlaluZMyTnp
         Vv4EbMB2YLcrKyZZzgNk+RUGKQzXV0piPluq8QK+qJB4ejBAdsRkJrX/D4THKsU/6Mgj
         LX+q6896f3+gmT8NReBvE0V7uWY2/S+bFpSwPALhFi/WiiUgqnEO3KZYe4EAiekzwVF2
         Y1oA==
X-Gm-Message-State: APjAAAX00ko0JIOZzeOPNeT0WpI0P6rHCM42O4d9WmsLF9kf1vakdHAn
        E8XVNlXuWF/HawCnzbjif6OaTwSN
X-Google-Smtp-Source: APXvYqyQebjdQG5znQU5a4+6JYrkm60A6h7bzrP6J9SM/zAemzJb4alCUECnJagCIqh3CGVoIbaT2g==
X-Received: by 2002:aed:3327:: with SMTP id u36mr26282499qtd.94.1565641069282;
        Mon, 12 Aug 2019 13:17:49 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c9::1085? ([2620:10d:c091:480::d0c4])
        by smtp.gmail.com with ESMTPSA id x15sm11240049qki.48.2019.08.12.13.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2019 13:17:48 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH v2 2/2] udev: add --no-devices option for calling 'mdadm
 --detail'
To:     Coly Li <colyli@suse.de>, linux-raid@vger.kernel.org
References: <20190731052930.108303-1-colyli@suse.de>
 <20190731052930.108303-2-colyli@suse.de>
Message-ID: <a2213f1a-cf92-38d9-6151-49cdc59f1fc3@gmail.com>
Date:   Mon, 12 Aug 2019 16:17:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190731052930.108303-2-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/31/19 1:29 AM, Coly Li wrote:
> When creating symlink of a md raid device, the detailed information of
> component disks are unnecessary for rule udev-md-raid-arrays.rules. For
> md raid devices with huge number of component disks (e.g. 1500 DASD
> disks), the detail information of component devices can be very large
> and exceed udev monitor's on-stack message buffer.
> 
> This patch adds '--no-devices' option when calling mdadm by,
> IMPORT{program}="BINDIR/mdadm --detail --no-devices --export $devnode"
> 
> Now the detailed output won't include component disks information,
> and the error message "invalid message length" reported by systemd can
> be removed.
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> Reviewed-by: NeilBrown <neilb@suse.com>

Applied!

Thanks
Jes

