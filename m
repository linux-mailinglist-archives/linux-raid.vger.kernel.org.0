Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7E2663977
	for <lists+linux-raid@lfdr.de>; Tue, 10 Jan 2023 07:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjAJGsF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 10 Jan 2023 01:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjAJGsE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 10 Jan 2023 01:48:04 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBDD30558
        for <linux-raid@vger.kernel.org>; Mon,  9 Jan 2023 22:48:03 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BB02D68B05; Tue, 10 Jan 2023 07:48:00 +0100 (CET)
Date:   Tue, 10 Jan 2023 07:48:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Adrian Huang <adrianhuang0701@gmail.com>
Cc:     linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH 1/1] md: fix incorrect declaration about claim_rdev in
 md_import_device
Message-ID: <20230110064800.GA10262@lst.de>
References: <20230110014512.19233-1-adrianhuang0701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110014512.19233-1-adrianhuang0701@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
