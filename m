Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189E82F9644
	for <lists+linux-raid@lfdr.de>; Mon, 18 Jan 2021 00:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbhAQXin (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 17 Jan 2021 18:38:43 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:17259 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729141AbhAQXim (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 17 Jan 2021 18:38:42 -0500
Received: from host86-157-192-59.range86-157.btcentralplus.com ([86.157.192.59] helo=[192.168.1.64])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1l1GvC-0003V0-5t; Sun, 17 Jan 2021 22:53:23 +0000
Subject: Re: What is the best way to combine 4 HDD's and 2 SSD's into a single
 filesystem?
To:     Cedric.dewijs@eclipso.eu, linux-raid@vger.kernel.org
References: <950d061954e1f779739c9c5777b94ade@mail.eclipso.de>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <6004C927.2070809@youngman.org.uk>
Date:   Sun, 17 Jan 2021 23:32:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <950d061954e1f779739c9c5777b94ade@mail.eclipso.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 17/01/21 20:35, Cedric.dewijs@eclipso.eu wrote:
> Is it feasible to add a checksum to mdadm, much like btrfs has, so it can tell what drive (if any) has returned the correct data?

put mdadm on top of dm-integrity

https://raid.wiki.kernel.org/index.php/Dm-integrity

Cheers,
Wol
