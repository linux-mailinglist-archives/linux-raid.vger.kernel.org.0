Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDEE7122ED8
	for <lists+linux-raid@lfdr.de>; Tue, 17 Dec 2019 15:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfLQOee convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Tue, 17 Dec 2019 09:34:34 -0500
Received: from sender11-op-o12.zoho.eu ([185.20.211.226]:17315 "EHLO
        sender21-op-o12.zoho.eu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726191AbfLQOee (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 17 Dec 2019 09:34:34 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1576593263; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=dMMUeynaLOTmfFp0paFtvwZoCGenkhvkDDOa2wUwYUnScVTdPcLKafHpZgQa2pNW6hYF+BMOi+Y/W260TwzH1c0Kv626vduJJrH+3eeFYwnf6VQIYX+IDmlpfpDWtVJGWhp8xZXiiyxNfzKJ48ak4YfTnwrBm6Afh2w+CRZ7pB8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1576593263; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=c3BR/eeMlIVSSj7RUOWdO8WO+GoPDzjv5v/ywsasBlk=; 
        b=garoJ5D+fJxW+6Gen/FbmTYMKNti0Xan9NxsMU8wi6UULFOZJt6Pv+4LeKnblGyW8ae+t9ygGwDh4WzdcHm8gxy99vxAUqB5iwNJhy9jKr4wF2vv1EudkhZn+Pamj8Ze9gajm32IEAp3go1d68tB5m2ehZOfDhR5UmkZWGZxnTA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=trained-monkey.org;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [172.30.119.7] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 1576592923119960.9843768839129; Tue, 17 Dec 2019 15:28:43 +0100 (CET)
Subject: Re: Broken Environment syntax in
 mdcheck_start/mdcheck_continue.service
To:     Xiao Ni <xni@redhat.com>, Jes Sorensen <jes.sorensen@gmail.com>,
        NeilBrown <neilb@suse.com>,
        linux-raid <linux-raid@vger.kernel.org>
References: <60128448-c1e6-5155-7ad8-fc19493fc9b1@redhat.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <8a6600ec-2b4a-50e9-bfb0-b3d9331a8a54@trained-monkey.org>
Date:   Tue, 17 Dec 2019 09:28:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <60128448-c1e6-5155-7ad8-fc19493fc9b1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Xiao,

Can you please sent a patch that has the proper signed-off-by line.

Also your mail client is broken, it states UTF-8 but there's what looks
like quoted-unreadble stuff in the description text.

Thanks,
Jes

On 12/17/19 9:24 AM, Xiao Ni wrote:
> Hi all
> 
> In rhel7 we encounter one systemd service failed problem.
> 
> [root@intel-rosecity-07 ~]# systemctl start mdcheck_start
> [root@intel-rosecity-07 ~]# systemctl status mdcheck_start -l
> ● mdcheck_start.service - MD array scrubbing
>    Loaded: loaded (/usr/lib/systemd/system/mdcheck_start.service;
> static; vendor preset: disabled)
>    Active: inactive (dead)
> 
> Dec 17 09:16:59 intel-rosecity-07.khw1.lab.eng.bos.redhat.com
> systemd[1]: [/usr/lib/systemd/system/mdcheck_start.service:14] Invalid
> environment assignment, ignoring: MDADM_CHECK_DURATION="6 hours"
> 
> This patch can fix this problem. So is it a systemd syntax problem? The
> service can start sucessfully in rhel8.
> 
> diff --git a/systemd/mdcheck_start.service b/systemd/mdcheck_start.service
> index f17f1aa..da62d5f 100644
> --- a/systemd/mdcheck_start.service
> +++ b/systemd/mdcheck_start.service
> @@ -11,7 +11,7 @@ Wants=mdcheck_continue.timer
> 
>  [Service]
>  Type=oneshot
> -Environment= MDADM_CHECK_DURATION="6 hours"
> +Environment= "MDADM_CHECK_DURATION=6 hours"
>  EnvironmentFile=-/run/sysconfig/mdadm
>  ExecStartPre=-/usr/lib/mdadm/mdadm_env.sh
>  ExecStart=/usr/share/mdadm/mdcheck --duration ${MDADM_CHECK_DURATION}
> 
> 
> Best Regards
> 
> Xiao
> 
> 



