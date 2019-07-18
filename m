Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48CF96C984
	for <lists+linux-raid@lfdr.de>; Thu, 18 Jul 2019 08:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfGRGyZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 18 Jul 2019 02:54:25 -0400
Received: from arcturus.uberspace.de ([185.26.156.30]:43570 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfGRGyZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 18 Jul 2019 02:54:25 -0400
Received: (qmail 16075 invoked from network); 18 Jul 2019 06:54:22 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 18 Jul 2019 06:54:22 -0000
Date:   Thu, 18 Jul 2019 08:54:22 +0200
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     Peter Grandi <pg@mdraid.list.sabi.co.uk>
Cc:     Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: slow BLKDISCARD on RAID10 md block devices
Message-ID: <20190718065422.GA3019@metamorpher.de>
References: <20190717090200.GD2080@wantstofly.org>
 <20190717113352.GA13079@metamorpher.de>
 <23855.33990.595530.291667@base.ty.sabi.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23855.33990.595530.291667@base.ty.sabi.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jul 17, 2019 at 09:27:50PM +0100, Peter Grandi wrote:
> [...]
> > Total time (this is tmpfs-backed, no real I/O)
> 
> That's not even remotely realistic.

That's not even remotely the point.

> My guess is that those limiting options are advisory

Amazingly unexpected news :-)
