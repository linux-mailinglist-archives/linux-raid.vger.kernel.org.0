Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088B11DCC83
	for <lists+linux-raid@lfdr.de>; Thu, 21 May 2020 14:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgEUMAR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 May 2020 08:00:17 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:41002 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729050AbgEUMAR (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 21 May 2020 08:00:17 -0400
Received: from [81.154.111.47] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jbjrz-0006Np-A9; Thu, 21 May 2020 13:00:15 +0100
Subject: Re: failed disks, mapper, and "Invalid argument"
To:     David T-G <davidtg-robot@justpickone.org>,
        Linux RAID list <linux-raid@vger.kernel.org>
References: <20200520200514.GE1415@justpickone.org>
 <5EC5BBEF.7070002@youngman.org.uk> <20200520235347.GF1415@justpickone.org>
 <5EC63745.1080602@youngman.org.uk> <20200521110139.GW1711@justpickone.org>
 <20200521112421.GK1415@justpickone.org>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5EC66D4E.8070708@youngman.org.uk>
Date:   Thu, 21 May 2020 13:00:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20200521112421.GK1415@justpickone.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 21/05/20 12:24, David T-G wrote:
> Sure enough, there it is.  Yay.
> 
> Now ...  What do I do with the last drive?  Can I put it back in and let
> it catch up, or should it reinitialize and build from scratch?

Can't remember the syntax, but there's a re-add option. If it can find
and replay a log of failed updates, it will bring the drive straight
back in. Otherwise it will rebuild from scratch.

That's probably the safest way - let mdadm choose the best option.

Oh - and when you get your Ironwolves or whatever, read up on the
replace option. Much the safest option.

Cheers,
Wol
