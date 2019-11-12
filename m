Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7661F9AE3
	for <lists+linux-raid@lfdr.de>; Tue, 12 Nov 2019 21:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKLUj1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 12 Nov 2019 15:39:27 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37632 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfKLUj1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 12 Nov 2019 15:39:27 -0500
Received: by mail-qt1-f195.google.com with SMTP id g50so21283942qtb.4
        for <linux-raid@vger.kernel.org>; Tue, 12 Nov 2019 12:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qN5kbXga0+JM1Hof7c7uDCQWtLmahe5EUofwi79jask=;
        b=IF415Co0YzU2QpGevlrs88Jc5YgTlJTqk/s41xV1xBAUuUylq3lflVNM5DsK8TKTA3
         K3wMz+dB1feGnzJapJGvjiNT++yewYHiGMSnAs69eLv4RM5Qb99qQXLMVOxwogjd+D+6
         +dFUf00cMpl2KHt06eoeoTv0OOEjVljWie8KTFI7AI6eZXfgqtjJjZQkpLVhJaVic656
         yq6bwuda5N+ADFWgHtHN/WVJN4NQvTeF667CF2IESG4UuS6bXIv61VU+4qR/T2TLQRTw
         nAOdArz4wpi8gaUqoeFFCBbn4p+jgNuzhsfXVRrDxdoEaxLLmzxPWgBg55jz1cPGiMHA
         UxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qN5kbXga0+JM1Hof7c7uDCQWtLmahe5EUofwi79jask=;
        b=k2hSoppp17SWkJhQu2OAVdXu1PT2eMf305NN3pKye8W2tpIh2jjCET/gHDaDMCtAFg
         8r26HWaTWeUwLzfvkRSMxBEEOcIXy33QCgJQqulWvX2cFY52HzMdZKNraaHrlENJHhmT
         ADXPYJWUOs84SB9CYrpnF0Ew3LmHuOSjuSbwUSydMTvybBO14eS1bm1TeHktVZjCkErX
         FQ9B5Xd6pc6+MexVw52S+Fx1WrJB829vxrZioS3NYD7vZmGekOy3OemkPVlDalgZPOcw
         9/D/2NF3c9RrKLzUABVjbazq5EAGpO+LexYBqWUpjMKGcH/EyZhe166A1ip5UdubDc4A
         zlWA==
X-Gm-Message-State: APjAAAVhvrHhF2qsvsS2iDYUWOCw5bzlq7JIz9T9L6FBif8R3/5XbPga
        t+oJmeZCxkO5s+pWfVqpRPIfhn++
X-Google-Smtp-Source: APXvYqwHehvFqquWq8eQm3gh5K2ZwBfB/XdkpEk9baaoxoM3s6uoMaKn7GC2CZN0H/AUuej8Bc/xjw==
X-Received: by 2002:ac8:395a:: with SMTP id t26mr34027831qtb.22.1573591165844;
        Tue, 12 Nov 2019 12:39:25 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a3:10fb:a464:42a6:e226:d387? ([2620:10d:c091:500::fa23])
        by smtp.gmail.com with ESMTPSA id e17sm12001586qtk.65.2019.11.12.12.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 12:39:25 -0800 (PST)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH mdadm] super-intel: don't mark structs 'packed'
 unnecessarily
To:     NeilBrown <neilb@suse.de>
Cc:     linux-raid@vger.kernel.org,
        Mariusz Dabrowski <mariusz.dabrowski@intel.com>
References: <87k18leqf2.fsf@notabene.neil.brown.name>
 <1f57b1a1-70bd-15a4-4693-1b72aa5546f1@gmail.com>
 <87h83peh6h.fsf@notabene.neil.brown.name>
 <87eeyteej9.fsf@notabene.neil.brown.name>
Message-ID: <d8915b0f-59b5-ed19-1d8d-3e1f5c439147@gmail.com>
Date:   Tue, 12 Nov 2019 15:39:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87eeyteej9.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/31/19 12:15 AM, NeilBrown wrote:
> 
> super-intel marks a number of structures 'packed', but this
> doesn't change the layout - they are already well organized.
> 
> This is a problem a gcc warns when code takes the address
> of a field in a packet struct - as super-intel sometimes does.
> 
> So remove the marking where isn't needed.
> Do ensure this does introduce a regression, add a compile-time
> assertion that the size of the structure is exactly the value
> it had before the 'packed' notation was removed.
> 
> Note that a couple of structure do need to be packed.
> As the address of fields is never taken, that is safe.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Applied!

Thanks,
Jes


