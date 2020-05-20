Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AE61DC020
	for <lists+linux-raid@lfdr.de>; Wed, 20 May 2020 22:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgETU3y (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 20 May 2020 16:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgETU3y (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 20 May 2020 16:29:54 -0400
Received: from forward102p.mail.yandex.net (forward102p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3344EC061A0E
        for <linux-raid@vger.kernel.org>; Wed, 20 May 2020 13:29:54 -0700 (PDT)
Received: from mxback6g.mail.yandex.net (mxback6g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:167])
        by forward102p.mail.yandex.net (Yandex) with ESMTP id 967041D401BB;
        Wed, 20 May 2020 23:29:48 +0300 (MSK)
Received: from iva3-dd2bb2ff2b5f.qloud-c.yandex.net (iva3-dd2bb2ff2b5f.qloud-c.yandex.net [2a02:6b8:c0c:7611:0:640:dd2b:b2ff])
        by mxback6g.mail.yandex.net (mxback/Yandex) with ESMTP id thVspmPseH-TmdCF5Gj;
        Wed, 20 May 2020 23:29:48 +0300
Received: by iva3-dd2bb2ff2b5f.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id zLG3j6KxsE-Tlre2VSh;
        Wed, 20 May 2020 23:29:47 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [general question] rare silent data corruption when writing data
To:     Chris Dunlop <chris@onthe.net.au>
Cc:     linux-raid@vger.kernel.org
References: <b0e91faf-3a14-3ac9-3c31-6989154791c1@yandex.pl>
 <20200513063127.GA2769@onthe.net.au>
From:   Michal Soltys <msoltyspl@yandex.pl>
Message-ID: <3e3dbd06-a425-59bd-5ce8-e66b5406eb80@yandex.pl>
Date:   Wed, 20 May 2020 22:29:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513063127.GA2769@onthe.net.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 20/05/13 08:31, Chris Dunlop wrote:
> Hi,
> 
> 
> "Me too!"
> 
> We are seeing 256-byte corruptions which are always the last 256b of a 
> 4K block. The 256b is very often a copy of a "last 256b of 4k block" 
> from earlier on the file. We sometimes see multiple corruptions in the 
> same file, with each of the corruptions being a copy of a different 256b 
> from earlier on the file. The original 256b and the copied 256b aren't 
> identifiably at a regular offset from each other. Where the 256b isn't a 
> copy from earlier in the file
> 
> I'd be really interested to hear if your problem is just in the last 
> 256b of the 4k block also!

 From what I have checked - in my case it has always been full 4k page.

I'll follow the suggestion by Sarah in the other part of this thread and 
enable pagealloc debug options and then put the machine/disks under load 
- so I'll keep an eye if something like you described happens.

This will have to wait a bit though, as I have another bug to hunt as 
well - as journaled raid refuses to assemble, so with help of Song I'm 
chasing that issue first.

If not for btrfs, we probably would have been using the machine happily 
until now (blaming occasional detected issues on userspace stuff, 
usually some fat java mess).

Thanks for detailed explanations of what happened in your case (and the 
span of kernel versions in which it does happen is scary). The hardware 
indeed looks strikingly similiar.
