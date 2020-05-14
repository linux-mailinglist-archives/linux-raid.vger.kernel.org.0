Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57B61D4051
	for <lists+linux-raid@lfdr.de>; Thu, 14 May 2020 23:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgENVmN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 14 May 2020 17:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgENVmM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 14 May 2020 17:42:12 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D488C061A0C
        for <linux-raid@vger.kernel.org>; Thu, 14 May 2020 14:42:12 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z18so237868qto.2
        for <linux-raid@vger.kernel.org>; Thu, 14 May 2020 14:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x8F0hqetcL96JIZ8wLVVHonh2vFHz+nr23cA5/Pn/qg=;
        b=OrNqj7amfszvVYletvfBTAqyyHm8/gzh4BWy+Ocs2sKq6M/I8gcG53R8OdRe+P8WY4
         nfpx09io7DhRpkjaa3FclpMr0o8eN6A2SR0YW0zhkstUMwcixv0tXYajBfxEqh7v4TqG
         wTm6JsCI9n6o03+yj2IXvUtBNYBWABRxiXe/qScGIkfj6yPOmUyEShf9/wcs1KwBdLun
         bm4g70sFe/oMQbJ7A2WLEDlFxAw18sbQTCbhYAEbr/2WTIp667X6Jq97xS8FTh/Bvbmo
         GMZ3PovVxfAK1RC18A3XvYDwHafWuThzvnAP6y1oQ6tW0NZqWlilHofG3GyqlS2crvJE
         yxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x8F0hqetcL96JIZ8wLVVHonh2vFHz+nr23cA5/Pn/qg=;
        b=fXZGmrFnHjO5cpGk/DUfHACf0CBA9fYmrHmNKvACLMPYnLLVIEs0auDAc+6507kDax
         H0PFlPhKPEI1LdCYEI2mjVPFxmgjpkV3brXvJXcZQMzQzIk8UTssaW2oy7shDW1P7lt0
         P3rEouC0XWtjzOT8FE0pxWpC8uRHaChS0S2RMQohFkAyztGbpidp9+VQq9+B1lA5rsC5
         dtjYe1Y+5cKAA7D5DIy+OuaFnbZLvAVtdQV7/a8ZXNp1ZvFpFBZ7Rb1vPJtHDMMU/Isk
         4QnIaQhH7uGDx024mJ17/JOzA+XzpQ0eF22YkH/z2OXkIh4svYC37jxGVBvRO+MGDqVu
         vRbg==
X-Gm-Message-State: AOAM531blu1O8jX1OYsWHFQz++9XiiCpBUSljgYZZEEmcovDNyf1ETxx
        kTPVtt5AaTwy/cb1VgmvwHfWQk9wVVAFxA==
X-Google-Smtp-Source: ABdhPJzql40qOv/rsMk2Ug/JlXiK06XEDngfNzL37PKv38SLqYgw2v7LjgjTlYEC+jYelhouXcQ46A==
X-Received: by 2002:aed:3c0d:: with SMTP id t13mr264664qte.137.1589492531382;
        Thu, 14 May 2020 14:42:11 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e1::10ab? ([2620:10d:c091:480::1:1b31])
        by smtp.gmail.com with ESMTPSA id t124sm108128qkf.99.2020.05.14.14.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 14:42:10 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] Use more secure HTTPS URLs
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-raid@vger.kernel.org
References: <20200513132707.16744-1-pmenzel@molgen.mpg.de>
 <f2d4fa4e-697f-033a-1144-d4ff30e48ec3@gmail.com>
 <844fa4e8-fe19-ad46-55e3-1357518f1366@molgen.mpg.de>
Message-ID: <e83921a0-fed5-be7f-e5ff-5a3f37cb53ec@gmail.com>
Date:   Thu, 14 May 2020 17:42:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <844fa4e8-fe19-ad46-55e3-1357518f1366@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/14/20 4:39 PM, Paul Menzel wrote:
> Dear Jes,
> 
> 
> Am 13.05.20 um 15:44 schrieb Jes Sorensen:
>> On 5/13/20 9:27 AM, Paul Menzel wrote:
>>> All URLs in the source are available over HTTPS, so convert all URLs to
>>> HTTPS with the command below.
>>>
>>>      git grep -l 'http://' | xargs sed -i 's,http://,https://,g'
>>>
>>> Cc: linux-raid@vger.kernel.org
>>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>
>> Some of this looks valid, but we're not going back to update existing
>> ANNOUNCE files.
> 
> May I ask why? It’s all logged in the VCS history, and the two URLs are
> always the same.

Because those are release files and that's to edit history.

Jes
