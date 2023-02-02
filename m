Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB51688A04
	for <lists+linux-raid@lfdr.de>; Thu,  2 Feb 2023 23:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjBBWrv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Feb 2023 17:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjBBWru (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 2 Feb 2023 17:47:50 -0500
Received: from mallaury.nerim.net (smtp-104-thursday.noc.nerim.net [178.132.17.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C03B169B3B
        for <linux-raid@vger.kernel.org>; Thu,  2 Feb 2023 14:47:47 -0800 (PST)
Received: from [192.168.0.252] (plouf.fr.eu.org [213.41.155.166])
        by mallaury.nerim.net (Postfix) with ESMTP id EA441DB17E;
        Thu,  2 Feb 2023 23:47:45 +0100 (CET)
Message-ID: <5a19ad42-e66c-9757-4fe6-9e12c759b54a@plouf.fr.eu.org>
Date:   Thu, 2 Feb 2023 23:47:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: how to know a hard drive will mix well
Content-Language: en-US
To:     Wols Lists <antlists@youngman.org.uk>,
        Linux RAID list <linux-raid@vger.kernel.org>
References: <20230202124306.GH25616@jpo>
 <894cb7f7-eb13-69e8-8cd8-0f71dc34e489@youngman.org.uk>
From:   Pascal Hambourg <pascal@plouf.fr.eu.org>
Organization: Plouf !
In-Reply-To: <894cb7f7-eb13-69e8-8cd8-0f71dc34e489@youngman.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 02/02/2023 at 19:52, Wols Lists wrote:
>
> Drives now are "Constant Head Speed" not constant rpm. I'm guessing, 

Source ?

"Constant linear velocity" (CLV, as opposed to "constant angular 
velocity" - CAV) is adapted for use requiring a constant transfer rate 
such as media recording or playback, not random access, and is mostly 
found in optical disc drives.

> that what it means is that for the inner tracks it spins at 7200, and as 
> the heads move out, the rpms slow down to keep the speed the head is 
> going over the platter constant.

It also implies that the spindle is able to accelerate from the lower 
speed (around 3600 RPM) to 7200 RPM or decelerate from 7200 to 3600 RPM 
in less than the full stroke time, which is around 20 ms in order to not 
degrade the access time. It sounds highly unlikely to me.
