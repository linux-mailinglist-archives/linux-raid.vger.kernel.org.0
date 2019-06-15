Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0960847143
	for <lists+linux-raid@lfdr.de>; Sat, 15 Jun 2019 18:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfFOQbZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 15 Jun 2019 12:31:25 -0400
Received: from arcturus.uberspace.de ([185.26.156.30]:41238 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfFOQbZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 15 Jun 2019 12:31:25 -0400
Received: (qmail 4067 invoked from network); 15 Jun 2019 16:31:22 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 15 Jun 2019 16:31:22 -0000
Date:   Sat, 15 Jun 2019 18:31:20 +0200
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     Colt Boyd <coltboyd@gmail.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: RAID-6 aborted reshape
Message-ID: <20190615163120.GA30001@metamorpher.de>
References: <CANrzNyh-dSfxGojcQqdg+FeycdvPEfH_0qJwYFQCFcVeKGgMhQ@mail.gmail.com>
 <20190611141621.GA16779@metamorpher.de>
 <CANrzNyiCF3Fhn30pJ_hWVcGyvaMrRBLAWkPD8o4+TpCDSWTkHw@mail.gmail.com>
 <CANrzNyiQQ1BFV87CRi7gE3-k=10Swg6U8cNa2qUpS3oo0ZW32w@mail.gmail.com>
 <20190611220553.GA23970@metamorpher.de>
 <004d01d52315$698f6bf0$3cae43d0$@Gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004d01d52315$698f6bf0$3cae43d0$@Gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Jun 14, 2019 at 07:58:14PM -0500, Colt Boyd wrote:
> Is there any way to re-create the array (keeping the data intact) with this
> same layout so I could access the data via linux?

From the man page:

| When creating an array, --data-offset can be specified as `variable`.
| In the case each member device is expected to have a offset appended
| to the name, separated by a colon. This makes it possible to recreate
| exactly an array which has varying data offsets (as can happen when
| different versions of mdadm are used to add different devices).

Alternatively, you could simply change partition offsets instead.

Move 6144 partition by 2048 sectors so data offset will be 4096, too.

Everything with overlays only.

Regards
Andreas Klauer
