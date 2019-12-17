Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 959B91234C0
	for <lists+linux-raid@lfdr.de>; Tue, 17 Dec 2019 19:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfLQSZM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Dec 2019 13:25:12 -0500
Received: from arcturus.uberspace.de ([185.26.156.30]:50080 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbfLQSZM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 17 Dec 2019 13:25:12 -0500
Received: (qmail 12274 invoked from network); 17 Dec 2019 18:25:09 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 17 Dec 2019 18:25:09 -0000
Date:   Tue, 17 Dec 2019 19:25:09 +0100
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     Patrick Pearcy <patrick.pearcy@gmail.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: WD MyCloud PR4100 RAID Failure
Message-ID: <20191217182509.GA16121@metamorpher.de>
References: <CAM-0FgP5dXnTbri-wB-2LJU-QE5wd9nsq=kzMW9kXND=wF=z8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM-0FgP5dXnTbri-wB-2LJU-QE5wd9nsq=kzMW9kXND=wF=z8w@mail.gmail.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Dec 17, 2019 at 11:54:43AM -0500, Patrick Pearcy wrote:
> MDADM Examine:
> /dev/sda1:
>           Magic : a92b4efc
>         Version : 00.90.00
>            UUID : 3593a169:b2495fbf:90fa7060:4cac0d65
>   Creation Time : Tue Dec 17 10:56:15 2019

This was re-created...

>      Raid Level : raid1

...with Level 1 (Mirror)...

>   Used Dev Size : 2097088 (2048.28 MiB 2147.42 MB)
>      Array Size : 2097088 (2048.28 MiB 2147.42 MB)
>    Raid Devices : 4

...across 4 devices? With that all data would be gone, 
cause it would have replicated anything on disk #1 to 
the other disks.

Oh, it's just 2GiB. A firmware/boot partition, maybe?

Do you have examine for the data partitions?

Regards
Andreas Klauer
