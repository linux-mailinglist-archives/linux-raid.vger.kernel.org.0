Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76674E8355
	for <lists+linux-raid@lfdr.de>; Sat, 26 Mar 2022 19:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiCZSbH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 26 Mar 2022 14:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiCZSbH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 26 Mar 2022 14:31:07 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F83533E0E
        for <linux-raid@vger.kernel.org>; Sat, 26 Mar 2022 11:29:29 -0700 (PDT)
Received: from host86-155-180-61.range86-155.btcentralplus.com ([86.155.180.61] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1nYBAE-000AA9-5p;
        Sat, 26 Mar 2022 18:29:27 +0000
Message-ID: <3f62842d-0eb0-37a3-8dcd-5d08da4d18e9@youngman.org.uk>
Date:   Sat, 26 Mar 2022 18:29:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: new drive is 4 sectors shorter, can it be used for swraid5 array?
Content-Language: en-GB
To:     Tom Mitchell <mitch@niftyegg.com>, Marc MERLIN <marc@merlins.org>
Cc:     linux-raid@vger.kernel.org
References: <20220318030855.GV3131742@merlins.org>
 <CAAMy4UQWbYMfHa--vdWr8=+P=B20jiBVthZgUxsEb=8B1uYVgA@mail.gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <CAAMy4UQWbYMfHa--vdWr8=+P=B20jiBVthZgUxsEb=8B1uYVgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 26/03/2022 18:01, Tom Mitchell wrote:
> Shrinking a filesystem (resize2fs) does have some risks so backup first.
> 
> It is sort of nice to leave modest unused space when setting up a new disk.
> 
> Also back up to the new disk formatted correctly then invert the question and
> add the old disk with matched size partitions to mirror to.
> 
> It all depends on the backup strategy. Clonezilla?

If they are the same size or the backup disk is larger, I'd just use dd 
on an unmounted filesystem!

Cheers,
Wol
