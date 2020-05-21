Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD5B1DCCF5
	for <lists+linux-raid@lfdr.de>; Thu, 21 May 2020 14:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgEUMdH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 May 2020 08:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgEUMdG (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 21 May 2020 08:33:06 -0400
Received: from u17383850.onlinehome-server.com (u17383850.onlinehome-server.com [IPv6:2607:f1c0:83f:ac00::a6:f62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1983C061A0E
        for <linux-raid@vger.kernel.org>; Thu, 21 May 2020 05:33:06 -0700 (PDT)
Received: by u17383850.onlinehome-server.com (Postfix, from userid 5001)
        id 2AC7B767; Thu, 21 May 2020 08:33:06 -0400 (EDT)
Date:   Thu, 21 May 2020 08:33:06 -0400
From:   David T-G <davidtg-robot@justpickone.org>
To:     Linux RAID list <linux-raid@vger.kernel.org>
Subject: re-add syntax (was "Re: failed disks, mapper, and "Invalid
 argument"")
Message-ID: <20200521123306.GO1415@justpickone.org>
References: <20200520200514.GE1415@justpickone.org>
 <5EC5BBEF.7070002@youngman.org.uk>
 <20200520235347.GF1415@justpickone.org>
 <5EC63745.1080602@youngman.org.uk>
 <20200521110139.GW1711@justpickone.org>
 <20200521112421.GK1415@justpickone.org>
 <5EC66D4E.8070708@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5EC66D4E.8070708@youngman.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

...and then Wols Lists said...
% 
% On 21/05/20 12:24, David T-G wrote:
% > Sure enough, there it is.  Yay.
% > 
% > Now ...  What do I do with the last drive?  Can I put it back in and let
% > it catch up, or should it reinitialize and build from scratch?
% 
% Can't remember the syntax, but there's a re-add option. If it can find
% and replay a log of failed updates, it will bring the drive straight
% back in. Otherwise it will rebuild from scratch.
% 
% That's probably the safest way - let mdadm choose the best option.

OK; yay.  I'm still confused, though, between "add" and "readd".  I'll
take any pointers to docs I can get.


% 
% Oh - and when you get your Ironwolves or whatever, read up on the
% replace option. Much the safest option.

THAT sounds familiar.  Thanks.


% 
% Cheers,
% Wol


HAND

:-D
-- 
David T-G
See http://justpickone.org/davidtg/email/
See http://justpickone.org/davidtg/tofu.txt

