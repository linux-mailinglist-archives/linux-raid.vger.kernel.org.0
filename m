Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39DB2CD142
	for <lists+linux-raid@lfdr.de>; Thu,  3 Dec 2020 09:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbgLCI0m (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 3 Dec 2020 03:26:42 -0500
Received: from verein.lst.de ([213.95.11.211]:57568 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387399AbgLCI0m (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 3 Dec 2020 03:26:42 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D4E3767373; Thu,  3 Dec 2020 09:25:59 +0100 (CET)
Date:   Thu, 3 Dec 2020 09:25:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-s390@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: block tracepoint cleanups
Message-ID: <20201203082559.GA15521@lst.de>
References: <20201130175854.982460-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130175854.982460-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Whom can I trick into reviewing this fairly simple series now that
the one dependig on it got fully reviewed?
