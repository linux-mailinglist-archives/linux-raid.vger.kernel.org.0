Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53AA51374F4
	for <lists+linux-raid@lfdr.de>; Fri, 10 Jan 2020 18:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgAJRhf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 10 Jan 2020 12:37:35 -0500
Received: from vsmx009.vodafonemail.xion.oxcs.net ([153.92.174.87]:44026 "EHLO
        vsmx009.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727358AbgAJRhf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 10 Jan 2020 12:37:35 -0500
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jan 2020 12:37:34 EST
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])
        by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id CADE0159D896;
        Fri, 10 Jan 2020 17:31:19 +0000 (UTC)
Received: from lazy.lzy (unknown [79.214.221.251])
        by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 9BF3C159D886;
        Fri, 10 Jan 2020 17:31:15 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
        by lazy.lzy (8.15.2/8.14.5) with ESMTPS id 00AHVEA4003734
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 10 Jan 2020 18:31:14 +0100
Received: (from red@localhost)
        by lazy.lzy (8.15.2/8.15.2/Submit) id 00AHVE3T003733;
        Fri, 10 Jan 2020 18:31:14 +0100
Date:   Fri, 10 Jan 2020 18:31:14 +0100
From:   Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
To:     Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Subject: Re: Last scrub date and result
Message-ID: <20200110173114.GA3701@lazy.lzy>
References: <CAJH6TXjryixcArdcu_oVzmkEyktpMSb62YaUJvUv_Nd7k3mbDg@mail.gmail.com>
 <CAJH6TXgvvgg3w096PJ+wKT==ixxH8VTzzoRjTTcMhTJ_SDf2xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJH6TXgvvgg3w096PJ+wKT==ixxH8VTzzoRjTTcMhTJ_SDf2xQ@mail.gmail.com>
X-VADE-STATUS: LEGIT
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

On Fri, Jan 10, 2020 at 12:17:21PM +0100, Gandalf Corvotempesta wrote:
> Any thought ? Is this a stupid suggestion ?
> 
> Il giorno lun 6 gen 2020 alle ore 12:49 Gandalf Corvotempesta
> <gandalf.corvotempesta@gmail.com> ha scritto:
> >
> > Would be possible to add, in mdadm --detail output, the date of last
> > scrub and it's result ?
> > Looking through logs is not always possible (and much more harder to
> > script something), having something like:
> >
> > Update Time : Mon Jan  6 12:47:29 2020
> >           State : clean
> > Last scrub Time: Mon Jan  4 12:47:29 2020
> > Last scrub result: success
> >
> > would be great!

as far as I know, the scrub is triggered by
a cron job, so, very likely, the logging of
time and result could / should be done there.

I do not think mdadm is the right place to
keep this information, but I might be wrong.

bye,

-- 

piergiorgio
