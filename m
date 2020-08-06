Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8414A23E455
	for <lists+linux-raid@lfdr.de>; Fri,  7 Aug 2020 01:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgHFXXp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 Aug 2020 19:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFXXo (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 6 Aug 2020 19:23:44 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F29FC061574
        for <linux-raid@vger.kernel.org>; Thu,  6 Aug 2020 16:23:43 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id u185so928pfu.1
        for <linux-raid@vger.kernel.org>; Thu, 06 Aug 2020 16:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HifY62CWXdZ2L+TS2HqHxDQIYXR0g1EkuCYk8qv3pfQ=;
        b=styde1gsBxJYDeVghDpuOSbxJiVnUp5eXflb1Hd4Ph/ZqPAZ/Trz/7X1Xu1yecJaE1
         FvA446jZM1qJpJGRRKisIy0pKPisKm5bglkvFApx30CH/bUV14cJgAtCM3F9nzZ3l8TD
         r89riWOVNqFgIQR9h09peVj6S4oMH3KTbb8/2Kxxw2tYgtPC0VtP9Y3M/kSXy8QJqsMX
         sLw5DAbhHgBnNFf55xytW3xi6DbyxTM6G8fLaQoJYw1kabaZd/MaV7HjqmdwOgf+n3qV
         rQXHw7uY0MC58OcJ56lbn2s2bfAW4SdG/A6x/2oQl4bpoU8tKim9vJPiFx/4yIy0PFqN
         HXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HifY62CWXdZ2L+TS2HqHxDQIYXR0g1EkuCYk8qv3pfQ=;
        b=uGRQiXUNVMtdSCpoE4R5Bgsm0ziqzN3kbV1mrybDwd3Yww9/sViCqSW6x6wXJ/royF
         1o84o6LKkWyqjHTLKyHsWG8FwpJ5tS13RAiCUHpcPhjnr7f+PA084W0YvOXm0w6eXs74
         Oiavn9zeE83Xw7+QaQXtvsL3HZd0iuv1nBpC6S9DMDx1RWuOvWEO4QULAgMDj7aAfzNQ
         APTAGCPPqwRvz2nrDLMb5AP5jPJhfS8d6ug5pPhkWmYK06fKUOiqxI2vaxxLh3pATmgl
         6Dfbnjngh7P9QSZYnTiZF9o8ubPyDMMW9+8Zz0zDRIPd7Lviz7nrD5JFNAuhwAA1nayE
         drmw==
X-Gm-Message-State: AOAM531Gt4kcYMRJiJ0ljXzA+pS7vA28TzVUyOyNAHLUf/PPcChmWQjM
        8oOTbWQFy235yb83nZZo7CZdLw==
X-Google-Smtp-Source: ABdhPJxgcQJaAMN7rtRt6XMy+L4jt0wn6BClI6SMyTM1vzsv/nnskI7QGd3yxCAMxjTTuPzyoXieqQ==
X-Received: by 2002:aa7:8e0c:: with SMTP id c12mr10390140pfr.38.1596756219806;
        Thu, 06 Aug 2020 16:23:39 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d2sm8299790pgp.17.2020.08.06.16.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 16:23:39 -0700 (PDT)
Subject: Re: [GIT PULL] md-next 20200806
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Junxiao Bi <junxiao.bi@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <DC5BBD6B-C93C-4376-8120-DF48249190F7@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8f461cfa-fc3a-cc96-9471-ec914b77405a@kernel.dk>
Date:   Thu, 6 Aug 2020 17:23:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DC5BBD6B-C93C-4376-8120-DF48249190F7@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 8/6/20 2:31 PM, Song Liu wrote:
> Hi Jens, 
> 
> Please consider pulling the following fixes for md-next on top of your for-5.9/drivers
> branch. 

Pulled, thanks.

-- 
Jens Axboe

