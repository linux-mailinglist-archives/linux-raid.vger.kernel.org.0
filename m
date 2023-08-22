Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D263B784955
	for <lists+linux-raid@lfdr.de>; Tue, 22 Aug 2023 20:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjHVSSE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 22 Aug 2023 14:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjHVSSE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 22 Aug 2023 14:18:04 -0400
X-Greylist: delayed 434 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 11:18:01 PDT
Received: from len.romanrm.net (len.romanrm.net [IPv6:2001:41d0:1:8b3b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37089128
        for <linux-raid@vger.kernel.org>; Tue, 22 Aug 2023 11:18:00 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by len.romanrm.net (Postfix) with SMTP id D2DD940118
        for <linux-raid@vger.kernel.org>; Tue, 22 Aug 2023 18:10:44 +0000 (UTC)
Date:   Tue, 22 Aug 2023 23:10:44 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Linux RAID <linux-raid@vger.kernel.org>
Subject: Modern best-practices for NVMe RAID0 stripe size?
Message-ID: <20230822231044.18b729aa@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,

Most articles I can find are like 2015 era and discuss whether 8K or 16K would
be better, or at most up to 128K. It feels like with the performance of modern
drives, larger stripe sizes should be preferred, such as 1M or 4M.

Does anyone have any up-to-date comparisons or advice about this?

Thanks

-- 
With respect,
Roman
