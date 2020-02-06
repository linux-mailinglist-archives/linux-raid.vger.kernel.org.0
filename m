Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50924154C3F
	for <lists+linux-raid@lfdr.de>; Thu,  6 Feb 2020 20:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgBFT2D (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 Feb 2020 14:28:03 -0500
Received: from mail.thelounge.net ([91.118.73.15]:54169 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgBFT2C (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 6 Feb 2020 14:28:02 -0500
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 48D7kS0cL1zXQQ;
        Thu,  6 Feb 2020 20:28:00 +0100 (CET)
Subject: Re: Recover RAID6 with 4 disks removed
To:     Nicolas KAROLAK <nicolas.karolak@ubicast.eu>
Cc:     linux-raid@vger.kernel.org
References: <CAO8Scz75h0mTqePyyeehnY+706R=eUgh7DOOKyCaWWJfADRUVg@mail.gmail.com>
 <dfac6758-1539-6b63-1883-03d704c67bc4@thelounge.net>
 <20200206160220.ewhf3xlehyrwajmt@laptop>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <a3f21c9e-afbd-6445-514c-2549f4f27d85@thelounge.net>
Date:   Thu, 6 Feb 2020 20:27:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206160220.ewhf3xlehyrwajmt@laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 06.02.20 um 17:02 schrieb Nicolas KAROLAK:
> On Thu, Feb 06, 2020 at 03:07:00PM +0100, Reindl Harald wrote:
>> didn't you realize that RAID6 has redundancy to survive *exactly two*
>> failing disks no matter how many disks the array has anmd the data and
>> redundancy informations are spread ove the disks?
> 
> Not at the moment, i tested on a VM before but with 6 disks and removing 2
> and then did it on the server without thinking/realizing than 4 is different
> than 2 and that it would obsviously f**k the RAID array... (>_<')

seriously?

but even without knowing what one is doing who sane in his mind removes
more than one disk at the same time from a working array with data?

restore your backups as you had the space to make dd-images i guess you
have made backups before such an operation

https://en.wikipedia.org/wiki/RAID

RAID 5 consists of block-level striping with distributed parity. Unlike
RAID 4, parity information is distributed among the drives, requiring
all drives but one to be present to operate

RAID 6 consists of block-level striping with double distributed parity.
Double parity provides fault tolerance up to two failed drives

