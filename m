Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F051DCD9E
	for <lists+linux-raid@lfdr.de>; Thu, 21 May 2020 15:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgEUNBK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 May 2020 09:01:10 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:59562 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729418AbgEUNBK (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 21 May 2020 09:01:10 -0400
Received: from [81.154.111.47] (helo=[192.168.1.225])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jbkou-0007sU-5O; Thu, 21 May 2020 14:01:08 +0100
Subject: Re: re-add syntax (was "Re: failed disks, mapper, and "Invalid
 argument"")
To:     David T-G <davidtg-robot@justpickone.org>,
        Linux RAID list <linux-raid@vger.kernel.org>
References: <20200520200514.GE1415@justpickone.org>
 <5EC5BBEF.7070002@youngman.org.uk> <20200520235347.GF1415@justpickone.org>
 <5EC63745.1080602@youngman.org.uk> <20200521110139.GW1711@justpickone.org>
 <20200521112421.GK1415@justpickone.org> <5EC66D4E.8070708@youngman.org.uk>
 <20200521123306.GO1415@justpickone.org>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <828a3b59-f79c-a205-3e1e-83e34ae93eac@youngman.org.uk>
Date:   Thu, 21 May 2020 14:01:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521123306.GO1415@justpickone.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 21/05/2020 13:33, David T-G wrote:
> % Can't remember the syntax, but there's a re-add option. If it can find
> % and replay a log of failed updates, it will bring the drive straight
> % back in. Otherwise it will rebuild from scratch.
> %
> % That's probably the safest way - let mdadm choose the best option.
> 
> OK; yay.  I'm still confused, though, between "add" and "readd".  I'll
> take any pointers to docs I can get.

Add just adds the drive back and rebuilds it.

Readd will play a journal if it can. If it can't, it will fall back and 
do an add.

So *you* should choose re-add. Let mdadm choose add if it can't do a re-add.

Cheers,
Wol
