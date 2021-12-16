Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF64477FD9
	for <lists+linux-raid@lfdr.de>; Thu, 16 Dec 2021 23:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbhLPWJB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Dec 2021 17:09:01 -0500
Received: from li1843-175.members.linode.com ([172.104.24.175]:44642 "EHLO
        mail.stoffel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbhLPWJB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Dec 2021 17:09:01 -0500
Received: from quad.stoffel.org (068-116-170-226.res.spectrum.com [68.116.170.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 47EB61EDBF;
        Thu, 16 Dec 2021 17:09:00 -0500 (EST)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id AAE14A76E8; Thu, 16 Dec 2021 17:08:59 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <25019.47355.649723.422478@quad.stoffel.home>
Date:   Thu, 16 Dec 2021 17:08:59 -0500
From:   "John Stoffel" <john@stoffel.org>
To:     Roger Heflin <rogerheflin@gmail.com>
Cc:     John Stoffel <john@stoffel.org>, Wol <antlists@youngman.org.uk>,
        linux-raid <linux-raid@vger.kernel.org>
Subject: Re: Debugging system hangs
In-Reply-To: <CAAMCDedKxvcXMzeBRjfU6mqLyZSFz=bMzZtJpPeHaLQUFgq48g@mail.gmail.com>
References: <d8a0d8c9-f8cc-a70a-03a0-aae2fd6c68c2@youngman.org.uk>
        <CAAMCDeekr+a6e7BwyF9b=n49X6YgqUWBc8UtAyZkjFcHBnbyRQ@mail.gmail.com>
        <cbfc2f45-96d8-4ee7-a12b-5a24bd2f2159@youngman.org.uk>
        <CAAMCDeemZO2u_4WW8pHVP2qOxz0HdHQTy2Gsa=zgY-7g4ptw7w@mail.gmail.com>
        <25019.45839.872620.235430@quad.stoffel.home>
        <CAAMCDedKxvcXMzeBRjfU6mqLyZSFz=bMzZtJpPeHaLQUFgq48g@mail.gmail.com>
X-Mailer: VM 8.2.0b under 26.1 (x86_64-pc-linux-gnu)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>>>>> "Roger" == Roger Heflin <rogerheflin@gmail.com> writes:

Roger> If the power supply cannot handle it the node will flat out crash.

Maybe... it might just have the voltage drop enough to cause the
system to hang, instead of quite crashing.  It's hard to debug though...

Roger> There is no mechanism for the cpu/memory/mb to deal with a
Roger> power supply unable to supply enough.

Roger> The load going up will likely be something else, I have never
Roger> seen hw show as that.

Roger> On Thu, Dec 16, 2021 at 3:43 PM John Stoffel <john@stoffel.org> wrote:
>> 
>> 
>> Another thing that struck me is maybe it's time to boot into a small
>> stress testing image and see if it's more of a hardware issue.  It
>> might also be a power supply issue, where as the load goes up, your
>> power supply can't keep the voltage up and the system fails that way?
>> 
>> There's the 'stress-ng' package for beating on systems.  And I think
>> I've used 'sysrecue' in the past to boot up systems and run stress
>> tests.
>> 
>> Getting the regular OS out of the way with something lower level and
>> simpler to stress test the hardware is a good idea.
>> 
>> https://www.stresslinux.org/sl/
>> 
>> Might be another good option.
>> 
>> Good luck!
>> John
