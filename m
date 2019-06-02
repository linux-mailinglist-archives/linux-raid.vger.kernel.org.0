Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1DA9322E1
	for <lists+linux-raid@lfdr.de>; Sun,  2 Jun 2019 12:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfFBKHR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 2 Jun 2019 06:07:17 -0400
Received: from wie.mywh.net ([62.109.39.47]:43204 "EHLO wie.mywh.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfFBKHR (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 2 Jun 2019 06:07:17 -0400
X-Greylist: delayed 2677 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Jun 2019 06:07:16 EDT
Received: from [128.77.17.232] (port=40212 helo=[192.168.1.106])
        by wie.mywh.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <raid+list@olstad.com>)
        id 1hXMhG-0003bj-6c; Sun, 02 Jun 2019 11:22:35 +0200
Subject: Re: RAID-1 can (sometimes) be 3x faster than RAID-10
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     keld@keldix.com, linux-raid@vger.kernel.org
References: <20190529194136.GW4569@bitfolk.com>
 <6b34f202-65c4-b6f9-0ae1-cbb517c2b8f2@suse.com>
 <20190601053925.GO4569@bitfolk.com> <20190601085024.GA7575@www5.open-std.org>
 <2d01a882-0902-b7b6-a359-80e04a919aaa@thelounge.net>
 <20190601154302.GA27756@www5.open-std.org>
 <67a47528-541d-09ec-c9f9-560c382b6760@thelounge.net>
From:   Kai Stian Olstad <raid+list@olstad.com>
Message-ID: <63d9d11f-0107-8705-016e-54bf2428e1cb@olstad.com>
Date:   Sun, 2 Jun 2019 11:22:34 +0200
MIME-Version: 1.0
In-Reply-To: <67a47528-541d-09ec-c9f9-560c382b6760@thelounge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - wie.mywh.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - olstad.com
X-Get-Message-Sender-Via: wie.mywh.net: authenticated_id: postmaster@olstad.com
X-Authenticated-Sender: wie.mywh.net: postmaster@olstad.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 01.06.2019 18:03, Reindl Harald wrote:
> 
> problem is that you can't switch layouts and given that "near" is
> default when you setup a distribution with RAID10 in the installer you
> get that

Are you sure, in the mdadm man page it says the following about grow

Currently the supported changes include
* change the chunk-size and layout of RAID0, RAID4, RAID5, RAID6 and RAID10.


-- 
Kai Stian Olstad
