Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245811E7CA6
	for <lists+linux-raid@lfdr.de>; Fri, 29 May 2020 14:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgE2MJY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 29 May 2020 08:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2MJX (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 29 May 2020 08:09:23 -0400
Received: from forward100j.mail.yandex.net (forward100j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202FBC08C5C6
        for <linux-raid@vger.kernel.org>; Fri, 29 May 2020 05:09:23 -0700 (PDT)
Received: from mxback1o.mail.yandex.net (mxback1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1b])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id A9B4C50E1F6F;
        Fri, 29 May 2020 15:09:19 +0300 (MSK)
Received: from sas2-e7f6fb703652.qloud-c.yandex.net (sas2-e7f6fb703652.qloud-c.yandex.net [2a02:6b8:c14:4fa6:0:640:e7f6:fb70])
        by mxback1o.mail.yandex.net (mxback/Yandex) with ESMTP id JhFhZGbupL-9J7KlRwL;
        Fri, 29 May 2020 15:09:19 +0300
Received: by sas2-e7f6fb703652.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id WTfsaPCjIb-9I2elwJD;
        Fri, 29 May 2020 15:09:18 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: Assemblin journaled array fails
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <70dad446-7d38-fd10-130f-c23797165a21@yandex.pl>
 <56b68265-ca54-05d3-95bc-ea8ee0b227f6@yandex.pl>
 <CAPhsuW4WcqkDXOhcuG33bZtSEZ-V-KYPLm87piBH24eYEB0qVw@mail.gmail.com>
 <b9b6b007-2177-a844-4d80-480393f30476@yandex.pl>
 <CAPhsuW70NNozBmt1-zsM_Pk-39cLzi8bC3ZZaNwQ0-VgYsmkiA@mail.gmail.com>
 <f9b54d87-5b81-1fa3-04d5-ea86a6c062cb@yandex.pl>
 <CAPhsuW5ZfmCowTHNum5CSeadHqqPa5049weK6bq=m+JmnDE9Vg@mail.gmail.com>
 <d0340d7b-6b3a-4fd3-e446-5f0967132ef6@yandex.pl>
 <CAPhsuW4byXUvseqoj3Pw4r5nRGu=fHekdDec8FG6vj3of1wCyg@mail.gmail.com>
 <1cb6c63f-a74c-a6f4-6875-455780f53fa1@yandex.pl>
 <CAPhsuW6HdatOPJykqYCQs_7onWL1-AQRo05TygkXdRVSwAy_gQ@mail.gmail.com>
 <7b2b2bca-c1b7-06c5-10c5-2b1cdda21607@yandex.pl>
 <48e4fa28-4d20-ba80-cd69-b17da719531a@yandex.pl>
 <CAPhsuW69VYgLBZboxvQ6-Fmm-Oa0fGOVBg3SOVkzP_UopH+_wg@mail.gmail.com>
From:   Michal Soltys <msoltyspl@yandex.pl>
Message-ID: <1767d7aa-6c60-7efb-bf37-6506f9aaa8a2@yandex.pl>
Date:   Fri, 29 May 2020 14:09:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW69VYgLBZboxvQ6-Fmm-Oa0fGOVBg3SOVkzP_UopH+_wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/28/20 5:06 PM, Song Liu wrote:
> 
> For the next step, could you please try the following the beginning of
> --assemble
> run?
> 
>     trace.py -M 10 'r::r5l_recovery_verify_data_checksum()(retval != 0)'
> 
> Thanks,
> Song
> 

How long should I keep this one running ? So far - after ~1hr - nothing 
got reported.
