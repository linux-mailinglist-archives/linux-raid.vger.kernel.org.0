Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFBC1C4FF0
	for <lists+linux-raid@lfdr.de>; Tue,  5 May 2020 10:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgEEILt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 May 2020 04:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725915AbgEEILt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 May 2020 04:11:49 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC26C061A0F
        for <linux-raid@vger.kernel.org>; Tue,  5 May 2020 01:11:49 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jVsg7-0002uV-FV; Tue, 05 May 2020 10:11:47 +0200
To:     linux-raid@vger.kernel.org
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Subject: RAID 1 | Test Booting from /dev/sdb
Message-ID: <221092f3-5b8a-5d95-01d9-261e6449f747@peter-speer.de>
Date:   Tue, 5 May 2020 10:11:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1588666309;525687b9;
X-HE-SMSGID: 1jVsg7-0002uV-FV
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi.
I want to test if grub is installed on both of the HDs which are part of 
my raid1 array. I wonder which would be the best solution to do so.

I think I will archive that when I shutdown the computer, make /dev/sda 
powerless and see if it is able to boot from /dev/sdb.

If it is not booting /dev/sdb will have no changes, I would shutdown, 
connect /dev/sda with power again, turn it on and do a "grub-install 
/dev/sdb". Depending on the state of the array (I guess it will need 
recovery) I would do a "mdadm /dev/md0 --add /dev/sdb1". After recovery 
I would try it again.

If it is booting from /dev/sdb this HD will have "more" data because of 
the one boot process than /dev/sda. I am not sure if it is a good idea 
to shutdown and just connect /dev/sda with power again, boot (assuming 
/dev/sda is the standard boot medium) because I do not know in which 
state the array will be. What to do in case I do not want to loose data 
from the last boot process with /dev/sdb? Change boot medium to /dev/sdb 
and do a "mdadm /dev/md0 --add /dev/sda1" to get it recovered again 
without loosing the "added" data (i.e. in /var/log) from booting? Also 
device identifiers could change I guess. Even if I am fine with loosing 
the "added" data from booting with /dev/sdb, will - when booting again 
from /dev/sda - /dev/sda be the master in the array again?

It is not clear to me if I understood correctly in which case which 
array member will be the master which will be the base for recovery. Is 
it always the HD one booted from?

Could you please help me with that?

Thanks,
Steffi
