Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0352A1E17CE
	for <lists+linux-raid@lfdr.de>; Tue, 26 May 2020 00:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbgEYWSq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 18:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgEYWSq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 May 2020 18:18:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A7DC061A0E
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 15:18:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t18so4416446wru.6
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 15:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=yujsI0jQtQYVe7lEyXeJSd3TDyo6PEB8I99oPBcEGe0=;
        b=J3u9CUBJBiNcADhk3X0wJdsv33jGQDN093XoesoY1qRowy35qv8vTn3YD6BBgwDn/B
         grGv6IqVcpFPNytAQH3+B13EPDUXRTGClzHw7fYhgi9ZzK7ksVTgGUCU3/bbugFvJafy
         3HO2sb0A1AsUvpb2PHVCw7Tp1GKfPQRefFtnuwm/R/VUbYvjNFSHaLCT6a/gtrKVt85g
         5cPtSe7+98/TID0tx2ay7lVaSoheayEBMPrHbHpKszpM4wLo0F5UJGHM1q+sZGXRwaZ+
         EHNxrGOeiwyH8b7qzpqAOvc0fdvqZ2zAXhLT4xwirwGEX1JJbSez+las3367avXTgFwm
         UjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=yujsI0jQtQYVe7lEyXeJSd3TDyo6PEB8I99oPBcEGe0=;
        b=Unglsk/vXi5hW2NWWMuKp1xp9pNKx1R2M8xcFo2v5bQQV70jTfo6uqBh/nztDhNc6W
         B4Azc2hI+I++7lknoaxZWHaRP4ZU7M4WQ5y6xee/216F+SZRxPt9ggkdwPH24B8QyMoy
         OTDDvbgk0U1Jgguge+jz0brRkAI8jzLpR9IxSQX13AOgeRbp13463uVk34MS1pk4lu9J
         bAacut+GFXWQgkL8mobM1NI72f4zXVShsBxtWDGO0CLPKe36RFbAFHjyO7Ls1wP4uRVM
         12vkI+IsdBXzi+pva6EpK/pO5MZciFj94q/n5K9mW6ZG/h6KhtLTIdaQ8EVU7RGdc35Y
         qHzQ==
X-Gm-Message-State: AOAM530EILa9AUFJQW2bL2uTUleJkafuShlnKsntjJaoBPSSiAOyTeE8
        JKt2HCCF6Ahvv8yP4OmU92QsLjxmBrg=
X-Google-Smtp-Source: ABdhPJz9lYsPpG/BuJ6sDPKhGFgivoYu5zc3ku4Kko/NY9STnv133SpTiADc+gQrTW8UPBAx4BNDSA==
X-Received: by 2002:adf:dc0a:: with SMTP id t10mr18271045wri.342.1590445124807;
        Mon, 25 May 2020 15:18:44 -0700 (PDT)
Received: from [192.168.188.88] ([46.28.163.233])
        by smtp.gmail.com with ESMTPSA id o15sm6054670wmm.31.2020.05.25.15.18.43
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 15:18:44 -0700 (PDT)
Subject: Re: help requested for mdadm grow error
Cc:     linux-raid@vger.kernel.org
References: <7d95da49-33d8-cd4d-fa3f-0f3d3074cb30@gmail.com>
 <5ECC09D6.1010300@youngman.org.uk>
 <ff4ea9cd-ab35-0990-5946-4a72d4021658@gmail.com>
 <5ECC1488.3010804@youngman.org.uk>
 <4891e1e8-aaee-b36b-4131-ca7deb34defd@gmail.com>
 <alpine.DEB.2.20.2005252132080.7596@uplift.swm.pp.se>
 <103b80fa-029f-ecdc-d470-5cc591dc8dd0@gmail.com>
 <e1a4a609-2068-b084-59a6-214c88798966@youngman.org.uk>
 <e1ad56b2-df70-bc6a-9a81-333230d558c2@gmail.com>
 <358e9f6b-a989-0e4a-04c4-6efe2666159f@youngman.org.uk>
From:   Thomas Grawert <thomasgrawert0282@gmail.com>
Message-ID: <b5e5c7af-9d1b-3eca-f3a1-f03f8d308015@gmail.com>
Date:   Tue, 26 May 2020 00:18:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <358e9f6b-a989-0e4a-04c4-6efe2666159f@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


> Okay, so we need to grep dmesg looking for a message like that above 
> about reshaping.
>
> So let's grep for "md/raid" and see what we get ...

root@nas:~# dmesg | grep md/raid
[  321.819562] md/raid:md0: not clean -- starting background reconstruction
[  321.819564] md/raid:md0: reshape_position too early for auto-recovery 
- aborting.


(again: thanks a lot for your help. I never expected that! :-) )


