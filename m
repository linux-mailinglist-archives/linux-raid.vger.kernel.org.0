Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE57DFEC4
	for <lists+linux-raid@lfdr.de>; Tue, 22 Oct 2019 09:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbfJVH4O (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 22 Oct 2019 03:56:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:42673 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbfJVH4O (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 22 Oct 2019 03:56:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 00:56:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="222727121"
Received: from apaszkie-desk.igk.intel.com (HELO [10.102.102.225]) ([10.102.102.225])
  by fmsmga004.fm.intel.com with ESMTP; 22 Oct 2019 00:56:13 -0700
Subject: Re: How to assemble Intel RST Matrix volumes?
To:     hhardly@secmail.pro, linux-raid@vger.kernel.org
References: <0a32d9235127ec7760334c3308ee6384.squirrel@giyzk7o6dcunb2ry.onion>
From:   Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Message-ID: <aff61b6a-15e1-555a-e507-f8dcfcfd3135@intel.com>
Date:   Tue, 22 Oct 2019 09:56:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <0a32d9235127ec7760334c3308ee6384.squirrel@giyzk7o6dcunb2ry.onion>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/20/19 10:44 PM, hhardly@secmail.pro wrote:
> With only the parent container assembled I have this:
> 
> # cat /proc/mdstat
> Personalities :
> md0 : inactive sdc[0](S)
>       5201 blocks super external:imsm
> 
> Is "inactive" a problem? Adding --run to the --assemble makes no
> difference. Is the small block count only for the superblocks?
> 
> How can I assemble and access those Intel Matrix volumes?

The "inactive" state is normal for containers. Try doing this now:

# IMSM_NO_PLATFORM=1 mdadm --incremental /dev/md0 --run

It should assemble both volumes as degraded. If that doesn't work, please send
the output from "mdadm -E /dev/sdc".

Regards,
Artur

