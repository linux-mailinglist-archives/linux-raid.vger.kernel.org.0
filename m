Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F0D3D493C
	for <lists+linux-raid@lfdr.de>; Sat, 24 Jul 2021 20:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhGXSI5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 24 Jul 2021 14:08:57 -0400
Received: from michael-notr.mail.tiscali.it ([213.205.33.216]:49332 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229530AbhGXSI5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 24 Jul 2021 14:08:57 -0400
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Jul 2021 14:08:56 EDT
Received: from chirone.localnet ([151.27.243.99])
        by michael.mail.tiscali.it with 
        id Z6h72500329PK4v016h7Hp; Sat, 24 Jul 2021 18:41:07 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: gianfrus@tiscali.it
From:   Gianluca Frustagli <gianfrus@tiscali.it>
To:     linux-raid@vger.kernel.org
Subject: SSD based sw RAID: is ERC/TLER really important?
Date:   Sat, 24 Jul 2021 20:41:06 +0200
Message-ID: <2232919.g0K5C1TF2C@chirone>
User-Agent: KMail/4.14.10 (Linux/3.16.7-53-desktop; KDE/4.14.9; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1627152067; bh=0QFps8p0WEmIAmrW0MEgyXHNPF7nI+Un88pTN/KN8WM=;
        h=From:To:Subject:Date;
        b=qy28VjssubuKYuODQMm7cPHEkLChQzXZHEElk4qd1DdO3iN+5DsizCLxz3vYA22t0
         4QokMo9o0uH9rC57laKrXqTMAssZWYBZKtvhItKZjpkuN2uPvHpvWcwJsj5KP3mfP1
         EvULXFMacHMeXj6XuL2U1DGh3vMlgSRmFdM898Dw=
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi, 

nowadays we all know that the ERC/TLER capability is very important for the 
use of spinning drives in RAID systems because, especially for recent hard 
disks, the recovery time in case of media errors could exceed kernel timeouts 
and possibly kick off the entire drive from the RAID set and, in turn, lead to 
a fault of a RAID5 system upon a subsequent error in a second drive. 

But in the case of SSD drives (where, possibly, the error recovery activities 
performed by the drive firmware are very fast) does the presence of the 
ERC/TLER capability really matter? Is the same scenario from the spinning 
drives case actually even probable or only theorical? 

Thank you for the considerations and evaluations you want to express. 

Gianluca 
