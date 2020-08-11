Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475FC242129
	for <lists+linux-raid@lfdr.de>; Tue, 11 Aug 2020 22:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgHKUNm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 11 Aug 2020 16:13:42 -0400
Received: from rin.romanrm.net ([51.158.148.128]:42442 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgHKUNm (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 11 Aug 2020 16:13:42 -0400
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id CA75E432;
        Tue, 11 Aug 2020 20:13:40 +0000 (UTC)
Date:   Wed, 12 Aug 2020 01:13:40 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Rudy Zijlstra <rudy@grumpydevil.homelinux.org>
Cc:     Reindl Harald <h.reindl@thelounge.net>,
        George Rapp <george.rapp@gmail.com>,
        Linux-RAID <linux-raid@vger.kernel.org>
Subject: Re: Recommended filesystem for RAID 6
Message-ID: <20200812011340.609e378f@natsu>
In-Reply-To: <e662446e-33e4-81fa-18ab-516fd140d51a@grumpydevil.homelinux.org>
References: <CAF-KpgYcEF5juR9nFPifZunPPGW73kWVG9fjR3=WpufxXJcewg@mail.gmail.com>
        <20200811212305.02fec65a@natsu>
        <ea7232af-a411-6b16-d03e-6b21c14cc5be@thelounge.net>
        <20200812003305.6628dd6e@natsu>
        <e662446e-33e4-81fa-18ab-516fd140d51a@grumpydevil.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, 11 Aug 2020 21:49:07 +0200
Rudy Zijlstra <rudy@grumpydevil.homelinux.org> wrote:

> >> no raid can replace backups anyways
> > All too often I've seen RAID being used as an implicit excuse to be lenient
> > about backups. Heck, I know from personal experience how enticing that can be.
> Is the backup not automatic? in that case it is no backup.

Sure it's automatic, by lenient I meant starting to exclude parts of their
data set from being backed up, deciding what is "important" and what is not,
and for the latter portion just hoping for the best because "it is RAID after
all, I can lose TWO drives, what could possibly go wrong". And then something
goes wrong, and it turns out even the data that was "not important" is actually
important enough to warrant scrambling for how to recover it, because
reobtaining it turns out to be costly / huge effort / not actually possible
even if they thought it will be.

> You have simply chosen a different set of mistakes to make. Considering 
> you need to update the "what is where" list regularly (is that 
> automated?)

Of course. In fact I'd suggest keeping similar lists no matter which storage
setup you run. One thing worse than losing data, is losing data *and* not
remembering what you had on there in the first place :)

-- 
With respect,
Roman
