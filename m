Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A10663E93
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jul 2019 02:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfGJAUw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 9 Jul 2019 20:20:52 -0400
Received: from mail.thelounge.net ([91.118.73.15]:56347 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGJAUw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 9 Jul 2019 20:20:52 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 45k0G90ytLzXMk;
        Wed, 10 Jul 2019 02:20:49 +0200 (CEST)
Subject: Re: Raid 1 vs Raid 5 suggestion
To:     Adam Goryachev <mailinglists@websitemanagers.com.au>,
        Luca Lazzarin <luca.lazzarin@gmail.com>,
        Wols Lists <antlists@youngman.org.uk>,
        linux-raid@vger.kernel.org
References: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
 <5D25196A.9020606@youngman.org.uk>
 <9a71fbbd-8a41-5d59-dd89-5e98bb22a11a@gmail.com>
 <8033f679-84cc-78f9-064d-dc0a191f5a31@websitemanagers.com.au>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <006fbf98-ec73-818d-f9d1-fbe315dc0f60@thelounge.net>
Date:   Wed, 10 Jul 2019 02:20:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8033f679-84cc-78f9-064d-dc0a191f5a31@websitemanagers.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 10.07.19 um 01:22 schrieb Adam Goryachev
> I'm not sure why I disagree with you Wol... why is RAID10 so much better
> than a 3 disk RAID1?

because rebuilds are much faster and a RAID with 3 disks is a joke anyways
