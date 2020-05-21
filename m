Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621F41DD629
	for <lists+linux-raid@lfdr.de>; Thu, 21 May 2020 20:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgEUSlL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 21 May 2020 14:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgEUSlK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 21 May 2020 14:41:10 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41005C061A0E
        for <linux-raid@vger.kernel.org>; Thu, 21 May 2020 11:41:10 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id m18so9549295ljo.5
        for <linux-raid@vger.kernel.org>; Thu, 21 May 2020 11:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WtNe7zZI1yRL84z+gDTWlgePuN1ZmaLgCFzAWncuOYY=;
        b=PdX9UnSaBq/tH7zdVsxBdLMB2SfxJJe1rGLfP3ooUWTQZ+pyKJ9kWINVhY/IE+GyAT
         xO5AOIEyKyPM2C+QMpxcYL+d/3VPIB+EIqiSqPrH0PNEjCe/Ya9SUGmiupjBorGKHC3y
         nAezwMPtadtjPlX99rzJbDHFSWOnRWkuUR5j9KLo2ChhgpY0cFhUNFVTeIJVY3YBSCtG
         7Ct+LnYeuyNC1BU0Rw0MM7Yfo1t8zqG6cmvW56g6BDLYsJ2YQFIEwdp1dAZuRN7ez5UI
         rIaSJ3HiyxxH+rFteZ8IFHXyrl/RSMLms1hCw9oC3kQuiMjaPD0axuIxYfsk76LySDC5
         z5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtNe7zZI1yRL84z+gDTWlgePuN1ZmaLgCFzAWncuOYY=;
        b=tExSDCK8X7RsCuW+4K+n0/nEb3caLLDJutSsQMpEyo6rt7SqSqxZC6C/1w7eGoQwGv
         K3ZWOL5k7Lrj2eu9LO8m1BktJC87RhzoSiPQTko+YS2NRVq82CZRKimPmW6UE8PySWq2
         lUUPQhkK+uFabnWKkDC9A1ZRYYPWhJc0VgVOCwpy2Fvf4OYI4jBNV5U/JA061QSI5OCF
         8IfQWfgXsSCtXZD33BgPAFQUxYyDd16d9/qNxpCsMlNbCusdc9mLxgbVZynFGykX4WBw
         PUMN5bfE667ui5QJChxLHaEQRjtKQ6lLikcJQWUPagAz7EKX/+0WGqW9Zj4MGCNubJAB
         mBOQ==
X-Gm-Message-State: AOAM5339stD/cugjuANfNhupIOUUk8/QpUjb7/0+OV9Q5hCm+C5a9C5V
        5uZGLgHW2xltHs7+ZaOL1eVoIWndcnGP8wtUB+/95uB8
X-Google-Smtp-Source: ABdhPJwwdXnBJe2DaILCZQehWPwOUmTTz43HvaIkFaDuTPeZomKyPaRe8Q7S4d6122ucG8zu+YfqIgl9mlgRXOGAIOQ=
X-Received: by 2002:a2e:6e0c:: with SMTP id j12mr2048429ljc.292.1590086468292;
 Thu, 21 May 2020 11:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200520200514.GE1415@justpickone.org> <5EC5BBEF.7070002@youngman.org.uk>
 <20200520235347.GF1415@justpickone.org> <5EC63745.1080602@youngman.org.uk>
 <20200521110139.GW1711@justpickone.org> <20200521112421.GK1415@justpickone.org>
 <5EC66D4E.8070708@youngman.org.uk> <20200521123306.GO1415@justpickone.org>
 <828a3b59-f79c-a205-3e1e-83e34ae93eac@youngman.org.uk> <20200521131500.GP1415@justpickone.org>
 <20200521180700.GT1415@justpickone.org>
In-Reply-To: <20200521180700.GT1415@justpickone.org>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Thu, 21 May 2020 13:40:56 -0500
Message-ID: <CAAMCDecB+CU-EGtx+4bMPKBYcy65sgT-8MW=s=OeviyZeq6URA@mail.gmail.com>
Subject: Re: re-add syntax
To:     David T-G <davidtg-robot@justpickone.org>
Cc:     Linux RAID list <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

For re-add to work the array must have a bitmap, so that mdadm knows
what parts of the disk need updating.

mine looks like this:
md13 : active raid6 sdi3[9] sdf3[12] sdg3[6] sdd3[1] sdc3[5] sdb3[7] sde3[10]
      3612623360 blocks super 1.2 level 6, 512k chunk, algorithm 2
[7/7] [UUUUUUU]
      bitmap: 0/6 pages [0KB], 65536KB chunk


On Thu, May 21, 2020 at 1:10 PM David T-G <davidtg-robot@justpickone.org> wrote:
>
> Hi, all --
>
> ...and then davidtg-robot@justpickone.org said...
> %
> % ...and then antlists said...
> % %
> % % So *you* should choose re-add. Let mdadm choose add if it can't do a re-add.
> %
> % Thanks.  Sooooo ...  Given this
> ...
> % does this
> %
> %   mdadm --manage /dev/md0 --re-add /dev/sdd1
> %
> % look like the right next step?
>
> Perhaps it did, but it wasn't to be:
>
>   diskfarm:root:10:~> mdadm --manage /dev/md0 --re-add /dev/sdd1
>   mdadm: --re-add for /dev/sdd1 to /dev/md0 is not possible
>
> So we'll try "add"
>
>   diskfarm:root:10:~> mdadm --manage /dev/md0 --add /dev/sdd1
>   mdadm: added /dev/sdd1
>
> and now we wait :-)
>
>
> Thanks again to all
>
> :-D
> --
> David T-G
> See http://justpickone.org/davidtg/email/
> See http://justpickone.org/davidtg/tofu.txt
>
