Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6D8CBE6B
	for <lists+linux-raid@lfdr.de>; Fri,  4 Oct 2019 17:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389333AbfJDPB3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 4 Oct 2019 11:01:29 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46482 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389131AbfJDPB2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 4 Oct 2019 11:01:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so8899996qtq.13
        for <linux-raid@vger.kernel.org>; Fri, 04 Oct 2019 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4oPO587bVhfJ+7QAPisOrOmWk9UF01gkiBPfkqxT7xg=;
        b=t9O/x569SUo4WC3YJMIgRtr+13kBeh1eo5oNyhp/mY/xO/l44qMgetHRfi9ADtr7mX
         5ix90uHLIRDuZcbNlNvhkFWxukOKKuv/qOoI/UNtlfEVm2YfdE0ywS3VVzAGbA4wtSP/
         jeKrCw4EBdqBUihnyyre/a+ncGIAyUGPXLEm3XQygE5d10FwhOgizR6wPRsT57d71Tgg
         IB7BafG8ypa2ZRPgdiwnDMYi88q2bg3KJZfbmWMuDY1sTS8hY5yzko8DecuO+3RFOeFD
         c4iPG0c/5317fv79iKRvlkF9dgetDN/CFZl9XyXEvkaSuaWG5dbc7XqhktSoq8uaDAIn
         XyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4oPO587bVhfJ+7QAPisOrOmWk9UF01gkiBPfkqxT7xg=;
        b=sNivjiGEmvFo05mC9KhrqMFPInKLPT79Bpfzk1lIcDmkwKmjrEkLdsGQF01n5meggD
         1rjdxx+sN4EmzKryt5WuY8PgAk5uVhnH7G6o8lo4peZ88/QpuiB7EwmjbfutChShHHbH
         8fcNUomsdAVIU4v91uWTEfvXokjhemt6531MtSvrlQWi4sdGJXRt/H+I1pWQiZkqTHQv
         Dr3MHIFk8LkKxVIX3S5yOZljeLA94OxfwFob1ppJEW1NNYDI4ZHgqXPQpLDfqDABwaSX
         JjZpVUtKn3fb/lQcgm2dxcnCU42sy3BmeMt/pZlRpX3lAl5Bxp73+AAwRWj6E0fFXBvM
         6w/Q==
X-Gm-Message-State: APjAAAX4I/5FIROu/sTX0W0SLxIej5EAyaRcvWsNuB0tJ+DRo9rmNHZF
        Vk5DipsBgGyzoZ8qWnRPHVTv6EEh
X-Google-Smtp-Source: APXvYqzVqqUZ69fFso+Teowt3Q9I4JqEdA95mbCHNmvYhpSlhLaYvjoRyIvr43AnLQhyfm8tCzL91Q==
X-Received: by 2002:ac8:641:: with SMTP id e1mr16540771qth.368.1570201286177;
        Fri, 04 Oct 2019 08:01:26 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a3:10fb:a464:42a6:e226:d387? ([2620:10d:c091:500::2:9b70])
        by smtp.gmail.com with ESMTPSA id m91sm2989784qte.8.2019.10.04.08.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 08:01:24 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH v2] imsm: save current_vol number
To:     Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20191004100728.22471-1-mariusz.tkaczyk@intel.com>
Message-ID: <fbb6378d-b161-71e5-14ed-33767c34ff7c@gmail.com>
Date:   Fri, 4 Oct 2019 11:01:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191004100728.22471-1-mariusz.tkaczyk@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/4/19 6:07 AM, Mariusz Tkaczyk wrote:
> The imsm container_content routine will set curr_volume index in super
> for getting volume information. This flag has never been restored to
> original value, later other function may rely on it.
> 
> Restore this flag to original value.
> 
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
> ---
>   super-intel.c | 2 ++
>   1 file changed, 2 insertions(+)

Applied!

Thanks,
Jes

