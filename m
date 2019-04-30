Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A21B410360
	for <lists+linux-raid@lfdr.de>; Wed,  1 May 2019 01:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfD3XjU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Apr 2019 19:39:20 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:44026 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfD3XjU (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 30 Apr 2019 19:39:20 -0400
Received: from [81.156.88.27] (helo=[192.168.1.82])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1hLcLG-00063p-3R; Wed, 01 May 2019 00:39:18 +0100
Subject: Re: RAID5 mdadm --grow wrote nothing (Reshape Status : 0% complete)
 and cannot assemble anymore
To:     Julien ROBIN <julien.robin28@free.fr>, linux-raid@vger.kernel.org
References: <a87383aa-3c49-0f62-6a93-9b9cb2fc60dd@free.fr>
 <96216021-6834-66ae-135d-ed654d64e5c0@free.fr>
 <cf3a34eb-2151-0903-116b-8c6fe1a63f52@free.fr>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5CC8DCA5.8000903@youngman.org.uk>
Date:   Wed, 1 May 2019 00:39:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <cf3a34eb-2151-0903-116b-8c6fe1a63f52@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 30/04/19 09:25, Julien ROBIN wrote:
> I'm about to play the following command :
> 
> mdadm --create /dev/md0 --level=5 --raid-devices=3 /dev/sdd1 /dev/sde1
> /dev/sdb1 --assume-clean
> 
> Is it fine ?

You clearly haven't read the raid wiki
https://raid.wiki.kernel.org/index.php/Linux_Raid

It states NEVER EVER use mdadm --create on an existing array unless you
(or the person helping you) really knows what they are doing.

Another thing it says is always update to the latest mdadm. I don't
remember you telling us what version you're using, and the problem you
describe sounds very much like something I suspect has been fixed in the
latest versions.

Not that it matters too much now, you've got your array back, but I
would make sure you have the latest mdadm, and read the wiki so you'll
know a bit more for next time.

Cheers,
Wol
