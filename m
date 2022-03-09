Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91BA4D271B
	for <lists+linux-raid@lfdr.de>; Wed,  9 Mar 2022 05:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiCIDDl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 8 Mar 2022 22:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiCIDDl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 8 Mar 2022 22:03:41 -0500
Received: from www18.qth.com (www18.qth.com [69.16.238.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4E61D0C1
        for <linux-raid@vger.kernel.org>; Tue,  8 Mar 2022 19:02:42 -0800 (PST)
Received: from [73.207.192.158] (port=42296 helo=justpickone.org)
        by www18.qth.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <davidtg-robot@justpickone.org>)
        id 1nRmb4-0001YY-0b
        for linux-raid@vger.kernel.org; Tue, 08 Mar 2022 21:02:41 -0600
Date:   Tue, 8 Mar 2022 22:02:40 -0500
From:   David T-G <davidtg-robot@justpickone.org>
To:     Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: backups and losses (was "Re: striping 2x500G to mirror 1x1T")
Message-ID: <20220309030239.GF4455@justpickone.org>
References: <20220305044704.GB4455@justpickone.org>
 <335f6238-9329-7616-051f-075706ac9022@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335f6238-9329-7616-051f-075706ac9022@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - www18.qth.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - justpickone.org
X-Get-Message-Sender-Via: www18.qth.com: authenticated_id: dmail@justpickone.org
X-Authenticated-Sender: www18.qth.com: dmail@justpickone.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Natanji, et al --

...and then Natanji said...
% 
% Hello David,
% what you propose here should work, but be aware that you are essentially
% first writing all data to the 2 smaller drives and then reading from them
% only when the mirror 1 TB disk gets added. If there are bad sectors that
% only gets dicovered while reading (not writing), you might lose data. A much
[snip]

Thanks for the input!

While I'd love to have the luxury of redundant backups and more devices,
that's out of the cards on this little server :-/  However, after I rsync
across all content I then use diff -r to check it, so I have to read each
byte on each side anyway.  That gives me at least a little more confidence!


Have a great day

:-D
-- 
David T-G
See http://justpickone.org/davidtg/email/
See http://justpickone.org/davidtg/tofu.txt

