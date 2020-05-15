Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D1F1D47C6
	for <lists+linux-raid@lfdr.de>; Fri, 15 May 2020 10:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgEOIIT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 15 May 2020 04:08:19 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:55708 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgEOIIT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 15 May 2020 04:08:19 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49NgyT0151z1r6R8
        for <linux-raid@vger.kernel.org>; Fri, 15 May 2020 10:08:17 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49NgyS71zHz1r7B8
        for <linux-raid@vger.kernel.org>; Fri, 15 May 2020 10:08:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Ovy65rTWMUs8 for <linux-raid@vger.kernel.org>;
        Fri, 15 May 2020 10:08:16 +0200 (CEST)
X-Auth-Info: StBlw7KImPAGunaZcfSUpWwhLGTwq9zpkEn9KZdeX0M=
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <linux-raid@vger.kernel.org>; Fri, 15 May 2020 10:08:16 +0200 (CEST)
Received: by janitor.denx.de (Postfix, from userid 108)
        id 08397A024D; Fri, 15 May 2020 10:08:16 +0200 (CEST)
Received: from gemini.denx.de (gemini.denx.de [10.4.0.2])
        by janitor.denx.de (Postfix) with ESMTPS id 4ADA3A00AA;
        Fri, 15 May 2020 10:08:09 +0200 (CEST)
Received: from gemini.denx.de (localhost [IPv6:::1])
        by gemini.denx.de (Postfix) with ESMTP id E637B240E1A;
        Fri, 15 May 2020 10:08:08 +0200 (CEST)
To:     Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc:     Linux Raid <linux-raid@vger.kernel.org>
From:   Wolfgang Denk <wd@denx.de>
Subject: Re: raid6check extremely slow ?
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <1430936688.3381175.1589485881380.JavaMail.zimbra@karlsbakk.net>
References: <20200510120725.20947240E1A@gemini.denx.de> <1999694976.3317399.1589476824607.JavaMail.zimbra@karlsbakk.net> <20200514182041.CDF1F240E1A@gemini.denx.de> <1430936688.3381175.1589485881380.JavaMail.zimbra@karlsbakk.net>
Comments: In-reply-to Roy Sigurd Karlsbakk <roy@karlsbakk.net>
   message dated "Thu, 14 May 2020 21:51:21 +0200."
Date:   Fri, 15 May 2020 10:08:08 +0200
Message-Id: <20200515080808.E637B240E1A@gemini.denx.de>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Roy Sigurd Karlsbakk,

In message <1430936688.3381175.1589485881380.JavaMail.zimbra@karlsbakk.net> you wrote:
> what?

You asked: "Try checking with iostat -x to see if one disk is
performing worse than the other ones."

The output of "iostat -x" which I posted shows clearly that all disk
behave very much the same - there are just minimal statistic
fluctuations, but agail equally distributed over all 8 disks.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I used to be indecisive, now I'm not sure.
