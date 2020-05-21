Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57DB1DD5A9
	for <lists+linux-raid@lfdr.de>; Thu, 21 May 2020 20:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgEUSHB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 May 2020 14:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgEUSHB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 21 May 2020 14:07:01 -0400
Received: from u17383850.onlinehome-server.com (u17383850.onlinehome-server.com [IPv6:2607:f1c0:83f:ac00::a6:f62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E720EC061A0E
        for <linux-raid@vger.kernel.org>; Thu, 21 May 2020 11:07:00 -0700 (PDT)
Received: by u17383850.onlinehome-server.com (Postfix, from userid 5001)
        id 60BDB767; Thu, 21 May 2020 14:07:00 -0400 (EDT)
Date:   Thu, 21 May 2020 14:07:00 -0400
From:   David T-G <davidtg-robot@justpickone.org>
To:     Linux RAID list <linux-raid@vger.kernel.org>
Subject: Re: re-add syntax
Message-ID: <20200521180700.GT1415@justpickone.org>
References: <20200520200514.GE1415@justpickone.org>
 <5EC5BBEF.7070002@youngman.org.uk>
 <20200520235347.GF1415@justpickone.org>
 <5EC63745.1080602@youngman.org.uk>
 <20200521110139.GW1711@justpickone.org>
 <20200521112421.GK1415@justpickone.org>
 <5EC66D4E.8070708@youngman.org.uk>
 <20200521123306.GO1415@justpickone.org>
 <828a3b59-f79c-a205-3e1e-83e34ae93eac@youngman.org.uk>
 <20200521131500.GP1415@justpickone.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521131500.GP1415@justpickone.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi, all --

...and then davidtg-robot@justpickone.org said...
% 
% ...and then antlists said...
% % 
% % So *you* should choose re-add. Let mdadm choose add if it can't do a re-add.
% 
% Thanks.  Sooooo ...  Given this
...
% does this
% 
%   mdadm --manage /dev/md0 --re-add /dev/sdd1
% 
% look like the right next step?

Perhaps it did, but it wasn't to be:

  diskfarm:root:10:~> mdadm --manage /dev/md0 --re-add /dev/sdd1
  mdadm: --re-add for /dev/sdd1 to /dev/md0 is not possible

So we'll try "add"

  diskfarm:root:10:~> mdadm --manage /dev/md0 --add /dev/sdd1
  mdadm: added /dev/sdd1

and now we wait :-)


Thanks again to all

:-D
-- 
David T-G
See http://justpickone.org/davidtg/email/
See http://justpickone.org/davidtg/tofu.txt

