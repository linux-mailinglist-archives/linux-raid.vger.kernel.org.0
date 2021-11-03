Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2376444834
	for <lists+linux-raid@lfdr.de>; Wed,  3 Nov 2021 19:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhKCSXt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 3 Nov 2021 14:23:49 -0400
Received: from verein.lst.de ([213.95.11.211]:60792 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230500AbhKCSXs (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 3 Nov 2021 14:23:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6319F68AA6; Wed,  3 Nov 2021 19:21:09 +0100 (CET)
Date:   Wed, 3 Nov 2021 19:21:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hch@lst.de, penguin-kernel@i-love.sakura.ne.jp,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, richard@nod.at,
        miquel.raynal@bootlin.com, vigneshr@ti.com, efremov@linux.com,
        song@kernel.org, martin.petersen@oracle.com, hare@suse.de,
        jack@suse.cz, ming.lei@redhat.com, tj@kernel.org,
        linux-mtd@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ataflop: address add_disk() error handling on
 probe
Message-ID: <20211103182109.GE7745@lst.de>
References: <20211103181258.1462704-1-mcgrof@kernel.org> <20211103181258.1462704-3-mcgrof@kernel.org> <20211103182016.GB7745@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103182016.GB7745@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Or maybe I should stop nitpicking for these cruft drivers.

I'm ok with this and the next patch:

Reviewed-by: Christoph Hellwig <hch@lst.de>
