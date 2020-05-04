Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094111C3FB7
	for <lists+linux-raid@lfdr.de>; Mon,  4 May 2020 18:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgEDQVp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 May 2020 12:21:45 -0400
Received: from vsmx011.vodafonemail.xion.oxcs.net ([153.92.174.89]:62318 "EHLO
        vsmx011.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729549AbgEDQVp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 4 May 2020 12:21:45 -0400
Received: from vsmx003.vodafonemail.xion.oxcs.net (unknown [192.168.75.197])
        by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id DEC8C59D1EA;
        Mon,  4 May 2020 16:21:43 +0000 (UTC)
Received: from lazy.lzy (unknown [79.214.216.232])
        by mta-7-out.mta.xion.oxcs.net (Postfix) with ESMTPA id A66A85399F8;
        Mon,  4 May 2020 16:21:39 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
        by lazy.lzy (8.15.2/8.14.5) with ESMTPS id 044GLcf0004850
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 May 2020 18:21:38 +0200
Received: (from red@localhost)
        by lazy.lzy (8.15.2/8.15.2/Submit) id 044GLcrW004849;
        Mon, 4 May 2020 18:21:38 +0200
Date:   Mon, 4 May 2020 18:21:38 +0200
From:   Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
To:     antlists <antlists@youngman.org.uk>
Cc:     Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: WD Red drives are now SMR drives?
Message-ID: <20200504162138.GA4791@lazy.lzy>
References: <b012e351-54cb-47c5-5fd7-fd2ee22322ed@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b012e351-54cb-47c5-5fd7-fd2ee22322ed@youngman.org.uk>
X-VADE-STATUS: LEGIT
X-VADE-SCORE: -100
X-VADE-REASON: gggruggvucftvghtrhhoucdtuddrgeduhedrjeeggdelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucevfgfuvffqoffgtfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujgesthdttddttddtvdenucfhrhhomheprfhivghrghhiohhrghhiohcuufgrrhhtohhruceophhivghrghhiohhrghhiohdrshgrrhhtohhrsehnvgigghhordguvgeqnecuggftrfgrthhtvghrnhephfdtvefhiefgvdfgveffudefudelgffhkedtkeetieefffevjeevtefggfevkedtnecuffhomhgrihhnpegvgihtrhgvmhgvthgvtghhrdgtohhmpdhsmhgrrhhtmhhonhhtohholhhsrdhorhhgnecukfhppeejledrvddugedrvdduiedrvdefvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghloheplhgriiihrdhliiihpdhinhgvthepjeelrddvudegrddvudeirddvfedvpdhmrghilhhfrhhomhepphhivghrghhiohhrghhiohdrshgrrhhtohhrsehnvgigghhordguvgdprhgtphhtthhopehlihhnuhigqdhrrghiugesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, May 04, 2020 at 12:38:04AM +0100, antlists wrote:
> Has anyone else picked up on this? Apparently 1TB and 8TB drives are still
> CMR, but new drives between 2 and 6 TB are now SMR drives.
> 
> https://www.extremetech.com/computing/309730-western-digital-comes-clean-shares-which-hard-drives-use-smr
> 
> What impact will this have on using them in raid arrays?

https://www.smartmontools.org/ticket/1313

And the ticket number says it all...

bye,

-- 

piergiorgio
