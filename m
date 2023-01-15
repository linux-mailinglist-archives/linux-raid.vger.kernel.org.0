Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD7566B0D4
	for <lists+linux-raid@lfdr.de>; Sun, 15 Jan 2023 13:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjAOMAW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 15 Jan 2023 07:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjAOMAV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 15 Jan 2023 07:00:21 -0500
X-Greylist: delayed 1686 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Jan 2023 04:00:19 PST
Received: from mallaury.nerim.net (smtp-100-sunday.noc.nerim.net [178.132.17.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B80D98
        for <linux-raid@vger.kernel.org>; Sun, 15 Jan 2023 04:00:18 -0800 (PST)
Received: from [192.168.0.252] (plouf.fr.eu.org [213.41.155.166])
        by mallaury.nerim.net (Postfix) with ESMTP id 3EB36DB17D
        for <linux-raid@vger.kernel.org>; Sun, 15 Jan 2023 13:00:18 +0100 (CET)
Message-ID: <f8531fc8-6928-5300-b43e-1cad0a4ab03b@plouf.fr.eu.org>
Date:   Sun, 15 Jan 2023 13:00:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     linux-raid <linux-raid@vger.kernel.org>
From:   Pascal Hambourg <pascal@plouf.fr.eu.org>
Subject: What does TRIM/discard in RAID do ?
Organization: Plouf !
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,

Linux RAID supports TRIM/discard, but what does it do exactly ?
Does it only pass-through TRIM/discard information to the underlying 
devices or can it also store information about which blocks contain 
valid data in the superblock metadata ?
