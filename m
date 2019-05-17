Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B24EA22075
	for <lists+linux-raid@lfdr.de>; Sat, 18 May 2019 00:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfEQWw7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 17 May 2019 18:52:59 -0400
Received: from mail.thelounge.net ([91.118.73.15]:41851 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfEQWw7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 17 May 2019 18:52:59 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 455NqC4p7SzXqy
        for <linux-raid@vger.kernel.org>; Sat, 18 May 2019 00:52:50 +0200 (CEST)
Subject: Re: Is --write-mostly supposed to do anything for SSD- and NVMe-class
 devices?
To:     linux-raid@vger.kernel.org
References: <20190517220436.GJ4569@bitfolk.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <b6add019-67a2-846c-dbe3-3db2f2a6e962@thelounge.net>
Date:   Sat, 18 May 2019 00:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517220436.GJ4569@bitfolk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 18.05.19 um 00:04 schrieb Andy Smith:
> I have a machine with one SATA SSD and one NVMe device. Of course
> even the SSD is pretty high performance and the NVMe is over 4 times
> faster than that, if we're talking about IOPS.
> 
> I've never used --write-mostly before but I thought maybe if I put
> them both in a RAID-10 but set the SSD device to --write-mostly then
> most reads would come from the NVMe and benefit from its increased
> performance.
sdaly RAID10 don't support --write-mostly, otherwise i won't have bought
4 expensive 2 TB SSD's in the last two years.....
