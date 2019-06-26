Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D120357204
	for <lists+linux-raid@lfdr.de>; Wed, 26 Jun 2019 21:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfFZTtj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 26 Jun 2019 15:49:39 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:38954 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZTtj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 26 Jun 2019 15:49:39 -0400
Received: by mail-pg1-f181.google.com with SMTP id 196so1692490pgc.6
        for <linux-raid@vger.kernel.org>; Wed, 26 Jun 2019 12:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Z7ANcLu5cAvDj3+P/cTiSaUFLCOhEwwx/zZzamstMvo=;
        b=u7ipS2BKqwERoes+Jae1VGR/FAEnHNFDexsR0FZghKT54D7cUXxT4IUKkqsgQxXjyV
         nbfdSEw/JVUcRzc0Xyy1l9CEFWqsC/Qwlufh51L4RDT5X8vBGOss/LS9EuWVnkbltuTz
         fqCVt5xel+d0yBRwwngZikT5EMFBIsSm998o+fydszaE5cHLohAzq+w3nQE7LUEvr3pa
         ITOA3AyR4y+9nBqnCjVqxfhXKKhXr1XXG4UD4/3Vjh+SqJczL0j/UJw49m+/fID+E+0K
         fjnYUsDk9gkzH7QINy4uxgsyjeYrCmAnnheiml70hzm4utWQMwZ6qRslo6+FK/r+Ou2i
         +Elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z7ANcLu5cAvDj3+P/cTiSaUFLCOhEwwx/zZzamstMvo=;
        b=MzuL8SItvFmen3iiPCea6oIZt+BZSqesZS6UfapzGQNhDTptaDPgauZxZoc0C1XhTd
         RvT34nGIJiUlkCQ6yeM8EsRIBRBggEdhr6TU0KFissolkrtryOPjr2WtLo+X8qfLF2C5
         JRqsrnRmlNoJnTApnv5yRxClTJ6A3krr9g9UhXn3NBBh+Hsabj95Oj+H5kQLAJyfO9OP
         XFJchsCDj9sb+56CD+wjlsWhziBjuNdq7eYOtU+hrMCNj+iVyriNeIKzmZrlw35/ADv/
         Ste9knuI2WACSS8gk1mnBHrsMry+rPzrrLRP4/iLgc1KaYg3G6RcvqNSdmbO4R9eKe0E
         ML2g==
X-Gm-Message-State: APjAAAV6nStAflY37Cfw+Jo3fyVMSuLIN6+AZxxAwI0uTqhEFdxOKWIW
        EfWb56MuwCT1vAP2vJ5v2JVQ6HnK57zzEQ==
X-Google-Smtp-Source: APXvYqyOMD4ynm4GQlPzT70TDzzckryt4VXlwSLTQSSePHA8URN/47lpLiqdBbpEJblLxlfVouOwFw==
X-Received: by 2002:a17:90a:1b0c:: with SMTP id q12mr1011530pjq.76.1561578578039;
        Wed, 26 Jun 2019 12:49:38 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id q5sm11575414pgj.49.2019.06.26.12.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 12:49:37 -0700 (PDT)
Subject: Re: [GIT PULL] fix for md-next 20190626
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
References: <526C01BF-475E-42A2-A994-B6B9741D6749@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4f43963c-0aab-4bfb-3ee2-96cfb31e32dd@kernel.dk>
Date:   Wed, 26 Jun 2019 13:49:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <526C01BF-475E-42A2-A994-B6B9741D6749@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/26/19 1:36 PM, Song Liu wrote:
> Hi Jens,
> 
> Please consider pulling the following fix on top of your for-5.3/block
> branch.

Pulled, thanks.

-- 
Jens Axboe

