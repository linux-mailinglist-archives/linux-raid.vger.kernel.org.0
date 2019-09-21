Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 424EAB9D25
	for <lists+linux-raid@lfdr.de>; Sat, 21 Sep 2019 11:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390946AbfIUJUK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 21 Sep 2019 05:20:10 -0400
Received: from mail.ugal.ro ([193.231.148.6]:7707 "EHLO MAIL.ugal.ro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389497AbfIUJUJ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 21 Sep 2019 05:20:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by MAIL.ugal.ro (Postfix) with ESMTP id 94AF213A2F551;
        Sat, 21 Sep 2019 09:20:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at ugal.ro
Received: from MAIL.ugal.ro ([127.0.0.1])
        by localhost (mail.ugal.ro [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TvMAOy0MZJXe; Sat, 21 Sep 2019 12:20:00 +0300 (EEST)
Received: from LPETCU (unknown [10.11.10.80])
        (Authenticated sender: lpetcu)
        by MAIL.ugal.ro (Postfix) with ESMTPA id 416E113A2ED6A;
        Sat, 21 Sep 2019 12:20:00 +0300 (EEST)
Reply-To: <Liviu.Petcu@ugal.ro>
From:   "Liviu Petcu" <Liviu.Petcu@ugal.ro>
To:     "'John Stoffel'" <john@stoffel.org>,
        "'Sarah Newman'" <srn@prgmr.com>
Cc:     <linux-raid@vger.kernel.org>
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro>        <23940.1755.134402.954287@quad.stoffel.home>        <094701d56f7c$95225260$bf66f720$@ugal.ro>        <cf597586-a450-f85a-51e1-76df59f22839@prgmr.com> <23941.15337.175082.79768@quad.stoffel.home>
In-Reply-To: <23941.15337.175082.79768@quad.stoffel.home>
Subject: RE: RAID 10 with 2 failed drives
Date:   Sat, 21 Sep 2019 12:19:38 +0300
Organization: =?us-ascii?Q?Universitatea_=22Dunarea_de_Jos=22_din_Gala=3Fi?=
Message-ID: <001e01d5705d$b1785360$1468fa20$@ugal.ro>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQLQ1+hi3KIqiub/RHQRSTvcyI2F0wLfsDrkAugv2EMBTTr/eQIDR3BRpPZGDjA=
Content-Language: ro
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



-----Original Message-----
From: linux-raid-owner@vger.kernel.org
[mailto:linux-raid-owner@vger.kernel.org] On Behalf Of John Stoffel
Sent: vineri, 20 septembrie 2019 23:52
To: Sarah Newman <srn@prgmr.com>
Cc: Liviu.Petcu@ugal.ro; linux-raid@vger.kernel.org
Subject: Re: RAID 10 with 2 failed drives

>>>>> "Sarah" == Sarah Newman <srn@prgmr.com> writes:

Sarah> On 9/19/19 11:28 PM, Liviu Petcu wrote:
>> Thank you John Stoffel.
>> 
>> So far I have done nothing but mdadm - exams.  Both disks seem to be gone
>> and have no led activity. Below are the system information and the
details
>> of the event from /var/log/messages.

Sarah> Maybe try reseating the drives, or reseating cables, or put the
Sarah> drives in a different server? Two drives being kicked at the
Sarah> same time sounds like a problem other than the hard drives
Sarah> themselves, unless you haven't been running any sort of SMART
Sarah> self tests or raid checks.


I agree with Sarah, make sure those two drives are really dead first.
If you have a USB3 port and one of those USB->SATA dongles, that might
be a quick and easy way to confirm.

Yes. Only one of the 2 disks reported by mdadm as failed, is broken. I
almost finished making images of all the discs, and for the second "failed"
disc ddrescue reported error-free copying. I intend to use the images to
recreate the array. I haven't done this before, but I hope I can handle
it...

I've been super busy at work today, just finally checking my own email.

Thank you!

