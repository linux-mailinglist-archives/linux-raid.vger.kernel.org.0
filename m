Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADAE242133
	for <lists+linux-raid@lfdr.de>; Tue, 11 Aug 2020 22:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgHKURg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Aug 2020 16:17:36 -0400
Received: from mail.thelounge.net ([91.118.73.15]:31759 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKURf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 11 Aug 2020 16:17:35 -0400
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4BR3zK5RGVzXNr;
        Tue, 11 Aug 2020 22:17:33 +0200 (CEST)
Subject: Re: Recommended filesystem for RAID 6
To:     Roman Mamedov <rm@romanrm.net>,
        Rudy Zijlstra <rudy@grumpydevil.homelinux.org>
Cc:     George Rapp <george.rapp@gmail.com>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <CAF-KpgYcEF5juR9nFPifZunPPGW73kWVG9fjR3=WpufxXJcewg@mail.gmail.com>
 <20200811212305.02fec65a@natsu>
 <ea7232af-a411-6b16-d03e-6b21c14cc5be@thelounge.net>
 <20200812003305.6628dd6e@natsu>
 <e662446e-33e4-81fa-18ab-516fd140d51a@grumpydevil.homelinux.org>
 <20200812011340.609e378f@natsu>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <b183f155-cec4-f02b-ab9a-d422d39b3b6e@thelounge.net>
Date:   Tue, 11 Aug 2020 22:17:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812011340.609e378f@natsu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 11.08.20 um 22:13 schrieb Roman Mamedov:
> On Tue, 11 Aug 2020 21:49:07 +0200
> Rudy Zijlstra <rudy@grumpydevil.homelinux.org> wrote:
> 
>> You have simply chosen a different set of mistakes to make. Considering 
>> you need to update the "what is where" list regularly (is that 
>> automated?)
> 
> Of course. In fact I'd suggest keeping similar lists no matter which storage
> setup you run. One thing worse than losing data, is losing data *and* not
> remembering what you had on there in the first place :)

if you don't remember and don't miss anything everything is fine

however, what is that difficult running a RAID and a rsync cronjob for
backup everything?

data without backup are lost data, you just don#t know the pont in time
and in that case i prefer delete them now
