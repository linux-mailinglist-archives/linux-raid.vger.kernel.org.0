Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3183FD8E1
	for <lists+linux-raid@lfdr.de>; Wed,  1 Sep 2021 13:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243866AbhIALkG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 1 Sep 2021 07:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243864AbhIALkG (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 1 Sep 2021 07:40:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77E8C061575
        for <linux-raid@vger.kernel.org>; Wed,  1 Sep 2021 04:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=nfBtnnP/UlXCnebhe+NeyyYZR6IHId4fP/6Ems/PS50=; b=GvesE4FhnaWnjux9Bg62WD6+FV
        o2IcieHyqXdC4zUC/WjM2CAehshqkxefPyQJnMfMWZUUMX3QKylbuKcyJGjSIFD+If+wQvsC2k3xq
        UIq6XHxac3TPMvI6ZelzN03iJv4NwzWdxvJ74iACZGZltPAC9XgKc56+vBo7Dwd2153B504FZf52v
        /oj88m7nCsbfgFeLa0ysqRjGVZj4ucpprcy4pazhnz4zKIybShipsdAD7KAd6caTYNkuFyrvyPTzy
        YLb+D9XBE3LZ+0ntxa+G/dBsFRp8PEeBpRaZybisuHCQiftnnLbNnD/PVYEeAYNqZNdcOzOJlQbfh
        x3pt4hFQ==;
Received: from [2001:4bb8:180:a30:2deb:705a:5588:bf7d] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLOZe-002FRQ-V2; Wed, 01 Sep 2021 11:38:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-raid@vger.kernel.org
Subject: fix a lock order reversal in md_alloc
Date:   Wed,  1 Sep 2021 13:38:28 +0200
Message-Id: <20210901113833.1334886-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Song,

the first patch in this series fixed the reported lock order reversal
in md_alloc.  The rest sort out the error handling in that function,
starting with the patch from Luis to handle add_disk errors, which
would otherwise conflict with the first patch.

Note that I have had a hard time verifying this all works fine as the
testsuite in mdadm already keeps failing a lot for me with the baseline
kernel. Some of thos reproducibly and others randomly.  Is there a
good document somehow describing what to expect from the mdadm test
suite?

Diffstat:
 drivers/md/md.c |   56 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 27 deletions(-)
