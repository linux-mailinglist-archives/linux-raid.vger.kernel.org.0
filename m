Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C216142D88
	for <lists+linux-raid@lfdr.de>; Mon, 20 Jan 2020 15:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgATO26 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Jan 2020 09:28:58 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:34654 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATO26 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 20 Jan 2020 09:28:58 -0500
Received: by mail-il1-f171.google.com with SMTP id s15so27445181iln.1
        for <linux-raid@vger.kernel.org>; Mon, 20 Jan 2020 06:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=SqkLjWYmPf8iY9FtNvyy87SkZYtulmhUxgfVCee18jY=;
        b=UXeHRMddSFdOuKCn8ZtOhlPSoCQgz8VINm0FnssmilKpP4jiecIjXJgwNcwbCu1OZg
         5Ch1ohVvtmLUGfqmxySWawgrRu3VODDJirSLzoy8Z4ljxAKiJzAe1jmhaKCwqgCzmYL0
         cy/JNVUGe9rbOCXDUFoUjlLdkJMV7KgQMg4GMPSIl5LkP2h5pDPuDtgT3HXbzUQxsDIK
         3Pwi7BUsoTarH1J6sw8yEg6jaguohQcxdFnz1TyT6v9yYNUwhkniioPwOux9MjF1nH0I
         9lDnfY97fVLXV4ZF95Qg96OP16yiCydhaEbVZjCosypqIfyByonXBknMLTqp0OyDgWA2
         G71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=SqkLjWYmPf8iY9FtNvyy87SkZYtulmhUxgfVCee18jY=;
        b=hTvPF8jI5N3K73l5VgOIELn4a83TO5bdq437lXXcylPWhVLMR3lpJVQZm1xV+53rom
         pOxkveqZBYUXzqsjclwtqBKHz9OjePPseUDuJ5Fz00IUIDFLfoAFxPc0n9lUcolxureh
         NUAOrnQG4qxo33gCA4+mTeq2yR6kSOnsmXOILE8YE7ODUjHv8RzUB8644NtTjuIOG32k
         VKpqJfSJzbbr1cR+08nWmeJaaYkFyhEUosTnvF8toj3T/rYOQyH0HBYo9HpsjdzAj4jY
         VapJSKdUSyKGRT/gXt56h1pDykPgVVtE7q4H/mWlPIYA/Ep/pyUA6T7lLqnzv41LZrx6
         qMTw==
X-Gm-Message-State: APjAAAXTb9WuaWNeTizZrn1UfNrzGTJelVqOQnebPTnxrTJ7mMz9S7ZM
        mpoKQdh/RIqgEmJnIsmRtAYXTnbwE4wJORF5GFYZ4m1I9fA=
X-Google-Smtp-Source: APXvYqzzmkG1bzqfo7CVWkM1OJoE64/NQ2vonpNuwhk5fcGtS1djDt84XVmG5mKM2UjEiO/w3fTS46Iph/VKr7Ir7Kg=
X-Received: by 2002:a92:da41:: with SMTP id p1mr11685564ilq.113.1579530537399;
 Mon, 20 Jan 2020 06:28:57 -0800 (PST)
MIME-Version: 1.0
References: <CAJH6TXjryixcArdcu_oVzmkEyktpMSb62YaUJvUv_Nd7k3mbDg@mail.gmail.com>
In-Reply-To: <CAJH6TXjryixcArdcu_oVzmkEyktpMSb62YaUJvUv_Nd7k3mbDg@mail.gmail.com>
From:   Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date:   Mon, 20 Jan 2020 15:29:10 +0100
Message-ID: <CAJH6TXiK0_v5sHqrphT1Q2oOVngT4TPGzvGKCPw35hAMRUHt4w@mail.gmail.com>
Subject: Re: Last scrub date and result
To:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Il giorno lun 6 gen 2020 alle ore 12:49 Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> ha scritto:
> Update Time : Mon Jan  6 12:47:29 2020
>           State : clean
> Last scrub Time: Mon Jan  4 12:47:29 2020
> Last scrub result: success

something similiar to ZFS:

scan: resilvered 817G in 0 days 01:33:48 with 0 errors on Wed Jan 15
19:36:08 2020

this is for a resilver, but a scub is similiar
