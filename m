Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9F41C516A
	for <lists+linux-raid@lfdr.de>; Tue,  5 May 2020 10:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgEEI41 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 May 2020 04:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgEEI41 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 May 2020 04:56:27 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2303C061A0F
        for <linux-raid@vger.kernel.org>; Tue,  5 May 2020 01:56:26 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jVtNJ-0005Rr-9f; Tue, 05 May 2020 10:56:25 +0200
Subject: Re: RAID 1 | Test Booting from /dev/sdb
To:     Reindl Harald <h.reindl@thelounge.net>, linux-raid@vger.kernel.org
References: <221092f3-5b8a-5d95-01d9-261e6449f747@peter-speer.de>
 <3e8685c3-a0a6-4614-073a-afe7bb67d2eb@thelounge.net>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Message-ID: <d0cb3e79-2a30-6e4e-0784-f143c8c6d387@peter-speer.de>
Date:   Tue, 5 May 2020 10:56:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3e8685c3-a0a6-4614-073a-afe7bb67d2eb@thelounge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1588668986;4b60c92b;
X-HE-SMSGID: 1jVtNJ-0005Rr-9f
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 05.05.20 10:39, Reindl Harald wrote:
> you shouldn't remove disks and put them back without a good reason and
> verify booting is not a good one
> 
> just change the boot order, switch the cables or explicit select both
> disks in BIOS

Very helpfull again, will check if booting from both devices is working 
exactly like you suggested.

Thanks again, Harald.
