Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D895163DEB
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jul 2019 00:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfGIWjO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 9 Jul 2019 18:39:14 -0400
Received: from mail.thelounge.net ([91.118.73.15]:57385 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfGIWjO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 9 Jul 2019 18:39:14 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 45jy0t4HZ1zXMk;
        Wed, 10 Jul 2019 00:39:05 +0200 (CEST)
Subject: Re: Raid 1 vs Raid 5 suggestion
To:     Luca Lazzarin <luca.lazzarin@gmail.com>, linux-raid@vger.kernel.org
References: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <9c7c3ae9-96a3-5a5f-a1e6-461968d7ed82@thelounge.net>
Date:   Wed, 10 Jul 2019 00:39:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 10.07.19 um 00:17 schrieb Luca Lazzarin:
> Hi all,
> 
> actually a server of mine has a 2x1TB Raid 1 array.
> The disks are becoming old and to avoid possible problems I would like
> to replace them.
> 
> Moving from 1TB of space to 2TB could be enough, but since I have to buy
> the new disks I am considering different possibilities, which are:
> 1) 2x2TB Raid 1 array;
> 2) 3x2TB Raid 1 array;
> 3) 3x1TB Raid 5 array;
> 4) 3x2TB Raid 5 array (I know, this will give me 4TB of space, which
> probably are enough for the next 10 year);
> 5) 4x1TB Raid 6 array.
> 
> Which one, in your opinion, would the the best solution?
RAID6 - when you plan for many years you should avoid single redundancy,
it gives some peace of mind when you know when a rebuild is running that
you survive aonther crahsing disk

personally i would always use RAID 10 no matter if it's HDD or SSD for a
great balance of redundancy and performance, i don#t igve a shit about
the "wasted" space when i plan for years of use
