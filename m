Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD77116B16B
	for <lists+linux-raid@lfdr.de>; Mon, 24 Feb 2020 22:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgBXVEH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 24 Feb 2020 16:04:07 -0500
Received: from sender11-of-f72.zoho.eu ([31.186.226.244]:17809 "EHLO
        sender11-of-f72.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgBXVEH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 24 Feb 2020 16:04:07 -0500
Received: from [172.30.220.169] (163.114.130.128 [163.114.130.128]) by mx.zoho.eu
        with SMTPS id 1582578220731710.0907332082263; Mon, 24 Feb 2020 22:03:40 +0100 (CET)
Subject: Re: [PATCH v2 1/1] mdadm.8: add note information for raid0 growing
 operation
To:     Petr Vorel <pvorel@suse.cz>, linux-raid@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, NeilBrown <neilb@suse.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Wols Lists <antlists@youngman.org.uk>, Nix <nix@esperi.org.uk>
References: <20200224113409.11137-1-pvorel@suse.cz>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <0ad0fd3a-b8bc-a47f-de8a-b991248d2e0b@trained-monkey.org>
Date:   Mon, 24 Feb 2020 16:03:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224113409.11137-1-pvorel@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2/24/20 6:34 AM, Petr Vorel wrote:
> From: Coly Li <colyli@suse.de>
> 
> When growing a raid0 device, if the new component disk size is not
> big enough, the grow operation may fail due to lack of backup space.
> 
> The minimum backup space should be larger than:
>  LCM(old, new) * chunk-size * 2
> 
> where LCM() is the least common multiple of the old and new count of
> component disks, and "* 2" comes from the fact that mdadm refuses to
> use more than half of a spare device for backup space.
> 
> There are users reporting such failure when they grew a raid0 array
> with small component disk. Neil Brown points out this is not a bug
> and how the failure comes. This patch adds note information into
> mdadm(8) man page in the Notes part of GROW MODE section to explain
> the minimum size requirement of new component disk size or external
> backup size.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Jes Sorensen <jsorensen@fb.com>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Wols Lists <antlists@youngman.org.uk>
> Cc: Nix <nix@esperi.org.uk>
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
> Hi,
> 
> Coly haven't sent v2, but it's already prepared in openSUSE package [1],
> therefore sending it on his behalf.
> 
> Kind regards,
> Petr

Applied!

Thanks,
Jes

