Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92DAD8D243
	for <lists+linux-raid@lfdr.de>; Wed, 14 Aug 2019 13:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfHNLe7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 14 Aug 2019 07:34:59 -0400
Received: from p3plsmtpa09-01.prod.phx3.secureserver.net ([173.201.193.230]:47402
        "EHLO p3plsmtpa09-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727717AbfHNLe7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 14 Aug 2019 07:34:59 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Aug 2019 07:34:59 EDT
Received: from localhost ([181.120.156.54])
        by :SMTPAUTH: with ESMTPA
        id xrRKhNubVAxyHxrRLhz32h; Wed, 14 Aug 2019 04:27:40 -0700
Date:   Wed, 14 Aug 2019 07:27:36 -0400
From:   "Renaud (Ron) OLGIATI" <renaud@olgiati-in-paraguay.org>
To:     Linux Raid <linux-raid@vger.kernel.org>
Subject: An annoyance resolved
Message-ID: <20190814072736.53bb5ccc@olgiati-in-paraguay.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-mandriva-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAfbU/ZDHgVHmUYIj5D/QgvdVFqtEIELOAbTkyFpATaeLU12a+VLLWfBx/HFFjGpBznZEJLVhWxk9iIo/8jCPChQ2M4n0DF6KyTNfK73wej0sY2RwkBm
 aSma/UFZksAhDblZblsrLc9ggw9lz4rBsE9+7Qt88H3pbxnoEvvDrRe0fVRAZf7S+KTGWDu6w4mAWw==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


I was getting annoyed, every Sunday morning, having my hard disk activity at 100% while 99-raid-check in cron.weekly was run.

As I tend to go to bed early, I found the solution lay in modifying in /etc/eanacrontab the line 
START_HOURS_RANGE=6-22 
to 
START_HOURS_RANGE=1-22
and so make 99-raid-check run while I am asleep.

Shared in case others are also annoyed  ;-3)
 
Cheers,
 
Ron.
-- 
                   For a man to truly understand rejection,
                      he must first be ignored by a cat.
                                    
                   -- http://www.olgiati-in-paraguay.org --
 
