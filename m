Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C28E1C7934
	for <lists+linux-raid@lfdr.de>; Wed,  6 May 2020 20:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgEFSRD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Wed, 6 May 2020 14:17:03 -0400
Received: from p3plsmtpa06-09.prod.phx3.secureserver.net ([173.201.192.110]:34681
        "EHLO p3plsmtpa06-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729442AbgEFSRD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 6 May 2020 14:17:03 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 May 2020 14:17:03 EDT
Received: from localhost ([181.120.129.159])
        by :SMTPAUTH: with ESMTPA
        id WOUIjM6gkoXx7WOUJj0AMY; Wed, 06 May 2020 11:09:44 -0700
X-CMAE-Analysis: v=2.3 cv=Revu9Glv c=1 sm=1 tr=0
 a=sDQzn4cTYThu7dlYCIJj2A==:117 a=sDQzn4cTYThu7dlYCIJj2A==:17
 a=IkcTkHD0fZMA:10 a=nivXcWBVAAAA:8 a=jeNT614biOa5FUjvAswA:9 a=QEXdDO2ut3YA:10
 a=AYU4-JbLY8jJQ8sGdisn:22
X-SECURESERVER-ACCT: renaud@olgiati-in-paraguay.org
Date:   Wed, 6 May 2020 14:09:40 -0400
From:   "Renaud (Ron) OLGIATI" <renaud@olgiati-in-paraguay.org>
To:     linux-raid <linux-raid@vger.kernel.org>
Subject: Raid1 after new MB
Message-ID: <20200506140940.39670aed@olgiati-in-paraguay.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-mandriva-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-CMAE-Envelope: MS4wfDcDsUl20evoMValj0yOzOaRkYum8oPuDgriu1Q0bMda49ENHbRcp3dsYw0KYvS8Ikmbx5m8QDG9haj2x5Rm3nQ1GpSsr426uPj+o+kSf0xNA642O1XA
 6p9emN+6dmWfMZFZb3A8KVHBam85bQGPuDyBBLAylBIuw9W58dFSzB8M0ERI88hR1hDsCD4XXmGFqw==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


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

What should I do to restore the RAID volumes md1 to md6 ?
 
Cheers,
 
Ron.
-- 
                 Une illusion perdue est une vérité trouvée .
                                    
                   -- http://www.olgiati-in-paraguay.org --
 
