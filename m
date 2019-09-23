Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7DFBBAE0
	for <lists+linux-raid@lfdr.de>; Mon, 23 Sep 2019 20:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440280AbfIWSDF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 23 Sep 2019 14:03:05 -0400
Received: from mailsrv.ugal.ro ([193.231.148.5]:16393 "EHLO MAIL.ugal.ro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393421AbfIWSDF (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 23 Sep 2019 14:03:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by MAIL.ugal.ro (Postfix) with ESMTP id 85AC413A2F58F;
        Mon, 23 Sep 2019 18:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at ugal.ro
Received: from MAIL.ugal.ro ([127.0.0.1])
        by localhost (mail.ugal.ro [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9GwxwvPs6zLI; Mon, 23 Sep 2019 21:02:49 +0300 (EEST)
Received: from LPETCU (unknown [10.11.10.80])
        (Authenticated sender: lpetcu)
        by MAIL.ugal.ro (Postfix) with ESMTPA id 22AE613A2F58D;
        Mon, 23 Sep 2019 21:02:49 +0300 (EEST)
Reply-To: <Liviu.Petcu@ugal.ro>
From:   "Liviu Petcu" <Liviu.Petcu@ugal.ro>
To:     "'Wols Lists'" <antlists@youngman.org.uk>,
        "'John Stoffel'" <john@stoffel.org>,
        "'Sarah Newman'" <srn@prgmr.com>
Cc:     <linux-raid@vger.kernel.org>
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro> <23940.1755.134402.954287@quad.stoffel.home> <094701d56f7c$95225260$bf66f720$@ugal.ro> <cf597586-a450-f85a-51e1-76df59f22839@prgmr.com> <23941.15337.175082.79768@quad.stoffel.home> <001e01d5705d$b1785360$1468fa20$@ugal.ro> <5D863E19.4000309@youngman.org.uk>
In-Reply-To: <5D863E19.4000309@youngman.org.uk>
Subject: RE: RAID 10 with 2 failed drives
Date:   Mon, 23 Sep 2019 21:02:33 +0300
Organization: =?us-ascii?Q?Universitatea_=22Dunarea_de_Jos=22_din_Gala=3Fi?=
Message-ID: <01d601d57239$13098130$391c8390$@ugal.ro>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQLQ1+hi3KIqiub/RHQRSTvcyI2F0wLfsDrkAugv2EMBTTr/eQIDR3BRAZijxEMAtOeTYqTnigzQ
Content-Language: ro
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>On 21/09/19 10:19, Liviu Petcu wrote:
>> Yes. Only one of the 2 disks reported by mdadm as failed, is broken. I
>> almost finished making images of all the discs, and for the second
"failed"
>> disc ddrescue reported error-free copying. I intend to use the images to
>> recreate the array. I haven't done this before, but I hope I can handle
>> it...

>Could be that failure that knocked the other drive out of the array too.
>Dunno why it should happen with SATA, they're supposedly independent,
>but certainly with the old PATA disks in pairs, a problem with one drive
>could affect the other.

Hello,
You were right Wol. Only one of the disks was damaged. I reinstalled the 5
drive plus a new one and started the system. I copied the partition table
from one drive to the new drive and then added the partitions to the 2
arrays. The recovery has started. It  seems to be almost all right. On raid
10 array md1 is a Xen Storage, and some VMs that have XFS file system,
booted up but report errors like "XFS (dm-2): Internal error
XFS_WANT_CORRUPTED_GOTO". But this is probably the subject of another
discussion...
Thank you all for your support and advices.

Cheers,
Liviu


