Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8F92322CF
	for <lists+linux-raid@lfdr.de>; Sun,  2 Jun 2019 11:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfFBJbx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 2 Jun 2019 05:31:53 -0400
Received: from mail.thelounge.net ([91.118.73.15]:51885 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfFBJbx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 2 Jun 2019 05:31:53 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 45GtHV46v0zXQV;
        Sun,  2 Jun 2019 11:31:45 +0200 (CEST)
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
To:     Kai Stian Olstad <raid+list@olstad.com>
Cc:     keld@keldix.com, linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <6b34f202-65c4-b6f9-0ae1-cbb517c2b8f2@suse.com>
 <20190601053925.GO4569@bitfolk.com> <20190601085024.GA7575@www5.open-std.org>
 <2d01a882-0902-b7b6-a359-80e04a919aaa@thelounge.net>
 <20190601154302.GA27756@www5.open-std.org>
 <67a47528-541d-09ec-c9f9-560c382b6760@thelounge.net>
 <63d9d11f-0107-8705-016e-54bf2428e1cb@olstad.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <da2ad8b6-80f0-e74b-ef84-cbc1ecb23c79@thelounge.net>
Date:   Sun, 2 Jun 2019 11:31:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <63d9d11f-0107-8705-016e-54bf2428e1cb@olstad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 02.06.19 um 11:22 schrieb Kai Stian Olstad:
> On 01.06.2019 18:03, Reindl Harald wrote:
>>
>> problem is that you can't switch layouts and given that "near" is
>> default when you setup a distribution with RAID10 in the installer you
>> get that
> 
> Are you sure, in the mdadm man page it says the following about grow
> 
> Currently the supported changes include
> * change the chunk-size and layout of RAID0, RAID4, RAID5, RAID6 and RAID10.

pretty sure, there are limits and switch from near to far is one of them
as far as i remember

i investigated that back in 2016 when i realized that far exists at all
while prepare build the NFS sverer and looking what filesystem and raid
options are there for a RAID10+LUKS setup

in that case all was easier because the HP microserver boots from a
micro-sd on the board, so no pojnt to deal with RAID in the installer at all
