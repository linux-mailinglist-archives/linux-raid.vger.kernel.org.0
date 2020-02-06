Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18EED154902
	for <lists+linux-raid@lfdr.de>; Thu,  6 Feb 2020 17:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgBFQXB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 Feb 2020 11:23:01 -0500
Received: from smtp1.servermx.com ([134.19.178.79]:51070 "EHLO
        smtp1.servermx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBFQXB (ORCPT
        <rfc822;linux-raid@vger.kernel.ORG>); Thu, 6 Feb 2020 11:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=servermx.com; s=servermx; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Yzbn6QyyaiLUrpNtD1dRWaJtMV75irUC1SGuYxG1bU4=; b=fsSXS5ZDvlHVW0GOmSXUMAh3f
        UfKA3zNvzj23QxckYAL3gd0sOmJ4z+a9W9PlKG3LjFWfL3wFIeiEHgCBM+rJIBrF8dhC+T6WnNDqv
        3l2C+/6cSTdTrwK0fwqtBBUrv8wI1rIRbwz1N0K6d7O9tZyJqhc9aqYAN5bpffc85LHp8=;
Received: by exim4; Thu, 06 Feb 2020 17:22:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=servermx.com; s=servermx; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Yzbn6QyyaiLUrpNtD1dRWaJtMV75irUC1SGuYxG1bU4=; b=fsSXS5ZDvlHVW0GOmSXUMAh3f
        UfKA3zNvzj23QxckYAL3gd0sOmJ4z+a9W9PlKG3LjFWfL3wFIeiEHgCBM+rJIBrF8dhC+T6WnNDqv
        3l2C+/6cSTdTrwK0fwqtBBUrv8wI1rIRbwz1N0K6d7O9tZyJqhc9aqYAN5bpffc85LHp8=;
Received: by exim4; Thu, 06 Feb 2020 17:22:53 +0100
Received: by cthulhu.home.robinhill.me.uk (Postfix, from userid 1000)
        id E2E1D6A8049; Thu,  6 Feb 2020 16:22:50 +0000 (GMT)
Date:   Thu, 6 Feb 2020 16:22:50 +0000
From:   Robin Hill <robin@robinhill.me.uk>
To:     Nicolas Karolak <nicolas.karolak@ubicast.eu>
Cc:     Reindl Harald <h.reindl@thelounge.net>, linux-raid@vger.kernel.org
Subject: Re: Recover RAID6 with 4 disks removed
Message-ID: <20200206162250.GA32172@cthulhu.home.robinhill.me.uk>
Mail-Followup-To: Nicolas Karolak <nicolas.karolak@ubicast.eu>,
        Reindl Harald <h.reindl@thelounge.net>, linux-raid@vger.kernel.org
References: <CAO8Scz75h0mTqePyyeehnY+706R=eUgh7DOOKyCaWWJfADRUVg@mail.gmail.com>
 <dfac6758-1539-6b63-1883-03d704c67bc4@thelounge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfac6758-1539-6b63-1883-03d704c67bc4@thelounge.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Feedback-ID: outgoingmessage:robin@robinhill.me.uk:ns02.servermx.com:servermx.com
X-AuthUser: bimu5pypsh
X-Mailgun-Native-Send: true
X-AuthUser: bimu5pypsh
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu Feb 06, 2020 at 03:07:00PM +0100, Reindl Harald wrote:

> Am 06.02.20 um 14:46 schrieb Nicolas Karolak:
> > I have (had...) a RAID6 array with 8 disks and tried to remove 4 disks
> > from it, and obviously i messed up. Here is the commands i issued (i
> > do not have the output of them):
> 
> didn't you realize that RAID6 has redundancy to survive *exactly two*
> failing disks no matter how many disks the array has anmd the data and
> redundancy informations are spread ove the disks?
> 
> > mdadm --manage /dev/md1 --fail /dev/sdh
> > mdadm --manage /dev/md1 --fail /dev/sdg
> > mdadm --detail /dev/md1
> > cat /proc/mdstat
> > mdadm --manage /dev/md1 --fail /dev/sdf
> > mdadm --manage /dev/md1 --fail /dev/sde
> > mdadm --detail /dev/md1
> > cat /proc/mdstat
> > mdadm --manage /dev/md1 --remove /dev/sdh
> > mdadm --manage /dev/md1 --remove /dev/sdg
> > mdadm --manage /dev/md1 --remove /dev/sde
> > mdadm --manage /dev/md1 --remove /dev/sdf
> > mdadm --detail /dev/md1
> > cat /proc/mdstat
> > mdadm --grow /dev/md1 --raid-devices=4
> > mdadm --grow /dev/md1 --array-size 7780316160  # from here it start
> > going wrong on the system
> 
> becaue mdadm din't't prevent you from shoot yourself in the foot, likely
> for cases when one needs a hammer for restore from a uncommon state as
> last ressort
> 
> set more than one disk at the same time to "fail" is aksing for troubles
> no matter what
> 
> what happens when one drive starts to puke when you removed every
> redundancy and happily start a reshape that implies heavy IO?
> 
> > I began to have "inpout/output" error, `ls` or `cat` or almost every
> > command was not working (something like "/usr/sbin/ls not found").
> > `mdadm` command was still working, so i did that:
> > 
> > ```
> > mdadm --manage /dev/md1 --re-add /dev/sde
> > mdadm --manage /dev/md1 --re-add /dev/sdf
> > mdadm --manage /dev/md1 --re-add /dev/sdg
> > mdadm --manage /dev/md1 --re-add /dev/sdh
> > mdadm --grow /dev/md1 --raid-devices=8
> > ```
> > 
> > The disks were re-added, but as "spares". After that i powered down
> > the server and made backup of the disks with `dd`.
> > 
> > Is there any hope to retrieve the data? If yes, then how?
> 
> unlikely - the started reshape did writes

I don't think it'll have written anything as the array was in a failed
state. You'll have lost the metadata on the original disks though as
they were removed & re-added (unless you have anything recording these
before the above operations?) so that means doing a create --assume-clean
and "fsck -n" loop with all combinations until you find the correct
order (and assumes they were added at the same time and so share the
same offset). At least you know the positions of 4 of the array members,
so that reduces the number of combinations you'll need.

Check the wiki - there should be instructions on there regarding use of
overlays to prevent further accidental damage. There may even be scripts
to help with automating the create/fsck process.

Cheers,
    Robin
