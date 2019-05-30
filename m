Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2CF42FFD6
	for <lists+linux-raid@lfdr.de>; Thu, 30 May 2019 18:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfE3QBb (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 May 2019 12:01:31 -0400
Received: from mail.thelounge.net ([91.118.73.15]:27009 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfE3QBb (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 30 May 2019 12:01:31 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 45FC4T33HwzXQV;
        Thu, 30 May 2019 18:01:29 +0200 (CEST)
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
To:     keld@keldix.com
Cc:     linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <20190530100420.GA7106@www5.open-std.org>
 <bd4ac362-6d91-df02-d7df-84de54dd90bf@thelounge.net>
 <20190530155834.GA21315@www5.open-std.org>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <0f5dcfb4-bb86-6f46-cf19-9d5b97608fac@thelounge.net>
Date:   Thu, 30 May 2019 18:01:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530155834.GA21315@www5.open-std.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 30.05.19 um 17:58 schrieb keld@keldix.com:
> so you will not get performance gains if you read one file sequentially in raid10,near
> nor md raid1, reading 2 different files concurrently theoretcally should give the same
> speed in md raid1 an mdraid10,near - but I think raid10,near only reads from one device.
> so it is a driver issue.

but why?

you have two simple mirrors, read from both disks, one half from mirror1
and the second from mirror2
