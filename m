Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA7D1C3769
	for <lists+linux-raid@lfdr.de>; Mon,  4 May 2020 12:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgEDK7u (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 May 2020 06:59:50 -0400
Received: from mail.thelounge.net ([91.118.73.15]:59947 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgEDK7u (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 4 May 2020 06:59:50 -0400
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 49G0HR5NzBzXQ5;
        Mon,  4 May 2020 12:59:47 +0200 (CEST)
Subject: Re: RAID 1 | Restore based on Image of /dev/sda
To:     Stefanie Leisestreichler 
        <stefanie.leisestreichler@peter-speer.de>,
        linux-raid@vger.kernel.org
References: <5e29b897-b2df-c6b9-019a-e037101bfeec@peter-speer.de>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <838c9c29-4256-40e1-8c49-12eba590b749@thelounge.net>
Date:   Mon, 4 May 2020 12:59:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5e29b897-b2df-c6b9-019a-e037101bfeec@peter-speer.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 04.05.20 um 12:48 schrieb Stefanie Leisestreichler:
> Hi.
> I have a running RAID 1 based on /dev/sda1 and /dev/sda2 with
> metadata=1.2 with mdadm version 3.2.5.
> 
> I took an image of /dev/sda using dd.
> There is a computer with identical hardware (test-env) where I put in
> this image. When I start this computer, it is booting and recognizing
> the raid active as md0 with state [2/1] [U_] like expected.
> 
> My target is to restore the raid using another new and blank hard disk
> in the test-env computer. I know I have to format the new disk
> identically to the format the image is providing, but I am unsure about
> how to add the new disk to the raid array.
> 
> Could you please guide me?

mdadm /dev/mdX --add /dev/sdx{1,2}
