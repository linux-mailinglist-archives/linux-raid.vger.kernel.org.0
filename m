Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05CB2C7A25
	for <lists+linux-raid@lfdr.de>; Sun, 29 Nov 2020 18:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgK2RGU (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 29 Nov 2020 12:06:20 -0500
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:41596
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2RGU (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 29 Nov 2020 12:06:20 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <linux-raid@m.gmane-mx.org>)
        id 1kjQ8o-0005Bo-Ri
        for linux-raid@vger.kernel.org; Sun, 29 Nov 2020 18:05:38 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-raid@vger.kernel.org
From:   Doug Herr <gmane@wombatz.com>
Subject: Re: Assemble RAID on new machine but with missing devices
Date:   Sun, 29 Nov 2020 17:05:33 -0000 (UTC)
Message-ID: <rq0kcs$ln0$1@ciao.gmane.io>
References: <4CjVhl4nSbz6tm9@submission01.posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
User-Agent: Pan/0.146 (Hic habitat felicitas; 8107378
 git@gitlab.gnome.org:GNOME/pan.git)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sat, 28 Nov 2020 00:10:14 +0100, c.buhtz wrote:

> Then I want to bring the RAID1 online again on the new machine but with
> one existing and one missing drive.

As example, after creating and then stopping md8 I restarted it with only 
one of the members. Mdadm told me how to force it...

[root@wombat looptesting]# mdadm --assemble /dev/md8 /dev/loop1
mdadm: /dev/md8 assembled from 1 drive - need all 2 to start it (use --
run to insist).

[root@wombat looptesting]# mdadm --assemble /dev/md8 /dev/loop1 --run
mdadm: /dev/md8 has been started with 1 drive (out of 2).


-- 
Doug Herr 





-- 
Doug Herr 

