Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A4812B37E
	for <lists+linux-raid@lfdr.de>; Fri, 27 Dec 2019 10:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfL0JOn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 27 Dec 2019 04:14:43 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:33133 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfL0JOm (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 27 Dec 2019 04:14:42 -0500
Received: from [86.152.238.29] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1iklhg-0001ZZ-Bl; Fri, 27 Dec 2019 09:14:40 +0000
Subject: Re: WD MyCloud PR4100 RAID Failure
To:     Patrick Pearcy <patrick.pearcy@gmail.com>,
        Andreas Klauer <Andreas.Klauer@metamorpher.de>
References: <CAM-0FgP5dXnTbri-wB-2LJU-QE5wd9nsq=kzMW9kXND=wF=z8w@mail.gmail.com>
 <20191217182509.GA16121@metamorpher.de>
 <CAM-0FgOpi4EGuhM7DXSutRtxRSJ4nb9kLzM0U_3LZi-jxUDVWQ@mail.gmail.com>
 <20191222130452.GA2580@metamorpher.de> <20191222134019.GA3770@metamorpher.de>
 <CAM-0FgNegq5Ujd=K9Rjk-Vi9Y2zzb1U3YXScs6MxrDbC2xmbeg@mail.gmail.com>
Cc:     linux-raid@vger.kernel.org
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5E05CB7F.5030608@youngman.org.uk>
Date:   Fri, 27 Dec 2019 09:14:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CAM-0FgNegq5Ujd=K9Rjk-Vi9Y2zzb1U3YXScs6MxrDbC2xmbeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 26/12/19 19:19, Patrick Pearcy wrote:
> Upon reboot of the PR4100 - the array etc. went away and I was back to
> configure the file system message.   I successfully re-ran the mdadm
> --assemble and mount commands so I can 'see the data' but I can't
> figure out how to 'copy' the data from the PR4100 (i.e., how to share
> the directory) OR mount the array (and shares) in the PR4100
> automatically...   Any suggestions??

Can you enable JBOD (Just a Bunch Of Disks) mode? That will make the
individual disks visible in linux. You can then assemble it there.

Or you may have to take the disks out and mount them in a linux system -
note that add-in SATA cards are cheap. 4 x 8TB drives with a 2008 mdadm?
Did they have 8TB drives 11 years ago?

BEWARE! The array may LOOK okay, but until you've run a READ ONLY fsck
over it and that reports it is clean, your data is still in grave danger!

And I'm inclined to agree with Andreas, the only way you're going to get
that WD working again is to backup and reformat. Unless you can engage
JBOD and take the WD firmware out of the picture, which is what I would
want to do ... you *need* to look at backing this thing up. How full was
the array? Do you actually need 24TB of disk for a backup?

Cheers,
Wol
