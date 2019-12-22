Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCF96128E41
	for <lists+linux-raid@lfdr.de>; Sun, 22 Dec 2019 14:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfLVNkW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 22 Dec 2019 08:40:22 -0500
Received: from arcturus.uberspace.de ([185.26.156.30]:46050 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfLVNkV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 22 Dec 2019 08:40:21 -0500
Received: (qmail 20597 invoked from network); 22 Dec 2019 13:40:19 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 22 Dec 2019 13:40:19 -0000
Date:   Sun, 22 Dec 2019 14:40:19 +0100
From:   Andreas Klauer <Andreas.Klauer@metamorpher.de>
To:     Patrick Pearcy <patrick.pearcy@gmail.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: WD MyCloud PR4100 RAID Failure
Message-ID: <20191222134019.GA3770@metamorpher.de>
References: <CAM-0FgP5dXnTbri-wB-2LJU-QE5wd9nsq=kzMW9kXND=wF=z8w@mail.gmail.com>
 <20191217182509.GA16121@metamorpher.de>
 <CAM-0FgOpi4EGuhM7DXSutRtxRSJ4nb9kLzM0U_3LZi-jxUDVWQ@mail.gmail.com>
 <20191222130452.GA2580@metamorpher.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191222130452.GA2580@metamorpher.de>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sun, Dec 22, 2019 at 02:04:52PM +0100, Andreas Klauer wrote:
>        truncate -s $((15619661440)) "$disk".img

whoops, should be $((15619661440*512))
