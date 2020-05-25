Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255D21E14EB
	for <lists+linux-raid@lfdr.de>; Mon, 25 May 2020 21:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390313AbgEYTmd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 15:42:33 -0400
Received: from swm.pp.se ([212.247.200.143]:60282 "EHLO uplift.swm.pp.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390295AbgEYTmd (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 25 May 2020 15:42:33 -0400
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 May 2020 15:42:32 EDT
Received: by uplift.swm.pp.se (Postfix, from userid 501)
        id CB0B4AF; Mon, 25 May 2020 21:33:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=swm.pp.se; s=mail;
        t=1590435226; bh=8iSK2T6UbnFJnEFuVcgMgb+EMd2LqnaJsd3IkkTblo0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=eyWwoZZImGL/uFtd7BocZCVn+4DQiCVwJdXkPv85Zj4HXTI9dMsTRG485t6z4dR2+
         HnbxYL0kmXEnGypWKxH4bJHA4UVsiUXdHmb7pxCkTlDNpZEX1+hwZqrAAawEWPN6M4
         nnosiUcv9F54/oincxfGhbomzbsncd5E4NT5wERU=
Received: from localhost (localhost [127.0.0.1])
        by uplift.swm.pp.se (Postfix) with ESMTP id C8DC89F;
        Mon, 25 May 2020 21:33:46 +0200 (CEST)
Date:   Mon, 25 May 2020 21:33:46 +0200 (CEST)
From:   Mikael Abrahamsson <swmike@swm.pp.se>
To:     Thomas Grawert <thomasgrawert0282@gmail.com>
cc:     linux-raid@vger.kernel.org
Subject: Re: help requested for mdadm grow error
In-Reply-To: <4891e1e8-aaee-b36b-4131-ca7deb34defd@gmail.com>
Message-ID: <alpine.DEB.2.20.2005252132080.7596@uplift.swm.pp.se>
References: <7d95da49-33d8-cd4d-fa3f-0f3d3074cb30@gmail.com> <5ECC09D6.1010300@youngman.org.uk> <ff4ea9cd-ab35-0990-5946-4a72d4021658@gmail.com> <5ECC1488.3010804@youngman.org.uk> <4891e1e8-aaee-b36b-4131-ca7deb34defd@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
Organization: People's Front Against WWW
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-137064504-873848250-1590435226=:7596"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---137064504-873848250-1590435226=:7596
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 25 May 2020, Thomas Grawert wrote:

> The Debian 10 is the most recent one. Kernel version is 4.9.0-12-amd64. 
> mdadm-version is v3.4 from 28th Jan 2016 - seems to be the latest, 
> because I can´t upgrade to any newer one using apt upgrade.

Are you sure about this? From what I can see debian 10 ships with mdadm 
v4.1 and newer kernels than 4.9.

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se
---137064504-873848250-1590435226=:7596--
