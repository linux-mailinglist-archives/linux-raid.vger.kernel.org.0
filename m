Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 999EC18091C
	for <lists+linux-raid@lfdr.de>; Tue, 10 Mar 2020 21:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgCJU1S (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 10 Mar 2020 16:27:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36006 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgCJU1S (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 10 Mar 2020 16:27:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id a13so8768edh.3
        for <linux-raid@vger.kernel.org>; Tue, 10 Mar 2020 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p+ul+bEhV3dFl9CTEkYnVitS4LJaQoxtCfO8psH/Ksc=;
        b=AjyDRgCdotwC4lymYH8lPGFs5ScXi7gMXJcuKyxVEiZyX+g3viMo48gkV/0WmyFia6
         t/+Zfxh73FpMHYPV+LZT5Qqhqgr15BkeF2Yz4JOSW7S+VdRYXVYpGXASH12iXJ/9JBwj
         JEG7qI4OaidWd6uZWW6QLr252odPjRMX+nPbR48Y2H4sFVIY+ewx1vgmaMLrsmrUQkoT
         0AUrzOPJ5vtaHfkloISZtMn8a4LChjL8fCLYtB6zaf0znNZ3nXof3hQXvKlGi7oNQgvV
         iUVDfTxYvtQc5DsjvkzEQtBCISFfxcUg2oXZo7moRMuZLfMcRAVXkvBSaT6692HV+Bzy
         g9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p+ul+bEhV3dFl9CTEkYnVitS4LJaQoxtCfO8psH/Ksc=;
        b=OBl1c3bPHyiaHnQbOmkDHLGbaz/FzD2KVwGsyA8zSytUiqiACWqPIQoKOsrwjpsAVh
         mKDDo2FYtPYGXGixIxcjwE/sKgAnJpTCwMXuvhAg74mZ+/STngobU+j7aY7n16Ealbzm
         x2LoNnTde7OyZpI8tBHFyK/6texC5CU7lbkkTXrsweR1SngX6eXtJEdGgZ35xboAXEc8
         lvavDumqCfMNIxHta6rXKHIifuEEfYz840EtPzEiNqjXV1+0kY3MznHPKSmakRBMYi5S
         dmWyo2MYSyzaEF9ibdRTASyyCMdnI3wifuFtjJgCmcBdYvbJc/1YHQXlwNkhGUKCF05S
         MXlw==
X-Gm-Message-State: ANhLgQ17Nsc2RS1jBRH/t/RrS5AxOWkhXZGF0WAvgXH9XjUMels0QArJ
        bnuaUqEBowMGtHVFOPLCwnFxjlBjqBs=
X-Google-Smtp-Source: ADFU+vuD5dyxmgjC7MFoLqUkW3ANvhNIbt2Zt3fpwJzjbG/PC092Skx1IFt2C3skc7VZ6Oyq9Ksu6g==
X-Received: by 2002:aa7:d305:: with SMTP id p5mr23020543edq.222.1583872036630;
        Tue, 10 Mar 2020 13:27:16 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4849:2c00:55b0:6e1e:26ab:27a5? ([2001:16b8:4849:2c00:55b0:6e1e:26ab:27a5])
        by smtp.gmail.com with ESMTPSA id t1sm3525259eju.35.2020.03.10.13.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 13:27:15 -0700 (PDT)
Subject: Re: Pausing md check hangs
To:     Georgi Nikolov <gnikolov@icdsoft.com>, song@kernel.org
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <2ce8813c-fd3e-5e78-39ac-049ddfa79ff6@icdsoft.com>
 <15519216-347d-c355-fa1e-e1ec29f7e996@cloud.ionos.com>
 <58a16d12-4df3-c97c-33cb-b7eed3534a8b@icdsoft.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <185645a9-48fb-e8df-4257-d395b08467f4@cloud.ionos.com>
Date:   Tue, 10 Mar 2020 21:27:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <58a16d12-4df3-c97c-33cb-b7eed3534a8b@icdsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 3/10/20 4:30 PM, Georgi Nikolov wrote:
> I have tried new 4.19 kernel with proposed patches with no success. Same story with md1_raid6 (last 
> time it was with 5.4 and md10_raid6).

Did "cat /sys/block/mdX/md/journal_mode" still hang? I thought below change would help ...
> 
>> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
>> index 9b6da759dca2..a961d8eed73e 100644
>> --- a/drivers/md/raid5-cache.c
>> +++ b/drivers/md/raid5-cache.c
>> @@ -2532,13 +2532,10 @@ static ssize_t r5c_journal_mode_show(struct mddev *mddev, char *page)
>>         struct r5conf *conf;
>>         int ret;
>>
>> -       ret = mddev_lock(mddev);
>> -       if (ret)
>> -               return ret;
>> -
>> +       spin_lock(&mddev->lock);
>>         conf = mddev->private;
>>         if (!conf || !conf->log) {
>> -               mddev_unlock(mddev);
>> +               spin_unlock(&mddev->lock);
>>                 return 0;
>>         }
>>
>> @@ -2558,7 +2555,7 @@ static ssize_t r5c_journal_mode_show(struct mddev *mddev, char *page)
>>         default:
>>                 ret = 0;
>>         }
>> -       mddev_unlock(mddev);
>> +       spin_unlock(&mddev->lock);
>>         return ret;
>>  }


Could you try with remove flush_workqueue(md_misc_wq) from below change? Or add some debug infos to 
see whether the hang is caused by flush_workqueue.

>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -4779,7 +4779,8 @@ action_store(struct mddev *mddev, const char *page, size_t len)
>>                 if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) &&
>>                     mddev_lock(mddev) == 0) {
>>                         flush_workqueue(md_misc_wq);
>> -                       if (mddev->sync_thread) {
>> +                       if (mddev->sync_thread ||
>> + test_bit(MD_RECOVERY_RUNNING,&mddev->recovery)) {
>>

Thanks,
Guoqing
