Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3283C1A2FEA
	for <lists+linux-raid@lfdr.de>; Thu,  9 Apr 2020 09:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgDIHTr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Apr 2020 03:19:47 -0400
Received: from smtp1.servermx.com ([134.19.178.79]:57796 "EHLO
        smtp1.servermx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgDIHTr (ORCPT
        <rfc822;linux-raid@vger.kernel.ORG>); Thu, 9 Apr 2020 03:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=servermx.com; s=servermx; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pJA5S3uMrd/xKxvQk4j4/vG8W0EzVdXiWip1yMc1Jts=; b=DHdjlx2jYPCGmPavRHZk5Yykj
        tMKiN149/cHtUumy9II4e6daKqabvVwonOx9v2OGTngoDabmZ1Ww1T3Ac8+scpy4sEYtG7UWVhW+l
        Y+w+yl/kAjUyqh0xb5F/pKFQLxX/2EnJQyi+rl2HOtsW5UOwruDu0fXGYjkh3knWhP8T4=;
Received: by exim4; Thu, 09 Apr 2020 09:19:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=servermx.com; s=servermx; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pJA5S3uMrd/xKxvQk4j4/vG8W0EzVdXiWip1yMc1Jts=; b=DHdjlx2jYPCGmPavRHZk5Yykj
        tMKiN149/cHtUumy9II4e6daKqabvVwonOx9v2OGTngoDabmZ1Ww1T3Ac8+scpy4sEYtG7UWVhW+l
        Y+w+yl/kAjUyqh0xb5F/pKFQLxX/2EnJQyi+rl2HOtsW5UOwruDu0fXGYjkh3knWhP8T4=;
Received: by exim4; Thu, 09 Apr 2020 09:19:43 +0200
Received: by cthulhu.home.robinhill.me.uk (Postfix, from userid 1000)
        id EA4B66A749B; Thu,  9 Apr 2020 08:19:40 +0100 (BST)
Date:   Thu, 9 Apr 2020 08:19:40 +0100
From:   Robin Hill <robin@robinhill.me.uk>
To:     Andrey ``Bass'' Shcheglov <andrewbass@gmail.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: Repairing a RAID1 with non-zero mismatch_cnt, vol. 2
Message-ID: <20200409071940.GA4072@cthulhu.home.robinhill.me.uk>
Mail-Followup-To: Andrey ``Bass'' Shcheglov <andrewbass@gmail.com>,
        linux-raid@vger.kernel.org
References: <CADSg1Jh1i+OPq0_hWOvHxK0xroUbn_w0_ZjxjwcnrbSsBXGY5A@mail.gmail.com>
 <5E25876A.1030004@youngman.org.uk>
 <CADSg1Jj3XmD_RmSedn3AT9uCXbHQGa6ATBK1UP33onS8Vi=60g@mail.gmail.com>
 <CADSg1Jh7=6XHXbDqWVWg=fa-+09Vd9E+KBuTy6AWucJesFkBmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADSg1Jh7=6XHXbDqWVWg=fa-+09Vd9E+KBuTy6AWucJesFkBmQ@mail.gmail.com>
User-Agent: Mutt/1.13.5 (2020-03-28)
Feedback-ID: outgoingmessage:robin@robinhill.me.uk:ns02.servermx.com:servermx.com
X-AuthUser: bimu5pypsh
X-Mailgun-Native-Send: true
X-AuthUser: bimu5pypsh
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu Apr 09, 2020 at 01:13:40AM +0300, Andrey ``Bass'' Shcheglov wrote:

> Now I have 3 empty ext4 partitions with only lost+found directories.
> 
> And the value of mismatch_cnt dropped to 384.
> 
> 
> Okay, so far, so good. I don't have any data, so a repair action can't
> possibly harm it.
> 
> > echo repair >>/sys/block/md4/md/sync_action
> 
> And the value of mismatch_cnt is still 384.
> 
The mismatch_cnt after repair indicates how many repairs were completed.
You need to run a new repair/check to see whether there are any
remaining mismatches.

Cheers,
    Robin
-- 
     ___        
    ( ' }     |       Robin Hill        <robin@robinhill.me.uk> |
   / / )      | Little Jim says ....                            |
  // !!       |      "He fallen in de water !!"                 |
