Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFF671375EF
	for <lists+linux-raid@lfdr.de>; Fri, 10 Jan 2020 19:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgAJSRM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 10 Jan 2020 13:17:12 -0500
Received: from mx009.vodafonemail.xion.oxcs.net ([153.92.174.39]:10589 "EHLO
        mx009.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726346AbgAJSRM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 10 Jan 2020 13:17:12 -0500
Received: from vsmx002.vodafonemail.xion.oxcs.net (unknown [192.168.75.192])
        by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTP id DE156605024;
        Fri, 10 Jan 2020 18:17:10 +0000 (UTC)
Received: from lazy.lzy (unknown [79.214.221.251])
        by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 8DD37603EC3;
        Fri, 10 Jan 2020 18:17:04 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
        by lazy.lzy (8.15.2/8.14.5) with ESMTPS id 00AIH3xj007049
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 10 Jan 2020 19:17:03 +0100
Received: (from red@localhost)
        by lazy.lzy (8.15.2/8.15.2/Submit) id 00AIH3sL007048;
        Fri, 10 Jan 2020 19:17:03 +0100
Date:   Fri, 10 Jan 2020 19:17:03 +0100
From:   Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
To:     Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        Linux RAID Mailing List <linux-raid@vger.kernel.org>
Subject: Re: Last scrub date and result
Message-ID: <20200110181703.GA7028@lazy.lzy>
References: <CAJH6TXjryixcArdcu_oVzmkEyktpMSb62YaUJvUv_Nd7k3mbDg@mail.gmail.com>
 <CAJH6TXgvvgg3w096PJ+wKT==ixxH8VTzzoRjTTcMhTJ_SDf2xQ@mail.gmail.com>
 <20200110173114.GA3701@lazy.lzy>
 <CAJH6TXgByNnaWkFo25SrkbR15XgN47b5VhzgWLX=LvMhH-A1VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJH6TXgByNnaWkFo25SrkbR15XgN47b5VhzgWLX=LvMhH-A1VQ@mail.gmail.com>
X-VADE-STATUS: LEGIT
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

On Fri, Jan 10, 2020 at 07:07:30PM +0100, Gandalf Corvotempesta wrote:
> Is triggered by a cron but is MD that does the scrub
> 
> As the scrub procedure is async, is not easy to log the scrub result,
> that's why i'm asking for something "native" that mdadm -D could show.

well, the time is available at script
level and this can be logged.
About the result, I guess it is possible
to log as well.
One option to investigate would be the
"--wait" of mdadm.

bye,

pg

> Il ven 10 gen 2020, 18:31 Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
> ha scritto:
> 
> > Hi,
> >
> > On Fri, Jan 10, 2020 at 12:17:21PM +0100, Gandalf Corvotempesta wrote:
> > > Any thought ? Is this a stupid suggestion ?
> > >
> > > Il giorno lun 6 gen 2020 alle ore 12:49 Gandalf Corvotempesta
> > > <gandalf.corvotempesta@gmail.com> ha scritto:
> > > >
> > > > Would be possible to add, in mdadm --detail output, the date of last
> > > > scrub and it's result ?
> > > > Looking through logs is not always possible (and much more harder to
> > > > script something), having something like:
> > > >
> > > > Update Time : Mon Jan  6 12:47:29 2020
> > > >           State : clean
> > > > Last scrub Time: Mon Jan  4 12:47:29 2020
> > > > Last scrub result: success
> > > >
> > > > would be great!
> >
> > as far as I know, the scrub is triggered by
> > a cron job, so, very likely, the logging of
> > time and result could / should be done there.
> >
> > I do not think mdadm is the right place to
> > keep this information, but I might be wrong.
> >
> > bye,
> >
> > --
> >
> > piergiorgio
> >

-- 

piergiorgio
