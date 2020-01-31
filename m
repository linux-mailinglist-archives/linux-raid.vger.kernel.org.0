Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6C6414E8D8
	for <lists+linux-raid@lfdr.de>; Fri, 31 Jan 2020 07:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgAaGgy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 31 Jan 2020 01:36:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgAaGgy (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 31 Jan 2020 01:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4C91OmxMHJbf2dvjbKRIv7O9Ffsa52p52fBfuWZA76w=; b=cs3mINyjlbh/P8XlEo6zHtKcX
        gz0hU18eOOvnenPCLVFQW6LHiiMVTfOu6vo0xwy3rWX6uc5XJpJNaF/da1A70uVDkkSbtDkJZObVu
        4UNlGDc6c6cpc4oKKO3KDH818j2nwPWJQjpghd9jYhfsp82l1UhE6bsX7zfIVM+ssHqI0h7VsFnIF
        Vo/ThkTRjF7ub39ros8yJm0q4T+Zo7v5/YXEwYNyYKRre8HAeNmhw4s+vHs90dWo8gleevzDc7Yfv
        GZGPUlTF9gQKR1zDarlf7SZrtRbAwk6x8L/BC62uyBWtJXsFW3vAhxCKzluRzbtt/VsTMvmotVzcj
        Cj0g85HNQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixPvB-000799-A5; Fri, 31 Jan 2020 06:36:53 +0000
Date:   Thu, 30 Jan 2020 22:36:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Cc:     axboe@kernel.dk, song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Subject: Re: [PATCH 2/2] md: enable io polling
Message-ID: <20200131063653.GD6267@infradead.org>
References: <20200126044138.5066-1-andrzej.jakowski@linux.intel.com>
 <20200126044138.5066-3-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126044138.5066-3-andrzej.jakowski@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> +	rdev_for_each(rdev, mddev) {
> +		if (rdev->raid_disk >= 0 && !test_bit(Faulty, &rdev->flags)) {
> +			rv = blk_poll(bdev_get_queue(rdev->bdev), cookie, false);

This adds a > 80 char line.  But if you just use a continue to skip
the not allicable ones you even clean up the code while avoiding that.
