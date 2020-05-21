Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31961DCB9A
	for <lists+linux-raid@lfdr.de>; Thu, 21 May 2020 13:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgEULEj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 May 2020 07:04:39 -0400
Received: from u17383850.onlinehome-server.com ([74.208.250.170]:33025 "EHLO
        u17383850.onlinehome-server.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728348AbgEULEj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 21 May 2020 07:04:39 -0400
Received: by u17383850.onlinehome-server.com (Postfix, from userid 5001)
        id E0D0B769; Thu, 21 May 2020 07:04:38 -0400 (EDT)
Date:   Thu, 21 May 2020 07:04:38 -0400
From:   David T-G <davidtg-robot@justpickone.org>
To:     Linux RAID list <linux-raid@vger.kernel.org>
Subject: Re: failed disks, mapper, and "Invalid argument"
Message-ID: <20200521110438.GH1415@justpickone.org>
References: <20200520200514.GE1415@justpickone.org>
 <5EC5BBEF.7070002@youngman.org.uk>
 <20200520235347.GF1415@justpickone.org>
 <5EC63819.5010508@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5EC63819.5010508@youngman.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Wol, et al --

...and then Wols Lists said...
% 
% On 21/05/20 00:53, David T-G wrote:
% >   diskfarm:root:13:/mnt/scratch/disks> mdadm --assemble --force /dev/md0 --verbose /dev/sda1 /dev/sdb1 /dev/sdc1
% >   mdadm: looking for devices for /dev/md0
% >   mdadm: /dev/sda1 is busy - skipping
% >   mdadm: /dev/sdb1 is busy - skipping
% >   mdadm: /dev/sdc1 is busy - skipping
% > 
% > like the overlay is keeping me from the raw devices, so I'd have to tear
% > down all of that to try the real thing.  I'll h old off on that...
% 
% Did you do an mdadm --stop before trying the force assemble? That
% implies to me you've got the remnants of a previous attempt lying around...

Yes, I did.  md0 doesn't exist at all on the system at the moment.


% 
% Not sure which command it is - "cat /proc/mdstat" maybe, but make sure
% ALL your arrays are stopped (unless you know they are running okay)
% before you try stuff.

The mish-mash array (md127, and no I don't understand how these things
are named!) is fine.  The problem array (md0) is on exactly those four
disks (now sda, sdb, sdc, sdd).


% 
% Cheers,
% Wol


Thanks again & HAND

:-D
-- 
David T-G
See http://justpickone.org/davidtg/email/
See http://justpickone.org/davidtg/tofu.txt

