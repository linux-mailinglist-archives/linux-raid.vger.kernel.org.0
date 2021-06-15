Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251443A783D
	for <lists+linux-raid@lfdr.de>; Tue, 15 Jun 2021 09:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFOHtD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 15 Jun 2021 03:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhFOHtB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 15 Jun 2021 03:49:01 -0400
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E7FC061574
        for <linux-raid@vger.kernel.org>; Tue, 15 Jun 2021 00:46:57 -0700 (PDT)
Received: from natsu (natsu2.home.romanrm.net [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 23A09768;
        Tue, 15 Jun 2021 07:46:53 +0000 (UTC)
Date:   Tue, 15 Jun 2021 12:46:52 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Leslie Rhorer <lesrhorer@att.net>
Cc:     Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: Recover from crash in RAID6 due to hardware failure
Message-ID: <20210615124652.79380de9@natsu>
In-Reply-To: <f07a1c5e-b2ed-cff6-e4e3-1f4956a68c3d@att.net>
References: <bd617822-79bd-ce40-f50e-21d482570324@gmail.com>
        <4745ddd9-291b-00c7-8678-cac14905c188@att.net>
        <ed21aa89-e6a1-651d-cc23-9f4c72cf63e0@gmail.com>
        <f07a1c5e-b2ed-cff6-e4e3-1f4956a68c3d@att.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, 14 Jun 2021 20:36:22 -0500
Leslie Rhorer <lesrhorer@att.net> wrote:

> Oops!  'Sorry.  That should be:
> 
> mdadm -S /dev/md2
> mdadm -C -f -e 1.2 -n 5 -c 64K --level=6 -p left-symmetric /dev/md2 
> /dev/sda3 /dev/sdb3 /dev/sdc3 /dev/sdd3 /dev/sde3
> 
> 
> 	You only have five disks, not six.

No --assume-clean?

-- 
With respect,
Roman
