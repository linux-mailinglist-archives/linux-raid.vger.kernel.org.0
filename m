Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAF8E881F
	for <lists+linux-raid@lfdr.de>; Tue, 29 Oct 2019 13:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfJ2M1u (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 29 Oct 2019 08:27:50 -0400
Received: from rin.romanrm.net ([91.121.75.85]:45920 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731213AbfJ2M1u (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 29 Oct 2019 08:27:50 -0400
Received: from natsu (natsu.2.romanrm.net [IPv6:fd39:aa:7359:7f90:e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 1493D2027D;
        Tue, 29 Oct 2019 12:27:47 +0000 (UTC)
Date:   Tue, 29 Oct 2019 17:27:47 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Jorge Bastos <jorge.mrbastos@gmail.com>
Cc:     Tim Small <tim@buttersideup.com>, Marc MERLIN <marc@merlins.org>,
        linux-raid@vger.kernel.org
Subject: Re: Cannot fix Current_Pending_Sector even after check and repair
Message-ID: <20191029172747.7cbe6e32@natsu>
In-Reply-To: <CAHzMYBSAzB+rjixTx9DSgs48WOHkGybFGyGOEy3b7mtqnLHLgQ@mail.gmail.com>
References: <20191028202732.GV15771@merlins.org>
        <eb24a24e-c268-0f3c-742a-5bde650c18dc@buttersideup.com>
        <CAHzMYBSAzB+rjixTx9DSgs48WOHkGybFGyGOEy3b7mtqnLHLgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, 29 Oct 2019 12:05:02 +0000
Jorge Bastos <jorge.mrbastos@gmail.com> wrote:

> Same, especially with WD drives, they appear to be false positives, if
> you can take the disk offline a full disk write will usually get rid
> of them.

Oh and talking of "especially WD" and especially Green, such transient errors
are a a sure symptom of rust developing on PCB contact pads:
https://www.youtube.com/watch?v=tDTt_yjYYQ8

E.g. Hitachi doesn't have this issue (they have drops of solder on each
contact pad); not much experience with Seagate; and WD themselves later
improved the design of this connection (redesigned type seen at least on a 6TB
WD Red).

-- 
With respect,
Roman
