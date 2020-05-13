Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1089A1D1639
	for <lists+linux-raid@lfdr.de>; Wed, 13 May 2020 15:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387927AbgEMNpB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 13 May 2020 09:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387722AbgEMNpA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 13 May 2020 09:45:00 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A383C061A0C
        for <linux-raid@vger.kernel.org>; Wed, 13 May 2020 06:45:00 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i68so14156874qtb.5
        for <linux-raid@vger.kernel.org>; Wed, 13 May 2020 06:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/ta3ifTaPJ/0rDD07puw7JQDgE0G/6GDnbbcU5lLI8g=;
        b=qVbaSU53i5h3ZgWW9KZq6JK2F3qLPmKeUxF2g2yNrSWCykQyaOA6NVWPuGCLRIjTyM
         p/SzYSFa9AmZtnA2PjA4ZUTTYeZXnYT/RWhZGtlk68AXRg6lKW2Iq3+vPY/qtTeSfX2r
         8y+evPOVGVr2ONNzV7qmdr102wFPeG6+GllebRm/b8SsPQnNJxdhM0wLtH9FCmlAjzN4
         l2mE6WZJIPIeUlgpsd++DV3H8hlSF/h+2kkiLSpZ5pthRIsY8RuLciYOmjZ2cBO24372
         wfPoPkrzqvGpWQbL96tVBQ8FKMq8dFKKhRIvG0lVG0kkm/LhHRN4E1vujBa763BYFKy4
         uryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/ta3ifTaPJ/0rDD07puw7JQDgE0G/6GDnbbcU5lLI8g=;
        b=WeZAkrdLYHXRlQIZ8jpWWIUGMStVzyZucF6zyj/pbB7/Wj2jNAyy+J9kL7iVspGDgK
         OFFDKmJkAdZtl3nV5H0DjCtNbUeemaQ6Few7AyOttE8Na/rWmqaByL2idVAZvdLifPtO
         60pKIj/FFkQYwKbeIvR+4MC0fTPi7QZ/6y88H+sw4amIMvTudZGwbnCm/TX/5CE35x2A
         Tl4JwZ4aKL2dcYx95kJDEpMEvtd4SIXsPxazeseGHr185owuM7VZ6Hdy5JN9FC2aeN7G
         BjM9rrf63UBUK8V3MKH0wS4N4rjQBhgc9oEgu436CzXycf95ROEP7TxELbVUEoSorCv9
         G1NA==
X-Gm-Message-State: AGi0PuZaZn+48oukLgt9cIXRrrzLqvj2RTBKVU1nes7wEUCaHTts1pwK
        Tpy62M0sRS+gzkmeNkDA5GK4PYrMBqA=
X-Google-Smtp-Source: APiQypKA+eEv9Dy+EnxxUaoMGbJzAZu9m55ttpumcaJf7leBToyFoomUQyO3uZPNn7ysLBF+jPQ/Og==
X-Received: by 2002:aed:3b75:: with SMTP id q50mr28052370qte.23.1589377499254;
        Wed, 13 May 2020 06:44:59 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e1::1007? ([2620:10d:c091:480::1:8ed8])
        by smtp.gmail.com with ESMTPSA id q17sm13905270qkq.111.2020.05.13.06.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 06:44:58 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] Use more secure HTTPS URLs
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-raid@vger.kernel.org
References: <20200513132707.16744-1-pmenzel@molgen.mpg.de>
Message-ID: <f2d4fa4e-697f-033a-1144-d4ff30e48ec3@gmail.com>
Date:   Wed, 13 May 2020 09:44:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513132707.16744-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/13/20 9:27 AM, Paul Menzel wrote:
> All URLs in the source are available over HTTPS, so convert all URLs to
> HTTPS with the command below.
> 
>     git grep -l 'http://' | xargs sed -i 's,http://,https://,g'
> 
> Cc: linux-raid@vger.kernel.org
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Some of this looks valid, but we're not going back to update existing
ANNOUNCE files.

Jes

> ---
>  ANNOUNCE-3.0                     | 4 ++--
>  ANNOUNCE-3.0.1                   | 4 ++--
>  ANNOUNCE-3.0.2                   | 4 ++--
>  ANNOUNCE-3.0.3                   | 4 ++--
>  ANNOUNCE-3.1                     | 4 ++--
>  ANNOUNCE-3.1.1                   | 4 ++--
>  ANNOUNCE-3.1.2                   | 4 ++--
>  ANNOUNCE-3.1.3                   | 4 ++--
>  ANNOUNCE-3.1.4                   | 4 ++--
>  ANNOUNCE-3.1.5                   | 4 ++--
>  ANNOUNCE-3.2                     | 4 ++--
>  ANNOUNCE-3.2.1                   | 4 ++--
>  ANNOUNCE-3.2.2                   | 4 ++--
>  ANNOUNCE-3.2.3                   | 4 ++--
>  ANNOUNCE-3.2.4                   | 4 ++--
>  ANNOUNCE-3.2.5                   | 4 ++--
>  ANNOUNCE-3.2.6                   | 4 ++--
>  ANNOUNCE-3.3                     | 4 ++--
>  ANNOUNCE-3.3.1                   | 4 ++--
>  ANNOUNCE-3.3.2                   | 4 ++--
>  ANNOUNCE-3.3.3                   | 4 ++--
>  ANNOUNCE-3.3.4                   | 4 ++--
>  ANNOUNCE-3.4                     | 4 ++--
>  ANNOUNCE-4.0                     | 4 ++--
>  ANNOUNCE-4.1                     | 4 ++--
>  external-reshape-design.txt      | 2 +-
>  mdadm.8.in                       | 6 +++---
>  mdadm.spec                       | 4 ++--
>  raid6check.8                     | 2 +-
>  restripe.c                       | 2 +-
>  udev-md-raid-safe-timeouts.rules | 2 +-
>  31 files changed, 59 insertions(+), 59 deletions(-)
