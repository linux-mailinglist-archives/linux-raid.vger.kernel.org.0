Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761532297FE
	for <lists+linux-raid@lfdr.de>; Wed, 22 Jul 2020 14:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbgGVMPE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Jul 2020 08:15:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60225 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726161AbgGVMPE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 22 Jul 2020 08:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595420102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJUdG/yYr+ku5dIBsCEM4uvvEfTwWSsTGXOQoABVj8M=;
        b=UIog3hqOaVrG04gyXE8CgbcIA6DV9GJb/lPuM32sZ0XyTSg8mjKSyWcI2pzceoOxA6i+ZT
        O80KpPyOqMeAqu5huX/7y9Dcq/XXKJerfpYxTfqMSZfUdxZBoabz5EHrdFzk6H6RuGm0ix
        fzQ8e+Cm1crKr3CxDKhGEVKsp344mNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-xhp_psKYMkuiaNs2jF21Qg-1; Wed, 22 Jul 2020 08:14:59 -0400
X-MC-Unique: xhp_psKYMkuiaNs2jF21Qg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C46BD80046A;
        Wed, 22 Jul 2020 12:14:58 +0000 (UTC)
Received: from [10.10.67.72] (unknown [10.10.67.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DE1978559;
        Wed, 22 Jul 2020 12:14:58 +0000 (UTC)
Subject: Re: [PATCH 1/1] md/raid10: avoid deadlock on recovery.
To:     Vitaly Mayatskikh <vmayatskikh@digitalocean.com>,
        linux-raid@vger.kernel.org, Song Liu <liu.song.a23@gmail.com>
References: <1583259280-124995-1-git-send-email-vmayatskikh@digitalocean.com>
 <1583259280-124995-2-git-send-email-vmayatskikh@digitalocean.com>
From:   Nigel Croxon <ncroxon@redhat.com>
Message-ID: <81161bfa-2bb1-2932-f605-197891f75e17@redhat.com>
Date:   Wed, 22 Jul 2020 08:14:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1583259280-124995-2-git-send-email-vmayatskikh@digitalocean.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 3/3/20 1:14 PM, Vitaly Mayatskikh wrote:
> When disk failure happens and the array has a spare drive, resync thread
> kicks in and starts to refill the spare. However it may get blocked by
> a retry thread that resubmits failed IO to a mirror and itself can get
> blocked on a barrier raised by the resync thread.
>
> Signed-off-by: Vitaly Mayatskikh <vmayatskikh@digitalocean.com>
> ---
>   drivers/md/raid10.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index ec136e4..f1a8e26 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -980,6 +980,7 @@ static void wait_barrier(struct r10conf *conf)
>   {
>   	spin_lock_irq(&conf->resync_lock);
>   	if (conf->barrier) {
> +		struct bio_list *bio_list = current->bio_list;
>   		conf->nr_waiting++;
>   		/* Wait for the barrier to drop.
>   		 * However if there are already pending
> @@ -994,9 +995,16 @@ static void wait_barrier(struct r10conf *conf)
>   		wait_event_lock_irq(conf->wait_barrier,
>   				    !conf->barrier ||
>   				    (atomic_read(&conf->nr_pending) &&
> -				     current->bio_list &&
> -				     (!bio_list_empty(&current->bio_list[0]) ||
> -				      !bio_list_empty(&current->bio_list[1]))),
> +				     bio_list &&
> +				     (!bio_list_empty(&bio_list[0]) ||
> +				      !bio_list_empty(&bio_list[1]))) ||
> +				     /* move on if recovery thread is
> +				      * blocked by us
> +				      */
> +				     (conf->mddev->thread->tsk == current &&
> +				      test_bit(MD_RECOVERY_RUNNING,
> +					       &conf->mddev->recovery) &&
> +				      conf->nr_queued > 0),
>   				    conf->resync_lock);
>   		conf->nr_waiting--;
>   		if (!conf->nr_waiting)

Acked-by: Nigel Croxon <ncroxon@redhat.com>

Nigel


