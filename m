Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0597E35BBA0
	for <lists+linux-raid@lfdr.de>; Mon, 12 Apr 2021 10:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbhDLIFx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 12 Apr 2021 04:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbhDLIFw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 12 Apr 2021 04:05:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A807DC06138C
        for <linux-raid@vger.kernel.org>; Mon, 12 Apr 2021 01:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=IFowPJGq1xlOBABfPIwjQCcvjFxX909wD8ZJV60bgAI=; b=HSpvgknfABxatmHEWN/X8TB/EC
        i8QKJxnsDAfG5I1Cpcx+XpvJosnuA7hzlYXzch/G9FNGnC1grVkcnweZIX+5YPUK4vm/uMTNO0Gcq
        8l3WMXTsNm+bLnbNQdoN7M1CacUy8AvigmceFC9cvm7MBEv9DvhM03D2awdi+WcfYye4zCBbZkh7W
        azRo8u9dwvYTMA++cJ/+h/DJwug4nCGeonVKdutAyhHrAlmJVDmpqOQwPXSQTg/fd2wDUcYQNuZyp
        glHMdOBUDNqLNaRbMCZZ7NEmVpYnK25N1PXjk/voJW9wY+CuwOy+D85L+9wNHS97Y8Q9Q6aSvgobQ
        uhKlLTNw==;
Received: from [2001:4bb8:199:e2bd:3218:1918:85d1:2852] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVrZc-005xM0-Ky; Mon, 12 Apr 2021 08:05:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org
Subject: refactor mddev_find_or_alloc
Date:   Mon, 12 Apr 2021 10:05:27 +0200
Message-Id: <20210412080530.2583868-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


Hi Song,

this series refactor mddev_find_or_alloc so that is more easier to
read and groups related funtionality into separate helpers.
