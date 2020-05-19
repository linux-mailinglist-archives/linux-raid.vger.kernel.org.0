Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C061DA01C
	for <lists+linux-raid@lfdr.de>; Tue, 19 May 2020 20:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgESS7M (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 19 May 2020 14:59:12 -0400
Received: from troy.meta-dynamic.com ([204.11.35.233]:60442 "EHLO
        mail.meta-dynamic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgESS7M (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 19 May 2020 14:59:12 -0400
Received: from minderbinder.meta-dynamic.com (mandelbrot [192.168.137.138])
        by mail.meta-dynamic.com (Postfix) with ESMTPS id 1E9CA53E96;
        Tue, 19 May 2020 14:59:12 -0400 (EDT)
Received: by minderbinder.meta-dynamic.com (Postfix, from userid 1000)
        id 616FC1980177; Tue, 19 May 2020 14:59:11 -0400 (EDT)
From:   dfavro@meta-dynamic.com
To:     jes@trained-monkey.org
Cc:     linux-raid@vger.kernel.org
Subject: [PATCH] mdadm: detect too-small device: error rather than underflow/crash
Date:   Tue, 19 May 2020 14:58:11 -0400
Message-Id: <20200519185812.979553-1-dfavro@meta-dynamic.com>
X-Mailer: git-send-email 2.26.2.593.gb9946226
In-Reply-To: <8c7c42f8-2040-859b-d558-0b523f7092d8@trained-monkey.org>
References: <8c7c42f8-2040-859b-d558-0b523f7092d8@trained-monkey.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Cheerfully re-sent using git-send-email as the MSA.

Just to clarify, before I sent the original email, I verified that
it applied cleanly as-is with "git am -c" (I then deliberately
mentioned the scissors line in the message so that you would know
to include the -c option to git-am).  I will of course in the
future use git-send-email as you prefer -- but there was never any
need to "manually take it apart to apply it".

Let me know what else about the patch needs improvement.

Thank you,
David

