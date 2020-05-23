Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2BA1DF734
	for <lists+linux-raid@lfdr.de>; Sat, 23 May 2020 14:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbgEWMZT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 23 May 2020 08:25:19 -0400
Received: from troy.meta-dynamic.com ([204.11.35.233]:38148 "EHLO
        mail.meta-dynamic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgEWMZT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 23 May 2020 08:25:19 -0400
Received: from minderbinder.meta-dynamic.com (mandelbrot [192.168.137.138])
        by mail.meta-dynamic.com (Postfix) with ESMTPS id 6BFA053E95;
        Sat, 23 May 2020 08:25:18 -0400 (EDT)
Received: by minderbinder.meta-dynamic.com (Postfix, from userid 1000)
        id D82091980272; Sat, 23 May 2020 08:25:17 -0400 (EDT)
From:   dfavro@meta-dynamic.com
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org
Subject: Revised: [PATCH] mdadm: detect too-small device: error rather than underflow/crash
Date:   Sat, 23 May 2020 08:24:58 -0400
Message-Id: <20200523122459.1151100-1-dfavro@meta-dynamic.com>
X-Mailer: git-send-email 2.26.2.593.gb9946226
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Forgive me, I didn't at first notice your additional comments on
the code.  I have now incorporated your comments on style; now I
think I got it right and respectfully resubmit the patch.

Please let me know if you have any additional feedback.

Thanks,
David

