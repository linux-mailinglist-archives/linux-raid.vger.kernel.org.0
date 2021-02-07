Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CD13125F7
	for <lists+linux-raid@lfdr.de>; Sun,  7 Feb 2021 17:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhBGQV5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 7 Feb 2021 11:21:57 -0500
Received: from verein.lst.de ([213.95.11.211]:38631 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhBGQV5 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 7 Feb 2021 11:21:57 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B8B868B02; Sun,  7 Feb 2021 17:21:14 +0100 (CET)
Date:   Sun, 7 Feb 2021 17:21:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: cleanup bvec allocation
Message-ID: <20210207162114.GA25630@lst.de>
References: <20210202171929.1504939-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202171929.1504939-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Feb 02, 2021 at 06:19:18PM +0100, Christoph Hellwig wrote:
> Hi Jens,
> 
> This series cleans up various lose ends in the bvec allocator.

Any comments?
