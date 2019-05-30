Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBFE32F6FF
	for <lists+linux-raid@lfdr.de>; Thu, 30 May 2019 07:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfE3FBB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 May 2019 01:01:01 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:33323 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfE3DJ2 (ORCPT
        <rfc822;groupwise-linux-raid@vger.kernel.org:0:0>);
        Wed, 29 May 2019 23:09:28 -0400
Received: from linux-fcij.suse (prva10-snat226-2.provo.novell.com [137.65.226.36])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Wed, 29 May 2019 21:09:17 -0600
Subject: Re: [RFC PATCH V2] mdadm/md.4: add the descriptions for bitmap sysfs
 nodes
To:     Wols Lists <antlists@youngman.org.uk>, jes.sorensen@gmail.com
Cc:     linux-raid@vger.kernel.org, NeilBrown <neilb@suse.com>
References: <20190527040523.24032-1-gqjiang@suse.com>
 <5CEE6062.1090604@youngman.org.uk>
From:   Guoqing Jiang <gqjiang@suse.com>
Message-ID: <176983e7-b3f4-b650-0e6d-afdcb1491ad1@suse.com>
Date:   Thu, 30 May 2019 11:09:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <5CEE6062.1090604@youngman.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 5/29/19 6:35 PM, Wols Lists wrote:
> On 27/05/19 05:05, Guoqing Jiang wrote:
>> +This variable sets a limit on the number of concurrent background writes,
>> +the valid values are 0 to 256, 0 means that write-behind is not allowed,
>> +while any other number means it can happen.  If there are more write requests
>> +than the number, new writes will by synchronous.
> Is this a byte-wide or an integer field? 0 to 256 is an odd number -
> surely it should be 255 (0xff)?

Thanks for the checking.

Actually the range should from 0 to 16383,  since there is one checking 
inside kernel.

                             if (backlog > COUNTER_MAX)
                                         return -EINVAL;

#define COUNTER_BITS 16
#define RESYNC_MASK ((bitmap_counter_t) (1 << (COUNTER_BITS - 2)))
#define COUNTER_MAX ((bitmap_counter_t) RESYNC_MASK - 1)

And mdadm has similar code.

                                 s.write_behind = parse_num(optarg);
                                 if (s.write_behind < 0 ||
                                     s.write_behind > 16383) {
                                         pr_err("Invalid value for 
maximum outstanding write-behind writes: %s.\n\tMust be between 0 and 
16383.\n", optarg);
                                         exit(2);
                                 }

Thanks & Regards,
Guoqing
