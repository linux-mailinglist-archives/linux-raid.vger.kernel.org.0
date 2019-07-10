Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC9ED64B95
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jul 2019 19:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfGJRl7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 10 Jul 2019 13:41:59 -0400
Received: from mx009.vodafonemail.xion.oxcs.net ([153.92.174.39]:10336 "EHLO
        mx009.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727095AbfGJRl6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 10 Jul 2019 13:41:58 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jul 2019 13:41:58 EDT
Received: from vsmx002.vodafonemail.xion.oxcs.net (unknown [192.168.75.192])
        by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTP id 1C0B1D9B5FE;
        Wed, 10 Jul 2019 17:34:05 +0000 (UTC)
Received: from lazy.lzy (unknown [79.214.218.120])
        by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTPA id AA3B4199C59;
        Wed, 10 Jul 2019 17:33:56 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
        by lazy.lzy (8.15.2/8.14.5) with ESMTPS id x6AHXsxB005621
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Jul 2019 19:33:54 +0200
Received: (from red@localhost)
        by lazy.lzy (8.15.2/8.15.2/Submit) id x6AHXsY1005620;
        Wed, 10 Jul 2019 19:33:54 +0200
Date:   Wed, 10 Jul 2019 19:33:54 +0200
From:   Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
To:     Xiao Ni <xni@redhat.com>
Cc:     Wols Lists <antlists@youngman.org.uk>,
        Luca Lazzarin <luca.lazzarin@gmail.com>,
        linux-raid@vger.kernel.org
Subject: Re: Raid 1 vs Raid 5 suggestion
Message-ID: <20190710173354.GA5523@lazy.lzy>
References: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
 <5D25196A.9020606@youngman.org.uk>
 <da428a60-aa9a-1cd9-d766-237fd885d425@redhat.com>
 <5D25A4A4.2000609@youngman.org.uk>
 <6e20bc11-9afb-3183-102e-2305990d5c89@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e20bc11-9afb-3183-102e-2305990d5c89@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-VADE-STATUS: LEGIT
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jul 10, 2019 at 04:46:35PM +0800, Xiao Ni wrote:
[...]
> Yes. I learned about this from this article
> https://securitypitfalls.wordpress.com/2018/05/08/raid-doesnt-work/
> As this article pointed, raid6 has problem to support this. The patch which
> I sent recent should fix this problem.

Interesting article.

In any case, RAID-6 offers a way to find this
type of unreported errors, albeit pro-actively.

"raid6check" implementents the considerations
of H. Peter Anvin in the paper:

https://mirrors.edge.kernel.org/pub/linux/kernel/people/hpa/raid6.pdf

Silent errors can be detected, in which drive,
if one only is present (per stripe).

bye,

-- 

piergiorgio
