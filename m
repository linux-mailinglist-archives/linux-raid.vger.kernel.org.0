Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173415F9F9F
	for <lists+linux-raid@lfdr.de>; Mon, 10 Oct 2022 15:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJJNuG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 10 Oct 2022 09:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJJNuF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 10 Oct 2022 09:50:05 -0400
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194C72183C
        for <linux-raid@vger.kernel.org>; Mon, 10 Oct 2022 06:50:04 -0700 (PDT)
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4MmKzV0XPpzXMx;
        Mon, 10 Oct 2022 15:49:58 +0200 (CEST)
Message-ID: <e2c8b04b-1f4b-6d65-101f-6cb83dff6be8@thelounge.net>
Date:   Mon, 10 Oct 2022 15:49:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
To:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Content-Language: en-US
From:   Reindl Harald <h.reindl@thelounge.net>
Subject: calculate "Array Size" for fdisk
Organization: the lounge interactive design
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

i  am at creating new RAID1 stoarges on twice sized disks to replace 
existing 4 drive RAID10

looking with fdisk and calculate twice din't end well and finally "dd" 
the FS in the array stopped with around 2 MB too small

is the "30716928" MiB or MB and what takes fdisk with "+30716928M"?

         Array Size : 30716928 (29.29 GiB 31.45 GB)
      Used Dev Size : 15358464 (14.65 GiB 15.73 GB)

did i say that i hate it that M isn't strictly 1024 when it comes to IT?
