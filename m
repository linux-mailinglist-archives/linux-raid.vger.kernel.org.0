Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F17A119FA19
	for <lists+linux-raid@lfdr.de>; Mon,  6 Apr 2020 18:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgDFQ1V (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 6 Apr 2020 12:27:21 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:65223 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbgDFQ1U (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 6 Apr 2020 12:27:20 -0400
Received: from [81.153.42.4] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jLUak-0001FO-C3; Mon, 06 Apr 2020 17:27:18 +0100
Subject: Re: Raid-6 cannot reshape
To:     Roger Heflin <rogerheflin@gmail.com>,
        Alexander Shenkin <al@shenkin.org>
References: <24a0ef04-46a9-13ee-b8cb-d1a0a5b939fb@shenkin.org>
 <6b9b6d37-6325-6515-f693-0ff3b641a67a@shenkin.org>
 <3135fb29-cfaa-d8ac-264d-fd3110217370@shenkin.org>
 <CAAMCDecyr4R_z3-E8HYwYM4CyQtAY_nBmXdvvMkTgZCcCp7MjQ@mail.gmail.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5E8B5865.9060107@youngman.org.uk>
Date:   Mon, 6 Apr 2020 17:27:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <CAAMCDecyr4R_z3-E8HYwYM4CyQtAY_nBmXdvvMkTgZCcCp7MjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 06/04/20 17:12, Roger Heflin wrote:
> When I looked at your detailed files you sent a few days ago, all of
> the reshapes (on all disks) indicated that they were at position 0, so
> it kind of appears that the reshape never actually started at all and
> hung immediately which is probably why it cannot find the critical
> section, it hung prior to that getting done.   Not entirely sure how
> to undo a reshape that failed like this.

This seems quite common. Search the archives - it's probably something
like --assemble --revert-reshape.

Cheers,
Wol
