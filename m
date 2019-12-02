Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB7910F1FF
	for <lists+linux-raid@lfdr.de>; Mon,  2 Dec 2019 22:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfLBVRE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Dec 2019 16:17:04 -0500
Received: from sender11-op-o12.zoho.eu ([185.20.211.226]:17490 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLBVRD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 Dec 2019 16:17:03 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575321418; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=LLHZkkyh+sPyZ2w7x0tjDk5rxmMQYWha8czFeplg3hPxdLUVoMVHwhe5fgfFhpqsvt68LPdi705YTEmMyZyzHnbw1NbKqVQCrzPcFpYPaqkcf21KQmF+PVGQeEOhOmNyN6uU+0GoYZsE0lfJHzXqqKMHnsnD70hSaXDuI0g2GYM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1575321418; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=VZvJyFznJgW15CZPvvJ1AlD8xAMFUaHDRobuJ/NIiCg=; 
        b=ZfNwELKuwlBnf40Yb5+pLqoO0lrAwKeZ73PHaXajKgSQSjjaAry2rYxofX0O2SBrjNcI9LXWQhr89L/a0NG17YgXEUtr+0jMJpbkFz4YOMRwdE8y/Y9sw+RgZumXpvn4WNTFF5HrnNaKtnQ5FE8/TfXoNCxfj/aPY2uiTHyavFo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=trained-monkey.org;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [172.30.221.108] (163.114.130.128 [163.114.130.128]) by mx.zoho.eu
        with SMTPS id 1575321416299767.5296914138305; Mon, 2 Dec 2019 22:16:56 +0100 (CET)
Subject: Re: [PATCH 1/2] Create: add support for RAID0 layouts.
To:     NeilBrown <neilb@suse.de>
Cc:     linux-raid@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Song Liu <liu.song.a23@gmail.com>
References: <157283799101.17723.14738560497847478383.stgit@noble.brown>
 <157247951643.8013.12020039865359474811.stgit@noble.brown>
 <157283806994.17723.2465574926328635872.stgit@noble.brown>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <7dbab6fe-70be-0cda-4ff9-3527b585fe7e@trained-monkey.org>
Date:   Mon, 2 Dec 2019 16:16:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157283806994.17723.2465574926328635872.stgit@noble.brown>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/3/19 10:27 PM, NeilBrown wrote:
> Since Linux 5.4 a layout is needed for RAID0 arrays with
> varying device sizes.
> This patch makes the layout of an array visible (via --examine)
> and sets the layout on newly created arrays.
> --layout=dangerous
> can be used to avoid setting a layout so that they array
> can be used on older kernels.
> 
> Tested-by: dann frazier <dann.frazier@canonical.com>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>   Create.c   |   11 +++++++++++
>   Detail.c   |    5 +++++
>   maps.c     |   12 ++++++++++++
>   md.4       |   14 ++++++++++++++
>   mdadm.8.in |   30 +++++++++++++++++++++++++++++-
>   mdadm.c    |    8 ++++++++
>   mdadm.h    |    8 +++++++-
>   super0.c   |    6 ++++++
>   super1.c   |   30 +++++++++++++++++++++++++++++-
>   9 files changed, 121 insertions(+), 3 deletions(-)

Applied!

Sorry for the late response. I wanted to read through the code properly 
and then got sidetracked.

Thanks,
Jes

