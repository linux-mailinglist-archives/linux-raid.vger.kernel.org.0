Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3554DE77C
	for <lists+linux-raid@lfdr.de>; Sat, 19 Mar 2022 11:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbiCSKr3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 19 Mar 2022 06:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiCSKr2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 19 Mar 2022 06:47:28 -0400
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CAE269A5F
        for <linux-raid@vger.kernel.org>; Sat, 19 Mar 2022 03:46:03 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id 3CEF8674;
        Sat, 19 Mar 2022 10:46:00 +0000 (UTC)
Date:   Sat, 19 Mar 2022 15:45:59 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-raid@vger.kernel.org
Subject: Re: new drive is 4 sectors shorter, can it be used for swraid5
 array?
Message-ID: <20220319154559.09f649e4@nvm>
In-Reply-To: <20220318173007.3ad9348c@nvm>
References: <20220318030855.GV3131742@merlins.org>
 <20220318173007.3ad9348c@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, 18 Mar 2022 17:30:07 +0500
Roman Mamedov <rm@romanrm.net> wrote:

> However there should not be such size difference in the first place

If we look closely though, there actually doesn't appear to be:

> On Thu, 17 Mar 2022 20:08:55 -0700
> Marc MERLIN <marc@merlins.org> wrote:
> 
> > old drive:
> > User Capacity:    6,001,175,126,016 bytes [6.00 TB]
> > 
> > new drive:
> > User Capacity:    6,001,175,126,016 bytes [6.00 TB]

As for...

> >    8      128 5860522584 sdi
> >    8      129 5860521543 sdi1
> >
> >    8      160 5860522580 sdk
> >    8      161 5860521536 sdk1

Which tool returns this output?

What do you get for 

  blockdev --getsize64 /dev/sdi
  blockdev --getsize64 /dev/sdk

If this returns the same size for both, wipe a few first MB the new drive with
zeroes using dd, and try a different partitioning tool.

-- 
With respect,
Roman
