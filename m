Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B35E1B9F63
	for <lists+linux-raid@lfdr.de>; Sat, 21 Sep 2019 20:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbfIUS2S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Sat, 21 Sep 2019 14:28:18 -0400
Received: from mail.ugal.ro ([193.231.148.6]:63783 "EHLO MAIL.ugal.ro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731774AbfIUS2R (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 21 Sep 2019 14:28:17 -0400
Received: from localhost (unknown [127.0.0.1])
        by MAIL.ugal.ro (Postfix) with ESMTP id F2BB013A2F551;
        Sat, 21 Sep 2019 18:28:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at ugal.ro
Received: from MAIL.ugal.ro ([127.0.0.1])
        by localhost (mail.ugal.ro [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S8ody-mhQ7K4; Sat, 21 Sep 2019 21:28:14 +0300 (EEST)
Received: from LPETCU (unknown [10.11.10.80])
        (Authenticated sender: lpetcu)
        by MAIL.ugal.ro (Postfix) with ESMTPA id 5C9F613A2ED6A;
        Sat, 21 Sep 2019 21:28:14 +0300 (EEST)
Reply-To: <Liviu.Petcu@ugal.ro>
From:   "Liviu Petcu" <Liviu.Petcu@ugal.ro>
To:     "'Sarah Newman'" <srn@prgmr.com>
Cc:     "'John Stoffel'" <john@stoffel.org>, <linux-raid@vger.kernel.org>
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro> <23940.1755.134402.954287@quad.stoffel.home> <094701d56f7c$95225260$bf66f720$@ugal.ro> <cf597586-a450-f85a-51e1-76df59f22839@prgmr.com> <23941.15337.175082.79768@quad.stoffel.home> <001e01d5705d$b1785360$1468fa20$@ugal.ro> <8a277324-d9b8-f2c9-bec0-5ed90c6e3eb4@prgmr.com>
In-Reply-To: <8a277324-d9b8-f2c9-bec0-5ed90c6e3eb4@prgmr.com>
Subject: RE: RAID 10 with 2 failed drives
Date:   Sat, 21 Sep 2019 21:27:53 +0300
Organization: =?utf-8?Q?Universitatea_=E2=80=9EDunarea_de_Jos=E2=80=9D_d?=
        =?utf-8?Q?in_Gala=3Fi?=
Message-ID: <004f01d570aa$48705410$d950fc30$@ugal.ro>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQLQ1+hi3KIqiub/RHQRSTvcyI2F0wLfsDrkAugv2EMBTTr/eQIDR3BRAZijxEMB9pN1IaTaZakQ
Content-Language: ro
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



-----Original Message-----
From: Sarah Newman [mailto:srn@prgmr.com] 
Sent: sâmbătă, 21 septembrie 2019 20:41
To: Liviu.Petcu@ugal.ro
Cc: 'John Stoffel' <john@stoffel.org>; linux-raid@vger.kernel.org
Subject: Re: RAID 10 with 2 failed drives

On 9/21/19 2:19 AM, Liviu Petcu wrote:

> Yes. Only one of the 2 disks reported by mdadm as failed, is broken. I
> almost finished making images of all the discs, and for the second "failed"
> disc ddrescue reported error-free copying. I intend to use the images to
> recreate the array. I haven't done this before, but I hope I can handle
> it...

If by recreate you mean run mdadm --create, you really shouldn't start with that - it's easy to get wrong.

You can almost certainly use mdadm --assemble --force per
https://raid.wiki.kernel.org/index.php/RAID_Recovery

Yes, I'll do that and all other attempts, with disk images as read only attached loop devices.
Thank you.

Liviu

