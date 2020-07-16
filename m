Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C3022242D
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jul 2020 15:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgGPNnk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jul 2020 09:43:40 -0400
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:43062
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPNnj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Jul 2020 09:43:39 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jul 2020 09:43:39 EDT
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <linux-raid@m.gmane-mx.org>)
        id 1jw45t-0004Tw-36
        for linux-raid@vger.kernel.org; Thu, 16 Jul 2020 15:38:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-raid@vger.kernel.org
From:   Ian Pilcher <arequipeno@gmail.com>
Subject: Programmatically check "global" RAID state?
Date:   Thu, 16 Jul 2020 08:38:32 -0500
Message-ID: <repl8o$ggb$1@ciao.gmane.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
X-Mozilla-News-Host: news://news.gmane.org:119
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I want to write a quick script/program for my NAS that will initiate a
check of one of my RAID devices every night.  However, I want it to skip
the check if either of the following is true:

* Another check/resync is in process on any RAID device, or

* Any of the RAID devices on the system are unhealthy (degraded or
   failed).

Is there any way to programmatically check the "global" status of the
RAID subsystem like this, or am I stuck iterating through all of the
devices (likely via sysfs) and checking them individually?  (I'm pretty
sure that I am "stuck" but wanted to check just in case.)

Thanks!

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================

