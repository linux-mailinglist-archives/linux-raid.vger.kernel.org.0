Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7031AAEEC
	for <lists+linux-raid@lfdr.de>; Fri,  6 Sep 2019 01:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfIEXEO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 5 Sep 2019 19:04:14 -0400
Received: from mail.thelounge.net ([91.118.73.15]:47259 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfIEXEO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 5 Sep 2019 19:04:14 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 46Pbpz1lGfzXYc;
        Fri,  6 Sep 2019 01:04:11 +0200 (CEST)
Subject: Re: raid6 with dm-integrity should not cause device to fail
To:     Chris Murphy <lists@colorremedies.com>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <9dd94796-4398-55c5-b4b6-4adfa2b88901@redhat.com>
 <fc3391a1-2337-4f9a-1f09-8a0882000084@redhat.com>
 <7429a69e-0b27-53de-2ad8-01d8ebbc2bb4@redhat.com>
 <20190905160512.GA17672@cthulhu.home.robinhill.me.uk>
 <CAJCQCtTiJS437Dc9FOiYNKr-=MX7xHabX-G0O=2TbgqR5nz+uw@mail.gmail.com>
 <20190905190558.GA8212@cthulhu.home.robinhill.me.uk>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <a100d6e4-c949-d288-a71a-e77276b68b70@thelounge.net>
Date:   Fri, 6 Sep 2019 01:04:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905190558.GA8212@cthulhu.home.robinhill.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 05.09.19 um 21:05 schrieb Robin Hill:
> On Thu Sep 05, 2019 at 12:19:19PM -0600, Chris Murphy wrote:
>> I don't agree that a heavy hammer is needed in order to send a notification.
>>
> You think that most people using this will be monitoring for
> dm-intergity reported errors? If all the errors are just rewritten
> silently then it's likely the only sign of an issue will be a
> performance impact, with no obvious sign as to where it's coming from

what is the differene mdmonitor trigger an email *before* a disk or
array is completly "spit out" or only "hey, you have lost"

it's up to mdmonitor to do the right thing and people which don't look
and monitor at all are lost anyways - so what's your point?
