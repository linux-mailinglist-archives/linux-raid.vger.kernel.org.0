Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E199B3557
	for <lists+linux-raid@lfdr.de>; Mon, 16 Sep 2019 09:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfIPHMt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 16 Sep 2019 03:12:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:43287 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfIPHMt (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 16 Sep 2019 03:12:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 00:12:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,510,1559545200"; 
   d="scan'208";a="211063795"
Received: from apaszkie-desk.igk.intel.com (HELO [10.102.102.225]) ([10.102.102.225])
  by fmsmga004.fm.intel.com with ESMTP; 16 Sep 2019 00:12:46 -0700
Subject: Re: Linux RAID 1 Not Working
To:     "David F." <df7729@gmail.com>,
        "Tkaczyk, Mariusz" <mariusz.tkaczyk@intel.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
References: <CAGRSmLvhPOw+KO7yAenXqyLDq__=vSLHMHQJ5f_0iOJ5E5b=Mg@mail.gmail.com>
 <3100213.Shkhs8viAj@mtkaczyk-devel.igk.intel.com>
 <CAGRSmLt6xsNXsXV0YoHihe2g8N5+w0jN2p7gmGSokrY8owsQ7Q@mail.gmail.com>
From:   Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Message-ID: <1d098e10-a2f9-12e4-5b8c-1312f6612eaa@intel.com>
Date:   Mon, 16 Sep 2019 09:12:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGRSmLt6xsNXsXV0YoHihe2g8N5+w0jN2p7gmGSokrY8owsQ7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9/16/19 1:30 AM, David F. wrote:
> Now I have a question, if mdadm is reading from UEFI, is it needing
> the efivarfs mounted?  because it's not mounted by defau

That's right, efivars is required.

Regards,
Artur
