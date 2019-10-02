Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB26C47E7
	for <lists+linux-raid@lfdr.de>; Wed,  2 Oct 2019 08:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfJBGqC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 2 Oct 2019 02:46:02 -0400
Received: from rin.romanrm.net ([91.121.75.85]:51302 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfJBGqC (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 2 Oct 2019 02:46:02 -0400
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 1FD3C2027E;
        Wed,  2 Oct 2019 06:45:59 +0000 (UTC)
Date:   Wed, 2 Oct 2019 11:45:59 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Andreas Klauer <Andreas.Klauer@metamorpher.de>
Cc:     "David F." <df7729@gmail.com>,
        "David C. Rankin" <drankinatty@suddenlinkmail.com>,
        mdraid <linux-raid@vger.kernel.org>
Subject: Re: Fix for fd0 and sr0 in /proc/partitions
Message-ID: <20191002114559.5cf6ea4a@natsu>
In-Reply-To: <20191001195510.GA33475@metamorpher.de>
References: <CAGRSmLs+nyQ0pp_VPt36MxXDqumcyqLSR_vhkOqtFXir18puEA@mail.gmail.com>
        <20190930101443.GA2751@metamorpher.de>
        <6026f55f-82c9-7b99-8c2b-8d03dfe8f52e@suddenlinkmail.com>
        <CAGRSmLvHc-gOVmr-fHTo0upUeDNjrQgCk9rSqpALFV1FiHra+g@mail.gmail.com>
        <20191001195510.GA33475@metamorpher.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, 1 Oct 2019 21:55:10 +0200
Andreas Klauer <Andreas.Klauer@metamorpher.de> wrote:

> For mdadm, there are plenty of devices it should not touch. 
> Such as device mapper

Some setup may require (or prefer) MD RAID of LVM LVs, not to mention of
encrypted devices.

> network block device

RAID1 of a couple of remote storage nodes sounds like something which could
be useful as well.

> and md devices. 

RAID6 where one or multiple members of it are themselves RAID0 of smaller
devices has been discussed earlier on this list and elsewhere.

> Well, that applies for my system anyway.

Good clarification!

-- 
With respect,
Roman
