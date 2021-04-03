Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419803534AC
	for <lists+linux-raid@lfdr.de>; Sat,  3 Apr 2021 18:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbhDCQME (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 3 Apr 2021 12:12:04 -0400
Received: from verein.lst.de ([213.95.11.211]:46628 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230450AbhDCQME (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 3 Apr 2021 12:12:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E9A6268BEB; Sat,  3 Apr 2021 18:11:58 +0200 (CEST)
Date:   Sat, 3 Apr 2021 18:11:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zhao Heming <heming.zhao@suse.com>
Cc:     linux-raid@vger.kernel.org, song@kernel.org, hch@lst.de,
        guoqing.jiang@cloud.ionos.com, lidong.zhong@suse.com,
        xni@redhat.com, neilb@suse.de, colyli@suse.com
Subject: Re: [PATCH] md: md_open returns -EBUSY when entering racing area
Message-ID: <20210403161158.GA4657@lst.de>
References: <1617418885-23423-1-git-send-email-heming.zhao@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617418885-23423-1-git-send-email-heming.zhao@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This defintively looks better than the ERESTARTSYS hack.

I think I'll defer the whole blkdev_get refactoring and bd_mutex to
open_mutex conversion to the next merge window, so I think we should
be fine with this plus the mddev_find split.

Reviewed-by: Christoph Hellwig <hch@lst.de>
