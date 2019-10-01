Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45C6FC415E
	for <lists+linux-raid@lfdr.de>; Tue,  1 Oct 2019 21:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfJATzP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 1 Oct 2019 15:55:15 -0400
Received: from arcturus.uberspace.de ([185.26.156.30]:54988 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfJATzO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 1 Oct 2019 15:55:14 -0400
Received: (qmail 13688 invoked from network); 1 Oct 2019 19:55:11 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 1 Oct 2019 19:55:11 -0000
Date:   Tue, 1 Oct 2019 21:55:10 +0200
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     "David F." <df7729@gmail.com>
Cc:     "David C. Rankin" <drankinatty@suddenlinkmail.com>,
        mdraid <linux-raid@vger.kernel.org>
Subject: Re: Fix for fd0 and sr0 in /proc/partitions
Message-ID: <20191001195510.GA33475@metamorpher.de>
References: <CAGRSmLs+nyQ0pp_VPt36MxXDqumcyqLSR_vhkOqtFXir18puEA@mail.gmail.com>
 <20190930101443.GA2751@metamorpher.de>
 <6026f55f-82c9-7b99-8c2b-8d03dfe8f52e@suddenlinkmail.com>
 <CAGRSmLvHc-gOVmr-fHTo0upUeDNjrQgCk9rSqpALFV1FiHra+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGRSmLvHc-gOVmr-fHTo0upUeDNjrQgCk9rSqpALFV1FiHra+g@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Oct 01, 2019 at 11:59:14AM -0700, David F. wrote:
> mdadm shouldn't be scanning fd0 or sr0 by default

First of all I apologize, it's my misunderstanding completely. 
For some reason I thought you wanted it removed from /proc/partitions...

For mdadm, there are plenty of devices it should not touch. 
Such as device mapper, network block device, and md devices. 
Well, that applies for my system anyway.

Hence my mdadm.conf restricts it to /dev/sd* /dev/loop* 
And loop devices are only included because I like to 
experiment with those.

Since it can be configured I never had an issue with it, 
so not sure what the default should be.

Regards
Andreas Klauer
