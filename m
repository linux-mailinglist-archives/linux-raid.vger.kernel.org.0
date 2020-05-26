Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F08A1DCCF3
	for <lists+linux-raid@lfdr.de>; Thu, 21 May 2020 14:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgEUMbA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 May 2020 08:31:00 -0400
Received: from u17383850.onlinehome-server.com ([74.208.250.170]:60364 "EHLO
        u17383850.onlinehome-server.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728037AbgEUMbA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 21 May 2020 08:31:00 -0400
Received: by u17383850.onlinehome-server.com (Postfix, from userid 5001)
        id 360AF767; Thu, 21 May 2020 08:30:59 -0400 (EDT)
Date:   Thu, 21 May 2020 08:30:59 -0400
From:   David T-G <davidtg-robot@justpickone.org>
To:     Linux RAID list <linux-raid@vger.kernel.org>
Cc:     Phil Turmel <philip@turmel.org>
Subject: Re: disks & prices plus python (was "Re: failed disks, mapper, and
 "Invalid argument"")
Message-ID: <20200521123059.GN1415@justpickone.org>
References: <20200520200514.GE1415@justpickone.org>
 <5EC5BBEF.7070002@youngman.org.uk>
 <20200520235347.GF1415@justpickone.org>
 <5EC63745.1080602@youngman.org.uk>
 <20200521110103.GG1415@justpickone.org>
 <5EC66C2E.90901@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5EC66C2E.90901@youngman.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Wol, et al --

...and then Wols Lists said...
% 
% On 21/05/20 12:01, David T-G wrote:
% > 
% > ...and then Wols Lists said...
% > % 
...
% > % 
% > % Seagate Barracudas :-(
% > 
% > Yep.  They were good "back in the day" ...
% 
% Still are. Just not for raid..

Oh!  Well, that's nice to know.  Of course, I had been hoping to move
these out to another system after upgrading to larger, but maybe that's
not an option :-(  They are going to be worlds better than the existing
crap drives in there now, though, so here's hoping I can put them to use.


% > 
...
% > % recovery. Plan to replace them with ones that do ASAP!
% > 
% > That would be nice.  I actually have wanted for quite some time
% > to grow these from 4T to 8T, but budget hasn't permitted.  Got any
% > particularly-affordable recommendations?
% 
% 8TB WD Reds are still CMR and okay AT THE MOMENT. I wouldn't trust them
% though (or make sure you can RMA them if they've changed!)

Thanks!


% 
% I haven't heard of Ironwolves using SMR (yet).
% 
% Looking quickly on Amazon
% WD Red 8TB                  �232
% Toshiba N300 8TB            �239
% Seagate Ironwolf 8TB        �260
% Seagate Ironwolf 8TB Silver �263 (optimised for raid it claims)
% WD Red 8TB Pro              �270
% Seagate Ironwolf 8TB Pro    �360

Ouch.  I sure hope they're cheaper over here!  Unfortunately, when I was
shopping I was looking at ... Barracudas :-/


% 
% Given that the Red and the N300 are similar in price, I'd go for the
% N300. Bear in mind that I *never* see those drives mentioned here, I
% really don't know what they're like.

Thanks; I'll have a look.


% 
...
% > 
% > % rebuild, but I would VERY STRONGLY suggest you download lsdrv and get
% > % the output. The whole point of this script is to get the information you
% > 
% > You mean the output that is some error and a few lines of traceback?
% > Yeah, I saw that, but I don't know how to fix it.  Another problem in the
% > queue.
% 
% Last time I ran it, it was Python 2.7. I needed to edit the shebang
% line. I think Phil's fixed that.

I checked and I have 2.7 on this box, so I figure it would work.  But I
can barely spell Python, much less understand it.


Thanks again & HAND

:-D
-- 
David T-G
See http://justpickone.org/davidtg/email/
See http://justpickone.org/davidtg/tofu.txt

