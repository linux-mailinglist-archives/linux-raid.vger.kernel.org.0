Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 869CBC28B3
	for <lists+linux-raid@lfdr.de>; Mon, 30 Sep 2019 23:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732210AbfI3VVP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Sep 2019 17:21:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39860 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731840AbfI3VVP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Sep 2019 17:21:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id v4so6309390pff.6
        for <linux-raid@vger.kernel.org>; Mon, 30 Sep 2019 14:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1LTH8mTG0A4YIKD0vPlkOuX3mLC13wca/MOypquzsXQ=;
        b=nGeWrnIyy3qTGjaBVJdR++F3QmJwATsRYRngPs/1lvaIh49I1LiZvCP74FaOvIUEJ6
         VMq2ciWrL0DIlfX22QlUxrLqlIkON2k+nByaWOcQgicG1QoTG3rM4VnhiwaIxrCP5wZH
         qvzDxvxg+pSm5Ct95OhlpHuVplz96kNgZDh3kILdKhvfYwUvGX1RsOZ6yeiKkPcwlyA3
         N8IQx4wi8cj4NLIUANfN2rJl36WgTaHrv7Gu8Uy9Am0+1EvtkfCq+snJRUc5Hb7kFNNi
         yHGpKSatuO9Q99ny4ckaI1xJG9nAO1N5ivLZCOkBqV9GrVBhG6fz5nHiaKBO+JEEBjxM
         cobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1LTH8mTG0A4YIKD0vPlkOuX3mLC13wca/MOypquzsXQ=;
        b=AoErohJIrC+67kQldW/BOL4mn9H2g+xMZZOmLNob/gil4o0LNpf8TB1ssi9cnOrsqt
         uVq7C6qS44Lvr+/eVUUIdwrVxvqW5vl7Iz5Tgisuqr1aLhqoK7gnSyYYnoRyAmzu6phh
         b25Sij/DDx0dmOAs/Wm76EfOUiEKZJeR1gUA9yms6zBJVmZIbVa1C5Kqhu/nOW9m3Eb8
         +0s/Re0jHqDAeuubjWRp+7UgWoEHVxpgAGsecYrWjdLwa1/fOpZtQY1c8wb4zR5av2I8
         466QuL7NdheJO5IdcGBFZutOJap6u/A/YCHxTejYw7xj3r52wdfxrqRoa4tWrKiZWhMn
         gAfg==
X-Gm-Message-State: APjAAAU1mpG8CSr026yoq0KDFFHyOfeKu6sGUzGydvyyYKe9Cl0sqwJy
        2m2RUmkAispJO7wLgA4mzZNvTLBrU7U=
X-Google-Smtp-Source: APXvYqxih5sMDgIx0q1/o082h8dbgSdgeIrICEWfM/dgY7CVmFVgk1kp7bNd9E2h6MNe8RTboIrawQ==
X-Received: by 2002:a17:90a:b63:: with SMTP id 90mr982390pjq.96.1569872147511;
        Mon, 30 Sep 2019 12:35:47 -0700 (PDT)
Received: from [172.19.249.239] ([38.98.37.138])
        by smtp.gmail.com with ESMTPSA id j16sm295917pje.6.2019.09.30.12.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 12:35:46 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] mdadm: force a uuid swap on big endian
To:     Nigel Croxon <ncroxon@redhat.com>, linux-raid@vger.kernel.org,
        xni@redhat.com, heinzm@redhat.com
References: <20190924153924.12503-1-ncroxon@redhat.com>
Message-ID: <3d047dcd-28e2-53ea-1664-1820bb893245@gmail.com>
Date:   Mon, 30 Sep 2019 15:35:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190924153924.12503-1-ncroxon@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9/24/19 11:39 AM, Nigel Croxon wrote:
> The code path for metadata 0.90 calls a common routine
> fname_from_uuid that uses metadata 1.2. The code expects member
> swapuuid to be setup and usable. But it is only setup when using
> metadata 1.2. Since the metadata 0.90 did not create swapuuid
> and set it. The test (st->ss == &super1) ? 1 : st->ss->swapuuid
> fails. The swapuuid is set at compile time based on byte order.
> Any call based on metadata 0.90 and on big endian processors,
> the --export uuid will be incorrect.
> 
> Signed-Off-by: Nigel Croxon <ncroxon@redhat.com>
> ---
>   util.c | 4 ++++
>   1 file changed, 4 insertions(+)

Applied!

Thanks!
Jes

