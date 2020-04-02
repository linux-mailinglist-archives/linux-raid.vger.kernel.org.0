Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBBA19BDEF
	for <lists+linux-raid@lfdr.de>; Thu,  2 Apr 2020 10:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbgDBItK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Apr 2020 04:49:10 -0400
Received: from mail.thelounge.net ([91.118.73.15]:27301 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbgDBItJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 2 Apr 2020 04:49:09 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 48tGvR07MxzXLV;
        Thu,  2 Apr 2020 10:49:06 +0200 (CEST)
Subject: Re: RAID Issues - RAID10 working but with errors
To:     Adam Goryachev <mailinglists@websitemanagers.com.au>,
        linux-raid@vger.kernel.org
References: <d934f662-9fde-370b-bb4b-b92bd1730c96@websitemanagers.com.au>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <832cb2b3-e9d3-e1a6-4ba5-f1f1b5d22b97@thelounge.net>
Date:   Thu, 2 Apr 2020 10:49:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d934f662-9fde-370b-bb4b-b92bd1730c96@websitemanagers.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 02.04.20 um 04:28 schrieb Adam Goryachev:
> Is there a method to determine if this is a HDD error (ie, 2 drives that
> have errors) or a cabling issue (with just these two drives) or some
> strange driver/motherboard issue?

just try by start with the cheapest option: cables

when nothing changes switch where they disks are connected and you will
find out it's the motherboard when suddenly one drive that was completly
fine before has the same issue

> I notice in the output below MD is showing a number of bad blocks on the
> drives, and logs suggest that the drives have run out of "spare" space
> to re-allocate these to.
from the moment on some software stack is telling you about bad blocks
on drives run fast and replace fast
