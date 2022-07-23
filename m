Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF0657EC49
	for <lists+linux-raid@lfdr.de>; Sat, 23 Jul 2022 08:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiGWGYl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 23 Jul 2022 02:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiGWGYk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 23 Jul 2022 02:24:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A209969F23
        for <linux-raid@vger.kernel.org>; Fri, 22 Jul 2022 23:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=MnnnJSqWlqShXmEE3YboPAwK26uledMASV6yTe9sJdM=; b=epQepJbslG40Ej4uLDz1DtBm3z
        GAHiC1pESWBMFZg4a9oGOIoHT12kjy6sQoua6WTPpYX8TA4deK414AbaKY6UQfHkIlqW94H60AUwq
        6D3hXIUzPMQDRszX0waHUvJG9EsETuYp/oXgEHigD6ZWGNmd3kD+fI3VQ8U3VflLGFOT7qjd+wFFl
        grTsNd7W82duDkZr2zGkIkXTaNgwNmxHpXe2eo5t8bWa/U3ynCDQiw7REQWQlu15KH2LtL/SIaKCp
        FRTHbCnl0xlAJDZQmRlTG+BWbfIv4fbFDMaIBwy++HKWDKm7Ds6YlkpVapOCURD7wcgLq2xMi/vxl
        RHenmXig==;
Received: from [2001:4bb8:199:fe1f:951f:1322:520f:5e75] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oF8Yy-00GKGp-Nj; Sat, 23 Jul 2022 06:24:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>, linux-raid@vger.kernel.org
Subject: md device allocation cleanups
Date:   Sat, 23 Jul 2022 08:24:27 +0200
Message-Id: <20220723062429.2210193-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi all,

this small series cleans up the mddev allocation a bit by returning
the structure to callers that want it instead of requiring another
lookup.
