Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D79EFF237
	for <lists+linux-raid@lfdr.de>; Tue, 30 Apr 2019 10:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfD3IrO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 30 Apr 2019 04:47:14 -0400
Received: from arcturus.uberspace.de ([185.26.156.30]:37970 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfD3IrO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 30 Apr 2019 04:47:14 -0400
Received: (qmail 7547 invoked from network); 30 Apr 2019 08:47:12 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 30 Apr 2019 08:47:12 -0000
Date:   Tue, 30 Apr 2019 10:47:12 +0200
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     Julien ROBIN <julien.robin28@free.fr>
Cc:     linux-raid@vger.kernel.org
Subject: Re: RAID5 mdadm --grow wrote nothing (Reshape Status : 0% complete)
 and cannot assemble anymore
Message-ID: <20190430084711.GA2132@metamorpher.de>
References: <a87383aa-3c49-0f62-6a93-9b9cb2fc60dd@free.fr>
 <96216021-6834-66ae-135d-ed654d64e5c0@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96216021-6834-66ae-135d-ed654d64e5c0@free.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Apr 30, 2019 at 04:49:19AM +0200, Julien ROBIN wrote:
>   Reshape pos'n : 0
>   Delta Devices : 1 (3->4)

You could try to assemble with --update=revert-reshape.
If it complains about the backup file, you could also 
try it with revert-reshape-nobackup but that's risky.

If in doubt always use overlays for such experiments.

https://raid.wiki.kernel.org/index.php/Recovering_a_failed_software_RAID#Making_the_harddisks_read-only_using_an_overlay_file

Good luck
Andreas Klauer
