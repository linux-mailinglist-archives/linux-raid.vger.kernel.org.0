Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B2B1EC0F8
	for <lists+linux-raid@lfdr.de>; Tue,  2 Jun 2020 19:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgFBRc4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 2 Jun 2020 13:32:56 -0400
Received: from li1843-175.members.linode.com ([172.104.24.175]:38936 "EHLO
        mail.stoffel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgFBRc4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 2 Jun 2020 13:32:56 -0400
Received: from quad.stoffel.org (066-189-075-104.res.spectrum.com [66.189.75.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 2D9DA1E141;
        Tue,  2 Jun 2020 13:32:55 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 73B41A6456; Tue,  2 Jun 2020 13:32:54 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24278.36166.418871.60864@quad.stoffel.home>
Date:   Tue, 2 Jun 2020 13:32:54 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc:     Song Liu <song@kernel.org>, linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH] md: improve io stats accounting
In-Reply-To: <26d5f5c7-9a20-e7f9-617f-0353c5d9bb2e@intel.com>
References: <20200601161256.27718-1-artur.paszkiewicz@intel.com>
        <CAPhsuW4fjc4NgFGQUPuAKSvtWvtzyPor876anj64NF=nqaPo5g@mail.gmail.com>
        <26d5f5c7-9a20-e7f9-617f-0353c5d9bb2e@intel.com>
X-Mailer: VM 8.2.0b under 26.1 (x86_64-pc-linux-gnu)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>>>>> "Artur" == Artur Paszkiewicz <artur.paszkiewicz@intel.com> writes:

Artur> On 6/2/20 8:48 AM, Song Liu wrote:
>>> +               clone = bio_clone_fast(bio, GFP_NOIO, &mddev->md_io_bs);
>> 
>> Handle clone == NULL?

Artur> I think this should never fail - bio_alloc_bioset() guarantees that. It
Artur> is used in a similar manner in raid1 and raid10. How about
Artur> BUG_ON(clone == NULL)?

No, use WARN_ON() instead, why would you bug the entire system for
just one logical device throwing an error?  

