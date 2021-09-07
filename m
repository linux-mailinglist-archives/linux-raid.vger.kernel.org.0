Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212BB4024C3
	for <lists+linux-raid@lfdr.de>; Tue,  7 Sep 2021 09:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240073AbhIGH6a (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 Sep 2021 03:58:30 -0400
Received: from rin.romanrm.net ([51.158.148.128]:38008 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231366AbhIGH6a (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 7 Sep 2021 03:58:30 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Sep 2021 03:58:29 EDT
Received: from natsu (natsu2.home.romanrm.net [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id E65574E2;
        Tue,  7 Sep 2021 07:52:01 +0000 (UTC)
Date:   Tue, 7 Sep 2021 12:52:01 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Ryan Patterson <ryan.goat@gmail.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: mdadm resync causes stable system to crash every 2 or 3 hours
Message-ID: <20210907125201.0cc77658@natsu>
In-Reply-To: <CA+Kggd7mUF9MWdJsLtAQMv=KXtwaNvj6BqfM+NMyffE86iHBoQ@mail.gmail.com>
References: <CA+Kggd7mUF9MWdJsLtAQMv=KXtwaNvj6BqfM+NMyffE86iHBoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, 6 Sep 2021 20:44:31 -0400
Ryan Patterson <ryan.goat@gmail.com> wrote:

> My file server is usually very stable.  The past week I had two mdadm
> arrays that required recync operations.
> * newly created raid6 array (14 x 16TB seagate exos)
> * existing raid 6 array, after a reboot resync on hot spare (14 x 4TB
> seagate barracuda)
> 
> During both resync operations (they ran one at a time) the system
> would routinely experience a major error and require a hard reboot,
> every two or three hours.  I saw several errors, such as:
> * kernel watchdog soft lockups [md127_raid6:364]
> * general protection faults (I have a few saved with the full exception stack)
> * exceptions in iommu routines (again I have the full error with
> exception stack saved)
> * full system lockup

So in other words the server is very stable, unless asked to do full-speed
reads from all disks at the same time.

I'd suggest to check or improve cooling on the HBA cards, and then try a
different PSU.

> I doubt there is a bug in mdadm that caused this behavior.  But it was
> very predictable and repeatable while the resync operations were in
> progress.
> 
> How can I avoid these errors the next time I have an array in need of a resync?
> 
> OS: debian 11 bullseye
> kernel: 5.10.0-8-amd64 #1 SMP Debian 5.10.46-4 (2021-08-03)
> mdadm: v4.1 - 2018-10-01
> sata HBA: 3 x LSI SAS 9201-16i
> _____________
> Ryan Patterson
> May the wings of liberty never lose a feather.


-- 
With respect,
Roman
