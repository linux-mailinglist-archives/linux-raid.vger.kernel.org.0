Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF561A8486
	for <lists+linux-raid@lfdr.de>; Tue, 14 Apr 2020 18:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391368AbgDNQUR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Apr 2020 12:20:17 -0400
Received: from mail.thelounge.net ([91.118.73.15]:61603 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391361AbgDNQUK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Apr 2020 12:20:10 -0400
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 491rLH5Ck2zXP1;
        Tue, 14 Apr 2020 18:20:07 +0200 (CEST)
Subject: Re: Setup Recommendation on UEFI/GRUB/RAID1/LVM
To:     G <garboge@shaw.ca>,
        Stefanie Leisestreichler 
        <stefanie.leisestreichler@peter-speer.de>,
        linux-raid@vger.kernel.org
References: <fc12df3c-aac9-4aa8-a596-f13225161e22@peter-speer.de>
 <f9f2f479-2899-6774-eb20-bf81ed24bc7b@shaw.ca>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <f857fc03-d18b-a489-54c9-49c22ad19c39@thelounge.net>
Date:   Tue, 14 Apr 2020 18:20:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f9f2f479-2899-6774-eb20-bf81ed24bc7b@shaw.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 14.04.20 um 18:00 schrieb G:
> Since you are running disks less than 2TB I would suggest a more
> rudimentary setup using legacy bios booting. This setup will not allow
> disks greater than 2TB because they would not be partitioned GPT. There
> would still be an ability to increase total storage using more disks.
> There would be raid redundancy with the ability for grub to boot off
> either disk.

terrible idea in 2020

Intel announced yeas ago that they itend to remove legacy bios booting
in 2020 and even if it#s just in 2022: RAID machines are supposed to
live many many years and you just move the disks to your next machine
and boot as yesterday

i argued like you in 2011 and now i have a 4x2 TB RAID10 and need to
deal with EFI-partition on a USB stick with the replacement as soon as
there are icelake or never serious desktop machines because there is no
single reason to reinstall from scratch when you survived already 17
fedora dist-upgrades
