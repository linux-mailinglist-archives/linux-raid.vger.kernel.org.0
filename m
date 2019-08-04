Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68B5680C47
	for <lists+linux-raid@lfdr.de>; Sun,  4 Aug 2019 22:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfHDUDe (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 4 Aug 2019 16:03:34 -0400
Received: from mail.thelounge.net ([91.118.73.15]:46053 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfHDUDd (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 4 Aug 2019 16:03:33 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 461sKH0YB4zXPG;
        Sun,  4 Aug 2019 22:03:31 +0200 (CEST)
Subject: Re: Raid5 2 drive failure (and my spare failed too)
To:     Ryan Heath <gaauuool@gmail.com>, linux-raid@vger.kernel.org
References: <8006bdd5-55df-f5f6-9e2e-299a7fd1e64a@gmail.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <019fb3fb-38e3-4080-2198-d5049a9cb46e@thelounge.net>
Date:   Sun, 4 Aug 2019 22:03:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8006bdd5-55df-f5f6-9e2e-299a7fd1e64a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 04.08.19 um 20:49 schrieb Ryan Heath:
> I have a 6 drive raid5 with two failed drives (and unbeknownst to me my
> spare died awhile back). I noticed the first failed drive a short time
> ago and got a drive to replace it (and a new spare too) but before I
> could replace it a second drive failed. I was hoping to force the array
> back online since the recently failed drive appears to be only slightly
> out of sync but get:
> 
> mdadm: /dev/md127 assembled from 4 drives - not enough to start the array.
> 
> I put some important data on this array so I'm really hoping someone can
> provide guidance to force this array online, or otherwise get this array
> back to a state allowing me to rebuild.

there is not enough data for a rebuild on a RAID5

you now learned backups the hard way as well as watch your log in
context of "and unbeknownst to me my spare died awhile back"
