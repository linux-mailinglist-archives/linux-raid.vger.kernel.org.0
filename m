Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6367F15B2E7
	for <lists+linux-raid@lfdr.de>; Wed, 12 Feb 2020 22:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgBLVmP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 12 Feb 2020 16:42:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727564AbgBLVmO (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 12 Feb 2020 16:42:14 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C92F21734;
        Wed, 12 Feb 2020 21:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581543734;
        bh=le/GdcrhG8sMWeDb4sd1yViCRHZ5He25OP84g6uwgEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PrMnxCfA71JMadWCoM/EW6c8G8mn8klM7fWku3Ds/bUZe3ahdHWNUQgd3oHF6t672
         H+e76OMh2Yoj6ZT73AdXHQ6gPugBOnOpQ429C/zB2EcazWNQrabtkFc+69NlQHQZOx
         D1emJXry9wTw7MbrWRKTjQB+U7LP2spvkPDWWmsA=
Date:   Thu, 13 Feb 2020 06:42:07 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Cc:     axboe@kernel.dk, song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Subject: Re: [PATCH v2 2/2] md: enable io polling
Message-ID: <20200212214207.GA6409@redsun51.ssa.fujisawa.hgst.com>
References: <20200211191729.4745-1-andrzej.jakowski@linux.intel.com>
 <20200211191729.4745-3-andrzej.jakowski@linux.intel.com>
 <20200211211334.GB3837@redsun51.ssa.fujisawa.hgst.com>
 <e9941d4d-c403-4177-526d-b3086207f31a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9941d4d-c403-4177-526d-b3086207f31a@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Feb 12, 2020 at 02:00:10PM -0700, Andrzej Jakowski wrote:
> On 2/11/20 2:13 PM, Keith Busch wrote:
> > I must be missing something: md's make_request_fn always returns
> > BLK_QC_T_NONE for the cookie, and that couldn't get past blk_poll's
> > blk_qc_t_valid(cookie) check. How does the initial blk_poll() caller get
> > a valid cookie for an md backing device's request_queue? And how is the
> > same cookie valid for more than one request_queue?
> 
> That's true md_make_request() always returns BLK_QC_T_NONE. md_make_request()
> recursively calls generic_make_request() for the underlying device (e.g. nvme).
> That block io request directed to member disk is added into bio_list and is 
> processed later by top level generic_make_request(). generic_make_request() 
> returns cookie that is returned by blk_mq_make_request().
> That cookie is later used to poll for completion. 

Okay, that's a nice subtlety. But it means the original caller gets the
cookie from the last submission in the chain. If md recieves a single
request that has to be split among more than one member disk, the cookie
you're using to control the polling is valid only for one of the
request_queue's and may break others.
