Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0D9EA7B81
	for <lists+linux-raid@lfdr.de>; Wed,  4 Sep 2019 08:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfIDGSF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 4 Sep 2019 02:18:05 -0400
Received: from rin.romanrm.net ([91.121.75.85]:39862 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfIDGSF (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 4 Sep 2019 02:18:05 -0400
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 392F82025C;
        Wed,  4 Sep 2019 06:18:04 +0000 (UTC)
Date:   Wed, 4 Sep 2019 11:18:03 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Phil Turmel <philip@turmel.org>
Cc:     Krzysztof =?UTF-8?B?SmFrw7NiY3p5aw==?= 
        <krzysiek.jakobczyk@gmail.com>, NeilBrown <neilb@suse.de>,
        Neil F Brown <nfbrown@suse.com>, linux-raid@vger.kernel.org,
        Wols Lists <antlists@youngman.org.uk>
Subject: Re: mdadm RAID5 to RAID6 migration thrown exceptions, access to
 data lost
Message-ID: <20190904111803.56669fde@natsu>
In-Reply-To: <d9a08687-0225-407f-dff0-f7f440786654@turmel.org>
References: <CA+ojRw=iw3uNHjmZcQyz6VsV6O0zTwZXNj5Y6_QEj70ugXAHrw@mail.gmail.com>
        <CA+ojRwmzNOUyCWXmCzZ5MG-aW3ykFZ1=o6q4o1pKv=c35zehDA@mail.gmail.com>
        <5D6CF46B.8090905@youngman.org.uk>
        <CA+ojRw=ph+zhqsiGvXhnj8tbQT7sz8q17u=LbiLxxcHYi=SBag@mail.gmail.com>
        <2ce6bd67-d373-e0fc-4dba-c6220aa4d8cb@turmel.org>
        <CA+ojRwmnpg6eLbzvXU51sLUmUVUdZnpbF71oafKtvdoApX3e1Q@mail.gmail.com>
        <87h85udyfs.fsf@notabene.neil.brown.name>
        <CA+ojRwnB8sm1WyFbwGpb8t7drPmTC9TqwzhwzUKtYy=D75c8YA@mail.gmail.com>
        <d9a08687-0225-407f-dff0-f7f440786654@turmel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, 3 Sep 2019 09:39:37 -0400
Phil Turmel <philip@turmel.org> wrote:

> > [ 7234.974190] perf: interrupt took too long (2517 > 2500), lowering
> > kernel.perf_event_max_sample_rate to 79400
> 
> Uhm?  Why are you running perf during this reshape?

See: https://bugzilla.redhat.com/show_bug.cgi?id=1013708#c7

This is not caused by running the userland "perf" tool. Happens on a few of my
machines too, shortly after each reboot. I guess you don't check dmesg often
enough, probably on yours too.

[ 1206.767374] perf: interrupt took too long (2510 > 2500), lowering kernel.perf_event_max_sample_rate to 79500
[ 1789.980074] perf: interrupt took too long (3142 > 3137), lowering kernel.perf_event_max_sample_rate to 63500
[ 3035.068060] perf: interrupt took too long (3932 > 3927), lowering kernel.perf_event_max_sample_rate to 50750
[71733.436153] perf: interrupt took too long (4924 > 4915), lowering kernel.perf_event_max_sample_rate to 40500

-- 
With respect,
Roman
