Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0802B159023
	for <lists+linux-raid@lfdr.de>; Tue, 11 Feb 2020 14:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgBKNl5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Feb 2020 08:41:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28962 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727653AbgBKNl5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 11 Feb 2020 08:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581428516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XF9rwhFYWivht0eGlToXTwJlSnqhPkyjM39WBwDsJPs=;
        b=BVwzqII6cPLF9KFfa3D7aQTthKyoLYU6SXAi8j7q+oVi207k/UUuIpp53g9scqBVTZbEnO
        U/tMFk7ODTVw8wjiReDPGJpekIyhrRCo0l9XE51b8MtyW2aPbpGcRGHUzpHmcH1KFNMR1q
        StUOlljSwZYu0+iz6W+8topunYaREx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-In5RN66mNmi14veQDX95ag-1; Tue, 11 Feb 2020 08:41:52 -0500
X-MC-Unique: In5RN66mNmi14veQDX95ag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E021B8010EB;
        Tue, 11 Feb 2020 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F6921001E91;
        Tue, 11 Feb 2020 13:41:48 +0000 (UTC)
Subject: Re: [PATCH 1/1] Remove the legacy whitespace
From:   Xiao Ni <xni@redhat.com>
To:     jes.sorensen@gmail.com
Cc:     ptoscano@redhat.com, ncroxon@redhat.com, linux-raid@vger.kernel.org
References: <1581428285-12008-1-git-send-email-xni@redhat.com>
Message-ID: <3334dde5-6947-167b-bcbc-cdae47ce2864@redhat.com>
Date:   Tue, 11 Feb 2020 21:41:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1581428285-12008-1-git-send-email-xni@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi all

Please ignore this patch. I missed another place that needs to modify. I'll

send a new patch later.

Regards

Xiao


On 02/11/2020 09:38 PM, Xiao Ni wrote:
> The whitespace between Environment= and the true value causes confusion.
> To avoid confusing other people in future, remove the whitespace to keep
> it a simple, unambiguous syntax
>
> Signed-off-by: Xiao Ni <xni@redhat.com>
> ---
>   systemd/mdcheck_continue.service | 2 +-
>   systemd/mdcheck_start.service    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/systemd/mdcheck_continue.service b/systemd/mdcheck_continue.service
> index aa02dde..854317f 100644
> --- a/systemd/mdcheck_continue.service
> +++ b/systemd/mdcheck_continue.service
> @@ -11,7 +11,7 @@ ConditionPathExistsGlob = /var/lib/mdcheck/MD_UUID_*
>   
>   [Service]
>   Type=oneshot
> -Environment= "MDADM_CHECK_DURATION=6 hours"
> +Environment="MDADM_CHECK_DURATION=6 hours"
>   EnvironmentFile=-/run/sysconfig/mdadm
>   ExecStartPre=-/usr/lib/mdadm/mdadm_env.sh
>   ExecStart=/usr/share/mdadm/mdcheck --continue --duration ${MDADM_CHECK_DURATION}
> diff --git a/systemd/mdcheck_start.service b/systemd/mdcheck_start.service
> index da62d5f..3bb3d13 100644
> --- a/systemd/mdcheck_start.service
> +++ b/systemd/mdcheck_start.service
> @@ -11,7 +11,7 @@ Wants=mdcheck_continue.timer
>   
>   [Service]
>   Type=oneshot
> -Environment= "MDADM_CHECK_DURATION=6 hours"
> +Environment="MDADM_CHECK_DURATION=6 hours"
>   EnvironmentFile=-/run/sysconfig/mdadm
>   ExecStartPre=-/usr/lib/mdadm/mdadm_env.sh
>   ExecStart=/usr/share/mdadm/mdcheck --duration ${MDADM_CHECK_DURATION}

