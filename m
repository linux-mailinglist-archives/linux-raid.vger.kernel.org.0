Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239DE1CC298
	for <lists+linux-raid@lfdr.de>; Sat,  9 May 2020 18:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgEIQ2a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Sat, 9 May 2020 12:28:30 -0400
Received: from p3plsmtpa12-05.prod.phx3.secureserver.net ([68.178.252.234]:57747
        "EHLO p3plsmtpa12-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726214AbgEIQ2a (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 9 May 2020 12:28:30 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 May 2020 12:28:30 EDT
Received: from localhost ([181.120.129.159])
        by :SMTPAUTH: with ESMTPA
        id XSDujLlVvlNbJXSDvjlaz4; Sat, 09 May 2020 09:21:12 -0700
X-CMAE-Analysis: v=2.3 cv=brYy+3Si c=1 sm=1 tr=0
 a=sDQzn4cTYThu7dlYCIJj2A==:117 a=sDQzn4cTYThu7dlYCIJj2A==:17
 a=IkcTkHD0fZMA:10 a=nivXcWBVAAAA:8 a=jeNT614biOa5FUjvAswA:9 a=QEXdDO2ut3YA:10
 a=AYU4-JbLY8jJQ8sGdisn:22
X-SECURESERVER-ACCT: renaud@olgiati-in-paraguay.org
Date:   Sat, 9 May 2020 12:21:09 -0400
From:   "Renaud (Ron) OLGIATI" <renaud@olgiati-in-paraguay.org>
To:     linux-raid <linux-raid@vger.kernel.org>
Subject: Raid1 not assembling correctly after after new MB
Message-ID: <20200509122109.5f68288b@olgiati-in-paraguay.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-mandriva-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-CMAE-Envelope: MS4wfN8RyI6u830bNWlLs185vdF9xUf+XdDITDGd7a2zjCyVFa965gmeqVC1DS5Te19VpvGfuOoM22kwWDKkqvTFZiElt8ASa1t9a6z+RUkhnyxBD1K+JdT1
 PFhTLbkOTXTbJskVnnvxkwzFIInHsud0f+Zg/4SXOJ2FusxrGMrIoq85kf5KHl6Q4admNzko1QE5jw==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Another try, as I am not sure it went anywhere on the first attempt.


I have just booted my box after putting in a new MBn old one died peacefully during the night.

My HDs were configured at the BIOS level as hardware RAID1, and in the PCLinuxOS system with mdadm.

I only learned later (on this list) that it was not necessary to configur HW RAID1 at the BIOS level.

Booting the box, and without configuring the RAID1 at the BIOS level, the box booted normally, but only the priùmary partitions of the two HD pairs work properly:

~ $ cat /proc/mdstat 
Personalities : [raid1] 
md7 : active raid1 sdc1[0] sdd1[1]
      1953382464 blocks super 1.2 [2/2] [UU]
      bitmap: 1/15 pages [4KB], 65536KB chunk

md6 : active raid1 sda10[0]
      248640 blocks super 1.2 [2/1] [U_]
      
md5 : active raid1 sda9[0]
      446840832 blocks super 1.2 [2/1] [U_]
      bitmap: 4/4 pages [16KB], 65536KB chunk

md4 : active raid1 sda8[0]
      15616000 blocks super 1.2 [2/1] [U_]
      
md3 : active raid1 sda7[0]
      12686336 blocks super 1.2 [2/1] [U_]
      
md2 : active raid1 sda6[0]
      242496 blocks super 1.2 [2/1] [U_]
      
md1 : active raid1 sda5[0]
      8198144 blocks super 1.2 [2/1] [U_]
      
md0 : active raid1 sda1[0] sdb1[1]
      4389888 blocks super 1.2 [2/2] [UU]
      
unused devices: <none>

So I went to the BIOS, to activate the hardware RAID1, get a warning that all data will be lost; so did not do it., 

What should I do to restore the RAID volumes md1 to md6 ? Where to look for guidance ?
 
Cheers,
 
Ron.
-- 
                 Une illusion perdue est une vérité trouvée .
                                    
                   -- http://www.olgiati-in-paraguay.org --
 
