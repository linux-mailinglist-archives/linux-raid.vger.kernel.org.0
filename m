Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB03938B894
	for <lists+linux-raid@lfdr.de>; Thu, 20 May 2021 22:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhETUtg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 20 May 2021 16:49:36 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:35962 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhETUtg (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 20 May 2021 16:49:36 -0400
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.16.1/8.16.1) with ESMTPS id 14KKmCv2025751
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 20 May 2021 21:48:12 +0100
From:   Nix <nix@esperi.org.uk>
To:     Leslie Rhorer <lesrhorer@att.net>
Cc:     Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: My superblocks have gone missing, can't reassemble raid5
References: <CA+o1gzBcQF_JeiC7Nv_zEBmJU2ypwQ_+RkbcZOOt0qOK1MkQww@mail.gmail.com>
        <c99e3bac-469a-0b48-31df-481754c477c7@att.net>
        <cceec847-e2e2-3d7f-008e-e3f1fac9ca20@youngman.org.uk>
        <3f77fc62-2698-a8cb-f366-75e8a63b9a8b@att.net>
        <60A55239.9070009@youngman.org.uk>
        <8ab0ec19-4d9b-3de6-59cf-9e6a8a18bd37@att.net>
Emacs:  is that a Lisp interpreter in your editor, or are you just happy to see me?
Date:   Thu, 20 May 2021 21:48:12 +0100
In-Reply-To: <8ab0ec19-4d9b-3de6-59cf-9e6a8a18bd37@att.net> (Leslie Rhorer's
        message of "Wed, 19 May 2021 14:01:42 -0500")
Message-ID: <87eee1nncj.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC-x.dcc-servers-Metrics: loom 104; Body=2 Fuz1=2 Fuz2=2
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 19 May 2021, Leslie Rhorer spake thusly:

> 	That's a little bit of an overstatement, depending on what you
> mean by "reasonably confident". Swapped drives should not ordinarily
> cause an issue, especially with RAID 4 or 5. The parity is, after all,
> numerically unique. Admin changes to the array should be similarly
> fully established provided the rebuild completed properly. I don't
> think the parity algorythms have changed over time in mdadm, either.

All sorts of creation-time things have changed over time: default chunk
sizes, drive ordering (particularly but not only for RAID10), data
offset, etc etc etc. The list is really rather long and the number of
possible combinations astronomical. (Sure, it's less astronomical if you
know what version of mdadm you made the array with in the first place,
but hardly anyone who hasn't already been bitten tracks that, and if
they do they probably recorded all the other relevant state too by
preserving --examine output, so no guesswork is needed.)

> Had they done so, mdadm would not be able to assemble arrays from
> previous versions regardless of whether the superblock was intact.

Naah. Most of this stuff is recorded *in* the superblock, so mdadm can
assemble without difficulty or assistance: it doesn't do it by picking
defaults from inside mdadm's source code! *Those* defaults only apply at
array creation time. But when recreating an array over the top of a
vanished one with the same parameters, you have to *remember* those
parameters...

-- 
NULL && (void)
