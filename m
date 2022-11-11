Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4083625F27
	for <lists+linux-raid@lfdr.de>; Fri, 11 Nov 2022 17:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiKKQKD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 11 Nov 2022 11:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiKKQKB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 11 Nov 2022 11:10:01 -0500
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Nov 2022 08:09:59 PST
Received: from len.romanrm.net (len.romanrm.net [91.121.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB2E60E96
        for <linux-raid@vger.kernel.org>; Fri, 11 Nov 2022 08:09:59 -0800 (PST)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by len.romanrm.net (Postfix) with SMTP id 70C3440180;
        Fri, 11 Nov 2022 15:59:58 +0000 (UTC)
Date:   Fri, 11 Nov 2022 20:59:57 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Wilson Jonathan <i400sjon@gmail.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: Kernel crash, possibly raid, and dump but no log available as
 shutdown.
Message-ID: <20221111205957.19bb7a0e@nvm>
In-Reply-To: <64eabe28c77a488e3c36839b7614770f9be7d389.camel@gmail.com>
References: <64eabe28c77a488e3c36839b7614770f9be7d389.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, 11 Nov 2022 15:10:47 +0000
Wilson Jonathan <i400sjon@gmail.com> wrote:

> Is there anyway to get/print/transmit the log in real time to some
> external "thing" such as another pc on the network as by the time the
> crash happens the array (with the log files) must be down because there
> is nothing in the log files. No errors, shutdown messages, or shutdown
> log (is there even such a thing as a shutdown log?).

Yes: https://www.kernel.org/doc/Documentation/networking/netconsole.txt

-- 
With respect,
Roman
