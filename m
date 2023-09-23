Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859517AC12F
	for <lists+linux-raid@lfdr.de>; Sat, 23 Sep 2023 13:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjIWLZK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 23 Sep 2023 07:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjIWLZK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 23 Sep 2023 07:25:10 -0400
Received: from len.romanrm.net (len.romanrm.net [IPv6:2001:41d0:1:8b3b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF35198
        for <linux-raid@vger.kernel.org>; Sat, 23 Sep 2023 04:25:03 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by len.romanrm.net (Postfix) with SMTP id C63FC40123;
        Sat, 23 Sep 2023 11:25:00 +0000 (UTC)
Date:   Sat, 23 Sep 2023 16:24:49 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Joel Parthemore <joel@parthemores.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: request for help on IMSM-metadata RAID-5 array
Message-ID: <20230923162449.3ea0d586@nvm>
In-Reply-To: <507b6ab0-fd8f-d770-ba82-28def5f53d25@parthemores.com>
References: <507b6ab0-fd8f-d770-ba82-28def5f53d25@parthemores.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sat, 23 Sep 2023 12:54:52 +0200
Joel Parthemore <joel@parthemores.com> wrote:

> the RAID array looking seemingly okay (according to mdadm -D) BUT this 
> time, any attempt to access the RAID array or even just stop the array 
> (mdadm --stop /dev/md126, mdadm --stop /dev/md127) once it was started 
> would cause the RAID array to lock up. That means (I think) that I can't 
> create an image of the array contents using dd, which is what -- of 
> course -- I should have done in the first place. (I could assemble the 
> RAID array read-only, but the RAID array is out of sync because it 
> didn't shut down properly.)

Does accessing the array also lock up when it's assembled read-only?

The out-of-sync should not be a great issue, because only a tiny portion that
was being written at the time of crash would be out of sync. The rest should be
fine, and you could try backing up your important data.

If #1 is yes, then try a different distro with a newer kernel version.

-- 
With respect,
Roman
