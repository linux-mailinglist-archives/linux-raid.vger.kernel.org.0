Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB07419EC72
	for <lists+linux-raid@lfdr.de>; Sun,  5 Apr 2020 17:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgDEPxN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 5 Apr 2020 11:53:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41057 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgDEPxN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 5 Apr 2020 11:53:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id v1so15783665edq.8
        for <linux-raid@vger.kernel.org>; Sun, 05 Apr 2020 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qUiS4Wqlk9W2+hvRW/ddG3IdnH2XLRyXeeamITzX+60=;
        b=QyCV/kGlVZlaWErdUfO67rjQIV3BLOkPHse+ZgFRBI0x6bqYECiTVqwA5xb9hTxaFi
         y5iFTlGcz1HgPEeuBv6uU7bRJwT7l5jjfFhFn2T/nKB7drjRi7oR2hhasQZRcN6WI7lM
         fUnqpyWCzA81PP6cTrm5r+FjMulSgPHI7FUunUSxcWvxb6P3GSofqe2k8XH6K88tEz30
         WTrjmVxFBDndtky587vOVUZU5bQFb1J7dOzVUVz2iGDxHINQFuKhGYrmMVmuWLgr6hk6
         eqqdtrdobOKYSRYfbVrSn+CaZT0r6ZFPniQIIFtSPmzmFnc8ireJJhj6Onh1TRKV0mad
         1nPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qUiS4Wqlk9W2+hvRW/ddG3IdnH2XLRyXeeamITzX+60=;
        b=JIZoSDALsXHhBEqniH259Ci2fVAWfT4eZvPAc9XgPnilcgH+2q5gMPUcNZTxH60IGo
         jmgRZRIPfUi9+q3zkD/zCGL93c0iMMT53cwX6lT6TJhQseXRJOFFKTVkGreA3RG9K7h/
         WcmUXSqefuldK5FU2iToPQ7YqqFscBbi5Q4fKAyTHn3Dsj9iIf9RrnX04xLLk1F2XGi0
         Uw1Mk1HzaglntEDBU4434dir1Q0lYYA/4aLA75OIGklCYNAuhntnoyAV78C8U9hlXC99
         4hoq5nYtXYpkRuiezDhc5Ap/d/WyLCc4tbQUwchXr+DhUQ4yJxrTzDRn2SLDFuzBTf4X
         aa7g==
X-Gm-Message-State: AGi0PuZ1mtyOvJV5xbbQu7Kuc+PayN4uqcHUdcauz4nF8T0Iv2hw5Dap
        euC3qAPOY46zeiPqb/30AAkd/Q==
X-Google-Smtp-Source: APiQypIzdA59VA+zEGfRM4Fugjf3v8Zyg19+9XrvxB1Cilf4yqlxjslStTa1QVAA59wu7zi2ph1f3g==
X-Received: by 2002:a17:906:3509:: with SMTP id r9mr17706022eja.5.1586101989449;
        Sun, 05 Apr 2020 08:53:09 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48b1:8100:34d4:fc5b:d862:dbd2? ([2001:16b8:48b1:8100:34d4:fc5b:d862:dbd2])
        by smtp.gmail.com with ESMTPSA id e8sm505350eja.60.2020.04.05.08.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 08:53:08 -0700 (PDT)
Subject: Re: [PATCH] raid5: use memalloc_noio_save()/restore in
 resize_chunks()
To:     Coly Li <colyli@suse.de>, songliubraving@fb.com
Cc:     linux-raid@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Michal Hocko <mhocko@suse.com>
References: <20200402081312.32709-1-colyli@suse.de>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <fa7e30b9-7480-6c03-0f43-d561fed912fb@cloud.ionos.com>
Date:   Sun, 5 Apr 2020 17:53:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402081312.32709-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 02.04.20 10:13, Coly Li wrote:
> -	scribble = kvmalloc_array(cnt, obj_size, flags);
> +	scribble = kvmalloc_array(cnt, obj_size, GFP_KERNEL);

Maybe it is simpler to call kvmalloc_array between memalloc_noio_save 
and memalloc_noio_restore.
And seems sched/mm.h need to be included per the report from LKP.

Thanks,
Guoqing
