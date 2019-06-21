Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 409EC4E019
	for <lists+linux-raid@lfdr.de>; Fri, 21 Jun 2019 07:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfFUFic (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 21 Jun 2019 01:38:32 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:35892 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfFUFic (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 21 Jun 2019 01:38:32 -0400
Received: by mail-ed1-f41.google.com with SMTP id k21so8275525edq.3
        for <linux-raid@vger.kernel.org>; Thu, 20 Jun 2019 22:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UAi1Ufn/I7CExCL+LiBq5reQ5FPkVtn72StWjaNKz2A=;
        b=ABolE5rUvpzVUJuCh2MAhf+h2efL7Pmr0cFNYc9boenbQb8hwvjiJ1t4st4bvXek/L
         lxu26LXUDo32l72Pnn3CagleYgp/Ohw24BWhnQQzZcWrzd3GINEfprmZP8Jylk8IxSNG
         YdIGzq20U47h5lgorUZCvOZ1FxvOq76vxBgV/TMjwnnH5VTJBx3eWBMcTn7f+JcrOS3b
         u4LBKK/7dbhYCtuyKtx5Kwbk7Co4vIyyfTbndnWhEKS97KrQD22mHpQ9eQmf9KRFGU02
         Tm7E3RamoJPH+483dApVLqBFExeNnFw7/4w3xvBYhZJdDGDNt4Uiwhj1I5+n8J2AxmQU
         wHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UAi1Ufn/I7CExCL+LiBq5reQ5FPkVtn72StWjaNKz2A=;
        b=mYKO+H6pBf8E0mfwGqfvD49Kt3Dg8RvZ4cPQNF6V5tiUdrSSz/zZlCCGZeL86I5uEF
         ESE0tbLgxofzeYHomKFy6SKcHQ85yZdvMDPO6N/UqN1IxR4GOOc4ze2OYlkqBgP+hVEU
         QZfBHe+Go3TK29mkt3fzzcLRecRzKa/tGfiICkJXvKC9SAirA89t9MLBYrhrP8lczi/0
         8RGCOYPiGHF9TCay/oMx+6N0UX+ZKzkTg7HHen56dajMPPIHe0Z9oYko2Eg/XaG5O2Vs
         NafW90i9PqUkIBZC5QUm6TnfoOC7VkZ7JbFZnoiNFD4ion3nmb4H9yi/Y3vAz+GKYUB3
         lGgA==
X-Gm-Message-State: APjAAAVnncaSU3t4Badwx77Gg1GL4u0p6I89plxWP8g9F0iz1j/2fmyk
        QAoyk32M/nHnC3OLJN7QwUs9lg==
X-Google-Smtp-Source: APXvYqzSUyDYvFJ/IxKFUs+81S8xndWHVUbxrggoPu6lRFZICUUSxoWRSTEh/obfDRAe7txSIbrvdA==
X-Received: by 2002:a17:906:f91:: with SMTP id q17mr85613895ejj.297.1561095510237;
        Thu, 20 Jun 2019 22:38:30 -0700 (PDT)
Received: from [192.168.1.208] (ip-5-186-115-204.cgn.fibianet.dk. [5.186.115.204])
        by smtp.gmail.com with ESMTPSA id 9sm235438ejg.49.2019.06.20.22.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 22:38:29 -0700 (PDT)
Subject: Re: [GIT PULL] md-next 20190620
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Kernel Team <Kernel-team@fb.com>, Guoqing Jiang <gqjiang@suse.com>
References: <FBC7C647-6761-4DDE-AC4D-A7E0DDA5E9E2@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d94e5266-571e-2460-d444-a0e31eed23b7@kernel.dk>
Date:   Thu, 20 Jun 2019 23:38:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <FBC7C647-6761-4DDE-AC4D-A7E0DDA5E9E2@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/20/19 6:08 PM, Song Liu wrote:
> Hi Jens,
> 
> Please consider pulling the following changes for md on top of your
> for-5.3/block branch.

Pulled, thanks.

-- 
Jens Axboe

