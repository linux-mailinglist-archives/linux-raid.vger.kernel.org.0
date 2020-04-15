Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A711A9E4A
	for <lists+linux-raid@lfdr.de>; Wed, 15 Apr 2020 13:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897795AbgDOLxI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Apr 2020 07:53:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40690 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409447AbgDOLsS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 15 Apr 2020 07:48:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id h26so7337615wrb.7
        for <linux-raid@vger.kernel.org>; Wed, 15 Apr 2020 04:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vdHYb8YBWB/pFdRZY5ouQIfp7WX0AVYLBWImbwDiRYE=;
        b=U8Z3TFCC+1AD1plWNiKnxyTUT7BRdtJf8ky2kp15Bf6qEZ5DT5mobO/g/x1LPD/4SJ
         7etn2tHFg4MQC3WwtdRC1SYrgfOYHy0NUu2JL7HIlEGpTztzG8XwacHkQ+qTgS0V7Jgz
         38hKrZ5dKDBrGgY1XqsirOL/RFs7ovxmXtMtIsjGBzCJ6WCqTMNmS3lmnZ4c8eYk28iA
         qwQPUF/kQOJmPU5+88rlRdexuzZqAnGpmZBDDPoOTUBgbDoH079tnXddI76iR6p5p6jk
         B349SlRrum+8U4sBg7agodDHhep39+KlFZXTiEVXEtuRMT8x3HpDJgMb+S0uQkcCQlkI
         iXOw==
X-Gm-Message-State: AGi0PubMgMTooulIZoGohO6mmNJBZRYpP9BffUFfLzhfJz5SrfszHkMU
        MUmZmDQXFxFRs9qo1Gav91c=
X-Google-Smtp-Source: APiQypJmWZUwoP1/Tut1vVUr6VbvuQz8B+wjTe4V9Ncq5AgslhKJWfeQ0N3ahnZhOXLI/0VeR2qC6g==
X-Received: by 2002:adf:ef51:: with SMTP id c17mr28266232wrp.130.1586951296235;
        Wed, 15 Apr 2020 04:48:16 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id f63sm22147050wma.47.2020.04.15.04.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 04:48:15 -0700 (PDT)
Date:   Wed, 15 Apr 2020 13:48:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Coly Li <colyli@suse.de>, songliubraving@fb.com,
        linux-raid@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH] raid5: use memalloc_noio_save()/restore in
 resize_chunks()
Message-ID: <20200415114814.GJ4629@dhcp22.suse.cz>
References: <20200402081312.32709-1-colyli@suse.de>
 <fa7e30b9-7480-6c03-0f43-d561fed912fb@cloud.ionos.com>
 <5f27365b-768f-eb69-36ec-f4ed0c292c60@suse.de>
 <204e9fd0-3712-4864-2bf5-38913511e658@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <204e9fd0-3712-4864-2bf5-38913511e658@cloud.ionos.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu 09-04-20 23:38:13, Guoqing Jiang wrote:
[...]
> Not know memalloc_noio_{save,restore} well, but I guess it is better
> to use them to mark a small scope, just my two cents.

This would go against the intentio of the api. It is really meant to
define reclaim recursion problematic scope. If there is a clear entry
point where any further allocation recursing to FS/IO could deadlock
then it should be used at that level. This might be a lock which is
taken from the reclaim or like this case a device is suspended and no IO
is processed so anything that would wait for an IO or rely on IO making
progress in the reclaim path would deadlock.

Please have a look at Documentation/core-api/gfp_mask-from-fs-io.rst
and let me know is something could be made more clear or explicit.
I am more than happy to improve the documentation.
-- 
Michal Hocko
SUSE Labs
