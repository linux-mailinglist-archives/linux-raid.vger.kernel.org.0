Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA24EEDA1A
	for <lists+linux-raid@lfdr.de>; Mon,  4 Nov 2019 08:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfKDHri (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 Nov 2019 02:47:38 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:10889 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbfKDHri (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 4 Nov 2019 02:47:38 -0500
Received: from [86.155.171.62] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iRX5M-0001Fx-Af; Mon, 04 Nov 2019 07:47:36 +0000
Subject: Re: [PATCH 1/2] Create: add support for RAID0 layouts.
To:     NeilBrown <neilb@suse.de>, Jes Sorensen <jes.sorensen@gmail.com>
References: <157283799101.17723.14738560497847478383.stgit@noble.brown>
 <157247951643.8013.12020039865359474811.stgit@noble.brown>
 <157283806994.17723.2465574926328635872.stgit@noble.brown>
Cc:     linux-raid@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Song Liu <liu.song.a23@gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5DBFD797.3010605@youngman.org.uk>
Date:   Mon, 4 Nov 2019 07:47:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <157283806994.17723.2465574926328635872.stgit@noble.brown>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 04/11/19 03:27, NeilBrown wrote:
> Since Linux 5.4 a layout is needed for RAID0 arrays with
> varying device sizes.
> This patch makes the layout of an array visible (via --examine)
> and sets the layout on newly created arrays.
> --layout=dangerous
> can be used to avoid setting a layout so that they array

s/they/the/

> can be used on older kernels.

Cheers,
Wol
