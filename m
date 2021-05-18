Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81853388045
	for <lists+linux-raid@lfdr.de>; Tue, 18 May 2021 21:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbhERTDt (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 18 May 2021 15:03:49 -0400
Received: from mail.thelounge.net ([91.118.73.15]:60427 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhERTDs (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 18 May 2021 15:03:48 -0400
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4Fl53S6qB4zXN3;
        Tue, 18 May 2021 21:02:28 +0200 (CEST)
To:     Phillip Susi <phill@thesusis.net>
Cc:     Wols Lists <antlists@youngman.org.uk>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Linux Raid <linux-raid@vger.kernel.org>
References: <CAC6SzHJLG=0_URJUsgQshpk-QLh6b8SBJDrfxiNg4wikQw4uyw@mail.gmail.com>
 <2140221131.2872520.1620837067395.JavaMail.zimbra@karlsbakk.net>
 <87a6oyr64b.fsf@vps.thesusis.net>
 <3f3fd663-77e4-8c23-eb22-1b8223eaf277@turmel.org>
 <87y2ch4c3w.fsf@vps.thesusis.net>
 <947223877.4161967.1621003717636.JavaMail.zimbra@karlsbakk.net>
 <87cztpm68z.fsf@vps.thesusis.net> <60A2EC87.9080701@youngman.org.uk>
 <874kf0yq31.fsf@vps.thesusis.net>
 <b27c2f22-a88e-520f-57ef-bc84afb938c3@thelounge.net>
 <87wnrvdg4n.fsf@vps.thesusis.net>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Subject: Re: raid10 redundancy
Message-ID: <ae729a44-b3fb-48ef-617a-6ba9efaffec7@thelounge.net>
Date:   Tue, 18 May 2021 21:02:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87wnrvdg4n.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 18.05.21 um 20:51 schrieb Phillip Susi:
> 
> Reindl Harald writes:
> 
>> it's common sense that additional load on drives which have the same
>> history makes a failure one one of them more likely
> 
> "It's common sense" = the logical fallacy of hand waving.  Show me
> statistical evidence.  I have had lightly loaded drives die in under 2
> years and heavily loaded ones last 10 years.  I have replaced failed
> drives in a raid and the other drives with essentially the same wear on
> them lasted for years without another failure.  There does not appear to
> be a strong correlation usage and drive failure.  Certainly not one that
> is so strong that you can claim with a straight face that after the
> first failure, a second one can be expected within X IOPS, and the IOPS
> needed to rebuild the array are a significant fraction of X

do what you want - others like to be better safe then sorry especially 
when there is no longer redundancy and you don't surive any error until 
the rebuild is finished

and yes i replaced last week a 365/24 for years running Seagate *desktop 
drive* in a RAID10 with 50k power up hours but that don't imply that you 
can expect that
