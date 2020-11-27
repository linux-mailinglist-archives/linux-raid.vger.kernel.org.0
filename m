Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CB82C6D86
	for <lists+linux-raid@lfdr.de>; Sat, 28 Nov 2020 00:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgK0XMB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 27 Nov 2020 18:12:01 -0500
Received: from mout01.posteo.de ([185.67.36.65]:37543 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729330AbgK0XKS (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 27 Nov 2020 18:10:18 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id C05A516005C
        for <linux-raid@vger.kernel.org>; Sat, 28 Nov 2020 00:10:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.jp; s=2017;
        t=1606518615; bh=Iyf6Xc8yMBELkpYBcxZObM7Lit1STYNqeSddGo09j+8=;
        h=Date:From:To:Subject:From;
        b=nnHswfxEw0lryCvnIJt2HRxTrQvsp+VXQFAV9EdnogW/EeF0xVZuhsCgZKDtKObIZ
         ez/W4lrlF9aEZh0HIsWdrpLfsZ8bIJXnyC89JVaH+o9YXL4wwlNhH8pAFx9I2nncHB
         8O2acGfM7LXCBGd8fIDQZmSyERsHrFjM/tKJ42wwbJiMn8Wz78e/zV7UXl5+dMNPc5
         krUQ6s0tJbVeQqk0G8KJ1DxL+l4YXHGJMPAtLz9ZwhCPK5G6uB2ijepLq/jqJkrc4A
         osEcE3jQJCJ0KvxwjuHdZm4xBhL06jw7fyTrRo+4N7Yf2Wbq9W60wdiNsTcffOHHmY
         SWHfE2IAa+c8A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CjVhl2CKKz6tmG
        for <linux-raid@vger.kernel.org>; Sat, 28 Nov 2020 00:10:15 +0100 (CET)
Date:   Sat, 28 Nov 2020 00:10:14 +0100
From:   <c.buhtz@posteo.jp>
To:     linux-raid@vger.kernel.org
Subject: Assemble RAID on new machine but with missing devices
Followup-To: linux-raid@vger.kernel.org
Reply-To: linux-raid@vger.kernel.org
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <4CjVhl4nSbz6tm9@submission01.posteo.de>
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,

I red some stuff about assembling mode for mdadm. But two points are
unclear for me.

1. Missing devices
I have two HDDs in a RAID1 - only data, no OS, on them. I want to
physical remove one HDD and plug it into a new server machine. Then I
want to bring the RAID1 online again on the new machine but with one
existing and one missing drive.
Background: When finished I will plug in a new fresh HDD as the second
one to the new server.

2. mdadm.conf
On the web I read sometimes about modifying mdadm.conf on the new
machine. But I do not understand why. If so. Why and what do I have to
modify in the mdadm.conf?

Kind
Christian
