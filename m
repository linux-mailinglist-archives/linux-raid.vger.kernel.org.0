Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0195393EB
	for <lists+linux-raid@lfdr.de>; Tue, 31 May 2022 17:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344880AbiEaP0F (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 31 May 2022 11:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343903AbiEaP0E (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 31 May 2022 11:26:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3DB3A703
        for <linux-raid@vger.kernel.org>; Tue, 31 May 2022 08:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qBqw4TW4izvaVHzCbo/wr6p2DUvbEvqYSBh40t35LQU=; b=0joYlOW3fyVrwPkjcLg9fHHrIn
        UDgZ5cb/dauupFSlExcaptwCeyg69Ee8CPQ7Y2AUTjW2jDXe4+xJo0NChPCCS/yJHK+5DPBzLV0Yu
        NZNrpWslrXLn/0Lti3D3S71p+v9nyLovA/hrpkoGoHIDWTevKJZ+tGxOCuBlZSxtyaNT9Ihnyz1Kg
        HD107N1bnLX9TVTctNNhaq0E6YnrHJOc97fqioNjwCp9IqUkaf0YXelI6n3oxWEv5hftSGHhrBBVI
        GC1lspImQ38zTUAvWlJ1LwoTw4Y0LRCIqKYAkj7HcTQCBTsImtgiNBOrs5webdL8lUNfV86mFggzP
        htQqN05g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nw3ks-00BXwN-QC; Tue, 31 May 2022 15:25:58 +0000
Date:   Tue, 31 May 2022 08:25:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chris Webb <chris@arachsys.com>
Cc:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: Re: [PATCH] md: Explicitly create command-line configured devices
Message-ID: <YpYzhpZZwc1jY4D0@infradead.org>
References: <YpXy4CLSwLf7arGp@arachsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpXy4CLSwLf7arGp@arachsys.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, May 31, 2022 at 11:50:08AM +0100, Chris Webb wrote:
> +extern int md_alloc(dev_t dev, char *name);

No need for the extern here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
