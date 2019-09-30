Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E216C1EDA
	for <lists+linux-raid@lfdr.de>; Mon, 30 Sep 2019 12:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfI3KV1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Sep 2019 06:21:27 -0400
Received: from arcturus.uberspace.de ([185.26.156.30]:54072 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbfI3KV1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Sep 2019 06:21:27 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Sep 2019 06:21:26 EDT
Received: (qmail 23920 invoked from network); 30 Sep 2019 10:14:44 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 30 Sep 2019 10:14:44 -0000
Date:   Mon, 30 Sep 2019 12:14:43 +0200
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     "David F." <df7729@gmail.com>
Cc:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Subject: Re: Fix for fd0 and sr0 in /proc/partitions
Message-ID: <20190930101443.GA2751@metamorpher.de>
References: <CAGRSmLs+nyQ0pp_VPt36MxXDqumcyqLSR_vhkOqtFXir18puEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGRSmLs+nyQ0pp_VPt36MxXDqumcyqLSR_vhkOqtFXir18puEA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sun, Sep 29, 2019 at 03:54:41PM -0700, David F. wrote:
> So /proc/partitions can have floppy and optical drives on it.

And people might rely on that so removing it is the wrong approach.

What does your mdadm.conf look like, DEVICE devices?

Regards
Andreas Klauer
