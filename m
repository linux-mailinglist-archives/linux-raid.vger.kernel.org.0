Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284101C03A1
	for <lists+linux-raid@lfdr.de>; Thu, 30 Apr 2020 19:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgD3RJw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 Apr 2020 13:09:52 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17147 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgD3RJw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 30 Apr 2020 13:09:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588266589; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=HeAqb0UM2vYLxatt8argkdk1AHUwoM4bNJewDn8vTGAAHXZBSB0RY89dmss+Va9ggzeWgZ8O1ZmiNwyOB+rTFoRxcabZMf4uxp+3yeRLgY3kzjEcbeAR5pGs9VJ0zIdv8SD1+euKpDM0lW7YJFjAfrl9BxyjfKXOYv9+TEdQ8qw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1588266589; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=6xsg9hbfjlQWjiyQvpGlcSWhWHoGju2cQDyLp191iSE=; 
        b=M80qCe+gKYhhvX4ZtMpsjS9Bqj5x+VGgmgUtGOjNYkOGZodS6tSyFPRZwg124OfWmJSYbctlNdEYBNVWAMQ9mO8Kt79VFs6vx3YU72w8loCL3tzlq7VnXYbUx+okKizcx1GrDPRLhrX276R933BufVhukoUZYTWQZxwUUPM8Gn8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=trained-monkey.org;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.124.22] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 1588266588112527.4421663168573; Thu, 30 Apr 2020 19:09:48 +0200 (CEST)
Subject: Re: [PATCH v2] Detail: adding sync status for cluster device
To:     Lidong Zhong <lidong.zhong@suse.com>, linux-raid@vger.kernel.org
Cc:     guoqing.jiang@cloud.ionos.com
References: <20200427161438.20296-1-lidong.zhong@suse.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <22b8afdb-1b90-70c0-d017-76bd86eb99bf@trained-monkey.org>
Date:   Thu, 30 Apr 2020 13:09:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427161438.20296-1-lidong.zhong@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/27/20 12:14 PM, Lidong Zhong wrote:
> On the node with /proc/mdstat is
> 
> Personalities : [raid1]
> md0 : active raid1 sdb[4] sdc[3] sdd[2]
>       1046528 blocks super 1.2 [3/2] [UU_]
>         recover=REMOTE
>       bitmap: 1/1 pages [4KB], 65536KB chunk
> 
> Let's change the 'State' of 'mdadm -Q -D' accordingly
> State : clean, degraded
> With this patch, it will be
> State : clean, degraded, recovering (REMOTE)
> 
> Signed-off-by: Lidong Zhong <lidong.zhong@suse.com>
> Acked-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

I already applied a version of this patch, what is new in the v2? Can
you send an incremental patch on top of the current git tree?

Thanks,
Jes

