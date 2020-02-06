Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89FF01548B8
	for <lists+linux-raid@lfdr.de>; Thu,  6 Feb 2020 17:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgBFQCF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 Feb 2020 11:02:05 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:55375 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgBFQCF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 6 Feb 2020 11:02:05 -0500
Received: by mail-wm1-f47.google.com with SMTP id q9so537408wmj.5
        for <linux-raid@vger.kernel.org>; Thu, 06 Feb 2020 08:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubicast.eu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CaCuS8gzA1La2kUegVPapdULK69reMfgP8TpBUueudU=;
        b=KfP9lRK67yu5mFIkkssE5OTXQZmZE55HlIztDpI7yPTEllxPRJklbEN6BEEMjX+Wkv
         gPFzG1eRBEBN7OHRd5Tpzgt5wEzSM6Hxyo5PkdMp7KLKrYeKaZo0Iuv4C7mS+HgeRwZb
         B/ydj+ozjc2nqRQZIXDyD4LrqioB3idp31YB//Wg9lHfQgI49djsdKOmw0+Ai1jrcSIs
         C2EYi/iqwZNiRFYKIK1nOaWpzHkf8886ej6Fc4BudvlNtO/N+yJ2NnHvfuxniRufTacB
         GuzwX4iwuEQvDje+75drE2yLsBGziWYvMLZC+Q/N+aDg2Ep94w0G4ujT1alb/3YDj5G+
         2U+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CaCuS8gzA1La2kUegVPapdULK69reMfgP8TpBUueudU=;
        b=djf5HKfOHVyCblU5HqEFa53kf0wzsySICl3eoURnbLixea8OCLKtHoe7c6ZGDfupjr
         vdc43uo+gL2te1u5UP1rdBpX43p5wWE61stYZ4WI+2iJEl4oWRItMlQsjXQysOHtGj0K
         hfzkHxx393pDm0cGhIOCBpBL7MNjAIYnfpaYXp0CQO3GGXyc//DXbEUGOFnHvMXidW+o
         jEg+Tj88qqTDD+rfLrQ5NmnZACdqtkgaq9hzTqSIeZG0YEtHoZ47ju8Rdvp1x5Q36VlI
         MI7eLX2Y208IK6LsK5u2SKAAuix464aG7GIcje3NJzUSN4Ik+JVaqCg3jvYDmf5Qiaxu
         rIfQ==
X-Gm-Message-State: APjAAAVGxPmRpw9CCdrouDTCmQejS4v3hhajsb8nDB5IYabldGXLKtPo
        RYMKN9KZEx0BrPOi7e8NWkutO++rn90=
X-Google-Smtp-Source: APXvYqzIdYxqb4ra4DrYN81LlRWeAyGX3h5138pYoSNZ3oZzO5M7NiQQakWTJ+ibTy1viziQZ2bwZQ==
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr5751693wmg.16.1581004923383;
        Thu, 06 Feb 2020 08:02:03 -0800 (PST)
Received: from localhost ([83.136.150.89])
        by smtp.gmail.com with ESMTPSA id c74sm4374681wmd.26.2020.02.06.08.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 08:02:02 -0800 (PST)
Date:   Thu, 6 Feb 2020 17:02:20 +0100
From:   Nicolas KAROLAK <nicolas.karolak@ubicast.eu>
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     linux-raid@vger.kernel.org
Subject: Re: Recover RAID6 with 4 disks removed
Message-ID: <20200206160220.ewhf3xlehyrwajmt@laptop>
References: <CAO8Scz75h0mTqePyyeehnY+706R=eUgh7DOOKyCaWWJfADRUVg@mail.gmail.com>
 <dfac6758-1539-6b63-1883-03d704c67bc4@thelounge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dfac6758-1539-6b63-1883-03d704c67bc4@thelounge.net>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Feb 06, 2020 at 03:07:00PM +0100, Reindl Harald wrote:
> didn't you realize that RAID6 has redundancy to survive *exactly two*
> failing disks no matter how many disks the array has anmd the data and
> redundancy informations are spread ove the disks?

Not at the moment, i tested on a VM before but with 6 disks and removing 2
and then did it on the server without thinking/realizing than 4 is different
than 2 and that it would obsviously f**k the RAID array... (>_<')

> unlikely - the started reshape did writes

That's what i was afraid of. Thank you anyway for the answer.
