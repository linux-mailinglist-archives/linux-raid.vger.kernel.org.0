Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB401C372A
	for <lists+linux-raid@lfdr.de>; Mon,  4 May 2020 12:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgEDKsn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 May 2020 06:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDKsn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 4 May 2020 06:48:43 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9FDC061A0E
        for <linux-raid@vger.kernel.org>; Mon,  4 May 2020 03:48:42 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jVYeM-0001JM-2W; Mon, 04 May 2020 12:48:39 +0200
To:     linux-raid@vger.kernel.org
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Subject: RAID 1 | Restore based on Image of /dev/sda
Message-ID: <5e29b897-b2df-c6b9-019a-e037101bfeec@peter-speer.de>
Date:   Mon, 4 May 2020 12:48:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1588589323;eb74f8e6;
X-HE-SMSGID: 1jVYeM-0001JM-2W
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi.
I have a running RAID 1 based on /dev/sda1 and /dev/sda2 with 
metadata=1.2 with mdadm version 3.2.5.

I took an image of /dev/sda using dd.
There is a computer with identical hardware (test-env) where I put in 
this image. When I start this computer, it is booting and recognizing 
the raid active as md0 with state [2/1] [U_] like expected.

My target is to restore the raid using another new and blank hard disk 
in the test-env computer. I know I have to format the new disk 
identically to the format the image is providing, but I am unsure about 
how to add the new disk to the raid array.

Could you please guide me?

Thanks,
Steffi
