Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77519255DE7
	for <lists+linux-raid@lfdr.de>; Fri, 28 Aug 2020 17:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgH1PbW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 28 Aug 2020 11:31:22 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:32899 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgH1PbV (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 28 Aug 2020 11:31:21 -0400
Received: from host86-157-102-164.range86-157.btcentralplus.com ([86.157.102.164] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1kBgLX-0008LN-DD; Fri, 28 Aug 2020 16:31:19 +0100
Subject: Re: Linux raid-like idea
To:     Brian Allen Vanderburg II <brianvanderburg2@aim.com>,
        linux-raid@vger.kernel.org
References: <1cf0d18c-2f63-6bca-9884-9544b0e7c54e.ref@aim.com>
 <1cf0d18c-2f63-6bca-9884-9544b0e7c54e@aim.com>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <e3cb1bbe-65eb-5b75-8e99-afba72156b6e@youngman.org.uk>
Date:   Fri, 28 Aug 2020 16:31:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1cf0d18c-2f63-6bca-9884-9544b0e7c54e@aim.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 24/08/2020 18:23, Brian Allen Vanderburg II wrote:
> Just an idea I wanted to put out there to see if there were any
> merit/interest in it.

I hate to say it, but your data/parity pair sounds exactly like a 
two-disk raid-1 mirror. Yes, parity != mirror, but in practice I think 
it's a distinction without a difference.

Cheers,
Wol
