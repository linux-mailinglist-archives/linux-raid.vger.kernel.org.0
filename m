Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 927CF5CFA4
	for <lists+linux-raid@lfdr.de>; Tue,  2 Jul 2019 14:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfGBMkI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 2 Jul 2019 08:40:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42019 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBMkI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 2 Jul 2019 08:40:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id b18so13745631qkc.9
        for <linux-raid@vger.kernel.org>; Tue, 02 Jul 2019 05:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yHtx68ZAjHL05zsf8LKl4/8R07AsUTWAQujQvNWAE98=;
        b=oHwuFj4e9SAbvqhR2aQMwet8YcjiY+Ithrn86T/ZrGtZgeMAf8/KjO9c3jVW8u9quC
         nVf9CR+mChysXl97I3KmSjwcNGtAP2+kqf2D9g4fG2riUQu7cZ9V8n2UZ4tWQSByiq1X
         lZ2ACn1dptflYSNFDdxUsqq4pd2517L4XvjjJqelSF9cUVQ44Umex5uJg5XrKVJM48LR
         bdIrx/6SwlHvIU+U7GUPoyq90fjqm4UG72fUTm5m1b1bDussDqbcRoAXYHERL+nqaG4x
         xGm1HfE44WnS6xoLOgQK5N7i1CuZ2p8BNeujFbb3XTLwDfgtGl3V91s0yUXnciO++2NQ
         7urQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yHtx68ZAjHL05zsf8LKl4/8R07AsUTWAQujQvNWAE98=;
        b=ct1fxmbmwjweKf0PpyqnSjV2OdGYwLgeopNul2eEeKl6sRIG5h6TuefcxeIQgmonrC
         6g/mHf2JYkkYwf50efawbzyEHbthXyhICs3KYfLE4/2Q/O3xPDQ+iEHPpumOZkajSdw7
         lTYjakpsObuZug8DJip+ngbuJrtmmNma9GCYsXsEzWKc+S55Xi9z6lqdd72pVAd63fXX
         rUu9B98fW+GWWTsLl0aEt8iKXewVKTX8DrX/4Zq/fYOOhwFofKT9o//kxoqqtZSTzRDx
         Z9aHrVO1rGiVRrq973t0U1Bp8f1Ga+VvIIJunyb6GS3ag89zrR/Yh5Qupk9aUNye6yxE
         XYzw==
X-Gm-Message-State: APjAAAVJXJyMov81l2VIcGNqQHIGUlnAP3m2ZNyBH2WXlhBVh4ngHu2n
        ieQfc2NVSOD1hi4u7SYFSLs3lVP3mXs=
X-Google-Smtp-Source: APXvYqyaquUX9f6AenGMpZynnOJgAOiBgp6e0NDnprvZG0nsVyR2t8cManaI4YRnOM+6V3/W0Eu2Bg==
X-Received: by 2002:a37:7dc1:: with SMTP id y184mr6834062qkc.58.1562071206929;
        Tue, 02 Jul 2019 05:40:06 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::1019? ([2620:10d:c091:480::c41e])
        by smtp.gmail.com with ESMTPSA id l63sm6068001qkb.124.2019.07.02.05.40.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 05:40:06 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] Enable probe_roms to scan more than 6 roms.
To:     Roman Sobanski <roman.sobanski@intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20190702112927.22733-1-roman.sobanski@intel.com>
Message-ID: <3f7d2810-27ba-0e30-8049-962be43f56db@gmail.com>
Date:   Tue, 2 Jul 2019 08:40:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190702112927.22733-1-roman.sobanski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/2/19 7:29 AM, Roman Sobanski wrote:
> In some cases if more than 6 oroms exist, resource for particular
> controller may not be found. Change method for storing
> adapter_rom_resources from array to list.
> 
> Signed-off-by: Roman Sobanski <roman.sobanski@intel.com>
> ---
>  probe_roms.c | 98 ++++++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 56 insertions(+), 42 deletions(-)

Applied!

Thanks!
Jes


