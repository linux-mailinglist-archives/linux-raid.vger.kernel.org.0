Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B12118D839
	for <lists+linux-raid@lfdr.de>; Fri, 20 Mar 2020 20:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgCTTPM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 20 Mar 2020 15:15:12 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:33099 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgCTTPL (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 20 Mar 2020 15:15:11 -0400
Received: from [86.146.112.25] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jFN6s-0006Sq-DA; Fri, 20 Mar 2020 19:15:10 +0000
Subject: Re: Raid6 recovery
To:     Glenn Greibesland <glenngreibesland@gmail.com>,
        linux-raid@vger.kernel.org
References: <CA+9eyijuUEJ7Y8BuxkKaZ=v8zbPpwixOezngPjtJzaLsBd+A4Q@mail.gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Cc:     Phil Turmel <philip@turmel.org>, NeilBrown <neilb@suse.com>
Message-ID: <5E75163B.2050602@youngman.org.uk>
Date:   Fri, 20 Mar 2020 19:15:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CA+9eyijuUEJ7Y8BuxkKaZ=v8zbPpwixOezngPjtJzaLsBd+A4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 19/03/20 19:55, Glenn Greibesland wrote:
> After a bit of digging in the manual and on different forums I have
> concluded that the next step for me is to recreate the array using
> –assume-clean and –data-offset=variable.
> I have tried a dry run of the command (answering no to “Continue
> creating array”), and mdadm accepts the parameters without any errors:

Oh my god NO!!!

Do NOT use --create unless someone rather more experienced than me tells
you to!!!

The obvious thing is to somehow get the sixteen drives that you know
should be okay, re-assembled in a forced manner. The --re-add should not
have done any real damage because, as mdadm keeps complaining, you
didn't have enough drives so it won't have touched the data on that
drive. Unfortunately, my fu isn't good enough to tell you how to get
that drive back in.

What's wrong with the two failed drives? Can you ddrescue them? They
might be enough to get you going again.

You say you've read the web page "Raid recovery" - which says it's
obsolete and points you at "When things go wrogn" - but you don't appear
to have read that! PLEASE read "asking for help" and in particular you
NEED to run lsdrv and give us that information. Without that, if you DO
run --create, you will be in for a world of hurt.

I know you may feel it's asking for loads of information, and the
resulting email will be massive, but trust me - the experts will look at
it and they will probably be able to come up with a plan of action. At
present, they don't have much to go on, and nor will you if carry on as
you're going ...

Cheers,
Wol
