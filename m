Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4E72AC337
	for <lists+linux-raid@lfdr.de>; Mon,  9 Nov 2020 19:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgKISH5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 9 Nov 2020 13:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbgKISH5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 9 Nov 2020 13:07:57 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D954C0613D4
        for <linux-raid@vger.kernel.org>; Mon,  9 Nov 2020 10:07:57 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id v11so6252147qtq.12
        for <linux-raid@vger.kernel.org>; Mon, 09 Nov 2020 10:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7NGOsjZERbiE5w2MHC1mFU2jxp4Wb+n3njEEiJYjdrs=;
        b=O4/l9OEaWnaVVx9mA/+hODfmoKgGQIEUNKB0HmUGrD+LhRciIQAcMV79vjoQi/4L15
         CDVLebLFqwtrXUj2MValkzQKsvuvZ+bIj/HDHunVOXdD5rmqC2zDcm6G2ntA+MvXnqhC
         vTEl8uxCxkWixlkEepU/54lrdZYMGD0U3koL7aiUg0SUzZXfN7ZexvE/u58j8exqrb0L
         /O1jcvVnjraSt/kGOG4mDP8TkZHx3MoMGZRLY1X+es3rUicc6WotFmSs08rTBby/Yuep
         Z7z6vRhPWjHEqJ+TL+UexVhcPZExA43AO0zs4xR+XnsHWVoRk8SDKKD+pe0DirmCEgT1
         wWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7NGOsjZERbiE5w2MHC1mFU2jxp4Wb+n3njEEiJYjdrs=;
        b=WoP2BCvEYuThiqhaL16Qu4FZ4Ps0PKOFd+S1Tbt2Q4huDlF1P1aiGosqBOTRdRJ5Zv
         6kbaTi+Vt7PbyP+rC9hqeRmYeBp9y5nCu5AvW8LwUGfbaj/zjVlwnBDIORvw6chdnZtl
         1nlBB5x5H8DPlepO+f/PDRlTUOMHn8w8Ys7XuZJUHSIxXbG5j/QDJVrWKY17gLc8aVpY
         o1LtgVwz+nkTXszUNO1K+6AlcLcuPAaHp7mu0WihKa1JUGcoqar/FY7odGFY94VSeDs5
         fnPaIID24izn2uzxom5F8uOVnQpri/uwE65ABtqKDlHznbuOGiVMW+w2xOfvkdDRQ+Rt
         4V4A==
X-Gm-Message-State: AOAM5331IsvDCgOT63bJPK9OmL/A/qdzN3N0Ye/YqDMdXS3hJrn+yazs
        xZC6Jjf4C/VuxD3hWiHE5Nfbow==
X-Google-Smtp-Source: ABdhPJz1XdtisV/lRv5ASDEyKBu7yVqtI15E3NOcCNcW+bkgomAeHWz+gX9FyFOWQktTiYmlqxOYiw==
X-Received: by 2002:aed:3147:: with SMTP id 65mr14719130qtg.295.1604945276157;
        Mon, 09 Nov 2020 10:07:56 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z2sm6588768qkl.22.2020.11.09.10.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 10:07:55 -0800 (PST)
Subject: Re: cleanup updating the size of block devices
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20201106190337.1973127-1-hch@lst.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7ddd60ce-f588-028f-7e47-2df4d52e22d5@toxicpanda.com>
Date:   Mon, 9 Nov 2020 13:07:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201106190337.1973127-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/6/20 2:03 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series builds on top of the work that went into the last merge window,
> and make sure we have a single coherent interfac for updating the size of a
> block device.
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

for the nbd bits, thanks,

Josef
