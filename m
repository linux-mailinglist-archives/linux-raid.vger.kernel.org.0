Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB4134199
	for <lists+linux-raid@lfdr.de>; Wed,  8 Jan 2020 13:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgAHMZl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 Jan 2020 07:25:41 -0500
Received: from arcturus.uberspace.de ([185.26.156.30]:56972 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgAHMZk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 8 Jan 2020 07:25:40 -0500
Received: (qmail 14202 invoked from network); 8 Jan 2020 12:25:38 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 8 Jan 2020 12:25:38 -0000
Date:   Wed, 8 Jan 2020 13:25:38 +0100
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     Marco Heiming <myx00r@gmail.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: Raid 5 cannot be re-assembled after disk was removed
Message-ID: <20200108122538.GB16146@metamorpher.de>
References: <CAEWf3EDf-CwMz660RjRAtL==fa-Xc2XVpbrJL_Xqw24ZTZ18Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEWf3EDf-CwMz660RjRAtL==fa-Xc2XVpbrJL_Xqw24ZTZ18Zg@mail.gmail.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Jan 08, 2020 at 10:31:28AM +0100, Marco Heiming wrote:
>        0       8        0        -      spare   /dev/sda

Your spare was /dev/sda

> mdadm --examine /dev/sd[b-z]

Here you deliberately examine sdb-z, so what happened to sda?

You mentioned drive letters changed, but is it really not there anymore?

If you don't know which drives you synced in the array then who does...?

Regards
Andreas Klauer
