Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D675C14F090
	for <lists+linux-raid@lfdr.de>; Fri, 31 Jan 2020 17:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgAaQW4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 31 Jan 2020 11:22:56 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:52460 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgAaQW4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 31 Jan 2020 11:22:56 -0500
Received: by mail-pj1-f43.google.com with SMTP id ep11so3052958pjb.2
        for <linux-raid@vger.kernel.org>; Fri, 31 Jan 2020 08:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YmL3hu0uQ8lGA3hrBXGz5zww81rL4lYHj2sPCFrPjGg=;
        b=iAFPAM8aFoAaUcVgxusLiDRzwKFzp1ahvI2EhpB6s/z6gZD1kB3w3KklHOO0WrDeQR
         XgY3IupCmOmghDRRLIJ5K7d3P+Kfcc2UqzmpY4hfzb6yFZ/+t3f2Lm72Ii3tFia1UX8w
         vcmX6bC3KDb8hmQ8K6NaeIHOm1QLeRVdEVuJ5kh26+dyRjO+TXeOID/rndkuf2ojohKV
         6zOwNOWmJJWZ/xcTUXRpp5yP67XStHAOsRFZ41xkxc2YzYEz7exnYDf4hu8jOK20kqHg
         BKUkXVwgMJrkMA8mzFq37WhjDG3lhUc0rG+dZMTvzgyA8ua3lyRYXnXrZ85lwNUge2Jv
         1/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YmL3hu0uQ8lGA3hrBXGz5zww81rL4lYHj2sPCFrPjGg=;
        b=QKfoex+GAA/PY4EM70r1hSW29QWYRbH1cG3DIU9W+yn4+uDO0yQj9HTf6VJXuJxOps
         BXl4SjAkxXIATAsl7lxOUKRrZn+dRwK06BdWN2nREsjj3AzIyd/alf6u35R0EBMfsRMg
         xz+mqbmL+1LFPlvFp+OIlFSGRdQIPvMlAD+t7mTBhyPZaeKjlo+lNYFOfuqISXFBTg1z
         2x/rIhwF8Ww1pkCN2P02j/Ck9eZfZ3Hq3Xm9Ts9O4qjdwXwThhIMrH/jdpJ35Um81wR0
         0tk5YSsVTzi9hpn+5omhCCmAhhFPoBk/z+DWwO7q1lxVM2aJrM6gG9t549+II0Tf+6ls
         T2oA==
X-Gm-Message-State: APjAAAUbY6UOdxXjDeFkSWiSqhfLpEwBSApLFqtsuSU7oYdsiLNkrpX6
        SeDsulrbbJHNXGJy3aFLWHCU37ptSeFShw==
X-Google-Smtp-Source: APXvYqwSrRItPoN/16c1Zt8Z2K5dzGnTvUZtEpz+x61RikApxOHXUGH8++xb1+64tstH54/Q1B+grA==
X-Received: by 2002:a17:90a:bf81:: with SMTP id d1mr5459356pjs.21.1580487774042;
        Fri, 31 Jan 2020 08:22:54 -0800 (PST)
Received: from [0.0.0.0] ([2001:1438:4010:2540:248f:cf92:4086:6c4e])
        by smtp.gmail.com with ESMTPSA id z30sm11851948pfq.154.2020.01.31.08.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 08:22:53 -0800 (PST)
Subject: Re: low memory deadlock with md devices and external (imsm) metadata
 handling
To:     Nigel Croxon <ncroxon@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>
References: <71c1884d-a9fd-807b-86d0-4406457d605b@redhat.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <5bdc7be3-e796-5da5-f0e0-5287d47f4900@cloud.ionos.com>
Date:   Fri, 31 Jan 2020 17:22:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <71c1884d-a9fd-807b-86d0-4406457d605b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 1/31/20 3:43 PM, Nigel Croxon wrote:
> Hello all,
> 
> I have a customer issue,  low memory deadlock with md devices and external (imsm) metadata handling
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1703180
> 
> Has anyone else seen this problem?

I think most people out of RH are not authorized to the website.

Guoqing
