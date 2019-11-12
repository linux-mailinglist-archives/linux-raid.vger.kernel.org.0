Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB0E3F9B43
	for <lists+linux-raid@lfdr.de>; Tue, 12 Nov 2019 21:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfKLUxD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 12 Nov 2019 15:53:03 -0500
Received: from sender11-op-o12.zoho.eu ([185.20.211.226]:17433 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfKLUxD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 12 Nov 2019 15:53:03 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573591075; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=SkVNjjpJH28cyOPRYR0krZ5rLCx7v65JEcnyW40LlmzulljS0wnwTzp68Seu2xfpEA7Zr1VB0bFQT4dWpEtEF1JQUrHQ0mqQNxq/AA7gNpn/Q9L0Fg4bhAFENchf1uDDnZOEOLQdiV+UcasbXxBEqCRkRpoAfub/4mL507Mr3NE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1573591075; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=sZ98lJYtIlceG6O8ZtdKhq+vfH3t3s8wab/PpqKQRl0=; 
        b=NHzDYc3ZaqLh+hyC+xCMSOaElI3wmQSc0afo9UJlv1Ke7X28DNJlUqxN5Sv98VzZCIP62WPYRp0f3GcPhQCFjRDDaRel/AMp1BXnWe2TBFd3vkEUSTQgy2h0QOP53yk2Znww7RBIxIo1///TVGfB0pijQQ+U5NRBDu7K0qViF4U=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=trained-monkey.org;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [172.30.223.21] (163.114.130.128 [163.114.130.128]) by mx.zohomail.com
        with SMTPS id 1573591075268303.06922400885867; Tue, 12 Nov 2019 21:37:55 +0100 (CET)
Subject: Re: [PATCH 0/3] mdadm: fixes for mdcheck
To:     NeilBrown <neilb@suse.de>
Cc:     linux-raid@vger.kernel.org
References: <157239190470.30065.4500556456316521334.stgit@noble.brown>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <a87eb788-feac-d706-d8ff-3808677b9ae4@trained-monkey.org>
Date:   Tue, 12 Nov 2019 15:37:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157239190470.30065.4500556456316521334.stgit@noble.brown>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/29/19 7:32 PM, NeilBrown wrote:
> A few problems with mdcheck systemd units, and one with the
> SUSE-specific script for generating an system environment.
> 
> Thanks,
> NeilBrown

Applied!

Thanks,
Jes


