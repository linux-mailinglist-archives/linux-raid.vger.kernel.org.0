Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EFB1DDB51
	for <lists+linux-raid@lfdr.de>; Fri, 22 May 2020 01:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgEUXxk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 May 2020 19:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgEUXxk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 21 May 2020 19:53:40 -0400
Received: from u17383850.onlinehome-server.com (u17383850.onlinehome-server.com [IPv6:2607:f1c0:83f:ac00::a6:f62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D1E4C061A0E
        for <linux-raid@vger.kernel.org>; Thu, 21 May 2020 16:53:40 -0700 (PDT)
Received: by u17383850.onlinehome-server.com (Postfix, from userid 5001)
        id 07648767; Thu, 21 May 2020 19:53:38 -0400 (EDT)
Date:   Thu, 21 May 2020 19:53:38 -0400
From:   David T-G <davidtg-robot@justpickone.org>
To:     Linux RAID list <linux-raid@vger.kernel.org>
Subject: Re: re-add syntax
Message-ID: <20200521235338.GV1415@justpickone.org>
References: <20200521110139.GW1711@justpickone.org>
 <20200521112421.GK1415@justpickone.org>
 <5EC66D4E.8070708@youngman.org.uk>
 <20200521123306.GO1415@justpickone.org>
 <828a3b59-f79c-a205-3e1e-83e34ae93eac@youngman.org.uk>
 <20200521131500.GP1415@justpickone.org>
 <20200521180700.GT1415@justpickone.org>
 <CAAMCDecB+CU-EGtx+4bMPKBYcy65sgT-8MW=s=OeviyZeq6URA@mail.gmail.com>
 <20200521225230.GU1415@justpickone.org>
 <48fe44c5-f43e-3167-fd08-077dfc429cf2@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48fe44c5-f43e-3167-fd08-077dfc429cf2@youngman.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Wol, et al --

...and then antlists said...
% 
% On 21/05/2020 23:52, David T-G wrote:
% >
...
% >
% >I've wondered about an internal bitmap vs not.  I also wonder how big the
% >bitmap is and where else I might stick it ...
% 
% Bear in mind the bitmap is obsolete ... I need to get my head round
% it, but you should upgrade from bitmap to journal ... amongst other
[snip]

Ahhhhh...  Very good to know!  Thanks.


HANW

:-D
-- 
David T-G
See http://justpickone.org/davidtg/email/
See http://justpickone.org/davidtg/tofu.txt

