Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD79E1DDA8F
	for <lists+linux-raid@lfdr.de>; Fri, 22 May 2020 00:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbgEUWwc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 May 2020 18:52:32 -0400
Received: from u17383850.onlinehome-server.com ([74.208.250.170]:42030 "EHLO
        u17383850.onlinehome-server.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730041AbgEUWwc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 21 May 2020 18:52:32 -0400
Received: by u17383850.onlinehome-server.com (Postfix, from userid 5001)
        id BF415767; Thu, 21 May 2020 18:52:30 -0400 (EDT)
Date:   Thu, 21 May 2020 18:52:30 -0400
From:   David T-G <davidtg-robot@justpickone.org>
To:     Linux RAID list <linux-raid@vger.kernel.org>
Subject: Re: re-add syntax
Message-ID: <20200521225230.GU1415@justpickone.org>
References: <20200520235347.GF1415@justpickone.org>
 <5EC63745.1080602@youngman.org.uk>
 <20200521110139.GW1711@justpickone.org>
 <20200521112421.GK1415@justpickone.org>
 <5EC66D4E.8070708@youngman.org.uk>
 <20200521123306.GO1415@justpickone.org>
 <828a3b59-f79c-a205-3e1e-83e34ae93eac@youngman.org.uk>
 <20200521131500.GP1415@justpickone.org>
 <20200521180700.GT1415@justpickone.org>
 <CAAMCDecB+CU-EGtx+4bMPKBYcy65sgT-8MW=s=OeviyZeq6URA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAMCDecB+CU-EGtx+4bMPKBYcy65sgT-8MW=s=OeviyZeq6URA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Roger, et al --

...and then Roger Heflin said...
% 
% For re-add to work the array must have a bitmap, so that mdadm knows
% what parts of the disk need updating.
[snip]

Ahhhhh...  Thanks!

I've wondered about an internal bitmap vs not.  I also wonder how big the
bitmap is and where else I might stick it ...


HANW

:-D
-- 
David T-G
See http://justpickone.org/davidtg/email/
See http://justpickone.org/davidtg/tofu.txt

