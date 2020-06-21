Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572EA202B8A
	for <lists+linux-raid@lfdr.de>; Sun, 21 Jun 2020 18:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgFUQXp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 21 Jun 2020 12:23:45 -0400
Received: from ciao.gmane.io ([159.69.161.202]:34138 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730414AbgFUQXp (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 21 Jun 2020 12:23:45 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <linux-raid@m.gmane-mx.org>)
        id 1jn2kx-000EGi-20
        for linux-raid@vger.kernel.org; Sun, 21 Jun 2020 18:23:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-raid@vger.kernel.org
From:   Ian Pilcher <arequipeno@gmail.com>
Subject: RAID types & chunks sizes for new NAS drives
Date:   Sun, 21 Jun 2020 11:23:35 -0500
Message-ID: <rco1i8$1l34$1@ciao.gmane.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
X-Mozilla-News-Host: news://news.gmane.org:119
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I'm replacing the drives in my 5-bay NAS, and planning how I'm going to
divide them up.  My general plan is to create a matching set of
partitions on the drives, and then create RAID devices across the sets
of partitions, for example:

   md1:  /dev/sdb1  /dev/sdc1  /dev/sdd1  /dev/sde1  /dev/sdf1
   md2:  /dev/sdb2  /dev/sdc2  /dev/sdd2  /dev/sde2  /dev/sdf2
    ⋮         ⋮          ⋮          ⋮          ⋮          ⋮
   md16: /dev/sdb16 /dev/sdc16 /dev/sdd16 /dev/sde16 /dev/sdf16

This will give me the flexibility to create RAID devices of different
types, as well as maybe(?) reducing the "blast radius" if a particular
portion of a disk goes bad.

I believe that it makes sense to use at least 2 different RAID levels -
RAID-10 for "general" use and RAID-6 for media content.  Does this make
sense?

If so, does anyone have any thoughts or pointers on the chunk size,
particularly for RAID-10?  (I assume that RAID-6 will have similar
considerations to RAID-5, and so a large chunk size would make sense,
particularly for large media files.)

Any other thoughts?

Thanks!

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================

