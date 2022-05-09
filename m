Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B5D51F812
	for <lists+linux-raid@lfdr.de>; Mon,  9 May 2022 11:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiEIJ3g (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 9 May 2022 05:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbiEIIwo (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 9 May 2022 04:52:44 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FDD88F7F
        for <linux-raid@vger.kernel.org>; Mon,  9 May 2022 01:48:51 -0700 (PDT)
Subject: Re: [Update PATCH V3] md: don't unregister sync_thread with
 reconfig_mutex held
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652086130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DeTzay7RnKzJXCcWw7q396Fvby5LZrU1xcpAnIVjuAo=;
        b=oaODxx/N1zA5DQt85M6TfrTqihic0/D9x4JsksqWWJkGhM3bLutnDgblXndM5mWjNwPf36
        PHm6ftMg+OEWvgStzwd5M6BPqREnvPFYwFxAqHvWDlzRL7UCtQTHf/NBdkPSCPRWI/2uDn
        1TwhQzBNHykz9LXBvBgbNR4+HMO1wZ0=
To:     Donald Buczek <buczek@molgen.mpg.de>, song@kernel.org
Cc:     linux-raid@vger.kernel.org
References: <20220505081641.21500-1-guoqing.jiang@linux.dev>
 <20220506113656.25010-1-guoqing.jiang@linux.dev>
 <b664e33f-1c7e-f618-c42e-7ca6c2416ba6@molgen.mpg.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <555e1640-f77d-1446-e7c6-fe12eca7cd39@linux.dev>
Date:   Mon, 9 May 2022 16:48:45 +0800
MIME-Version: 1.0
In-Reply-To: <b664e33f-1c7e-f618-c42e-7ca6c2416ba6@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 5/9/22 4:18 PM, Donald Buczek wrote:
>
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -9432,10 +9432,17 @@ void md_reap_sync_thread(struct mddev *mddev)
>>   {
>>       struct md_rdev *rdev;
>>       sector_t old_dev_sectors = mddev->dev_sectors;
>> -    bool is_reshaped = false;
>> +    bool is_reshaped = false, is_locked = false;
>>   +    if (mddev_is_locked(mddev)) {
>> +        is_locked = true;
>> +        mddev_unlock(mddev);
>
>
> Hmmm. Can it be excluded, that another task is holding the mutex?

Yes, it is hacky as Song said, so we probably go back to v2.

Thanks,
Guoqing
