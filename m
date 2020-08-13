Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C770243A73
	for <lists+linux-raid@lfdr.de>; Thu, 13 Aug 2020 15:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgHMNDL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 13 Aug 2020 09:03:11 -0400
Received: from smtp1.servermx.com ([134.19.178.79]:36830 "EHLO
        smtp1.servermx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgHMNDK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 13 Aug 2020 09:03:10 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Aug 2020 09:03:09 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=servermx.com; s=servermx; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vmzcYQczPnm97pfCluw8HWLC1gkhZTn/akRn63A4+Eo=; b=cX+P6guel5OPihM3DrjKzQLw4
        H/uTv/J7RuRTmLuohy65pNFxSQYjEfSDrxCa9TmwUYoZktZWI0y4qbHaqt5WFFbG2IFtOivVEj0vH
        eYU/uQhliaqgMARIFhFv/2qHnuLQpn5vHhjb4X65B4vrGiu9/dnjzgTYj7BkruNsiwJUs=;
Received: by exim4; Thu, 13 Aug 2020 14:57:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=servermx.com; s=servermx; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vmzcYQczPnm97pfCluw8HWLC1gkhZTn/akRn63A4+Eo=; b=cX+P6guel5OPihM3DrjKzQLw4
        H/uTv/J7RuRTmLuohy65pNFxSQYjEfSDrxCa9TmwUYoZktZWI0y4qbHaqt5WFFbG2IFtOivVEj0vH
        eYU/uQhliaqgMARIFhFv/2qHnuLQpn5vHhjb4X65B4vrGiu9/dnjzgTYj7BkruNsiwJUs=;
Received: by exim4; Thu, 13 Aug 2020 14:57:16 +0200
Received: by cthulhu.home.robinhill.me.uk (Postfix, from userid 1000)
        id D9C4F6A057D; Thu, 13 Aug 2020 13:57:09 +0100 (BST)
Date:   Thu, 13 Aug 2020 13:57:09 +0100
From:   Robin Hill <robin@robinhill.me.uk>
To:     Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Subject: Re: mdadm development?
Message-ID: <20200813125709.GA13041@cthulhu.home.robinhill.me.uk>
Mail-Followup-To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
References: <1637821313.22423838.1597320925127.JavaMail.zimbra@karlsbakk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637821313.22423838.1597320925127.JavaMail.zimbra@karlsbakk.net>
User-Agent: Mutt/1.14.4 (2020-06-18)
Feedback-ID: outgoingmessage:robin@robinhill.me.uk:ns02.servermx.com:servermx.com
X-AuthUser: bimu5pypsh
X-Mailgun-Native-Send: true
X-AuthUser: bimu5pypsh
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu Aug 13, 2020 at 02:15:25PM +0200, Roy Sigurd Karlsbakk wrote:

> Hi all
> 
> Looking around to debug an issue (see previous email about badblocks),
> I wanted to find the latest version of mdadm. It seems it's 4.1 from
> october 2018. I can't find anything newer. Has development of mdadm
> halted or is it declared "perfect" or something?
> 
> Vennlig hilsen
> 
> roy

The mdadm application doesn't do a lot itself - most of the work is done
by the md kernel module, so that's where development is focussed.

Cheers,
    Robin
-- 
     ___        
    ( ' }     |       Robin Hill        <robin@robinhill.me.uk> |
   / / )      | Little Jim says ....                            |
  // !!       |      "He fallen in de water !!"                 |
