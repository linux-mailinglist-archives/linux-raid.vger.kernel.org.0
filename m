Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4445AC8776
	for <lists+linux-raid@lfdr.de>; Wed,  2 Oct 2019 13:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfJBLj4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 2 Oct 2019 07:39:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39213 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfJBLj4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 2 Oct 2019 07:39:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id v17so6617768wml.4
        for <linux-raid@vger.kernel.org>; Wed, 02 Oct 2019 04:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jvg9OEUzjj3EmhIUQl+wIratpIlNGBWZoiNFSxBHUuM=;
        b=Be0Pad3cath3BsN5oSbLIfRJWOi80anTvApT42MpxHUtt9yPbS+82Xk/PRTBz3EQIy
         +E61aUxGClyTQE56EQToOZ3cDxLYt5SnknsIFQmFon3Zye/qxlVrXncVGMhRTYEt3och
         3dpK1JFBgeh76BzhGcd+gCEqOOrd327hV6i9ngl6GwiRuGltvoUyZizUNAnnzsymns2V
         ax9JXBpN4luefG2sCYjYkYmtC6KFcTu1Ou0UidNMzdxEYPo+B0NN/odIjvImRHUxwbWM
         Bl5kvMNMLHhYMV+bbqjwdqGa4ZhXMzEb0OMK5gcP2PO3sgetfS/7ProUY/l2Xv8C4fjW
         gaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jvg9OEUzjj3EmhIUQl+wIratpIlNGBWZoiNFSxBHUuM=;
        b=eWb1RqNLMj8ZMeD4o/bODZsE+GRc6YNDaHhiP2qT+MtKD3AxjYCLnLU8X8K+LFQ2gq
         qXz51w5XM2S7aHv4hddsOd+sJvXLBiTudGCm+Xg3JfpHukExs4gas2ZIkDlLff44Y/0Y
         fv97MtGxEUERwjOZA4pd2dohCJx2VXOs2lwCwoGGW5/ar1JM0rV1G8RFxBndT6C8Lu35
         Q06zKBvVD1gvn/URRzofPUU2x9T9dQi/tlMW3iwj7KwCkQmp8ZahtjnEcc+oSVgK3trt
         PwWhcOe3tjEuhLvBEjA42eM7kPQb4pZe9cCG+8uM4SZiXlIqQ+F/3r40TUWmzR/+Dwig
         /DUw==
X-Gm-Message-State: APjAAAVWN0csyazejdany0RnW5ll/yxg3xA/QTsAB/LG9XjWGTNTjrrV
        nnUVGY3IBuk0LMlOrQcdmdb1gcaO
X-Google-Smtp-Source: APXvYqy8qFCM1vpuoqVzTY69At8VTfAPGia1T6sgWCNcn14IB2wBX1JIiU1ClaSMu11j70GcbOzajQ==
X-Received: by 2002:a05:600c:241:: with SMTP id 1mr2518929wmj.32.1570016393250;
        Wed, 02 Oct 2019 04:39:53 -0700 (PDT)
Received: from [192.168.99.123] (pool-108-6-208-218.nycmny.fios.verizon.net. [108.6.208.218])
        by smtp.gmail.com with ESMTPSA id s1sm25836874wrg.80.2019.10.02.04.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 04:39:51 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] udev: allow for udev attribute reading bug.
To:     NeilBrown <neilb@suse.de>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <87impq9oh4.fsf@notabene.neil.brown.name>
Message-ID: <9d532652-0cf9-1187-9fa9-59be922b9c49@gmail.com>
Date:   Tue, 1 Oct 2019 10:09:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <87impq9oh4.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9/18/19 1:12 AM, NeilBrown wrote:
> 
> There is a bug in udev (which will hopefully get fixed, but
> we should allow for it anways).
> When reading a sysfs attribute, it first reads the whole
> value of the attribute, then reads again expecting to get
> a read of 0 bytes, like you would with an ordinary file.
> If the sysfs attribute changed between these two reads, it can
> get a mixture of two values.
> 
> In particular, if it reads when 'array_state' is changing from
> 'clear' to 'inactive', it can find the value as "clear\nve".
> 
> This causes the test for "|clear|active" to fail, so systemd is allowed
> to think that the array is ready - when it isn't.
> 
> So change the pattern to allow for this but adding a wildcard at
> the end.
> Also don't allow for an empty string - reading array_state will
> never return an empty string - if it exists at all, it will be
> non-empty.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>   udev-md-raid-arrays.rules | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Applied!

Thanks,
Jes


