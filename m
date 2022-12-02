Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A764641053
	for <lists+linux-raid@lfdr.de>; Fri,  2 Dec 2022 23:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiLBWHV (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 2 Dec 2022 17:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLBWHV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 2 Dec 2022 17:07:21 -0500
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46073F2C6B
        for <linux-raid@vger.kernel.org>; Fri,  2 Dec 2022 14:07:20 -0800 (PST)
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4NP6Vs0nHqzXLx;
        Fri,  2 Dec 2022 23:07:17 +0100 (CET)
Message-ID: <60258a01-d13a-e969-fc7a-11f05a8880b5@thelounge.net>
Date:   Fri, 2 Dec 2022 23:07:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Revisit Old Issue - Raid1 (harmless still?) mismatch_cnt = 128 on
 scrub?
Content-Language: en-US
To:     "David C. Rankin" <drankinatty@suddenlinkmail.com>,
        mdraid <linux-raid@vger.kernel.org>
References: <53c32c9a-c727-ca36-961d-4f3d3afd545f@suddenlinkmail.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
In-Reply-To: <53c32c9a-c727-ca36-961d-4f3d3afd545f@suddenlinkmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 02.12.22 um 22:49 schrieb David C. Rankin:
> All,
> 
>    I have a Raid1 array on boot that showed 0 mismatch count for a 
> couple of years, but lately shows:
> 
> mismatch_cnt = 128

sadly that's normal while i count it as a bug in mdadm

it depends more or less on random IO due raid-check and makes no sense 
at all (besides it's non-fixable anyways for a mirrored array because 
only god could know the truth)
