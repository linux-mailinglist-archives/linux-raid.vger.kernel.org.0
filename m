Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBE004B348
	for <lists+linux-raid@lfdr.de>; Wed, 19 Jun 2019 09:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfFSHo5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 19 Jun 2019 03:44:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53890 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfFSHo4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 19 Jun 2019 03:44:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so611303wmj.3
        for <linux-raid@vger.kernel.org>; Wed, 19 Jun 2019 00:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oldum-net.20150623.gappssmtp.com; s=20150623;
        h=from:reply-to:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Gqu4cFB3mBTQv0dKWB6D+EctUG3zh77SwkXur28gE2w=;
        b=TSsHMwEXqRzIzZzAxLhwZ+77WDs2HXfkcQs7DGk+4x2YBQUXtHu+XWnexCSZjvF7N5
         jABmAEiXrUOw5IXxVDq0CfD4c68Fl0boUhg1kOyf9sjU5QxLHSc8DzST47a2oJBVtu4Z
         Cti0GJ/FwDGM5cT2GEHqTIKJQYX/swgzermIZLjKz+0pOVtRxoBjWOs6FXW3aGM/N0GE
         djkgJ7G5DJNIKDNpcx8khWmOFsz5jMezQmr3MzOHx8rCvOqT6SMTqDL88C7NF7yu1yFC
         Tg/KTSe1jdbbQmpOWF6c1okmHdTESHz19YvUbSQrTUqPgFgSO2KieDaSEUECkyBlQH8Y
         UrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:subject:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=Gqu4cFB3mBTQv0dKWB6D+EctUG3zh77SwkXur28gE2w=;
        b=oUfp1DPpm3tFkL2bx2MWmbiKpmlSHYYOh0mcn+ux2zmq3sl/2YGbFMXDP1JgapbXk7
         Ikah0uPmwscR6p0JbtMPBOSTGkmhyNk4KgN6QcLWhiBcik66moF4aYLXjrdl3KIT/8vG
         9SFPwXFR6VJh1CvmryzCjnKEB0Md5tuYsCQ37t1ypVoJhb5vOLUQt8bYija99Javc6y0
         mzdXAAeTkNb+vOxeymsB8oZx2cXOG9M+b6eqoIGNMCHEQ//1dIqWyihRDRDOA5Zk3Ub8
         ai6NhqQFUPVNSeHlalPFFwIlLKlvlKW2TQl/QweoGTUz0MsZrGUesCLczaepHYqLmZvM
         mV2Q==
X-Gm-Message-State: APjAAAUZ7pCbgf7HH/3u+CshCdFPbAqCwhj8Ik0O/w5C/snbkdKZQ56f
        moJ/duFXkIlpgbFr0Yje568CTPeJOMCpNA==
X-Google-Smtp-Source: APXvYqx+YZ30QYLk0xHVxboaDuJ8s/+/nQbtoOvxNH0RMDVA2lruFdtlIM0n1JjqPgSOuowwrGUvHQ==
X-Received: by 2002:a1c:10f:: with SMTP id 15mr7063093wmb.142.1560930293794;
        Wed, 19 Jun 2019 00:44:53 -0700 (PDT)
Received: from [192.168.178.34] (external.oldum.net. [82.161.240.76])
        by smtp.googlemail.com with ESMTPSA id t12sm20352716wrw.53.2019.06.19.00.44.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 00:44:52 -0700 (PDT)
From:   Nikolay Kichukov <hijacker@oldum.net>
X-Google-Original-From: Nikolay Kichukov <nikolay@oldum.net>
Reply-To: nikolay@oldum.net
Subject: Re: [PATCH 1/5] md/raid1: fix potential data inconsistency issue with
 write behind device
To:     Guoqing Jiang <gqjiang@suse.com>, Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <20190614091039.32461-1-gqjiang@suse.com>
 <20190614091039.32461-2-gqjiang@suse.com>
 <CAPhsuW6eYaqxmHzHeu8UzXXx+DH-2FkEtQcWfvHp-YKTVe2U6Q@mail.gmail.com>
 <a8504a6a-6ecf-798a-0d3b-1243936b5588@suse.com>
 <CAPhsuW4YqH46jiSH9OEzUMf3rBCoJPa_=+ekVEi5s==sx=SWRQ@mail.gmail.com>
 <545a6f2a-7dab-e6b6-649a-6e6e67f10e0e@suse.com>
 <dcc1af10-6e45-464a-bb6d-e4f5e446788a@oldum.net>
 <25524d6e-ad56-8da3-f0ae-bbb935c7e2b0@suse.com>
Message-ID: <46d2e7bb-61ba-dc36-ed8c-6ee9c08d9a32@oldum.net>
Date:   Wed, 19 Jun 2019 09:45:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <25524d6e-ad56-8da3-f0ae-bbb935c7e2b0@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello Guoqing,

Rebase is not required as I can easily go to any kernel version,
GNU/Gentoo Linux here. Currently I am at 5.1.7 but happy to upgrade.
Where is the repo with those suggested changes where I can clone the
patch from?

Thank you,
-N

On 6/19/19 6:38 AM, Guoqing Jiang wrote:
> Hi,
>
> On 6/18/19 5:30 PM, Nikolay Kichukov wrote:
>> Hello,
>>
>> Is there a proper patch formatted variant of this where I can download
>> and test? Or is it included in a released kernel already?
>>
>
> As you can see, it is still in review stage, so the patch is not in
> any released kernel.
>
> I suppose you can get the patch from the archive, but I am not sure
> if it can apply directly.
>
>> I am seeing an issue, where one of the write-mostly disks in a 3 disk
>> raid1 array consisting of one ssd and 2 spinning disks(write-mostly) is
>> causing the mismatch_cnt to go as high as 1,5 million and a repair does
>> not fix it. So this looks like a good potential resolver.
>>
>
> You are more than welcome to test the patch. And I can rebase the patch
> to your kernel version if needed.
>
> Thanks,
> Guoqing
