Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D50443C5A5
	for <lists+linux-raid@lfdr.de>; Tue, 11 Jun 2019 10:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404641AbfFKIMA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Jun 2019 04:12:00 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:59417 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404589AbfFKIL7 (ORCPT
        <rfc822;groupwise-linux-raid@vger.kernel.org:0:0>);
        Tue, 11 Jun 2019 04:11:59 -0400
Received: from linux-fcij.suse (prva10-snat226-1.provo.novell.com [137.65.226.35])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Tue, 11 Jun 2019 02:11:56 -0600
Subject: Re: [PATCH] md/raid10: read balance chooses idlest disk for SSD
To:     keld@keldix.com, Guoqing Jiang <gqjiang@suse.com>
Cc:     linux-raid@vger.kernel.org
References: <20190611073311.14120-1-gqjiang@suse.com>
 <20190611074315.GA28052@www5.open-std.org>
From:   Guoqing Jiang <gqjiang@suse.com>
Message-ID: <1110737b-e037-9ef8-395e-83bd540e24b1@suse.com>
Date:   Tue, 11 Jun 2019 16:11:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190611074315.GA28052@www5.open-std.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

On 6/11/19 3:43 PM, keld@keldix.com wrote:
> thanks for this patch
>
> I think we should change the hd algorithm to chose the highest block number at least for the
> far layout. ther outer blocks have the fastest transfer rates and also the shortest
> distance for head movement.

I didn't investigate the performance of far layout a lot, seems there 
was one patch
(commit 8ed3a19563b6c " md: don't attempt read-balancing for raid10 
'far' layouts")
which was aimed to do it, and you were the author, no? ;-). Or I missed 
something.

Cheers,
Guoqing
