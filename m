Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16BB71392E6
	for <lists+linux-raid@lfdr.de>; Mon, 13 Jan 2020 14:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgAMN6x (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 13 Jan 2020 08:58:53 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38874 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729101AbgAMN6t (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 13 Jan 2020 08:58:49 -0500
Received: by mail-ed1-f66.google.com with SMTP id i16so8524486edr.5
        for <linux-raid@vger.kernel.org>; Mon, 13 Jan 2020 05:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=+t/pZS98XefACFlnNoUdDYtOWbisiAfMSZO9J6UoAtE=;
        b=Fe7xCyH2+2eIlKY+8QsrCrgKfjT5W+byxcndcmE2V3WuY1I/b8L6lKxWM9OhKKvVgb
         +DpRuKZV/egKfuc/vf5Nc5TKLguaJcnAgrXG2qPOIj7fVC0uXCbMUQhz6qJyDbBptaap
         uR9H78rBqJnPvjEzCC/MFgXDgVQC+y8s5wHkwYYUg2wBRWOg4psDowwQUJe8znYxnp76
         UVoDYfEag7AeQbxzkg5QsG4iKMkmjHxM45ZSnvwrOS3ThIrtCoDOsRw5FrjO0cQgmNcl
         bxkNMhsSbebgDfqnm+/gfp2GLt1p+s8N4N/kaUad4GTNjbLUS4KtT6TGonZKaBtkoCWG
         iW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+t/pZS98XefACFlnNoUdDYtOWbisiAfMSZO9J6UoAtE=;
        b=Xe+lHuOJDZPo7MYl76hNgQX0eDlghC5nVB/52oSxyBrm8hil9SI7b/UJIwksv8FnJb
         RQOWPRCXU6pB+haL12TWlUC9gYwCPLqaqHHEpW1Zy949Z9sV+VbpNzLnwT3tlW3DeSKX
         UKsDdfbpjZOqOGfzKwh6GppPf2muYj838dVO8hB6fzshesl7coAGZ7Kxxijm0EVT4GJU
         2yAfc/oIxuD1AG1eJQFWNI8qy6RcBKbYCrgqEmI0Jhcdsip7fo7gHPfGBPjrXRqUNsyR
         idBkQC+GWIIaIXzwWmX02apyhNZ2KAkdhLypfWH9a3FUfybM8jnWlcOs7tsBfCMMu9aR
         sKyw==
X-Gm-Message-State: APjAAAWSpo0JIeKBhFbSRH5+NiLSCL4b8utdWi9cMqKtv+gnYhd21Rk0
        VkLVjQJ48awFGcze83s7hgVxxQ==
X-Google-Smtp-Source: APXvYqzZ5p+1xLSk4PlbhDTTQ/eUUaJjmRN0iZSnwsBtGV3VnqC071+aaoIKoNunNSCURlAWSf8P4A==
X-Received: by 2002:a17:907:20a8:: with SMTP id pw8mr16564057ejb.248.1578923928225;
        Mon, 13 Jan 2020 05:58:48 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:5486:b91d:1617:ce4e? ([2001:1438:4010:2540:5486:b91d:1617:ce4e])
        by smtp.gmail.com with ESMTPSA id y5sm458893ejm.57.2020.01.13.05.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2020 05:58:47 -0800 (PST)
Subject: Re: hung-task panic in raid5_make_request
To:     Alexander Lyakas <alex.bolshoy@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>, liu.song.a23@gmail.com
References: <CAGRgLy4Yi1HNqNO0MLq5xjRRgWe7EaByRYF5sA3fFVa1tmpNvA@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <cde80def-2832-2a45-28fa-055e6be88d05@cloud.ionos.com>
Date:   Mon, 13 Jan 2020 14:58:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAGRgLy4Yi1HNqNO0MLq5xjRRgWe7EaByRYF5sA3fFVa1tmpNvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 12/24/19 9:18 PM, Alexander Lyakas wrote:
> We recently moved to kernel 4.14 (long term kernel) from kernel 3.18.
> With kernel 3.18 we haven't seen this issue.

Could you bisect commits between 3.18 and 4.14 to identify
which commit may related to the issue?

Thanks,
Guoqing
