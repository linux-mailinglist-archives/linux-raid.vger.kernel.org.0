Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEF01B0584
	for <lists+linux-raid@lfdr.de>; Mon, 20 Apr 2020 11:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDTJXS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Apr 2020 05:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725896AbgDTJXS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 20 Apr 2020 05:23:18 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271D7C061A0C
        for <linux-raid@vger.kernel.org>; Mon, 20 Apr 2020 02:23:18 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jQSe3-0005SQ-8M; Mon, 20 Apr 2020 11:23:15 +0200
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
To:     Nix <nix@esperi.org.uk>, Wols Lists <antlists@youngman.org.uk>
Cc:     linux-raid@vger.kernel.org
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
 <5E95C698.1030307@youngman.org.uk>
 <13a3bc12-67f7-46d5-7e6a-c6880ace4b1c@peter-speer.de>
 <5E95F461.50209@youngman.org.uk> <87lfmtemqf.fsf@esperi.org.uk>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Message-ID: <6dd25ff4-7c99-4b6f-3a50-de4130013847@peter-speer.de>
Date:   Mon, 20 Apr 2020 11:23:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87lfmtemqf.fsf@esperi.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1587374598;1850aeb2;
X-HE-SMSGID: 1jQSe3-0005SQ-8M
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 18.04.20 01:06, Nix wrote:
> Frankly... I would make this stuff a lot simpler and just not make a
> swap partition at all. Instead, make a swapfile: RAID will just happen
> for you automatically, you can expand the thing (or shrink it!) with
> ease while the system is up, and it's exactly as fast as swap
> partitions: swapfiles have been as fast as raw partitions since the
> Linux 2.0 days.

This convinced me, I'll take this approach.
Thanks.
