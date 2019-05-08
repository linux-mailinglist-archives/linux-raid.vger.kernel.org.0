Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274DB1824C
	for <lists+linux-raid@lfdr.de>; Thu,  9 May 2019 00:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfEHWfK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 May 2019 18:35:10 -0400
Received: from pide.tip.net.au ([203.10.76.2]:35865 "EHLO pide.tip.net.au"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfEHWfK (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 8 May 2019 18:35:10 -0400
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 May 2019 18:35:09 EDT
Received: from pide.tip.net.au (pide.tip.net.au [IPv6:2401:fc00:0:107::2])
        by mailhost.tip.net.au (Postfix) with ESMTP id 44zrfz1YfgzFvY8
        for <linux-raid@vger.kernel.org>; Thu,  9 May 2019 08:26:35 +1000 (AEST)
Received: from e7.eyal.emu.id.au (203-214-110-141.dyn.iinet.net.au [203.214.110.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pide.tip.net.au (Postfix) with ESMTPSA id 44zrfz10qDz980M
        for <linux-raid@vger.kernel.org>; Thu,  9 May 2019 08:26:35 +1000 (AEST)
Subject: Re: ID 5 Reallocated Sectors Count
To:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
References: <1471924184.12974949.1557351707986.JavaMail.zimbra@karlsbakk.net>
From:   Eyal Lebedinsky <eyal@eyal.emu.id.au>
Message-ID: <2aff655d-0495-1f7d-a305-adf23f9800bb@eyal.emu.id.au>
Date:   Thu, 9 May 2019 08:26:34 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1471924184.12974949.1557351707986.JavaMail.zimbra@karlsbakk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9/5/19 7:41 am, Roy Sigurd Karlsbakk wrote:
> Hi
> 
> I'm monitoring this box and it seems ID 5 Reallocated Sectors Count (from SMART) is climbing frantically on one disk. It's a r6 so it shouldn't be much of an issue once the disk eventually fails, but does anyone out there know how many reallocated sectors you can have on a drive? This is an older 1TB ST31000524NS

My rule, and what is often suggested in raid documents, is that once the number start to visibly climb (you say 'frantically') I replace the disk.

> Vennlig hilsen
> 
> roy

Regards,

-- 
Eyal at Home (eyal@eyal.emu.id.au)
