Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90CD31D770
	for <lists+linux-raid@lfdr.de>; Wed, 17 Feb 2021 11:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhBQKS6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 17 Feb 2021 05:18:58 -0500
Received: from rin.romanrm.net ([51.158.148.128]:54648 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232251AbhBQKSp (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 17 Feb 2021 05:18:45 -0500
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 2D982870;
        Wed, 17 Feb 2021 10:17:59 +0000 (UTC)
Date:   Wed, 17 Feb 2021 15:17:59 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     pg@mdraid.list.sabi.co.UK (Peter Grandi)
Cc:     list Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: use ssd as write-journal or lvm-cache?
Message-ID: <20210217151759.60abe249@natsu>
In-Reply-To: <24620.55192.588729.189939@cyme.ty.sabi.co.uk>
References: <CAC6SzHLHq9yX+dtcYwYyhfoTufFYohg_ZMmaSv6-HVt4e-m-hA@mail.gmail.com>
        <20210217110923.62fd685f@natsu>
        <24620.55192.588729.189939@cyme.ty.sabi.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, 17 Feb 2021 09:45:12 +0100
pg@mdraid.list.sabi.co.UK (Peter Grandi) wrote:

> The main point of "enterprise" flash SSD models is (as the
> original poster wrote) the ability to enable write-back (thus
> much, much higher committed write rates), if they have
> persistent buffering.

I read the OP as they meant enabling the write-back mode of LVM cache, where
loss of the SSD may lead to a data loss for the entire array, and justifying
that simply by the SSD being a reliable datacenter one. My objection was to
that, but perhaps indeed I understood that part wrong.

-- 
With respect,
Roman
