Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2281E150A
	for <lists+linux-raid@lfdr.de>; Mon, 25 May 2020 22:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390699AbgEYUAw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 16:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390691AbgEYUAu (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 May 2020 16:00:50 -0400
X-Greylist: delayed 1083 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 May 2020 13:00:50 PDT
Received: from mail.bitfolk.com (mail.bitfolk.com [IPv6:2001:ba8:1f1:f019::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D25EC061A0E
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com; s=alpha;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date; bh=SFMdhgLBBo3tBdbqRUp/UmZTjt2rgJjGALxemKmrK3c=;
        b=C4ZSMgaWaqwG4HKWx8uXTf1sAlaXtKCmNFK43xIPlV5jd3hdQxmAMdzHnDHUHaSMZmImOBbdT3s8F9swor29zTt9FIyWjJDvRslpBintzfiQ+KZmVgi2dFiDsnQkpybnVjnhAAS78s9kpcMmzIfgJXizJHOhUSs7RtRfMtYBzF4emLPgHb4KbYTatYTRV6rBgXXVQl9tbIa/nWhQoe8I2TVDcSaKUa/fhJVFXS5pL1laF9b084vZ0vp5v6XLajby5LDDK0gO1AL4BgCVBTYpVPBDvnoM/e2sCbAhaY0V4MikHzUo+ct+x+atZlf4HLJARHIDW0TPUW9db+OBjEzB6A==;
Received: from andy by mail.bitfolk.com with local (Exim 4.84_2)
        (envelope-from <andy@strugglers.net>)
        id 1jdIzl-0003cs-6q
        for linux-raid@vger.kernel.org; Mon, 25 May 2020 19:42:45 +0000
Date:   Mon, 25 May 2020 19:42:45 +0000
From:   Andy Smith <andy@strugglers.net>
To:     linux-raid@vger.kernel.org
Subject: Re: help requested for mdadm grow error
Message-ID: <20200525194245.GV17408@bitfolk.com>
Mail-Followup-To: linux-raid@vger.kernel.org
References: <7d95da49-33d8-cd4d-fa3f-0f3d3074cb30@gmail.com>
 <5ECC09D6.1010300@youngman.org.uk>
 <ff4ea9cd-ab35-0990-5946-4a72d4021658@gmail.com>
 <5ECC1488.3010804@youngman.org.uk>
 <4891e1e8-aaee-b36b-4131-ca7deb34defd@gmail.com>
 <alpine.DEB.2.20.2005252132080.7596@uplift.swm.pp.se>
 <a755c889-a5bd-1ff3-6a9f-4274b7d7fc83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a755c889-a5bd-1ff3-6a9f-4274b7d7fc83@gmail.com>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL:  http://strugglers.net/wiki/User:Andy
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, May 25, 2020 at 09:35:20PM +0200, Thomas Grawert wrote:
> >Someone unattributed wrote:
> >Are you sure about this? From what I can see debian 10 ships with mdadm
> >v4.1 and newer kernels than 4.9.
> >
> I shall check before yelling out some shit...
> It´s currently running Debian 9.

$ lsb_release -d && mdadm --version && uname -r
Description:    Debian GNU/Linux 10 (buster)
mdadm - v4.1 - 2018-10-01
4.19.0-9-amd64

Cheers,
Andy

-- 
https://bitfolk.com/ -- No-nonsense VPS hosting
