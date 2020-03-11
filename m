Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C02F18196B
	for <lists+linux-raid@lfdr.de>; Wed, 11 Mar 2020 14:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgCKNSS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Mar 2020 09:18:18 -0400
Received: from smtp1.servermx.com ([134.19.178.79]:60526 "EHLO
        smtp1.servermx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbgCKNSS (ORCPT
        <rfc822;linux-raid@vger.kernel.ORG>); Wed, 11 Mar 2020 09:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=servermx.com; s=servermx; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tM9ST5qjUQFo91d9PXc4RSqvtBZHaEH3VDOSDbLNm+E=; b=VdRWgB0jSxR+zjrnkjMnMfIWbS
        ohA/p8SfianIOrvBHVhBwgHJqy9a7JIjjU9gQdeLVh3RAglGoSkpi9UQJLfxhGEvElFc5SDrJJ3jg
        SHhYwuEbh6gctt7jPGIHRKDvXKq+sURPwhMZ/zrCgvx0nlKXcL4AlAUZfMr4tDgFd4cY=;
Received: by exim4; Wed, 11 Mar 2020 14:18:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=servermx.com; s=servermx; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tM9ST5qjUQFo91d9PXc4RSqvtBZHaEH3VDOSDbLNm+E=; b=VdRWgB0jSxR+zjrnkjMnMfIWbS
        ohA/p8SfianIOrvBHVhBwgHJqy9a7JIjjU9gQdeLVh3RAglGoSkpi9UQJLfxhGEvElFc5SDrJJ3jg
        SHhYwuEbh6gctt7jPGIHRKDvXKq+sURPwhMZ/zrCgvx0nlKXcL4AlAUZfMr4tDgFd4cY=;
Received: by exim4; Wed, 11 Mar 2020 14:18:14 +0100
Received: by cthulhu.home.robinhill.me.uk (Postfix, from userid 1000)
        id D660C6A8419; Wed, 11 Mar 2020 13:18:11 +0000 (GMT)
Date:   Wed, 11 Mar 2020 13:18:11 +0000
From:   Robin Hill <robin@robinhill.me.uk>
To:     Leslie Rhorer <lesrhorer@att.net>
Cc:     linux-raid@vger.kernel.org
Subject: Re: checkarray not running or emailing
Message-ID: <20200311131811.GA30443@cthulhu.home.robinhill.me.uk>
Mail-Followup-To: Leslie Rhorer <lesrhorer@att.net>,
        linux-raid@vger.kernel.org
References: <814aad65-fba3-334c-c4df-6b8f4bfc4193.ref@att.net>
 <814aad65-fba3-334c-c4df-6b8f4bfc4193@att.net>
 <0ef54c89-b486-eb0b-8d70-a043ef089c9f@att.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ef54c89-b486-eb0b-8d70-a043ef089c9f@att.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Feedback-ID: outgoingmessage:robin@robinhill.me.uk:ns02.servermx.com:servermx.com
X-AuthUser: bimu5pypsh
X-Mailgun-Native-Send: true
X-AuthUser: bimu5pypsh
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue Mar 10, 2020 at 08:11:36PM -0500, Leslie Rhorer wrote:

>      Is there seriously no one here who knows how checkarray was 
> launched in previous versions?
> 
> On 3/1/2020 3:03 PM, Leslie Rhorer wrote:
> >     I have upgraded 2 of my servers to Debian Buster, and now neither 
> > one seems to be running checkarray automatically.  In addition, when I 
> > run checkarray manually, it isn't sending update emails on the status 
> > of the job.  Actually, I have never been able to figure out how 
> > checkarray runs.  One my older servers, there doesn't seem to be 
> > anything in /etc/crontab, /etc/cron.monthly, /etc/init.d/, 
> > /etc/mdadm/mdadm.conf, or /lib/systemd/system/ that would run checkarray.

Google suggests it's run from /etc/cron.d/mdadm. Does this exist on your
systems? I'm not sure why upgrading to Buster would have stopped the
checks though, unless the script wasn't replaced and the file location
for checkarray has changed.

Cheers,
    Robin
-- 
     ___        
    ( ' }     |       Robin Hill        <robin@robinhill.me.uk> |
   / / )      | Little Jim says ....                            |
  // !!       |      "He fallen in de water !!"                 |
