Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A50205826
	for <lists+linux-raid@lfdr.de>; Tue, 23 Jun 2020 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbgFWRBt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 23 Jun 2020 13:01:49 -0400
Received: from li1843-175.members.linode.com ([172.104.24.175]:36508 "EHLO
        mail.stoffel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732686AbgFWRBt (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 23 Jun 2020 13:01:49 -0400
Received: from quad.stoffel.org (066-189-075-104.res.spectrum.com [66.189.75.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 5D81325750;
        Tue, 23 Jun 2020 13:01:48 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id CC213A64A8; Tue, 23 Jun 2020 13:01:47 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24306.13691.769328.392093@quad.stoffel.home>
Date:   Tue, 23 Jun 2020 13:01:47 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     o1bigtenor <o1bigtenor@gmail.com>
Cc:     John Stoffel <john@stoffel.org>,
        Ian Pilcher <arequipeno@gmail.com>,
        Linux-RAID <linux-raid@vger.kernel.org>
Subject: Re: RAID types & chunks sizes for new NAS drives
In-Reply-To: <CAPpdf5-RWyGX4Q9qaZBDfxUXedf+MnV3wnXh6R3XSF7-LomKzQ@mail.gmail.com>
References: <rco1i8$1l34$1@ciao.gmane.io>
        <24305.24232.459249.386799@quad.stoffel.home>
        <CAPpdf5-RWyGX4Q9qaZBDfxUXedf+MnV3wnXh6R3XSF7-LomKzQ@mail.gmail.com>
X-Mailer: VM 8.2.0b under 26.1 (x86_64-pc-linux-gnu)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>>>>> "o1bigtenor" == o1bigtenor  <o1bigtenor@gmail.com> writes:

o1bigtenor> On Mon, Jun 22, 2020 at 9:06 PM John Stoffel <john@stoffel.org> wrote:
>> 
o1bigtenor> snip

>> In any case, make sure you get NAS rated disks, either the newest WD
>> RED+ (or is it Blue?)  In any case, make sure to NOT get the SMR
>> (Shingled Magnetic Recording) format drives.  See previous threads in
>> this group, as well as the arstechnica.com discussion about it all
>> that they disk last month.  Very informative.
>> 
>> Personally, with regular hard disks, I still kinda think 4gb is the
>> sweet spot, since you can just mirror pairs of the disks and then
>> stripe across on top as needed.  I like my storage simple, because
>> when (not if!) it all hits the fan, simple is easier to recover from.
>> 
o1bigtenor> Did you mean 4 TB or 4 GB as you wrote?
o1bigtenor> (Somewhat of a difference I do believe.)

LOL!  I meant 4Tb of course... but I do remember when 10mb HDs were
amazing... :-)
