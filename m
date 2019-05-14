Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D15BE1CECD
	for <lists+linux-raid@lfdr.de>; Tue, 14 May 2019 20:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfENSOB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 May 2019 14:14:01 -0400
Received: from mail.thelounge.net ([91.118.73.15]:17817 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfENSOB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 May 2019 14:14:01 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 453Qml03D9zXLx;
        Tue, 14 May 2019 20:13:58 +0200 (CEST)
Subject: Re: Help restoring a raid10 Array (4 disk + one spare) after a hard
 disk failure at power on
To:     eric.valette@free.fr, linux-raid@vger.kernel.org
References: <87d22dc0-4b45-e13f-86e1-d3e9fbd7f55d@free.fr>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <1bc43f99-3c57-db16-64d2-e5ab7d2e27cf@thelounge.net>
Date:   Tue, 14 May 2019 20:13:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87d22dc0-4b45-e13f-86e1-d3e9fbd7f55d@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 14.05.19 um 17:48 schrieb Eric Valette:
> I have a dedicated hardware nas that runs a self maintained debian 10.
> 
> before the hardware disk problem (before/after)
> 
> sda : system disk OK/OK no raid
> sdb : first disk of the raid10 array OK/OK
> sdc : second disk of the raid10 array OK/OK
> sdd : third disk of the raid10 array OK/KO
> sde : fourth disk of the raid10 array OK/OK but is now sdd
> sdf : spare disk for the array is now sde
> 
> After the failure the BIOS does not detect the original third disk. Disk
> are renamed and I think sde has become sdd and sdf -> sde

how does that matter on any proper setup?
*never* use /dev/xyz anywhere

[root@srv-rhsoft:~]$ cat /etc/mdadm.conf
MAILADDR root
HOMEHOST localhost.localdomain
AUTO +imsm +1.x -all

ARRAY /dev/md0 level=raid1 num-devices=4
UUID=1d691642:baed26df:1d197496:4fb00ff8
ARRAY /dev/md1 level=raid10 num-devices=4
UUID=b7475879:c95d9a47:c5043c02:0c5ae720
ARRAY /dev/md2 level=raid10 num-devices=4
UUID=ea253255:cb915401:f32794ad:ce0fe396
