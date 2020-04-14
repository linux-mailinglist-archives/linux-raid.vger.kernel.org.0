Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3021A854E
	for <lists+linux-raid@lfdr.de>; Tue, 14 Apr 2020 18:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405304AbgDNQlG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Apr 2020 12:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405227AbgDNQlE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 14 Apr 2020 12:41:04 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDABC061A0C
        for <linux-raid@vger.kernel.org>; Tue, 14 Apr 2020 09:41:04 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jOOcQ-0001Q3-27; Tue, 14 Apr 2020 18:41:02 +0200
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
To:     Reindl Harald <h.reindl@thelounge.net>, G <garboge@shaw.ca>,
        linux-raid@vger.kernel.org
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
 <f9f2f479-2899-6774-eb20-bf81ed24bc7b@shaw.ca>
 <f857fc03-d18b-a489-54c9-49c22ad19c39@thelounge.net>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Message-ID: <bfb8fd04-0f6e-62af-44f8-c9336ef0dd66@peter-speer.de>
Date:   Tue, 14 Apr 2020 18:41:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f857fc03-d18b-a489-54c9-49c22ad19c39@thelounge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1586882464;93a14b30;
X-HE-SMSGID: 1jOOcQ-0001Q3-27
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 14.04.20 18:20, Reindl Harald wrote:
> RAID machines are supposed to
> live many many years and you just move the disks to your next machine
> and boot as yesterday

This is exactly the idea behind that setup. My OS will be Arch Linux 
which is a rolling distribution. I have some years of very good 
experience with it on my development machine and I love to have the 
newest and supported software/kernel/libs it is providing.

For these very rare cases in which the system update will somehow hurt 
something I need the LVM snapshots to get me running again pretty soon 
if needed. I bought double hardware like motherboard/processor and will 
change disks at latest after 5 years. The system is supposed to run for 
10+ years and will host some virtual machines based on KVM (one of them 
is from 2006 :-) running ubuntu LTS, totally outdated but always there, 
when needed, guess the next 10 years, LOL).
