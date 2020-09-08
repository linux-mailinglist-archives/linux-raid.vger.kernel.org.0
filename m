Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93477261E82
	for <lists+linux-raid@lfdr.de>; Tue,  8 Sep 2020 21:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbgIHTwd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 8 Sep 2020 15:52:33 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:23280 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730700AbgIHPtc (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 8 Sep 2020 11:49:32 -0400
Received: from host86-136-163-47.range86-136.btcentralplus.com ([86.136.163.47] helo=[192.168.1.64])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1kFekR-0001Z9-Et; Tue, 08 Sep 2020 15:37:27 +0100
Subject: Re: [PATCH 11/19] gdrom: use bdev_check_media_change
To:     Christoph Hellwig <hch@lst.de>
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-12-hch@lst.de>
 <0b8fa1fe-f2d5-bf18-2e8a-ad13e343629d@youngman.org.uk>
 <20200908142334.GA7344@lst.de>
Cc:     linux-raid <linux-raid@vger.kernel.org>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5F579727.3080706@youngman.org.uk>
Date:   Tue, 8 Sep 2020 15:37:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20200908142334.GA7344@lst.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 08/09/20 15:23, Christoph Hellwig wrote:
> On Wed, Sep 02, 2020 at 11:00:05PM +0100, antlists wrote:
>> On 02/09/2020 15:12, Christoph Hellwig wrote:
>>> The GD-ROM driver does not have a ->revalidate_disk method, so it can
>>       ^^ (sic)
> 
> No, this really is the GD-ROM and not the CD-ROM driver!
> 
Wow. I had to Google to find out what it was.

That says it's proprietary Sega/Nintendo, so dare I suggest you change
that to "Sega GD-ROM" or similar to avoid other clueless people like me
jumping on it?

Cheers,
Wol
