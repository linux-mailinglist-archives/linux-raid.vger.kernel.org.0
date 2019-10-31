Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41C5DEAF28
	for <lists+linux-raid@lfdr.de>; Thu, 31 Oct 2019 12:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfJaLu0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 31 Oct 2019 07:50:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:16953 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfJaLu0 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 31 Oct 2019 07:50:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 04:50:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="225667177"
Received: from apaszkie-desk.igk.intel.com (HELO [10.102.102.225]) ([10.102.102.225])
  by fmsmga004.fm.intel.com with ESMTP; 31 Oct 2019 04:50:23 -0700
Subject: Re: [PATCH mdadm] super-intel: don't mark structs 'packed'
 unnecessarily
To:     NeilBrown <neilb@suse.de>, Jes Sorensen <jes.sorensen@gmail.com>
Cc:     linux-raid@vger.kernel.org,
        Mariusz Dabrowski <mariusz.dabrowski@intel.com>
References: <87k18leqf2.fsf@notabene.neil.brown.name>
 <1f57b1a1-70bd-15a4-4693-1b72aa5546f1@gmail.com>
 <87h83peh6h.fsf@notabene.neil.brown.name>
 <87eeyteej9.fsf@notabene.neil.brown.name>
From:   Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Message-ID: <7107c82a-762c-4049-307a-b0e4244cb15a@intel.com>
Date:   Thu, 31 Oct 2019 12:50:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <87eeyteej9.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/31/19 5:15 AM, NeilBrown wrote:
> 
> super-intel marks a number of structures 'packed', but this
> doesn't change the layout - they are already well organized.
> 
> This is a problem a gcc warns when code takes the address
> of a field in a packet struct - as super-intel sometimes does.
> 
> So remove the marking where isn't needed.
> Do ensure this does introduce a regression, add a compile-time
> assertion that the size of the structure is exactly the value
> it had before the 'packed' notation was removed.
> 
> Note that a couple of structure do need to be packed.
> As the address of fields is never taken, that is safe.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Good idea!

Acked-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>

