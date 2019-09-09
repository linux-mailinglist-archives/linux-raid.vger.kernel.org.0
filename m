Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935E7AD212
	for <lists+linux-raid@lfdr.de>; Mon,  9 Sep 2019 04:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbfIIC6d (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 8 Sep 2019 22:58:33 -0400
Received: from hoggar.fisica.ufpr.br ([200.238.171.242]:38222 "EHLO
        hoggar.fisica.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731568AbfIIC6d (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 8 Sep 2019 22:58:33 -0400
Received: by hoggar.fisica.ufpr.br (Postfix, from userid 577)
        id 7FDC0362018A; Sun,  8 Sep 2019 23:58:30 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=fisica.ufpr.br;
        s=201705; t=1567997910;
        bh=jgua7LHYTxsv4cyAuOnQEwN+S0BtJ/ycbBsXSFl2PQI=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=g11XfPBPnpE2Cx7KnYMpQiaeuFdfvO6nBCL3R0tDKhLFQy/90y/hP6d+50FHS15cR
         kF/96J8oVPqXXWU8T0gf91zL7lo1TL1GRqPHGMyYurS1tGOWqka+qtuUEpC4Rj3k6T
         gDV55EfI8lQ1xaUfy4gJVMEB5oOaUvaa88sNyhqgwDEpHzwlanv8Oey/wZJ+T/mheG
         /vZiCwUXU5whDgI5Xoyf18jnEcdRpa0+TnbbaCP9JD398Xqkd8Z0pH+8UHPKxxmXNm
         4gXX9HBmdWen8ylX/1wobTM7aXvsoporlGA2EUqibXY5v+htiAa3NMDtO3cDVMgukD
         RTWz0l9uFGmAw==
Date:   Sun, 8 Sep 2019 23:58:30 -0300
From:   Carlos Carvalho <carlos@fisica.ufpr.br>
To:     linux-raid@vger.kernel.org
Subject: [SOLVED] Re: --add-journal not working with 5.2.13??!!
Message-ID: <20190909025830.GA1484@fisica.ufpr.br>
References: <20190909013326.GA31505@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190909013326.GA31505@fisica.ufpr.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

To linux-raid@vger.kernel.org (carlos@fisica.ufpr.br) wrote on Sun, Sep 08, 2019 at 10:33:26PM -03:
> What am I missing?

This message in the log: md/raid:md0: array cannot have both journal and bitmap

Removing the bitmap everything works. I was watching the log with tail but it
scrolled up because of the many disks added and I didn't see it :-( Sorry for
the noise.
