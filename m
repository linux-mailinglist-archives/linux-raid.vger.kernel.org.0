Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A0B12B40C
	for <lists+linux-raid@lfdr.de>; Fri, 27 Dec 2019 11:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfL0KnH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 27 Dec 2019 05:43:07 -0500
Received: from arcturus.uberspace.de ([185.26.156.30]:35062 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfL0KnH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 27 Dec 2019 05:43:07 -0500
Received: (qmail 19058 invoked from network); 27 Dec 2019 10:43:04 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 27 Dec 2019 10:43:04 -0000
Date:   Fri, 27 Dec 2019 11:43:02 +0100
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     Patrick Pearcy <patrick.pearcy@gmail.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: WD MyCloud PR4100 RAID Failure
Message-ID: <20191227104302.GA4173@metamorpher.de>
References: <CAM-0FgP5dXnTbri-wB-2LJU-QE5wd9nsq=kzMW9kXND=wF=z8w@mail.gmail.com>
 <20191217182509.GA16121@metamorpher.de>
 <CAM-0FgOpi4EGuhM7DXSutRtxRSJ4nb9kLzM0U_3LZi-jxUDVWQ@mail.gmail.com>
 <20191222130452.GA2580@metamorpher.de>
 <20191222134019.GA3770@metamorpher.de>
 <CAM-0FgNegq5Ujd=K9Rjk-Vi9Y2zzb1U3YXScs6MxrDbC2xmbeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM-0FgNegq5Ujd=K9Rjk-Vi9Y2zzb1U3YXScs6MxrDbC2xmbeg@mail.gmail.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Dec 26, 2019 at 02:19:15PM -0500, Patrick Pearcy wrote:
> Any suggestions??

I don't have this system so I don't know how it considers its RAID arrays. 
It might be something very simple (like wrong UUID in mdadm.conf after 
re-create, which you might find on the RAID1 partition) or it might be 
something more involved. You could also check dmesg for error messages.

Either way I can't really comment, you might need someone 
more familiar with this device in particular.

Regards
Andreas Klauer
