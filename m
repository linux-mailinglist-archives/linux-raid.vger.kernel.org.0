Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFCA69FFAB
	for <lists+linux-raid@lfdr.de>; Thu, 23 Feb 2023 00:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjBVXj5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 22 Feb 2023 18:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjBVXjy (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 22 Feb 2023 18:39:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986D42A6C0
        for <linux-raid@vger.kernel.org>; Wed, 22 Feb 2023 15:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AslA7TjVPGhKPSN2gLRsg7E6X3WF+63Cdlu+oLkcAFU=; b=AEWMJ7CY/UWeptidwVHDr1qh2K
        eepAMK0sX0XA61POL2EvFA90KX1C0b7CCCefojRciJGXKf9rl1+6+zR5Ju1UINMWaRWQ/SLvvPIuy
        8ObvxMGLQFoFqgNGeoIz/0ThhkBtaHvkK9+Qa9vgIjuRRiq6Oe5zcU9ZBspbeaSw/uyXpEOVS2OFB
        u6A7U2dHeIU4EldjCNIFA6BrwPCB0uJl/tBviNPmfNDauCGJv5ZqjW9G3LZkomE53CunbbLf7mZgS
        mkoFIEPsrMhGtB5jDlh5bmL1l040BGXdxWp5jD6NMPVaGXiqVpK322M2ELflIw/O4z40aMV1rDKVk
        SGDGH6dg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUyi8-00ESBS-Bh; Wed, 22 Feb 2023 23:39:44 +0000
Date:   Wed, 22 Feb 2023 15:39:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        Xiao Ni <xni@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Sushma Kalakota <sushma.kalakota@intel.com>
Subject: Re: [PATCH v3 1/3] md: Move sb writer loop to its own function
Message-ID: <Y/anwPqnrDs9Tt8H@infradead.org>
References: <20230222215828.225-1-jonathan.derrick@linux.dev>
 <20230222215828.225-2-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222215828.225-2-jonathan.derrick@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I was going to complain about the formatting, but as that gets
fixed up in the next patch:

Reviewed-by: Christoph Hellwig <hch@lst.de>
