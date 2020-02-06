Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5331545BB
	for <lists+linux-raid@lfdr.de>; Thu,  6 Feb 2020 15:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBFOHD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 Feb 2020 09:07:03 -0500
Received: from mail.thelounge.net ([91.118.73.15]:59833 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFOHD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 6 Feb 2020 09:07:03 -0500
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 48D0c43F59zXSW;
        Thu,  6 Feb 2020 15:07:00 +0100 (CET)
Subject: Re: Recover RAID6 with 4 disks removed
To:     Nicolas Karolak <nicolas.karolak@ubicast.eu>,
        linux-raid@vger.kernel.org
References: <CAO8Scz75h0mTqePyyeehnY+706R=eUgh7DOOKyCaWWJfADRUVg@mail.gmail.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <dfac6758-1539-6b63-1883-03d704c67bc4@thelounge.net>
Date:   Thu, 6 Feb 2020 15:07:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAO8Scz75h0mTqePyyeehnY+706R=eUgh7DOOKyCaWWJfADRUVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 06.02.20 um 14:46 schrieb Nicolas Karolak:
> I have (had...) a RAID6 array with 8 disks and tried to remove 4 disks
> from it, and obviously i messed up. Here is the commands i issued (i
> do not have the output of them):

didn't you realize that RAID6 has redundancy to survive *exactly two*
failing disks no matter how many disks the array has anmd the data and
redundancy informations are spread ove the disks?

> mdadm --manage /dev/md1 --fail /dev/sdh
> mdadm --manage /dev/md1 --fail /dev/sdg
> mdadm --detail /dev/md1
> cat /proc/mdstat
> mdadm --manage /dev/md1 --fail /dev/sdf
> mdadm --manage /dev/md1 --fail /dev/sde
> mdadm --detail /dev/md1
> cat /proc/mdstat
> mdadm --manage /dev/md1 --remove /dev/sdh
> mdadm --manage /dev/md1 --remove /dev/sdg
> mdadm --manage /dev/md1 --remove /dev/sde
> mdadm --manage /dev/md1 --remove /dev/sdf
> mdadm --detail /dev/md1
> cat /proc/mdstat
> mdadm --grow /dev/md1 --raid-devices=4
> mdadm --grow /dev/md1 --array-size 7780316160  # from here it start
> going wrong on the system

becaue mdadm din't't prevent you from shoot yourself in the foot, likely
for cases when one needs a hammer for restore from a uncommon state as
last ressort

set more than one disk at the same time to "fail" is aksing for troubles
no matter what

what happens when one drive starts to puke when you removed every
redundancy and happily start a reshape that implies heavy IO?

> I began to have "inpout/output" error, `ls` or `cat` or almost every
> command was not working (something like "/usr/sbin/ls not found").
> `mdadm` command was still working, so i did that:
> 
> ```
> mdadm --manage /dev/md1 --re-add /dev/sde
> mdadm --manage /dev/md1 --re-add /dev/sdf
> mdadm --manage /dev/md1 --re-add /dev/sdg
> mdadm --manage /dev/md1 --re-add /dev/sdh
> mdadm --grow /dev/md1 --raid-devices=8
> ```
> 
> The disks were re-added, but as "spares". After that i powered down
> the server and made backup of the disks with `dd`.
> 
> Is there any hope to retrieve the data? If yes, then how?

unlikely - the started reshape did writes
