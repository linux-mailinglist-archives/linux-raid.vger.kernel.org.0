Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 736E814292
	for <lists+linux-raid@lfdr.de>; Sun,  5 May 2019 23:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfEEVmE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 5 May 2019 17:42:04 -0400
Received: from p3plsmtpa07-06.prod.phx3.secureserver.net ([173.201.192.235]:46189
        "EHLO p3plsmtpa07-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726905AbfEEVmE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 5 May 2019 17:42:04 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 May 2019 17:42:04 EDT
Received: from localhost ([181.120.156.54])
        by :SMTPAUTH: with ESMTPA
        id NOmQhoIxgCOngNOmTh3vVQ; Sun, 05 May 2019 14:34:46 -0700
Date:   Sun, 5 May 2019 17:34:39 -0400
From:   "Renaud (Ron) OLGIATI" <renaud@olgiati-in-paraguay.org>
To:     Linux Raid <linux-raid@vger.kernel.org>
Subject: Raid1 syncing every Sunday morning.
Message-ID: <20190505173439.1ba86d9d@olgiati-in-paraguay.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-mandriva-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLhbLgCAm+pc/AH5kCBm1dqvZc9eqw0K3nS2rXZzPpJdFE5Z3GQHdlLrHtIPjvGOS6VeQwSTnZPdRFjXzRCRmR5ovagXm7qU45G88rwJ5vQfr0I1na/V
 j6Oj8zyvIn0JaRrw+vhwgRBZ1sfiXkrZAkkd9k3sf3tGMD9pWoCZ5kcudmRAqfql956ZGTyx+MvaRg==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


It has come to my notice that for the last five Sundays, when I logged-in on my computer in the morning, I find rhe Raid1 arrays re-syncing. mornings, I

 I have checked (crontab -l) both the root and user crontabs, nothing there that is planned for Sundays.

Any idea ?

Cheers,
 
Ron.
-- 
                   Immortality -- a fate worse than death.
                                        -- Edgar A. Shoaff
                                    
                   -- http://www.olgiati-in-paraguay.org --
 
