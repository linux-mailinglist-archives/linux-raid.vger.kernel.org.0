Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94762CD5B1
	for <lists+linux-raid@lfdr.de>; Thu,  3 Dec 2020 13:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgLCMns (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 3 Dec 2020 07:43:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:59378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgLCMns (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 3 Dec 2020 07:43:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E79BBAC2E;
        Thu,  3 Dec 2020 12:43:06 +0000 (UTC)
Subject: Re: [PATCH 1/5] block: remove the unused block_sleeprq tracepoint
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-s390@vger.kernel.org
References: <20201130175854.982460-1-hch@lst.de>
 <20201130175854.982460-2-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d7222f62-3bcc-e9a2-55b2-58c83ca08556@suse.de>
Date:   Thu, 3 Dec 2020 13:43:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130175854.982460-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/30/20 6:58 PM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/trace/events/block.h | 18 ------------------
>   kernel/trace/blktrace.c      | 22 ----------------------
>   2 files changed, 40 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
