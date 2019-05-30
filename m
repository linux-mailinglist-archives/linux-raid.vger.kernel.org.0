Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9518F2FDF9
	for <lists+linux-raid@lfdr.de>; Thu, 30 May 2019 16:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfE3Ohq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 May 2019 10:37:46 -0400
Received: from mail.thelounge.net ([91.118.73.15]:43017 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfE3Ohq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 30 May 2019 10:37:46 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 45F9Cq2nB8zXQV;
        Thu, 30 May 2019 16:37:43 +0200 (CEST)
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
To:     keld@keldix.com, linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <20190530100420.GA7106@www5.open-std.org>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <bd4ac362-6d91-df02-d7df-84de54dd90bf@thelounge.net>
Date:   Thu, 30 May 2019 16:37:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530100420.GA7106@www5.open-std.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 30.05.19 um 12:04 schrieb keld@keldix.com:
> you need to clarify which layout you use with md raid10.
> the layouts are near, far and offset, with very different performance characteristics.
> far and offset are designed to be faster than near, which I understand that you use.
> So why are you using the slowest md raid10 layout, and not mentioning this fact?

besides that when you install a distribution like Fedora "near" is
default for pure reads it shouldn't be slower than RAID1 at all, just
read from both mirrors of the stripe

"far" has the advantage that it shoukd be even faster than RAID1

